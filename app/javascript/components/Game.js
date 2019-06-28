// import Card from './Card'
export default class Game {
  constructor(player, opponents, cardsInDeck, playerTurn, logs, playerNames, level) {
    this._player = player
    this._opponents = opponents
    this._cardsInDeck = cardsInDeck
    this._playerTurn = playerTurn
    this._playerNames = playerNames
    this._logs = logs
    this._level = level
  }

  logs() {
    return this._logs
  }

  level() {
    return this._level
  }

  playerNames() {
    return this._playerNames
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
