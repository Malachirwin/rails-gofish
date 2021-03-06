import React from "react"
import PropTypes from "prop-types"
import CardView from './CardView'
export default class PlayerView extends React.Component {
  static propTypes = {
    player: PropTypes.object.isRequired,
    clicked: PropTypes.func.isRequired,
    targetCard: PropTypes.string.isRequired
  }

  cardClasses(rank) {
    if (rank === this.props.targetCard && this.props.player.isTurn() === true) {
      return 'highlight card-in-hand'
    }
    return 'card-in-hand'
  }

  click(rank) {
    if (this.props.player.isTurn() === true) {
      this.props.clicked(rank)
    }
  }

  renderCards() {
    return this.props.player.cards().map((c, i) => <CardView clicked={this.click.bind(this)} classes={this.cardClasses(c.rank())} key={i} cardSrc={c.src()}/>)
  }

  renderMatches() {
    return this.props.player.matches().map((match, index) => <div key={index} className="matches inbetween-match">{match.map((c, i) => <CardView clicked={() => {}} classes={'match'} key={i} cardSrc={c.src()}/>)}</div>)
  }

  render() {
    return (
      <div className="player-div">
        <h1>{this.props.player.name()}</h1>
        <div className="player-hand">{this.renderCards()}</div>
        <div className="matchesWrapper">{this.renderMatches()}</div>
      </div>
    );
  }
}
