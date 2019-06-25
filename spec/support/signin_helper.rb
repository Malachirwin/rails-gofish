module SigninHelper
  def self.start_sessions(x)
    return Array.new(x).reduce([]) { |arr| arr.push Capybara::Session.new(:selenium_chrome_headless, Rails.application) }
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
end
