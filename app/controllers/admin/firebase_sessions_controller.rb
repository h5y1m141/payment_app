module Admin
  class FirebaseSessionsController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :logged_in_user, only: [:destroy]

    include Admin::SessionsHelper

    def new
      redirect_to users_path if logged_in?
      @config = {
        api_key: ENV['FIREBASE_API_KEY'],
        auth_domain: ENV['FIREBASE_AUTH_DOMAIN'],
        database_url: ENV['FIREBASE_DATABASE_URL'],
        project_id: ENV['FIREBASE_PROJECT_ID'],
        storage_bucket: ENV['FIREBASE_STORAGE_BUCKET'],
        messaging_sender_id: ENV['FIREBASE_MESSAGING_SENDER_ID'],
        app_id: ENV['FIREBASE_APP_ID'],
        measurement_id: ENV['FIREBASE_MEASUREMENT_ID']
      }
    end

    def create
      decoded_token = AuthToken.verify(params[:id_token])

      if decoded_token
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
  end
end
