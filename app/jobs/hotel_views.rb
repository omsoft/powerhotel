class HotelViews

	class << self

		# We handle the update of views_count field
		def update(hotel_ids)
			# ensure parameter is an array
			ids = Array.wrap(hotel_ids)

			# for each hotel id
			ids.each do |id|
				# increment the counter, without touching the updated_at field
				Hotel.increment_counter(:views_count, id)
			end
		end
		handle_asynchronously :update, run_at: Proc.new { 20.seconds.from_now.getutc }

	end

end