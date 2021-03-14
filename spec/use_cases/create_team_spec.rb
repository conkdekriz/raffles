# frozen_string_literal: true
require 'rails_helper'

RSpec.describe UseCases::CreateTeam, type: :use_case do
  pending "add some examples to (or delete) #{__FILE__}"

  context 'Before creation' do
    it 'must generate a slug' do
      player = User.create(email: 'test123@example.com', password: '123123123')
      slug = UseCases::CreateTeam.new(player: player, name: 'InfinityKings', acronym:'INK').execute
      expect(slug).not_to be_nil
    end
  end
end
