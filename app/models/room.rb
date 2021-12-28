class Room < ApplicationRecord
  validates :name, presence: true
  has_one :table, dependent: :destroy
  has_many :admins
  has_many :users, through: :admins
  has_many :participants, dependent: :destroy
end
