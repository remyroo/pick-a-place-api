module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthorizationError < StandardError; end

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end
    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
    rescue_from ExceptionHandler::AuthorizationError do |e|
      json_response({ message: "Unauthorized Request" }, :unauthorized)
    end
  end
end
