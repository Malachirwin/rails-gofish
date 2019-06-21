import React from 'react'
import PlayerView from 'components/PlayerView'
import Player from 'components/Player'
import { shallow } from 'enzyme';
import 'jest-enzyme'
describe("PlayerView", () => {
  it('renders PlayerView', () => {
    const player = new Player({cards: [{rank: '2', suit: 'H', value: '2 of Hearts'}, {rank: '4', suit: 'D', value: '2 of Diamonds'}], matches: [], name: 'Malachi'})
    const wrapper = shallow(<PlayerView player={player}/>)
    expect(wrapper).toIncludeText('Malachi')
  });
});
