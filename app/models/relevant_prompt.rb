# frozen_string_literal: true

class RelevantPrompt < ApplicationRecord
  searchkick

  validates :value, presence: true, allow_blank: false
end
