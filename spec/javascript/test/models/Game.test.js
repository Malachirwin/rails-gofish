import Game from 'components/Game'
import Player from 'components/Player'
import Opponent from 'components/Opponent'
// import Game from '../../../../app/javascript/components/Game'

describe("Card", () => {
  let game, player, opponent;
  beforeEach(() => {
    player = new Player({cards: [{rank: '2', suit: 'H', value: '2 of Hearts'}, {rank: '4', suit: 'D', value: '2 of Diamonds'}], matches: [], name: 'Malachi'})
    opponent = new Opponent({cards_in_hand: 5, matches: [], name: 'Bob'})
    game = new Game(player, [opponent], 42, 0)
  });

  it("has a player", () => {
    expect(game.player()).toEqual(player);
  });

  it("has a opponents", () => {
    expect(game.opponents().length).toEqual(1);
    expect(game.opponents()[0]).toEqual(opponent);
  });

  it("has a number of cards that are left in the deck", () => {
    expect(game.cardsInDeck()).toEqual(42);
  });

  it("has a playerTurn", () => {
    expect(game.playerTurn()).toEqual(0);
  });
});
