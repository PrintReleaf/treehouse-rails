require "rails"

module Treehouse
  def self.configure(options={}, &block)
    options.each { |key, value| configuration[key] = value }
    yield configuration if block_given?
  end

  def self.configuration
    @configuration ||= OpenStruct.new
  end

  def self.cookie
    configuration.cookie or raise "Treehouse cookie not configured"
  end

  def self.dummy?
    !!configuration.dummy
  end

  def self.key
    configuration.key or raise "Treehouse key not configured"
  end

  def self.site
    configuration.site or raise "Treehouse site not configured"
  end

  def self.url
    configuration.url or raise "Treehouse URL not configured"
  end

  def self.login_url(options={})
    # This is a shim to support the old syntax of pasing in options
    # like Treehouse.login_url(return_to: "/whatever").
    # We should remove it when we remove treehouse-rails's concept of "site".
    if options.is_a? Hash
      "#{url}/login?site=#{site}#{options[:return_to]}"
    elsif options.is_a? String
      "#{url}/login?site=#{options}"
    end
  end
end

require "treehouse/constraints"
require "treehouse/login"
require "treehouse/middleware"
require "treehouse/session"
require "treehouse/engine"

