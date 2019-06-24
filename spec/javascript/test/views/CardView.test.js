import React from 'react'
import CardView from 'components/CardView'
import { shallow } from 'enzyme';
import 'jest-enzyme'

describe("CardView", () => {
  it('renders a card', () => {
    const wrapper = shallow(<CardView classes="card-in-hand" clicked={jest.fn()} cardSrc="da" />)
    expect(wrapper.find('img').length).toEqual(1)
    expect(wrapper.find('img')).toHaveClassName('.card-in-hand')
  });

  it('renders a card back if no src is passed down', () => {
    const wrapper = shallow(<CardView classes="card-back" clicked={jest.fn()}/>)
    expect(wrapper.find('img').length).toEqual(1)
    expect(wrapper.find('img')).toHaveClassName('.card-back')
  });
});
