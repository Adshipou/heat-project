require 'rails_helper'

RSpec.describe 'members/index', type: :view do
  let(:members) { FactoryBot.create_list(:member, 2) }

  before do
    assign(:members, members)
    render
  end

  it 'displays all members' do
    members.each do |member|
      expect(rendered).to have_content(member.member_name)
    end
  end
end
