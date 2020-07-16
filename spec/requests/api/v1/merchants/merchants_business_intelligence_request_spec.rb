require 'rails_helper'

describe "Merchants Business Intelligence" do
  it "most revenue" do
    m1= create(:merchant)
    item1=  create(:item, merchant: m1)
    inv_item = create(:invoice_item, item: item1, unit_price:100.00)
    inv = create(:invoice, merchant: m1)
    transaction1 = create(:transaction, result: "failed", invoice: inv)

    m2 = create(:merchant)
    item2 = create(:item, merchant: m2)
    inv_item2 = create(:invoice_item, item: item2, unit_price:400.00)
    inv2 = create(:invoice, merchant: m2)
    transaction2 = create(:transaction, result: "success", invoice: inv2)

    m3 = create(:merchant)
    item3 = create(:item, merchant: m3)
    inv_item3 = create(:invoice_item, item: item3, unit_price:3000.00)
    inv3 = create(:invoice, merchant: m3)
    transaction3 = create(:transaction, result: "success", invoice: inv3)

    m4 = create(:merchant)
    item4 = create(:item, merchant: m4)
    inv_item4 = create(:invoice_item, item: item4, unit_price:50.00)
    inv4 = create(:invoice, merchant: m4)
    transaction4 = create(:transaction, result: "success", invoice: inv4)

    get "/api/v1/merchants/most_revenue?quantity=3"

    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants["data"]).to eq(3)
    expect(merchants["data"][0]["attributes"]["name"]).to eq(m3.name)
    expect(merchants["data"][2]["attributes"]["name"]).to eq(m4.name)
  end
end
