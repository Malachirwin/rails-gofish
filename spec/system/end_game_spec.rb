require "rails_helper"

require_relative '../support/signin_helper'

RSpec.describe "Games", type: :system do
  describe '/create_game' do
    it 'views the end game', js: true do
      session1, session2 = SigninHelper.start_sessions(2)
      SigninHelper.login([session1, session2])
      user = User.find_by(name: 'Player1')
      user2 = User.find_by(name: 'Player2')
      game = Game.create(player_num: 2, go_fish_game: SigninHelper.game, level: 'hard', start_at: Time.zone.now)
      game_user = GameUser.create(game_id: game.id, user_id: user.id)
      game_user2 = GameUser.create(game_id: game.id, user_id: user2.id)
      session1.visit "/games/#{game.id}"
      session2.visit "/games/#{game.id}"
      card = session1.all('.card-in-hand').last
      card.click
      bot = session1.all('.bot').last
      bot.click
      session1.click_on 'Request'
      session1.driver.refresh
      expect(session1).to have_text('The Game is over')
    end
  end
end
