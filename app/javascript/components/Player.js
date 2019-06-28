import Card from './Card'
export default class Player {
  constructor(player, isTurn) {
    this._name = player.name
    this._isTurn = isTurn
    this._cards = this.inflateCards(player.cards)
    this._matches = this.inflateMatches(player.matches)
  }

  inflateCards(cards) {
    return cards.map(card => new Card(card.rank, card.suit, card.value))
  }

  inflateMatches(matches) {
    return matches.map(match => match.map(card => new Card(card.rank, card.suit, card.value)))
  }

  name() {
    return this._name
  }

  cards() {
    return this._cards
  }

  matches() {
    return this._matches
  }

  isTurn() {
    return this._isTurn
  }

  points() {
    return this.matches().length
  }
}
