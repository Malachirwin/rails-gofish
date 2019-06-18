require 'rails_helper'
RSpec.describe SessionHelper, type: :helper do
  describe "log_in" do
    it "sets the session[:user_id]" do
      user = User.create(name: 'Malachi')
      helper.log_in(user)
      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe "logged_in?" do
    it "returns false if not logged in" do
      user = User.create(name: 'Malachi')
      expect(helper.logged_in?).to eq(false)
    end

    it "returns true if logged in" do
      user = User.create(name: 'Malachi')
      helper.log_in(user)
      expect(helper.logged_in?).to eq(true)
    end
  end

  describe "current_user" do
    it "returns the current user" do
      user = User.create(name: 'Malachi')
      helper.log_in(user)
      expect(helper.current_user).to eq(user)
    end
  end

  describe "log_out" do
    it "resets the current user" do
      user = User.create(name: 'Malachi')
      helper.log_in(user)
      expect(session[:user_id]).to eq(user.id)
      helper.log_out
      expect(helper.current_user).to eq(nil)
    end
  end
end
