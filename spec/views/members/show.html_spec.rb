require 'rails_helper'

RSpec.describe 'members/show', type: :view do
  let(:member) { FactoryBot.create(:member) }

  before do
    assign(:member, member)
    render
  end

  it 'displays the member details' do
    expect(rendered).to have_content(member.member_name)
    expect(rendered).to have_content(member.member_points)
    expect(rendered).to have_content(member.executive_status ? 'Yes' : 'No')
  end
end
