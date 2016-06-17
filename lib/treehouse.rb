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
    "#{url}/login?site=#{site}#{options[:return_to]}"
  end
end

require "treehouse/constraints"
require "treehouse/login"
require "treehouse/middleware"
require "treehouse/session"
require "treehouse/engine"

