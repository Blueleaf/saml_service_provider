class HomeController < ApplicationController
  def index

  end

  def signout
    reset_session
    redirect_to root_path
  end
end
