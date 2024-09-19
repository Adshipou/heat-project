class Meeting < ApplicationRecord
	# has_many :attendances
	# has_many :members, through: :attendances
	has_many :budget_items
	has_many :announcements
	has_many :meetings_members
	has_many :members, through: :meetings_members
	
	validates :name, presence: true
	validates :date, presence: true
	validates :location, presence: true
  end