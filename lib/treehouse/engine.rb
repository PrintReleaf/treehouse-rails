module Treehouse
  class Engine < ::Rails::Engine
    isolate_namespace Treehouse
    config.app_middleware.use(Treehouse::Middleware)
  end
end

