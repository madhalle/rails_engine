class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices

  def self.attribute_finder(query_params)
    attributes = query_params.keys
    merchantos = nil
    attributes.each do |attribute|
      value = query_params[attribute]
      merchantos = Merchant.where("merchants.#{attribute} ILIKE ?", "%#{value}%")
    end
    merchantos
  end

  def self.single_finder(query_params)
    attribute = query_params.keys.first
    value = query_params[attribute]
    Merchant.where("merchants.#{attribute} ILIKE ?", "%#{value}%")
  end

  def self.most_revenue(merchant_quantity)
    merchant_limit = merchant_quantity.values.first.to_i
    Merchant.select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: "success"})
    .group("merchants.id")
    .order("revenue desc")
    .limit(merchant_limit)
  end
end
