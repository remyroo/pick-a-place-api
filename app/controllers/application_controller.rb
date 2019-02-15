class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include Knock::Authenticable

  def authorize_as_admin
    raise ExceptionHandler::AuthorizationError unless current_user.present? && current_user.admin?
  end
end
