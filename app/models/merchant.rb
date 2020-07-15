class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy

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
end
