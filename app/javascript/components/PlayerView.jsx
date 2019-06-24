import React from "react"
import PropTypes from "prop-types"
import CardView from './CardView'
export default class PlayerView extends React.Component {
  static propTypes {
    player: PropTypes.object.isRequired
  }

  constructor(props) {
    super(props)
    this.state
  }

  renderCards() {
    return this.props.player.cards().map((c, i) => <CardView classes="card-in-hand" key={i} cardSrc={c.src()}/>)
  }

  render() {
    return (
      <div className="player-div">
        <h1>{this.props.player.name()}</h1>
        <div className="player-hand">{this.renderCards()}</div>
      </div>
    );
  }
}
