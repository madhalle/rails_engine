require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create(:item)
    create(:item)

    get api_v1_items_path
    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(2)
  end

  it "can get one item by its id" do
    item = create(:item)
    get "/api/v1/items/#{item.id}"
    expect(response).to be_successful

    itemus = JSON.parse(response.body)
    expect(itemus["data"]["attributes"]["name"]).to eq(item.name)
  end

  it "can create a new item" do
    merchant1 = create(:merchant)
    item = build(:item, merchant: merchant1)

    post "/api/v1/items", params: item.attributes

    expect(response).to be_successful
    body = response.body
    response = JSON.parse(body)
    expect(response["data"]["attributes"]["name"]).to eq(item.name)
    expect(response["data"]["attributes"]["description"]).to eq(item.description)
  end

  it "can update an existing item" do
    merchant1 = create(:merchant)
    item = create(:item)
    updated_item = build(:item, merchant: merchant1)

    put "/api/v1/items/#{item.id}", params: updated_item.attributes

    expect(response).to be_successful
    expect(item.name).to_not eq(updated_item.name)
  end

  it "can destroy an item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error{ActiveRecord::RecordNotFound}
  end
end
