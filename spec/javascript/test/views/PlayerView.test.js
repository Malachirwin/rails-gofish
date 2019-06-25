import React from 'react'
import PlayerView from 'components/PlayerView'
import Player from 'components/Player'
import { shallow, mount } from 'enzyme';
import 'jest-enzyme'
describe("PlayerView", () => {
  it('renders PlayerView', () => {
    const player = new Player({cards: [{rank: '2', suit: 'H', value: '2 of Hearts'}, {rank: '4', suit: 'D', value: '2 of Diamonds'}], matches: [], name: 'Malachi', isTurn: true})
    const wrapper = shallow(<PlayerView targetCard="" clicked={jest.fn()} player={player}/>)
    expect(wrapper).toIncludeText('Malachi')
  });

  it('renders highlighted class', () => {
    const player = new Player({cards: [{rank: '2', suit: 'H', value: '2 of Hearts'}, {rank: '4', suit: 'D', value: '2 of Diamonds'}], matches: [], name: 'Malachi', isTurn: true})
    const wrapper = mount(<PlayerView targetCard="2" clicked={jest.fn()} player={player}/>)
    expect(wrapper.find('.highlight').length).toEqual(1)
  });

  it('doesn\'t render highlighted class if it is not your turn', () => {
    const player = new Player({cards: [{rank: '2', suit: 'H', value: '2 of Hearts'}, {rank: '4', suit: 'D', value: '2 of Diamonds'}], matches: [], name: 'Malachi', isTurn: false})
    const wrapper = mount(<PlayerView targetCard="2" clicked={jest.fn()} player={player}/>)
    expect(wrapper.find('.highlight').length).toEqual(0)
  });
});
