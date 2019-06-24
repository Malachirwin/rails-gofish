import React from "react"
import PropTypes from "prop-types"
import CardView from './CardView'
export default class OpponentView extends React.Component {
  static propTypes = {
    opponent: PropTypes.object.isRequired,
    cardSrc: PropTypes.string
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

  render () {
    return (
      <div className={this.classes()} onClick={this.props.clicked.bind(this, this.props.opponent.name())}>
        <h3>{this.props.opponent.name()}</h3>
        <div className="opponent-hand">{this.renderCards()}</div>
        <div className="matches">{this.renderMatches()}</div>
      </div>
    )
  }
}
