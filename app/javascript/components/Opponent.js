import Card from './Card'
export default class Opponent {
  constructor(player) {
    this._name = player.name
    this._numberOfCards = player.cards_in_hand
    this._matches = this.inflateMatches(player.matches)
  }

  inflateMatches(matches) {
    return matches.map(match => match.map(card => new Card(card.rank, card.suit)))
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
