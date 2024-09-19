require 'rails_helper'

RSpec.describe ApplicationCable::Channel, type: :channel do
  before do
    stub_connection user_id: "123"
  end

  it 'successfully subscribes' do
    subscribe
    expect(subscription).to be_confirmed
  end
end
