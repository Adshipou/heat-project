require 'rails_helper'

RSpec.describe "meetings/edit", type: :view do
  let(:meeting) { Meeting.create!(name: "Sample Meeting", date: Date.today, time: Time.now, location: "Sample Location") }

  before(:each) do
    assign(:meeting, meeting)
  end

  it "renders the edit meeting form" do
    render

    assert_select "form[action=?][method=?]", meeting_path(meeting), "post" do
      # Add assertions for form fields if needed
    end
  end
end
