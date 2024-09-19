require 'rails_helper'

RSpec.describe MeetingsMember, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:meeting) }
    it { is_expected.to belong_to(:member) }
  end
end
