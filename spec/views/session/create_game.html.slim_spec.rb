require 'rails_helper'

RSpec.describe "session/create_game.html.slim", type: :view do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'create_game' do
    it 'has text on page' do
    assign(:user, User.create(name: 'Malachi'))
    render
    expect(rendered).to match("What level do you want")
    end
  end
end
