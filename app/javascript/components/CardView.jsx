import React from "react"
import PropTypes from "prop-types"
const hash = {}
const array = []
const suits = ['s', 'h', 'd', 'c']
const ranks = ['a', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'j', 'q', 'k']
suits.forEach(suit => array.push(...ranks.map(rank => `${suit}${rank}`)))
array.forEach((card) => {
  hash[card] = require(`images/${card}.png`)
})
hash['cardBack'] = require(`images/backs_custom.jpg`)

export default class CardView extends React.Component {
  render () {
    if (this.props.cardSrc !== undefined) {
      return <img className={this.props.classes} src={hash[this.props.cardSrc]} alt="Card" />
    } else {
      return <img className={this.props.classes} src={hash['cardBack']} alt="Card Back" />
    }
  }
}
