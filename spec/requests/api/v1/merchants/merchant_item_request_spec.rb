require 'rails_helper'
describe "Merchants Items" do
  it "sends a list of merchant items" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    item3 = create(:item, merchant: merchant)
    item4 = create(:item, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"
    expect(response).to be_successful
    merchant_items = JSON.parse(response.body)
    expect(merchant_items["data"].count).to eq(4)
  end
end
