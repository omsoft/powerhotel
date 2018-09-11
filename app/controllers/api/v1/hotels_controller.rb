require "#{Rails.root}/app/jobs/hotel_views.rb"

module Api
	module V1
		class HotelsController < ApiController

			after_action :launch_hotel_views, only: :index

			def index
				@hotels = @current_user.hotels
				render json: @hotels.as_json({
					currency: ISO3166::Country.new(extract_country_from_accept_language_header).currency.iso_code
				}), status: :ok
			end

			private

			def launch_hotel_views
				HotelViews.update(@hotels.pluck(:id))
			end

			def extract_country_from_accept_language_header
				request.env['HTTP_ACCEPT_LANGUAGE'].scan(/[A-Z]{2}/).first
			end
		end
	end
end