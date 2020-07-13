require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do

    create_list(:item, 3)
    get api_v1_items_path
    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end

  it "can get one item but its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["id"]).to eq(id)
  end

  it "can create a new item" do
    merchant1 = create(:merchant)
    item_params = { name: "mclovviiiinn",
                    description: "u know u know",
                    unit_price: 107.02,
                    merchant_id: merchant1.id}

    post "/api/v1/items", params: {item: item_params}
    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
  end

  it "can update an existing item" do
    id = create(:item).id
    previous_item_name = Item.last.name
    item_params = { name: "oogabooga"}

    put "/api/v1/items/#{id}", params: {item: item_params}
    item = Item.find_by(id: :id)
    
    expect(respone).to be_successful
    expect(item.name).to_not eq(previous_item_name)
    expect(item.name).to eq("oogabooga")
  end
end
