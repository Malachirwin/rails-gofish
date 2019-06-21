import React from "react"
import PlayerView from './PlayerView'
import PropTypes from "prop-types"
class GameView extends React.Component {
  componentDidMount() {
    const data = fetch(`/games/${this.props.game_id}`, { headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      credentials: 'same-origin',
    }).then(data => data.json())
    .then(data => {
      console.log(data)
      alert(data)
    });
  }

  render () {
    return (
      <PlayerView name={this.props.name} />
    );
  }
}

GameView.propTypes = {
  greeting: PropTypes.string
};
export default GameView
