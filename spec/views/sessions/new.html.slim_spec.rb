require 'rails_helper'

RSpec.describe "sessions/new.html.slim", type: :view do
  describe 'new' do
    it 'has text on page' do
    user = User.new
    assign(:user, user)
    render
    expect(rendered).to match('Name')
    end
  end
end
