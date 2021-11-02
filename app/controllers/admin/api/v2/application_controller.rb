module Admin
  module Api
    module V2
      class ApplicationController < ActionController::Base
        protect_from_forgery with: :null_session

        include ErrorResponseGenerateable
      end
    end
  end
end
