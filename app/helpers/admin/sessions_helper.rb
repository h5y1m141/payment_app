# https://github.com/xojan0120/auth_firebase_test/blob/master/app/helpers/sessions_helper.rb
module Admin
  module SessionsHelper
    def log_in(admin_account)
      session[:uid] = admin_account.uid
    end

    def log_out
      session.delete(:uid)
      @current_user = nil
    end 

    def logged_in?
      !current_user.nil?
    end

    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end

    def current_user
      if (uid = session[:uid])
        @current_user ||= AdminAccount.find_by(uid: uid)
      end
    end

    def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
    end

    private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = 'ログインして下さい。'
        redirect_to login_url
      end
    end
  end
end