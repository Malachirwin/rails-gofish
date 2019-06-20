import Enzyme from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
Enzyme.configure({ adapter: new Adapter() });

import React from 'react'
import PlayerView from '../../../app/javascript/components/PlayerView'
import { shallow } from 'enzyme';
import 'jest-enzyme'
describe("PlayerView", () => {
  it('renders PlayerView', () => {
    const wrapper = shallow(<PlayerView name='Malachi' cards={['Ace of Hearts', 'Ace of Dimonds']}/>)
    expect(wrapper).toIncludeText('Malachi')
  });
});
