require "rails_helper"

RSpec.describe "Sessions", type: :system do
  # before do
  #   driven_by(:selenium_chrome)
  #   visit '/'
  # end

  describe '/create_game' do
    include SessionsHelper
    it 'once logged in it allows you to create a game', js: true do
      # game = Game.create(level: 'easy', player_num: 2)
      # session1 = Capybara::Session.new(:selenium_chrome, Rails.application)
      # session2 = Capybara::Session.new(:selenium_chrome, Rails.application)
      # [ session1, session2 ].each_with_index do |session, index|
      #   user = User.create(name: "Player #{index + 1}")
      #   session.visit '/'
      #   session.fill_in "Name", :with => "Malachi"
      #   session.click_button "commit"
      #   session.click_on "easy waiting for #{game.player_num - game.users.length} of 2 players"
      # end
      # session1.driver.refresh
      # # session2.driver.refresh
      # expect(session1).to have_content("The Game Has Started")
      # expect(session2).to have_content("The Game Has Started")
      # click_button 'Create'
    end
  end
end
