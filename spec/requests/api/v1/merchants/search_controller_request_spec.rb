require 'rails_helper'

RSpec.describe "Api::V1::Merchants::SearchControllers", type: :request do

  describe "GET /show" do
    xit "returns http success" do
      get "/api/v1/merchants/search_controller/show"
      expect(response).to have_http_status(:success)
    end
  end

end
