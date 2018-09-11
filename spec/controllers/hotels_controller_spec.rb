require 'rails_helper'

RSpec.describe HotelsController, type: :controller do

  describe "GET #index" do

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns @hotels" do
      hotel = FactoryGirl.create(:hotel)
      get :index
      expect(assigns(:hotels)).to eq([hotel])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

  end

  describe "GET edit" do
    let(:hotel) { FactoryGirl.create(:hotel) }

    it "assigns @hotel" do
      get :edit, { id: hotel.id }
      expect(assigns(:hotel)).to eq(hotel)
    end

    it "returns the edit template" do
      get :edit, { id: hotel.id }
      expect(response).to render_template("edit")
    end
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT update/:id" do
    let(:hotel) { FactoryGirl.create(:hotel) }
    let(:attr) do
      { :name => 'hacked!', :description => 'hacked!' }
    end

    context "when given valid parameters" do
      before(:each) do
        put :update, id: hotel.id, hotel: attr
        hotel.reload
      end

      it { expect(hotel.name).to eql(attr[:name]) }
      it { expect(hotel.description).to eql(attr[:description]) }
      it { expect(response).to redirect_to(hotels_path) }
      
    end

    context 'when the property does not exist' do
      it 'raises a not found error' do
        expect { put :update, id: 0, hotel: attr }.to raise_error ActiveRecord::RecordNotFound
      end
    end

  end

  describe "POST create" do

    context "when hotel object is valid" do
      let(:attr) do
        { name: "Underground", country_code: "ABCD", average_price: 100, description: 'my beautiful hotel' }
      end

      it "creates a Hotel and returns to the Hotels index" do
        post :create, :hotel => attr
        expect(assigns(:hotel)).to be_valid
        expect(response).to redirect_to hotels_path
      end
    end

    context "when hotel object is not valid 'cause of missing parameters" do
      it "should have errors and render the new template" do
        post :create, :hotel => {:name => "My new hotel"}
        expect(assigns(:hotel).errors.count).to be >= 0
        expect(response).to render_template("new")
      end
    end

  end

  describe "DELETE #delete" do

    it "delete the given hotel and redirects to hotels index" do
      hotel = FactoryGirl.create(:hotel)
      expect {
        delete :destroy, :id => hotel.id
      }.to change(Hotel, :count).by(-1)

      expect(response).to redirect_to hotels_path
    end
  end

end
