require 'rails_helper'

RSpec.describe Hotel, type: :model do
  
	let(:hotel) { FactoryGirl.create(:hotel) }

	before do
		I18n.available_locales.each do |locale|
		  Globalize.with_locale(locale) do
		    hotel.description = "Hotel_description_#{locale}"
		  end
		end
		hotel.save
	end

	it "is invalid without a name" do
		FactoryGirl.build(:hotel, name: nil).should_not be_valid
	end
	it "is invalid without a country_code" do
		FactoryGirl.build(:hotel, country_code: nil).should_not be_valid
	end
	it "is invalid without a average_price" do
		FactoryGirl.build(:hotel, average_price: nil).should_not be_valid
	end
	it "is invalid when average_price is not a number or it is less than (or equal to) 0" do
		FactoryGirl.build(:hotel, average_price: 0).should_not be_valid
	end
	it "should respond_to users" do
		expect(hotel).to respond_to(:users)
	end
	it "returns a list of associated users" do
		user1 = FactoryGirl.create(:user, hotel_ids: [hotel.id])
		expect(hotel.users).to match_array([user1])
	end
	it "returns the english description with I18n.locale = en" do
		I18n.locale = :en
		expect(hotel.description).to eql("Hotel_description_en")
	end

end
