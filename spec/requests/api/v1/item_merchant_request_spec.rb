require 'rails_helper'

describe "Item Merchant" do
  it "sends item's merchant" do
    item = create(:item)

    get "/api/v1/items/#{item.id}/merchant"
    expect(response).to be_successful
    item_merchant = JSON.parse(response.body)
    expect(item_merchant["data"]["id"].to_i).to eq(item.merchant.id)
  end

end
