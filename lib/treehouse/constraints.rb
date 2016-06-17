module Treehouse
  module Constraints
    class Constraint
      def treehouse_session
        @request.env[:treehouse]
      end

      def logged_in?
        treehouse_session.present? && treehouse_session.logged_in?
      end
    end

    class LoggedIn < Constraint
      def matches?(request)
        @request = request
        logged_in?
      end
    end

    class LoggedOut < Constraint
      def matches?(request)
        @request = request
        !logged_in?
      end
    end
  end
end

