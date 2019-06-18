require 'rails_helper'

RSpec.describe SessionController, type: :controller do
  include SessionHelper
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #game" do
    it "returns http success" do
      @user = User.create(name: 'Malachi')
      log_in @user
      get :game
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create_game" do
    it "returns http success" do
      @user = User.create(name: 'Malachi')
      log_in @user
      get :create_game
      expect(response).to have_http_status(:success)
    end
  end
end
