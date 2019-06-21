// const { fetch } = require('whatwg-fetch');
const mockSuccessResponse = {game: {player: {name: 'Malachi', cards: [{rank: '3', suit: 'H', value: '3 of Hearts'}]}, opponents: [{name: 'Bob', numberOfCards: 5, matches: ['1', '2']}]}};
const mockJsonPromise = Promise.resolve(mockSuccessResponse); // 2
const mockFetchPromise = Promise.resolve({ // 3
  json: () => mockJsonPromise,
});
// jest.spyOn(global, 'fetch').mockImplementation(() => mockFetchPromise); // 4
global.fetch = () => mockFetchPromise;

import React from 'react'
import GameView from 'components/GameView'
import { shallow } from 'enzyme';
import 'jest-enzyme'




describe("PlayerView", () => {
  it('renders PlayerView', () => {
    const wrapper = shallow(<GameView />)
    expect(wrapper).toIncludeText('Loading')
    expect(wrapper.state()['isLoaded']).toEqual(false)
    process.nextTick(() => {
      // expect(wrapper.state()).toEqual({
      //   mockSuccessResponse
      // });
    });
  });
});
