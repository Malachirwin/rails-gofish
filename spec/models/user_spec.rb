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

    it 'can not create to users with the same name' do
      user = User.create(name: 'Malachi')
      user2 = User.new(name: 'Malachi')
      user3 = User.new(name: 'MaLaChI')
      expect(user2.save).to eq false
      expect(user3.save).to eq false
    end
  end
end
