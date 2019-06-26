class Log
  attr_reader :target, :fisher, :rank, :result
  def initialize(target:, fisher:, rank:, result:)
    @target = target
    @fisher = fisher
    @rank = rank
    @result = result
  end

  def as_json()
    {'target' => target.as_json, 'fisher' => fisher.as_json, 'rank' => rank, 'result' => result}
  end

  def self.from_json(json)
    Log.new(
      fisher: Player.from_json(json['fisher']),
      target: Player.from_json(json['target']),
      rank: json['rank'],
      result: json['result']
    )
  end
end
