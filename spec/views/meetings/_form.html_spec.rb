require 'rails_helper'

RSpec.describe "meetings/_form", type: :view do
  let(:meeting) { Meeting.new }

  before do
    assign(:meeting, meeting)
    render partial: "meetings/form", locals: { meeting: } # Assuming your partial is named "_form.html.erb"
  end

  it "renders the form with correct form fields" do
    expect(rendered).to have_selector('form.meeting-form')
    expect(rendered).to have_selector('form[method="post"][action="/meetings"]')

    expect(rendered).to have_selector('input[type="text"][name="meeting[name]"][placeholder="Enter meeting name"]')
    expect(rendered).to have_selector('input[type="date"][name="meeting[date]"][placeholder="Select meeting date"]')
    expect(rendered).to have_selector('input[type="text"][name="meeting[location]"][placeholder="Enter meeting location"]')

    expect(rendered).to have_selector('input[type="submit"][value="Save Meeting"]')
  end
end
