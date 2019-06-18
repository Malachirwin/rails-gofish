require 'rails_helper'

RSpec.describe "game/new.html.slim", type: :view do
  describe 'New' do
    it 'has text on page' do
    render
    expect(rendered).to match("Hello from react-rails.")
    end
  end
end
