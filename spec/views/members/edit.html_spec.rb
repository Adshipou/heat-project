require 'rails_helper'

RSpec.describe 'members/edit', type: :view do
  let(:member) { FactoryBot.create(:member) }

  before do
    assign(:member, member)
    render
  end

  it 'renders the edit member form' do
    expect(rendered).to match(/Editing member/)
    expect(rendered).to have_selector('form')
  end
end
