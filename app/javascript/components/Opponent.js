import Card from './Card'
export default class Opponent {
  constructor(player) {
    this._name = player.name
    this._numberOfCards = player.cards_in_hand
    this._matches = this.inflateCards(player.matches)
  }

  inflateCards(cards) {
    return cards.map(card => new Card(card.rank, card.suit))
  }

  name() {
    return this._name
  }

  numberOfCards() {
    return this._numberOfCards
  }

  matches() {
    return this._matches
  }
}
