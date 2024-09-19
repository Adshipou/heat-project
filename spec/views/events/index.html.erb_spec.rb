require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(event_name: "Event 1", event_link: "Link 1", event_datetime: DateTime.now, event_end: DateTime.now),
      Event.create!(event_name: "Event 2", event_link: "Link 2", event_datetime: DateTime.now, event_end: DateTime.now)
    ])
  end

  it "renders a list of events" do
    render
    expect(rendered).to match(/Event 1/)
    expect(rendered).to match(/Event 2/)
    expect(rendered).to have_selector("div.event", count: 2)

  end
end
