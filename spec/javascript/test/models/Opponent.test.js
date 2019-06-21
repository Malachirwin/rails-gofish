import Opponent from 'components/Opponent'

describe("Card", () => {
  let opponent;
  beforeEach(() => {
    opponent = new Opponent({cards_in_hand: 5, matches: [], name: 'Malachi'})
  });

  it('has a name', () => {
    expect(opponent.name()).toEqual('Malachi')
  });

  it("has a matches", () => {
    expect(opponent.matches()).toEqual([])
  });

  it("has a number of cards", () => {
    expect(opponent.numberOfCards()).toEqual(5)
  });
});
