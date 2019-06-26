require "rails_helper"

RSpec.describe "Sessions", type: :system do
  before do
    driven_by(:rack_test)
    visit "/"

  end

  describe '/login' do
    it "visits the root and logs in" do
      fill_in "Name", :with => "Malachi"
      click_button "commit"
      expect(page).to have_text("Welcome to Go Fish")
    end
  end
end
