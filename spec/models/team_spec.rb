# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Team, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  context 'Before creation' do

    it 'must not have a nil slug' do
      team = Team.create(name: 'TeamNull', acronym: 'NIL')
      expect(team.slug).not_to be_nil
    end
    it 'must create a valid slug' do
      team = Team.create(name: 'InfinityKings', acronym: 'INK')
      expect(team.slug).to eql 'infinitykings'
    end

    context 'with the same name' do
      it 'must have different slugs' do
        team1 = Team.create(name: 'Team Azuka', acronym: 'AZK')
        team2 = Team.create(name: 'Team Azuka', acronym: 'TAZ')
        expect(team1.slug).not_to eql(team2.slug)
      end
    end
  end
end
