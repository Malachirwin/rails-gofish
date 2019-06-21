import React from "react"
import PropTypes from "prop-types"
class PlayerView extends React.Component {
  constructor(props) {
    super(props)
    this.state
  }

  render() {
    return (
      <div className="player-div">
        <h1>{this.props.player.name()}</h1>
        <h1>{this.props.player.cards().map(c => c.value()).join(', ')}</h1>
      </div>
    );
  }
}

PlayerView.propTypes = {
  name: PropTypes.string,
};
export default PlayerView
//<h1>{this.props.player.cards.join(', ')}</h1>
