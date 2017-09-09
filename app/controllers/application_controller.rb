class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def root
    redirect_to Bundle
  end
end
