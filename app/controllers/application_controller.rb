class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    AuthorizationService.current_user
  end
end
