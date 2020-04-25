module SigninHelper
  def self.start_sessions(x)
    x.times.map { Capybara::Session.new(:selenium_chrome_headless, Rails.application) }
  end

  def self.login(sessions)
    sessions.each_with_index do |session, index|
      session.visit '/'
      session.fill_in "Name", :with => "Player #{index + 1}"
      session.click_button "commit"
    end
  end

  def self.join sessions, game
    sessions.each do |session|
      session.driver.refresh
      game.reload
      session.click_on "Waiting for #{game.player_num - game.users.length} of #{game.player_num} players"
    end
  end

  def self.create_game
    session1, session2 = SigninHelper.start_sessions(2)
    SigninHelper.login([session1, session2])
    session1.click_link 'Create Game'
    session1.fill_in :game_player_num, with: 2
    session1.click_on 'Create'
    game = Game.find_by(player_num: 2)
    SigninHelper.join([session2], game)
    game.reload
    session1.driver.refresh
    [session1, session2]
  end

  def self.game
    player = Player.new(name: 'Player1', cards: [Card.new(rank: 'A', suit: 'H'), Card.new(rank: 'A', suit: 'C'), Card.new(rank: 'A', suit: 'S')])
    player2 = Player.new(name: 'Player2', cards: [Card.new(rank: 'A', suit: 'D')])
    game = GoFishGame.new(player_names: ['Player 1', 'Player 2'], player_num: 2, players: [player, player2], deck: CardDeck.new(cards: []))
    game
  end
end
