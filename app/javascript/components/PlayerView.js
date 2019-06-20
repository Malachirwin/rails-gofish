import React from "react"
import PropTypes from "prop-types"
class PlayerView extends React.Component {
  render () {
    return (
      <div className="player-div">
        <h1>{this.props.name}</h1>
        <h1>{this.props.cards.join(', ')}</h1>
      </div>
    );
  }
}

PlayerView.propTypes = {
  name: PropTypes.string,
  cards: PropTypes.array
};
export default PlayerView
