export default class Card {
  constructor(rank, suit, value) {
    this._rank = rank
    this._suit = suit
    this._value = value
  }

  suit() {
    return this._suit
  }

  rank() {
    return this._rank
  }

  value() {
    return this._value
  }
}
