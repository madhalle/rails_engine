require 'faker'
# FactoryBot.define do
#
#
#   factory :item do
#     name {"McLovin"}
#     description { "prolly shouldn't be able to buy me"}
#     unit_price { 10.00 }
#     merchant
#   end
# end
FactoryBot.define do
  factory :item do
    association :merchant
    name { Faker::Games::Zelda.item }
    description { Faker::Movies::Ghostbusters.quote }
    unit_price { rand(199..9999) }
  end

  factory :merchant do
    name {"McLovin shop"}
  end
end
