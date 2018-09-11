require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns @users" do
      user = FactoryGirl.create(:user)
      get :index
      expect(assigns(:users)).to eq([user])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

  end

  describe "GET edit" do
    let(:user) { FactoryGirl.create(:user) }

    it "assigns @user" do
      get :edit, { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it "returns the edit template" do
      get :edit, { id: user.id }
      expect(response).to render_template("edit")
    end
  end

  describe "PUT update/:id" do
    let(:user) { FactoryGirl.create(:user) }
    let(:attr) do
      { :first_name => 'hacked!' }
    end

    context "when given valid parameters" do
      before(:each) do
        put :update, id: user.id, user: attr
        user.reload
      end

      it { expect(user.first_name).to eql(attr[:first_name]) }
      it { expect(response).to redirect_to(users_path) }
      
    end

    context 'when the property does not exist' do
      it 'raises a not found error' do
        expect { put :update, id: 0, user: attr }.to raise_error ActiveRecord::RecordNotFound
      end
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

  describe "POST create" do

    context "when user object is valid" do
      it "creates a User and returns to the Users index" do
        post :create, :user => {email: "my@email.com", first_name: "Nome", last_name: "Cognome", password: "secret!"}
        expect(assigns(:user)).to be_valid
        expect(response).to redirect_to users_path
      end
    end

    context "when user object is not valid 'cause of missing parameters" do
      it "should have errors and render the new template" do
        post :create, :user => {:first_name => "My new user"}
        expect(assigns(:user).errors.count).to be >= 0
        expect(response).to render_template("new")
      end
    end

  end

  describe "DELETE #delete" do

    it "delete the given user and redirects to users index" do
      user = FactoryGirl.create(:user)
      expect {
        delete :destroy, :id => user.id
      }.to change(User, :count).by(-1)

      expect(response).to redirect_to users_path
    end
  end

end
