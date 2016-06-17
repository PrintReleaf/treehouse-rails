module Treehouse
  class Login
    def self.dummy
      new(123, "bob@example.com")
    end

    attr_reader :id, :email

    def initialize(id, email)
      raise ArgumentError, "Invalid ID" if id.blank?
      raise ArgumentError, "Invalid email" if email.blank?
      @id = id
      @email = email
    end
  end
end

