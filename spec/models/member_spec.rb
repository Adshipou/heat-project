require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:meetings_members) }
    it { is_expected.to have_many(:meetings).through(:meetings_members) }
    it { is_expected.to have_many(:events_members) }
    it { is_expected.to have_many(:events).through(:events_members) }
  end
end
