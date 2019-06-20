import React from "react"
import PlayerView from './PlayerView'
import PropTypes from "prop-types"
class GameView extends React.Component {
  render () {
    return (
      <PlayerView name={this.props.name} cards={this.props.cards} />
    );
  }
}

GameView.propTypes = {
  greeting: PropTypes.string
};
export default GameView
