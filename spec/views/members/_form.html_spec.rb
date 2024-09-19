require 'rails_helper'

RSpec.describe 'members/_form', type: :view do
  context 'without errors' do
    let(:member) { FactoryBot.build(:member) }

    before do
      assign(:member, member)
      render partial: 'members/form', locals: { member: }
    end

    it 'renders the member form' do
      expect(rendered).to have_selector('form')
      expect(rendered).to have_field('member[member_name]')
      expect(rendered).to have_field('member[member_points]')
      expect(rendered).to have_unchecked_field('member[executive_status]')
    end
  end

  context 'with validation errors' do
    let(:member_with_errors) { FactoryBot.build_stubbed(:member) }

    before do
      member_with_errors.errors.add(:member_name, "can't be blank")
      assign(:member, member_with_errors)
      render partial: 'members/form', locals: { member: member_with_errors }
    end

    it 'displays validation errors when present' do
      expect(rendered).to have_content("1 error prohibited this member from being saved:")
      expect(rendered).to have_content("Member name can't be blank")
    end
  end
end
