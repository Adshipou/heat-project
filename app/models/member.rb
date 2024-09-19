class Member < ApplicationRecord
    has_many :meetings_members
    has_many :meetings, through: :meetings_members
    # new code
    has_many :events_members
    has_many :events, through: :events_members
end
