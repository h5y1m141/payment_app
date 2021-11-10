require 'rails_helper'

RSpec.describe "Admin::CompleteShippings", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/complete_shippings/index"
      expect(response).to have_http_status(:success)
    end
  end

end
