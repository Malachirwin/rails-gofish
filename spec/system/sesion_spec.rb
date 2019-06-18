require "rails_helper"

RSpec.describe "Session", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "enables me to create widgets" do
    visit "/"
    fill_in "Name", :with => "Malachi"
    click_button "commit"
    expect(page).to have_text("Welcome to Go Fish")
  end
end