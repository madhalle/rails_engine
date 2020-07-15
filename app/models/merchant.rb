class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy

  def self.attribute_finder(query_params)
    attributes = query_params.keys
    merchantos = nil
    attributes.each do |attribute|
      value = query_params[attribute]
      merchantos = Merchant.where("merchants.name ILIKE ?", "%#{value}%")
    end
    merchantos
  end
end
