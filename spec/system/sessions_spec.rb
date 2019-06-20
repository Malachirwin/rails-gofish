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

  describe '/create_game' do
    it 'once logged in it allows you to create a game' do
      fill_in "Name", :with => "Malachi"
      click_button "commit"
      click_link 'Create Game'
      expect(page).to have_text("What level do you want")
      click_button 'Create'
      binding.pry
      # expect(page.has_route?).to eq(true)
    end
  end
end