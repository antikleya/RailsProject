class Score < ApplicationRecord
  validates :position, :value, presence: true
  belongs_to :room
  belongs_to :participant
end
