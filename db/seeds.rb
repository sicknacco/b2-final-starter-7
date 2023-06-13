# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
InvoiceItem.destroy_all
Transaction.destroy_all
Invoice.destroy_all
Item.destroy_all
Coupon.destroy_all
Merchant.destroy_all
Customer.destroy_all
Rake::Task["csv_load:all"].invoke

@merchant1 = Merchant.create!(name: "Hair Care")
@merchant2 = Merchant.create!(name: "Jewelry")

@coupon1 = @merchant1.coupons.create!(name: "Test $10", code: "TEST10", value: 10.00, value_type: 1, activated: true)
@coupon3 = @merchant1.coupons.create!(name: "Test $20", code: "20TEST", value: 20.00, value_type: 1, activated: false)
@coupon4 = @merchant1.coupons.create!(name: "Test Percent", code: "PERCENT", value: 0.20, value_type: 0, activated: true)

@coupon2 = @merchant2.coupons.create!(name: "Test 10%", code: "10TEST", value: 0.10, value_type: 0, activated: true)
@coupon5 = @merchant2.coupons.create!(name: "$20 Now", code: "NOW20", value: 20.00, value_type: 1, activated: false)
@coupon6 = @merchant2.coupons.create!(name: "Golden Ticket", code: "GOLDEN", value: 50.00, value_type: 1, activated: false)

@item_1 = @merchant1.items.create!(name: "Shampoo", description: "This washes your hair", unit_price: 100)
@item_2 = @merchant1.items.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 100)
@item_3 = @merchant1.items.create!(name: "Brush", description: "This takes out tangles", unit_price: 100)

@item_4 = @merchant2.items.create!(name: "Bracelet", description: "Wrist bling", unit_price: 100)
@item_5 = @merchant2.items.create!(name: "Necklace", description: "Neck bling", unit_price: 100)

@customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
@customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")

@invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, coupon_id: @coupon1.id)
@invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
@invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2, coupon_id: @coupon2.id)
@invoice_4 = Invoice.create!(customer_id: @customer_2.id, status: 2, coupon_id: @coupon1.id)
@invoice_5 = Invoice.create!(customer_id: @customer_2.id, status: 1, coupon_id: @coupon1.id)

@ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 100, status: 2)
@ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 100, status: 2)
@ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_2.id, quantity: 2, unit_price: 100, status: 2)
@ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_3.id, quantity: 3, unit_price: 100, status: 2)
@ii_5 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_5.id, quantity: 3, unit_price: 100, status: 2)

@transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
@transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_2.id)
@transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_3.id)
@transaction4 = Transaction.create!(credit_card_number: 850348, result: 1, invoice_id: @invoice_4.id)
@transaction5 = Transaction.create!(credit_card_number: 850348, result: 0, invoice_id: @invoice_5.id)