class Participant < ApplicationRecord
  validates :first_name, :last_name, presence: true
  belongs_to :room
  has_many :scores, dependent: :destroy
end
