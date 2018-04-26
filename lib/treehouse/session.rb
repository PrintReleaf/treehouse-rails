module Treehouse
  class Session
    def initialize(env)
      @env = env
    end

    def current_login
      return @current_login if defined? @current_login
      @current_login = find_current_login
    end

    def logged_in?
      current_login.present?
    end

    def cookie
      @cookie ||= decrypted_cookie
    end

    def cookie_jar
      @cookie_jar ||= ActionDispatch::Request.new(@env).cookie_jar
    end

    def find_current_login
      return Treehouse::Login.dummy if Treehouse.dummy?
      return nil if login_id.blank? or login_email.blank?
      return Treehouse::Login.new(login_id, login_email)
    end

    def login_id
      cookie['treehouse_login_id']
    end

    def login_email
      cookie['treehouse_login_email']
    end

    private

    def decrypted_cookie
      secret_key = Treehouse.key
      cookie_key = Treehouse.cookie
      cookie_value = cookie_jar[cookie_key]
      return {} if cookie_value.blank?
      cookie_value = CGI::unescape(cookie_value)
      salt         = 'encrypted cookie'
      signed_salt  = 'signed encrypted cookie'
      key_generator = ActiveSupport::KeyGenerator.new(secret_key, iterations: 1000)
      secret = key_generator.generate_key(salt)[0, ActiveSupport::MessageEncryptor.key_len]
      signed_secret = key_generator.generate_key(signed_salt)
      encryptor = ActiveSupport::MessageEncryptor.new(secret, signed_secret, cipher: "aes-256-cbc", serializer: JSON)
      return encryptor.decrypt_and_verify(cookie_value) || {}
    end
  end
end

