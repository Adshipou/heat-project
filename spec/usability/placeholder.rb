require 'rails_helper'

RSpec.describe "meetings/show", type: :view do
  let(:meeting) { Meeting.create(name: "Test Meeting", date: Date.today, location: "Test Location") }

  before(:each) do
    assign(:meeting, meeting)
    render
  end

  it "renders the meeting details" do
    expect(rendered).to include('<strong>Name:</strong>')
    expect(rendered).to include('<strong>Date:</strong>')
    expect(rendered).to include('<strong>Location:</strong>')
    expect(rendered).to include('Test Meeting')
    expect(rendered).to include(Date.today.to_s)
    expect(rendered).to include('Test Location')
  end

  it "renders links to edit meeting and back to meetings" do
    expect(rendered).to have_link("Edit this meeting", href: edit_meeting_path(meeting))
    expect(rendered).to have_link("Back to meetings", href: meetings_path)
  end
end
