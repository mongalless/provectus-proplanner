# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Task model', type: :model do
  let(:user) { build :user }
  let(:goal) { build :goal, user: user }
  let(:event) { build :event, goal: goal }
  let(:task) { build :task, event: event }
  describe 'validating Task model with attributes' do
    it 'is valid with valid attributes' do
      expect(goal).to be_valid
    end
  end
end
