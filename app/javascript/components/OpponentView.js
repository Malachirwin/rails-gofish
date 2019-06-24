import React from "react"
import PropTypes from "prop-types"
import CardView from './CardView'
export default class OpponentView extends React.Component {
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

  render () {
    return (
      <div className="bot">
        <h3>{this.props.opponent.name()}</h3>
        <div className="opponent-hand">{this.renderCards()}</div>
        <div className="matches">{this.renderMatches()}</div>
      </div>
    )
  }
}
