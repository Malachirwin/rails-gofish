// import Card from './Card'
export default class Game {
  constructor(player, opponents, cardsInDeck, playerTurn, logs) {
    this._player = player
    this._opponents = opponents
    this._cardsInDeck = cardsInDeck
    this._playerTurn = playerTurn
    this._logs = logs
  }

  logs() {
    return this._logs
  }

  player() {
    return this._player
  }

  playerTurn() {
    return this._playerTurn
  }

  cardsInDeck() {
    return this._cardsInDeck
  }

  opponents() {
    return this._opponents
  }
}
