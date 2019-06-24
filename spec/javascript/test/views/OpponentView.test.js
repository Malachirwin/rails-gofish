import React from 'react'
import OpponentView from 'components/OpponentView'
import Opponent from 'components/Opponent'
import { shallow } from 'enzyme';
import 'jest-enzyme'

describe("OpponentView", () => {
  it('has a name', () => {
    const player = new Opponent({name: 'Malachi', cards_in_hand: 5, matches: []})
    const wrapper = shallow(<OpponentView clicked={jest.fn()} opponent={player} />)
    expect(wrapper).toIncludeText('Malachi')
  });

  it('has a how many cards that the opponent has', () => {
    const card = {rank: 'A', suit: 'S', value: 'Ace of Spades'}
    const match = [card, card, card, card]
    const player = new Opponent({name: 'Malachi', cards_in_hand: 5, matches: [match, match]})
    const wrapper = shallow(<OpponentView clicked={jest.fn()} targetPlayer="Malachi" opponent={player} />)
    const matches = 8, cards = 5;
    expect(wrapper.find('CardView').length).toEqual(matches + cards)
  });

  it('highlights if selected', () => {
    const player = new Opponent({name: 'Malachi', cards_in_hand: 5, matches: []})
    const wrapper = shallow(<OpponentView clicked={jest.fn()} targetPlayer="Malachi" opponent={player} />)
    expect(wrapper).toHaveClassName('.highlight-player')
  });
});
