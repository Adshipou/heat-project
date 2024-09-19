require 'rails_helper'

RSpec.describe 'members/new', type: :view do
  before do
    assign(:member, Member.new)
    render
  end

  it 'renders new member form' do
    expect(rendered).to match(/New member/)
    expect(rendered).to have_selector('form')
  end
end
