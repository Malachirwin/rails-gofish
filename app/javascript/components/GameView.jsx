import React from "react"
import Player from './Player'
import Game from './Game'
import Opponent from './Opponent'
import PlayerView from './PlayerView'
import CardView from './CardView'
import OpponentView from './OpponentView'
import PropTypes from "prop-types"
export default class GameView extends React.Component {
  constructor(props) {
    super(props);
    this.state = { isLoaded: false }
  }

  componentDidMount() {
    fetch(`/games/${this.props.game_id}`, { headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      credentials: 'same-origin',
    })
    .then(data => data.json())
    .then(data => {
      console.log(data)
      this.inflate(data)
      this.setState({isLoaded: true})
    });
  }

  inflate(data) {
    const player = new Player(data.game.player)
    const opponents = data.game.opponents.map(pl => new Opponent(pl))
    this.setState({game: new Game(player, opponents, data.game.cards_in_deck, data.game.player_turn)})
  }

  renderOpponents() {
    return this.state.game.opponents().map((opponent, i) => {
      return <OpponentView key={i} opponent={opponent}/>
    })
  }

  renderCenterDeck() {
    return [...Array(this.state.game.cardsInDeck()).keys()].map(i => <CardView classes="card-in-deck" key={i} /> )
  }

  render () {
    if(this.state.isLoaded === false) {
      return <div><h1>Loading</h1></div>
    } else {
      return (
        <div className="center">
          <div className="flex-wrapper">{this.renderOpponents()}</div>
          <div className="deck">{this.renderCenterDeck()}</div>
          <PlayerView player={this.state.game.player()} />
        </div>
      )
    }
  }
}

// GameView.propTypes = {
//   greeting: PropTypes.string
// };
// export default GameView
