import React from "react"
import PropTypes from "prop-types"
import CardView from './CardView'
class PlayerView extends React.Component {
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

PlayerView.propTypes = {
  name: PropTypes.string,
};
export default PlayerView
//<h1>{this.props.player.cards.join(', ')}</h1>
