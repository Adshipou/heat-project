require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:events_members) }
    it { is_expected.to have_many(:members).through(:events_members) }
  end
end
