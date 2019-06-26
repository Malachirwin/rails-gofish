class Log
  attr_reader :target, :fisher, :rank, :result
  def initialize(target:, fisher:, rank:, result:)
    @target = target
    @fisher = fisher
    @rank = rank
    @result = result
  end

  def to_player_json
    if result == "Go Fish"
      "#{fisher.name} asked for the #{rank}'s from #{target.name} and went fishing"
    else
      "#{fisher.name} took all the #{rank}'s from #{target.name}"
    end
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
