module Admin
  class SessionsController < FirebaseSessionsController
    # POST /login
    def create
      super do |decoded_token|
        AdminAccount.find_or_create_by(uid: decoded_token['uid'])
      end
    end

    # DELETE /logout
    def destroy
      flash[:success] = 'ログアウトしました。'
      super
    end
  end
end
