# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Room, type: :model do
  
  context 'with valid params' do
    let(:user) { User.create(email: 'cristian@als.cl', password: '123123')}
    let(:room) { Room.create(name: 'Room 1', starts_at: 1.day.from_now, slot_qty: 10, players_per_slot: 4, creator: user) }
    
    it 'should make 10 slots' do
      expect(room.slots.count).to eql(10)
    end

    it 'should generate a quick_code' do
      expect(room.quick_code).to_not be_nil
    end
  end

end
