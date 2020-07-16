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
end

FactoryBot.define do
  factory :merchant do
    name {Faker::Movies::PrincessBride.character}
  end
end

FactoryBot.define do
  factory :customer do
    first_name {Faker::Movies::PrincessBride.character}
    last_name {Faker::Movies::StarWars.character}
  end
end

FactoryBot.define do
  factory :invoice do
    status {"shipped"}
    association :merchant
    association :customer
    association :transactions
  end
end

FactoryBot.define do
  factory :invoice_item do
    quantity {rand(1..11)}
    association :item
    unit_price {item.unit_price}
    association :invoice
  end
end

FactoryBot.define do
  factory :transactions do
    creadit_card_number {rand(4000000000000000..5000000000000000)}
    credit_card_expiration_date { " " }
    result {rand("success", "failed")}
    association :invoice
  end
end
