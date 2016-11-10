class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= begin
      if session['nameid'].present?
        User.new(session['nameid'], session['attributes'])
      end
    end
  end

  helper_method :current_user

  def authenticated?
    current_user.present?
  end

  helper_method :authenticated?
end
