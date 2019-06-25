import Card from './Card'
export default class Player {
  constructor(player) {
    this._name = player.name
    this._isTurn = player.is_turn
    debugger
    this._cards = this.inflateCards(player.cards)
    this._matches = this.inflateCards(player.matches)
  }

  inflateCards(cards) {
    return cards.map(card => new Card(card.rank, card.suit, card.value))
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
}
