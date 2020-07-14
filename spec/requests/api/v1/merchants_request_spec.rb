require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create(:merchant)
    create(:merchant)

    get api_v1_merchants_path
    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(2)
  end

  it "can get one merchant by its id" do
    merchant = create(:merchant)
    get "/api/v1/merchants/#{merchant.id}"
    expect(response).to be_successful

    itemus = JSON.parse(response.body)
    expect(itemus["data"]["attributes"]["name"]).to eq(merchant.name)
  end

  xit "can create a new merchant" do
    merchant1 = create(:merchant)
    merchant = build(:merchant, merchant: merchant1)

    post "/api/v1/merchants", params: merchant.attributes

    expect(response).to be_successful
    body = response.body
    response = JSON.parse(body)
    expect(response["data"]["attributes"]["name"]).to eq(merchant.name)
    expect(response["data"]["attributes"]["description"]).to eq(merchant.description)
  end

  xit "can update an existing merchant" do
    merchant1 = create(:merchant)
    merchant = create(:merchant)
    updated_item = build(:merchant, merchant: merchant1)

    put "/api/v1/merchants/#{merchant.id}", params: updated_item.attributes

    expect(response).to be_successful
    expect(merchant.name).to_not eq(updated_item.name)
  end

  xit "can destroy an merchant" do
    merchant = create(:merchant)

    expect(Item.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(merchant.id)}.to raise_error{ActiveRecord::RecordNotFound}
  end
end
