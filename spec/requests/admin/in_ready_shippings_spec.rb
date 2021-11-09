require 'rails_helper'

RSpec.describe "Admin::InReadyShippings", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/in_ready_shippings/index"
      expect(response).to have_http_status(:success)
    end
  end

end
