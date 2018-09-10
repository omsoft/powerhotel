
describe HotelViews do

	describe ".update" do

		context "given wrong parameters" do
			it "returns false with an empty string" do
				expect(HotelViews.update_without_delay("")).to eql(false)
			end

			it "returns false with a string of characters" do
				expect(HotelViews.update_without_delay("asdf")).to eql(false)
			end
		end

		context "given a list of valid Hotel IDs" do
			it "updates hotel.views_count for each hotel object" do
				hotel1 = Hotel.create(name: "Test Hotel 1", average_price: 80, country_code: "IT")
				hotel2 = Hotel.create(name: "Test Hotel 2", average_price: 100, country_code: "IT")

				HotelViews.update_without_delay([ hotel1.id, hotel2.id ])

				expect(hotel1.reload.views_count).to eql(1)
				expect(hotel2.reload.views_count).to eql(1)
			end
		end
	end

end