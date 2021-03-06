import React from "react"
import PropTypes from "prop-types"
const hash = {}
const array = []
const suits = ['s', 'h', 'd', 'c']
const ranks = ['a', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'j', 'q', 'k']
ranks.forEach(rank => (
  suits.forEach((suit) => {
    hash[`${suit}${rank}`] = require(`images/${suit}${rank}.png`)
  })
))
hash['cardBack'] = require(`images/backs_custom.jpg`)

export default class CardView extends React.Component {
  static propTypes = {
    classes: PropTypes.string.isRequired,
    cardSrc: PropTypes.string,
    clicked: PropTypes.func
  }

  render () {
    if (this.props.cardSrc !== undefined) {
      return <img onClick={() => this.props.clicked(this.props.cardSrc.slice(1).toUpperCase())} className={this.props.classes} src={hash[this.props.cardSrc]} alt="Card" />
    } else {
      return <img className={this.props.classes} src={hash['cardBack']} alt="Card Back" />
    }
  }
}
