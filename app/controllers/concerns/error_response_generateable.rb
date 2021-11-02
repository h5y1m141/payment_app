module ErrorResponseGenerateable
  extend ActiveSupport::Concern

  included do
    # NOTE: rescue_fromを複数記述した場合下から上の順に動作
    # rescue_from XXX, with: :render_internal_server_error
    # rescue_from XXX, with: :render_conflict
  end

  def render_bad_request(error_message)
    error_response = {
      message: "リクエストパラメーターエラー: #{error_message}"
    }
    render json: error_response, status: :bad_request
  end

  def render_unauthorized
    error_response = {
      message: '認証エラーが発生しました'
    }
    render json: error_response, status: :unauthorized
  end

  def render_not_found
    error_response = {
      message: '対象のリソースは見つかりません'
    }
    render json: error_response, status: :not_found
  end

  def render_conflict
    error_response = {
      message: 'すでに存在するリソースの更新/作成は行なえません'
    }
    render json: error_response, status: :conflict
  end

  def render_internal_server_error
    error_response = {
      message: 'アプリケーションエラーが発生しました'
    }
    render json: error_response, status: :internal_server_error
  end

  def verify_token
    render_bad_request('ID Tokenが設定されていません') if params[:id_token].blank?

    result = AuthToken.verify(params[:id_token])
    render_unauthorized if result['uid'].empty?
  end
end
