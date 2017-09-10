module Api
  module V1
    class BaseController < JSONAPI::ResourceController
      # Prevent CSRF attacks by raising an exception.
      # For APIs, you may want to use :null_session instead.
      protect_from_forgery with: :null_session
    end
  end
end
