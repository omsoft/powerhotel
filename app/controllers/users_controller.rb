class UsersController < ApplicationController
	before_action :load_user,   only: [:show, :edit, :update]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def show
	end

	def edit
	end

	def create
		@user = User.new(user_params)

	    if @user.save
      	  redirect_to users_path, notice: "User created!"
	    else
	    	render :new
	    end
	end

	def update
		if @user.update_attributes(user_params)
	      flash[:success] = "Profile updated"
	      redirect_to users_path
	    else
	      render 'edit'
	    end
	end

	def destroy
		User.find(params[:id]).destroy
	    flash[:success] = "User destroyed."
	    redirect_to users_url
	end

	private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password,
                                   :password_confirmation, { hotel_ids:[] })
    end

    def load_user
      @user = User.find(params[:id])
      #redirect_to(root_url) unless current_user?(@user)
    end
end
