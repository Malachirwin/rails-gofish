import Player from 'components/Player'

describe("Card", () => {
  let player;
  beforeEach(() => {
    player = new Player({cards: [{rank: '2', suit: 'H', value: '2 of Hearts'}, {rank: '4', suit: 'D', value: '2 of Diamonds'}], matches: [], name: 'Malachi'})
  });

  it('has a name', () => {
    expect(player.name()).toEqual('Malachi')
  });

  it("has a matches", () => {
    expect(player.matches()).toEqual([])
  });

  it("has a cards", () => {
    const cardsArray = [{"_rank": "2", "_suit": "H", "_value": "2 of Hearts"}, {"_rank": "4", "_suit": "D", "_value": "2 of Diamonds"}]
    expect(JSON.stringify(player.cards())).toContain(JSON.stringify(cardsArray))
  });
});
