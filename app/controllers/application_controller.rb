class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_cart

  private
    def logged_in?
      !!current_user
    end

    def current_cart
      current_user.current_cart if !current_user.nil?
    end

end
