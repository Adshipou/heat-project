require 'rails_helper'

RSpec.describe Meeting, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:meetings_members) }
    it { is_expected.to have_many(:members).through(:meetings_members) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:location) }
  end
end
