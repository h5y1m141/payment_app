module Admin
  class FirebaseSessionsController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :logged_in_user, only: [:destroy]

    include Admin::SessionsHelper
    include Admin::FirebaseHelper

    def new
      redirect_to users_path if logged_in?
    end

    def create
      if decoded_token = authenticate_firebase_id_token
        admin_account = yield(decoded_token)
        log_in(admin_account)
        flash[:success] = 'ログインしました。'
        redirect_back_or(admin_products_path)
      else
        flash[:danger] = 'ログインできませんでした。'
        redirect_to login_url
      end
    end

    def destroy
      log_out if logged_in?
      redirect_to login_url
    end

    private

    def authenticate_firebase_id_token
      authenticate_with_http_token do |token, options|
        begin
          decoded_token = FirebaseHelper::Auth.verify_id_token(token)
        rescue => exception
          logger.error(exception)
          false
        end
      end
    end
  end
end