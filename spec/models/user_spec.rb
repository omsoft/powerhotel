require 'rails_helper'

RSpec.describe User, type: :model do
  
	let(:user) { FactoryGirl.build(:user) }

	it "should call the ensure_authentication_token method" do
		expect(user).to receive(:ensure_authentication_token)
		user.save
	end
	it "should have a unique token" do
		user.save
		expect(user.authentication_token).to match(/./)
	end
	it "is invalid without first_name" do
		FactoryGirl.build(:user, first_name: nil).should_not be_valid
	end
	it "is invalid without last_name" do
		FactoryGirl.build(:user, last_name: nil).should_not be_valid
	end
	it "is invalid without an email" do
		FactoryGirl.build(:user, email: nil).should_not be_valid
	end
	it "is invalid without a properly formatted email" do
		FactoryGirl.build(:user, email: "wrong.email").should_not be_valid
	end
	it "is invalid with a duplicated email" do
		FactoryGirl.create(:user, email: "my@email.com")
		user.should_not be_valid
	end
	it "should respond_to hotels" do
		expect(user).to respond_to :hotels
	end

end
