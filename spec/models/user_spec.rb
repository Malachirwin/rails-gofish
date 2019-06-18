require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User validations' do
    it 'can not have a blank name' do
      user = User.new(name: '')
      expect(user.save).to eq(false)
    end

    it 'is valid with a name' do
      user = User.new(name: 'Malachi')
      expect(user.save).to eq(true)
    end
  end
end
