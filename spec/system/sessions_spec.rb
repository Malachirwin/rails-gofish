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
      expect(page).to have_selector('h2', text: 'Pending Games')
      expect(page).to have_selector('h2', text: 'In Progress')
      expect(page).to have_selector('h2', text: 'Finished')
    end
  end
end
