import React from "react"
import PropTypes from "prop-types"
import CardView from './CardView'
export default class OpponentView extends React.Component {
  renderCards() {
    const arr = []
    for(var i = 0;i<this.props.opponent.numberOfCards();i++){
      arr.push(<CardView key={i} />)
    }
    return arr
  }

  renderMatches() {
    return this.props.opponent.matches().map((match, index) => {
      return <div key={index} className="inbetween-match"> {
        match.map((c, i) => {
          return <CardView key={i} cardSrc={c.src()}/>
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
