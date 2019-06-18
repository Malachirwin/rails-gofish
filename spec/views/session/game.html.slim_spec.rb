require 'rails_helper'

RSpec.describe "session/game.html.slim", type: :view do
  describe 'game' do
    it 'has text on page' do
    user = User.create(name: 'Malachi')
    assign(:user, user)
    render
    expect(rendered).to match(user.name)
    end
  end
end
