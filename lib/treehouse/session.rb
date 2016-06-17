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

    def cookies
      @cookies ||= ActionDispatch::Request.new(@env).cookie_jar
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
      cookie = ActionDispatch::Cookies::EncryptedCookieJar.new(
        { cookie_key => cookies[cookie_key] },
        ActiveSupport::KeyGenerator.new(secret_key, iterations: 1000),
        { encrypted_cookie_salt: 'encrypted cookie', encrypted_signed_cookie_salt: 'signed encrypted cookie', serializer: :json }
      )[cookie_key]
      return cookie || {}
    end
  end
end

