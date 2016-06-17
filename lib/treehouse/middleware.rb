module Treehouse
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      session = Treehouse::Session.new(env)
      env[:treehouse] = session
      @app.call(env)
    end
  end
end

