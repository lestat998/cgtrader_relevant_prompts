class RelevantPrompt < ApplicationRecord
  searchkick

  validates :value, presence: true, allow_blank: false
end
