desc "Clear and seed development database"
task import: :environment do
  Transaction.destroy_all
  InvoiceItem.destroy_all
  Item.destroy_all
  Invoice.destroy_all
  Merchant.destroy_all
  Customer.destroy_all
  puts 'database has been absolutely wrecked. no survivors'
  #big lovisa 'rake db drop create migrate'
  require 'csv'
  puts 'importing customers'
  CSV.foreach('./data/customers.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
    Customer.create(row.to_h)
  end

  puts 'importing merchants'
  CSV.foreach('./data/merchants.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
    Merchant.create(row.to_h)
  end

  puts 'importing invoices'
  CSV.foreach('./data/invoices.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
    Invoice.create(row.to_h)
  end

  puts 'importing items'
  CSV.foreach('./data/items.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
    item = Item.create(row.to_h)
    item.unit_price = (row[:unit_price]/100.00.to_f.round(2))
    item.save
  end

  puts 'importing invoice items'
  CSV.foreach('./data/invoice_items.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
    invoice = InvoiceItem.create!(row.to_h)
    invoice.unit_price = (row[:unit_price]/100.00.to_f.round(2))
    invoice.save
  end

  puts 'importing transactions items'
  CSV.foreach('./data/transactions.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
    Transaction.create(row.to_h)
  end
  puts 'preparing to kick ass'
end
