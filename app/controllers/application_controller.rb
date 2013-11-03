class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_user_api_token

  protected
  def set_user_api_token
    RequestStore.store[:my_api_token] = Secrets.vine_session_id # current_user.api_token # or something similar based on `session`
  end
end
