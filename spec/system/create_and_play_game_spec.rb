require "rails_helper"

require_relative '../support/signin_helper'

RSpec.describe "Games", type: :system do
  describe '/create_game' do
    it 'once logged in it allows you to create a game', js: true do
      session1, session2 = SigninHelper.start_sessions(2)
      SigninHelper.login([session1, session2])
      session1.click_on 'Create Game'
      session1.fill_in :game_player_num, with: 2
      session1.click_on 'Create Game'
      game = Game.find_by(player_num: 2)
      SigninHelper.join([session2], game)
      game.reload
      session1.driver.refresh
      expect(session1).to have_content("The Game Has Started")
      expect(session2).to have_content("The Game Has Started")
    end

    it 'allows you to click cards and highlight it' do
      session1, session2 = SigninHelper.create_game
      card = session1.find('.card-in-hand', match: :first)
      card.click
      expect(session1.find('.highlight', match: :first)).to eq session1.find('.card-in-hand', match: :first)
    end

    it 'doesn\'t allows you to click cards and highlight it if it is not your turn' do
      session1, session2 = SigninHelper.create_game
      card = session2.all('.card-in-hand').last
      card.click
      expect(session2.has_no_css?('.highlight'))
    end
  end
end
