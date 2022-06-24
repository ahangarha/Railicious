require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:the_user) { User.create!(name: 'Omid', email: 'omid@domain.com', password: '123123') }
  let(:the_food) { Food.new(user: the_user, name: 'Potato', measurement_unit: 'KG', price: 1) }

  it 'Given food is valid' do
    expect(the_food).to be_valid
  end

  it 'must have a user' do
    the_food.user = nil
    expect(the_food).to_not be_valid
  end

  context 'Food name' do
    it 'cannot be blank' do
      the_food.name = ''
      expect(the_food).to_not be_valid
    end

    it 'can have upto 255 characters' do
      the_food.name = 'a' * 255
      expect(the_food).to be_valid
    end

    it 'cannot be longer than 255' do
      the_food.name = 'a' * 256
      expect(the_food).to_not be_valid
    end
  end

  context 'Measurement' do
    it 'cannot be blank' do
      the_food.measurement_unit = ''
      expect(the_food).to_not be_valid
    end

    it 'can have upto 255 characters' do
      the_food.measurement_unit = 'a' * 255
      expect(the_food).to be_valid
    end

    it 'cannot be longer than 255' do
      the_food.measurement_unit = 'a' * 256
      expect(the_food).to_not be_valid
    end
  end

  context 'Price' do
    it 'should present' do
      the_food.price = nil
      expect(the_food).to_not be_valid
    end

    it 'cannot be a letter' do
      the_food.price = 'a'
      expect(the_food).to_not be_valid
    end

    it 'cannot cannot be negative' do
      the_food.price = -1
      expect(the_food).to_not be_valid
    end
  end
end
