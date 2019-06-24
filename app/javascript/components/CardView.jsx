import React from "react"
import PropTypes from "prop-types"
import cardBack from 'images/backs_custom.jpg'
export default class CardView extends React.Component {
  render () {
    return <img src={cardBack} alt="Card Back" />
  }
}
