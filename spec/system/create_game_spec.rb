require "rails_helper"

RSpec.describe "Sessions", type: :system do
  before do
    driven_by(:selenium_chrome)
    visit '/'
  end

  describe '/create_game' do
    include SessionsHelper
    it 'once logged in it allows you to create a game', :js do
      user1 = User.create(name: 'Malachi')
      user2 = User.create(name: 'Jimmy')
      user3 = User.create(name: 'Fred')
      user4 = User.create(name: 'Bob')
      fill_in "Name", :with => "Malachi"
      click_button "commit"
      game = Game.create(level: 'easy', player_num: 4)
      # game_user1 = GameUser.create(game_id: game.id, user_id: user1.id)
      game_user2 = GameUser.create(game_id: game.id, user_id: user2.id)
      game_user3 = GameUser.create(game_id: game.id, user_id: user3.id)
      game_user4 = GameUser.create(game_id: game.id, user_id: user4.id)
      visit "/games/#{game.id}"
      # expect(page).to have_text("What level do you want")
      # click_button 'Create'
    end
  end
end
