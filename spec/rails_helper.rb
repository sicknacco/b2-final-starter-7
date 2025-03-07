def test_data
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
end

require "simplecov"
SimpleCov.start
# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
