class MerchantSearch
  def self.attribute_finder(attribute, value)
    Merchant.where("name ILIKE ?", "%#{attribute}%", "%#{value}" )
    require "pry"; binding.pry
  end
end
