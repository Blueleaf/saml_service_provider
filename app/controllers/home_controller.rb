class HomeController < ApplicationController
  before_filter :verify_logged_in
  def index

  end

  private

  def verify_logged_in
    current_user || (raise "Not Logged In")
  end
end
