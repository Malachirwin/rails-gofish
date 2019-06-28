import React from 'react'
import EndGame from 'components/EndGame'
import Player from 'components/Player'
import Game from 'components/Game'
import { shallow, mount } from 'enzyme';
import 'jest-enzyme'
describe("EndGame", () => {
  it('renders the end game state', () => {
    const matches = [[{rank: '2', suit: 'H', value: '2 of Hearts'}, {rank: '2', suit: 'D', value: '2 of Diamonds'}], [{rank: '4', suit: 'H', value: '4 of Hearts'}, {rank: '4', suit: 'D', value: '4 of Diamonds'}]]
    const logs = ['player 1 asked for a 9 and went fishing']
    const winners = [new Player({name: 'Malachi', cards: [], matches: matches})]
    const wrapper = mount(<EndGame game={new Game("player", "opponents", "cardsInDeck", "playerTurn", logs, "playerNames", "level", winners)} />)
    expect(wrapper).toIncludeText('Malachi won with 2 points')
    expect(wrapper).toIncludeText('player 1 asked for a 9 and went fishing')
  });

  it('renders a tie', () => {
    const matches = [[{rank: '2', suit: 'H', value: '2 of Hearts'}, {rank: '2', suit: 'D', value: '2 of Diamonds'}], [{rank: '4', suit: 'H', value: '4 of Hearts'}, {rank: '4', suit: 'D', value: '4 of Diamonds'}]]
    const logs = ['player 1 asked for a 9 and went fishing']
    const player = new Player({name: 'Malachi', cards: [], matches: matches})
    const player2 = new Player({name: 'Bob', cards: [], matches: matches})
    const winners = [player, player2]
    const wrapper = mount(<EndGame game={new Game("player", "opponents", "cardsInDeck", "playerTurn", logs, "playerNames", "level", winners)} />)
    expect(wrapper).toIncludeText('Malachi, Bob tied with 2 points')
  });
});
