class HotelsController < ApplicationController
	before_action :load_hotel,   only: [:show, :edit, :update]

	def index
		@hotels = Hotel.all
	end

	def new
		@hotel = Hotel.new
	end

	def show
	end

	def edit
	end

	def create
		@hotel = Hotel.new(hotel_params)

	    if @hotel.save
	    	respond_to do |format|
			    format.html { redirect_to hotels_path, notice: "Hotel created!" }
			    format.js	{ render json: quote, status: :created }
			end
	    else
	    	render :new
	    end
	end

	def update
		if @hotel.update_attributes(hotel_params)
	      flash[:success] = "Hotel updated"
	      redirect_to hotels_url
	    else
	      render 'edit'
	    end
	end

	def destroy
		Hotel.find(params[:id]).destroy
	    flash[:success] = "Hotel destroyed."
	    redirect_to hotels_url
	end

	private

    def hotel_params
      params.require(:hotel).permit(:name, :country_code, :average_price, :description)
    end

    def load_hotel
      @hotel = Hotel.find(params[:id])
    end
end
