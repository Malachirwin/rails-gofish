import Card from 'components/Card'

describe("Card", () => {
  let card;
  beforeEach(() => {
    card = new Card('2', 'H', '2 of Hearts')
  });

  it('has a rank', () => {
    expect(card.rank()).toEqual('2')
  });

  it("has a suit", () => {
    expect(card.suit()).toEqual('H')
  });

  it("has a value", () => {
    expect(card.value()).toEqual('2 of Hearts')
  });
});
