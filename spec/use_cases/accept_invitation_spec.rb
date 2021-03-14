# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UseCases::AcceptInvitation, type: :use_case do
  context 'with an existing room' do
    let(:user) { User.create(email: 'pl@ay.cl', password: '123123') }
    let(:player) do
      user.add_role :player
      user
    end
    let(:team) { Team.find_by(slug: UseCases::CreateTeam.new(player: player, name: 'NIL', acronym: 'NIL').execute) }
    let(:leader) { team.leader }
    let(:room) { Room.create(name: 'ROOM', starts_at: 1.day.from_now, slot_qty: 50, players_per_slot: 5) }

    it 'joins an available room' do
      slot = described_class.new(leader: leader, quick_code: room.quick_code, slot_number: 1)
      expect(slot).not_to be_nil
    end
  end
end
