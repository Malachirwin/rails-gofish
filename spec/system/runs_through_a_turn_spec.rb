require "rails_helper"

require_relative '../support/signin_helper'

RSpec.describe "Games", type: :system do
  describe '/show' do
    it 'allows you to request a card' do
      session1, session2, session3 = SigninHelper.start_sessions(3)
      SigninHelper.login([session1, session2, session3])
      session1.click_on 'Create Game'
      session1.fill_in :game_player_num, with: 3
      session1.click_on 'Start Game'
      game = Game.find_by(player_num: 3)
      SigninHelper.join([session2, session3], game)
      card = session1.all('.card-in-hand').last
      card.click
      bot = session1.all('.bot').last
      bot.click
      session1.click_on 'Request'
      session1.driver.refresh
      expect(session1.all('.card-in-hand').length).to be > 5
      expect(session1).to have_text('Game Logs')
      expect(session1.all('.book').length).to eq 2
    end
  end
end
