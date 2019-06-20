import Enzyme from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
Enzyme.configure({ adapter: new Adapter() });

import React from 'react'
import GameView from '../../../app/javascript/components/GameView'
import { shallow } from 'enzyme';
import 'jest-enzyme'
describe("PlayerView", () => {
  it('renders PlayerView', () => {
    const wrapper = shallow(<GameView name='Malachi' cards={['Ace of Hearts', 'Ace of Dimonds']}/>)
    expect(wrapper.find('PlayerView').length).toEqual(1)
  });
});
