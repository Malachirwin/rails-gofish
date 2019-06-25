import React from 'react'
import OpponentView from 'components/OpponentView'
import Opponent from 'components/Opponent'
import { shallow } from 'enzyme';
import 'jest-enzyme'

describe("OpponentView", () => {
  let card, match, wrapper, player
  beforeEach(() => {
    card = {rank: 'A', suit: 'S', value: 'Ace of Spades'}
    match = [card, card, card, card]
    player = new Opponent({name: 'Malachi', cards_in_hand: 5, matches: [match, match]})
    wrapper = shallow(<OpponentView clicked={jest.fn()} targetPlayer="Malachi" opponent={player} />)
  });

  it('has a name', () => {
    expect(wrapper).toIncludeText('Malachi')
  });

  it('has a how many cards that the opponent has', () => {
    const matches = 8, cards = 5;
    expect(wrapper.find('CardView').length).toEqual(matches + cards)
  });

  it('highlights if selected', () => {
    expect(wrapper).toHaveClassName('.highlight-player')
  });
});
