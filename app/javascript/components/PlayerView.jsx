import React from "react"
import PropTypes from "prop-types"
import CardView from './CardView'
export default class PlayerView extends React.Component {
  static propTypes = {
    player: PropTypes.object.isRequired,
    clicked: PropTypes.func.isRequired,
    targetCard: PropTypes.string.isRequired
  }

  constructor(props) {
    super(props)
    this.state
  }

  cardClasses(rank) {
    if (rank === this.props.targetCard) {
      return 'highlight card-in-hand'
    }
    return 'card-in-hand'
  }

  renderCards() {
    return this.props.player.cards().map((c, i) => <CardView clicked={this.props.clicked} classes={this.cardClasses(c.rank())} key={i} cardSrc={c.src()}/>)
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
