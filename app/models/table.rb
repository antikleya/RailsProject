class Table < ApplicationRecord
  validates :width, presence: true
  belongs_to :room
  validates :room_id, uniqueness: true
end
