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
    # Merchant.joins(:invoices).joins(:transactions).where(transactions: {result: "success"})
     merchants = Merchant.joins(invoices: [:invoice_items, :transactions]).where("transactions.result = 'success'").group("merchants.name").select("merchants.name, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
     require "pry"; binding.pry
  end
end
