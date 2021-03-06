import React from "react"
import Player from './Player'
import Game from './Game'
import Opponent from './Opponent'
import PlayerView from './PlayerView'
import CardView from './CardView'
import OpponentView from './OpponentView'
import PropTypes from "prop-types"
import Pusher from 'pusher-js';
import EndGame from './EndGame'
export default class GameView extends React.Component {
  static propTypes = {
    game_id: PropTypes.number.isRequired
  }

  constructor(props) {
    super(props);
    this.state = {
      isLoaded: false,
      targetCard: '',
      targetPlayer: '',
      showLogs: true
    }
  }

  setLevel() {
    fetch(`/games/${this.props.game_id}/update_level`, {
      headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
      },
      method: 'POST',
      credentials: 'same-origin',
    })
  }

  componentDidMount() {
    this.requestGame()
    if (!window.pusher) {
      window.pusher = new Pusher('39f3a6aa23acc09d4631', {
        cluster: 'us2',
        forceTLS: true
      });
    }
    const channel = window.pusher.subscribe(`Game${this.props.game_id}`);
    channel.bind(`game-has-changed`, (data) => {
      this.requestGame()
    });
  }

  requestGame() {
    fetch(`/games/${this.props.game_id}`, { headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      credentials: 'same-origin',
    })
    .then(data => data.json())
    .then(data => {
      this.inflate(data)
      this.setState({
        isLoaded: true,
        targetCard: '',
        targetPlayer: ''
      })
    });
  }

  inflate(data) {
    const player = new Player(data.game.player, data.game.is_turn)
    const opponents = data.game.opponents.map(pl => new Opponent(pl))
    let winners
    if (data.game.winners !== false) {
      winners = data.game.winners.map(pl => new Player(pl))
    } else {
      winners = false
    }
    this.setState({game: new Game(player, opponents, data.game.cards_in_deck, data.game.player_turn, data.game.logs, data.game.player_names, data.game.level, winners)})
  }

  renderOpponents() {
    return this.state.game.opponents().map((opponent, i) => {
      return <OpponentView isTurn={this.state.game.player().isTurn()} targetPlayer={this.state.targetPlayer} clicked={this.setTargetPlayer.bind(this)} key={i} opponent={opponent}/>
    })
  }

  renderCenterDeck() {
    return [...Array(this.state.game.cardsInDeck()).keys()].map(i => <CardView classes="card-in-deck" key={i} /> )
  }

  setTargetCard(rank) {
    this.setState({targetCard: rank})
  }

  setTargetPlayer(name) {
    this.setState({targetPlayer: name})
  }

  setLevelButton() {
    if (this.state.game.playerNames().indexOf(this.state.game.player().name()) === 0) {
      return <div><button className="button change-level-button" onClick={this.setLevel.bind(this)}>Change Level</button></div>
    }
    return ''
  }

  toggleLogs() {
    this.setState({showLogs: !this.state.showLogs})
  }

  removeButton() {
    const button = document.getElementById("requestButton")
    document.getElementById("requestButtonWrapper").removeChild(button)
  }

  requestCard() {
    this.removeButton()
    fetch(`/games/${this.props.game_id}/run_round`, {
      headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
      },
      method: 'POST',
      body: JSON.stringify({
        target_card: this.state.targetCard,
        target_player: this.state.targetPlayer
      }),
      credentials: 'same-origin',
    })
  }

  button() {
    if (this.state.targetCard !== '' && this.state.targetPlayer !== '') {
      return <div id="requestButtonWrapper"><button className="button" id="requestButton" onClick={this.requestCard.bind(this)}>Request</button></div>
    }
    return ''
  }

  renderLogs() {
    if (this.state.showLogs === true) {
      const logs = this.state.game.logs().slice()
      return logs.reverse().slice(0, 20).map((log, i) => <h4 className="book" key={i}>{log}</h4>)
    }
    return ''
  }

  renderLogTitle() {
    if (this.state.showLogs === true) {
      return 'Hide Game Logs'
    }
    return 'Show Game Logs'
  }

  renderWhoIsPlaying() {
    if (this.state.game.player().isTurn() === true) {
      return <h1>It is your turn</h1>
    }
    return <h1>Waiting for {this.state.game.playerNames()[this.state.game.playerTurn()]} to finish a turn</h1>
  }

  renderLevel() {
    // checking if there is bots
    if (this.state.game.opponents().filter((p) => p.name().includes('Bot')).length > 0) {
      return (
        <div>
          <h3>level: {this.state.game.level()}</h3>
          {this.setLevelButton()}
        </div>
      )
    } else {
      return ''
    }
  }

  renderGame() {
    return (
      <div className="center" id="gameWrapper">
        {this.renderLevel()}
        {this.renderWhoIsPlaying()}
        <div className="flex-wrapper">{this.renderOpponents()}</div>
        <div className="deck">{this.renderCenterDeck()}</div>
        <PlayerView targetCard={this.state.targetCard} clicked={this.setTargetCard.bind(this)} player={this.state.game.player()} />
        {this.button()}
        <div onClick={this.toggleLogs.bind(this)} className="log"><h2 className="book">{this.renderLogTitle()}</h2>{this.renderLogs()}</div>
      </div>)
  }

  render () {
    if(this.state.isLoaded === false) {
      return <div><h1>Loading</h1></div>
    } else if (this.state.game.winners() === false) {
      return (this.renderGame())
    } else {
      return <EndGame game={this.state.game} />
    }
  }
}
