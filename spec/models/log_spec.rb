require 'rails_helper'
describe Player do
  before do
    @fisher = Player.new(name: 'Malachi')
    @target = Player.new(name: 'Bob')
    @rank = 'A'
    @result = 'Ace of Diamonds'
    @log = Log.new(fisher: @fisher, target: @target, rank: @rank, result: @result)
  end

  it 'has a fisher' do
    expect(@log.fisher).to eq @fisher
  end

  it 'has a rank' do
    expect(@log.rank).to eq @rank
  end

  it 'has a target' do
    expect(@log.target).to eq @target
  end

  it 'has a result' do
    expect(@log.result).to eq @result
  end

  it 'turns into json hash' do
    json = @log.as_json
    expect(json).to include_json fisher: @fisher.as_json
    expect(json).to include_json target: @target.as_json
    expect(json).to include_json result: @result
    expect(json).to include_json rank: @rank
  end

  it 'Comes to from json state' do
    json = @log.as_json
    log = Log.from_json(json)
    expect(log.rank).to eq @rank
    expect(log.result).to eq @result
    expect(log.fisher.name).to eq @fisher.name
    expect(log.target.name).to eq @target.name
  end
end
