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
    merchantemus = JSON.parse(response.body)
    expect(merchantemus["data"]["attributes"]["name"]).to eq(merchant.name)
  end

  it "can create a new merchant" do
    merchant = build(:merchant)

    post "/api/v1/merchants", params: merchant.attributes

    expect(response).to be_successful
    body = response.body
    response = JSON.parse(body)
    expect(response["data"]["attributes"]["name"]).to eq(merchant.name)
  end

  it "can update an existing merchant" do
    merchant1 = create(:merchant)
    updated_merchant = build(:merchant)

    put "/api/v1/merchants/#{merchant1.id}", params: updated_merchant.attributes

    expect(response).to be_successful
    expect(merchant1.name).to_not eq(updated_merchant.name)
  end

  it "can destroy an merchant" do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error{ActiveRecord::RecordNotFound}
  end
end
