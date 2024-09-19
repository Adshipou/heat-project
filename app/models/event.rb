class Event < ApplicationRecord
  has_many :events_members
  has_many :members, through: :events_members
end
