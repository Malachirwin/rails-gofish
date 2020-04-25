require "rails_helper"

require_relative '../support/signin_helper'

RSpec.describe "Games", type: :system do
  describe '/create_game' do
    it 'adds bots', js: true do
      session1 = SigninHelper.start_sessions(1).first
      SigninHelper.login([session1])
      session1.click_on 'Create Game'
      session1.fill_in :game_player_num, with: 5
      session1.click_on 'Create'
      session1.click_on 'Start Now With Bots'
      expect(session1).to have_text('It is your turn')
      expect(session1).to have_text('Bot 1')
      expect(session1).to have_text('Bot 4')
    end
  end
end
