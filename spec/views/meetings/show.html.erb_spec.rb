require 'rails_helper'

RSpec.describe "meetings/show", type: :view do
  before(:each) do
    @meeting = assign(:meeting, Meeting.create!(name: "Sample Meeting", date: Date.today, time: Time.now, location: "Sample Location"))
  end

  it "renders attributes in <p>" do
    render

    expect(rendered).to match(/#{Regexp.escape(@meeting.name)}/)
    # Add assertions for other attributes if needed
  end
end
