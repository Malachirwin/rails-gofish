require "rails_helper"

require_relative '../support/signin_helper'

RSpec.describe "Games", type: :system do
  describe '/show' do
    it 'allows you to request a card' do
      session1, session2 = SigninHelper.create_game
      card = session1.find('.card-in-hand', match: :first)
      card.click
      bot = session1.find('.bot', match: :first)
      bot.click
      session1.click_on 'Request'
      session1.driver.refresh
      expect(session1.all('.card-in-hand').length).to be > 5
    end
  end
end
