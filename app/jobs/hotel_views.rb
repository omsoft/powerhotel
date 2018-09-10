class HotelViews

	class << self

		# We handle the update of views_count field
		def update(hotel_ids)
			return false unless hotel_ids.is_a?(Array) || hotel_ids.is_a?(Integer)
			
			# ensure parameter is an array
			ids = Array.wrap(hotel_ids)

			# for each hotel id
			ids.each do |id|
				# increment the counter, without touching the updated_at field
				# also make sure id is an integer
				Hotel.increment_counter(:views_count, id.to_i)
			end
		end
		handle_asynchronously :update, run_at: Proc.new { 20.seconds.from_now.getutc }

	end

end