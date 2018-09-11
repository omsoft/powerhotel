require 'rails_helper'

RSpec.describe Api::V1::HotelsController, type: :controller do

  describe "Hotels API" do

    before(:each) do
      # We create 5 hotels
      FactoryGirl.create_list(:hotel, 5)
      # We create a user and associate it with the previous hotels
      user = FactoryGirl.create(:user, hotel_ids: Hotel.pluck(:id))
      # We create a standalone hotel for testing purposes
      @standalone_hotel = FactoryGirl.create(:hotel)

      request.env["ACCEPT"] = 'application/json'
      request.env['HTTP_ACCEPT_LANGUAGE'] = 'en-US'
      request.headers['X-AUTH-EMAIL'] = "#{user.email}"
      request.headers['X-AUTH-TOKEN'] = "#{user.authentication_token}"

      get :index
    end

    it "sets locale from browser settings" do
      expect(I18n.locale).to eql(:en)
    end

    it "returns an unauthorized status response with an invalid user" do
      request.headers['X-AUTH-EMAIL'] = "non_existing@email.com"
      request.headers['X-AUTH-TOKEN'] = "an_invalid_token"
      get :index
      expect(response).to have_http_status 401
    end

    it "creates a background job after each successful request" do
      expect(Delayed::Job.count).to eq(1)
      get :index
      expect(Delayed::Job.count).to eq(2)

      # prep a wrong request
      request.headers['X-AUTH-TOKEN'] = "an_invalid_token"
      get :index
      # delayed job count should be still 2
      expect(Delayed::Job.count).to eq(2)
    end

    it "returns all the user hotels" do
      # test for the 200 status-code
      expect(response).to be_success
      # check the length of the response (should be 5 items)
      expect(json_response.length).to eq(5)
      # check if standalone_hotel not present on the response
      expect(json_response).not_to include(@standalone_hotel)
    end

    it "returns hotels object without average_price_cents and average_price_currency fields" do
      expect(json_response[0]).not_to have_key('average_price_currency')
    end

  end

end
