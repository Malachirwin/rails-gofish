require "rails_helper"

require_relative '../support/signin_helper'

RSpec.describe "Games", type: :system do
  describe '/create_game' do
    it 'creates a game and allows only the player who is playing to select a card', js: true do
      session1, session2 = SigninHelper.create_game
      expect(session1).to have_content("It is your turn")
      expect(session2).to have_content("Waiting for Player1 to finish a turn")
      card = session1.all('.card-in-hand').last
      card.click
      expect(session1.all('.highlight').last).to eq session1.all('.card-in-hand').last
      card = session2.all('.card-in-hand').last
      card.click
      expect(session2.has_no_css?('.highlight'))
    end
  end
end
