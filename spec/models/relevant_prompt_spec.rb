# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RelevantPrompt, type: :model do
  # Testing the 'value' validation
  describe 'validations' do
    it 'is valid with a value' do
      relevant_prompt = RelevantPrompt.new(value: 'Some value')
      expect(relevant_prompt).to be_valid
    end

    it 'is invalid without a value' do
      relevant_prompt = RelevantPrompt.new(value: nil)
      expect(relevant_prompt).not_to be_valid
      expect(relevant_prompt.errors[:value]).to include("can't be blank")
    end

    it 'is invalid with a blank value' do
      relevant_prompt = RelevantPrompt.new(value: '')
      expect(relevant_prompt).not_to be_valid
      expect(relevant_prompt.errors[:value]).to include("can't be blank")
    end
  end

  describe 'search', search: true do
    it 'is valid with a value' do
      RelevantPrompt.create(value: 'Apple')
      RelevantPrompt.search_index.refresh
      expect(['Apple']).to eq(RelevantPrompt.search('apple').map(&:value))
    end
  end
end
