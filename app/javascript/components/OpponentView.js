import React from "react"
import PropTypes from "prop-types"
import CardView from './CardView'
export default class OpponentView extends React.Component {
  static propTypes = {
    opponent: PropTypes.object.isRequired,
    clicked: PropTypes.func.isRequired,
    targetPlayer: PropTypes.string.isRequired
  }

  renderCards() {
    return [...Array(this.props.opponent.numberOfCards()).keys()].map(i => <CardView classes="card-back" key={i} /> )
  }

  renderMatches() {
    return this.props.opponent.matches().map((match, index) => {
      return <div key={index} className="inbetween-match"> {
        match.map((c, i) => {
          return <CardView classes='match' key={i} cardSrc={c.src()}/>
        })
      }</div>
    })
  }

  classes() {
    if (this.props.opponent.name() === this.props.targetPlayer) {
      return 'bot highlight-player'
    }
    return 'bot'
  }

  handleClick() {
    if (this.props.isTurn === true) {
      this.props.clicked(this.props.opponent.name())
    } else {
      () => {}
    }
  }

  render () {
    return (
      <div className={this.classes()} onClick={this.handleClick.bind(this)}>
        <h3>{this.props.opponent.name()}</h3>
        <div className="opponent-hand">{this.renderCards()}</div>
        <div className="matches">{this.renderMatches()}</div>
      </div>
    )
  }
}
