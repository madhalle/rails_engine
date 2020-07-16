describe "Item Find" do
  it "returns a list of items that meet query params criteria" do
    create(:item, name: "will")
    create(:item, name: "chill")
    create(:item, name: "BILL")
    create(:item, name: "charlie")
    get "/api/v1/items/find_all?name=ILL"

    expect(response).to be_successful
    ill_items = JSON.parse(response.body)
    expect(ill_items["data"].count).to eq(3)
  end

  it "returns a list of items that meet query params criteria" do
    m1 = create(:item, name: "guppy")
    m2 = create(:item, name: "charlie")
    get "/api/v1/items/find?name=uppy"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["data"].class).to eq(Hash)
    expect(item["data"]["attributes"]["name"]).to eq(m1.name)
  end
end
