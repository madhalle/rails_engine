class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.attribute_finder(query_params)
    attributes = query_params.keys
    itemus = nil
    attributes.each do |attribute|
      value = query_params[attribute]
      itemus = Item.where("items.#{attribute} ILIKE ?", "%#{value}%")
    end
    itemus
  end

  def self.single_attribute_finder(query_params)
    attribute = query_params.keys.first
    value = query_params[attribute]
    Item.where("items.#{attribute} ILIKE ?", "%#{value}%")
  end
end
