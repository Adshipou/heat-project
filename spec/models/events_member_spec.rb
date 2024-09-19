require 'rails_helper'

RSpec.describe EventsMember, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:event) }
    it { is_expected.to belong_to(:member) }
  end
end
