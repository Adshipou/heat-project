require 'rails_helper'

RSpec.describe 'members/_member', type: :view do
  let(:member) { FactoryBot.create(:member, member_name: 'John Doe', member_points: 100, executive_status: true) }

  before do
    render 'members/member', member:
  end

  it 'displays member details' do
    expect(rendered).to include('John Doe')
    expect(rendered).to include('100')
    expect(rendered).to include('Yes')
  end
end
