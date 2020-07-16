require "rails_helper"

describe "Merchant Find" do
  it "returns a list of merchants that meet query params criteria" do
    create(:merchant, name: "will")
    create(:merchant, name: "chill")
    create(:merchant, name: "BILL")
    create(:merchant, name: "charlie")
    get "/api/v1/merchants/find_all?name=ILL"

    expect(response).to be_successful
    ill_merchants = JSON.parse(response.body)
    expect(ill_merchants["data"].count).to eq(3)
  end

  it "returns a list of merchants that meet query params criteria" do
    m1 = create(:merchant, name: "guppy")
    m2 = create(:merchant, name: "charlie")
    get "/api/v1/merchants/find?name=uppy"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant["data"].class).to eq(Hash)  
    expect(merchant["data"]["attributes"]["name"]).to eq(m1.name)
  end
end
