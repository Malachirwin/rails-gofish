import React from "react"
import PropTypes from "prop-types"

export default class EndGame extends React.Component {
  static propTypes = {
    game: PropTypes.object.isRequired,
  }

  winners() {
    return this.props.game.winners().filter(pl => pl.points() === this.props.game.winners()[0].points())
  }

  others() {
    return this.props.game.winners().filter(pl => pl.points() !== this.props.game.winners()[0].points())
  }

  renderWinners() {
    if (this.winners().length == 1) {
      return <h3>{this.winners()[0].name()} won with {this.winners()[0].points()} points</h3>
    } else {
      return <h3>{this.winners().map(pl => pl.name()).join(', ')} tied with {this.winners()[0].points()} points</h3>
    }
  }

  renderRankings() {
    return this.others().map((player, i) => <h3 key={i}>{player.name()} had {player.points()} point(s)</h3>)
  }

  renderLogs() {
    const logs = this.props.game.logs().slice()
    return logs.reverse().map((log, i) => <h4 className="book" key={i}>{log}</h4>)
  }


  render () {
    return (
      <div>
        <h1>The Game is over</h1>
        {this.renderWinners()}
        {this.renderRankings()}
        <div className="flex-log">
          <div className="end_game_log"><h2 className="book">Game Logs</h2>{this.renderLogs()}</div>
        </div>
      </div>
    )
  }
}
