# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe '/events', type: :request do
#   let(:valid_event_attributes) { { name: 'Test Event', date: Date.today, location: 'Test Location' } }
#   let(:invalid_event_attributes) { { name: '', date: Date.yesterday, location: '' } }
# end

# describe 'GET /index' do
#   it 'renders a successful response' do
#     create_event
#     get events_url
#     expect(response).to be_successful
#   end
# end

# describe 'GET /show' do
#   it 'renders a successful response' do
#     event = create_event
#     get event_url(event)
#     expect(response).to be_successful
#   end
# end

# describe 'GET /new' do
#   it 'renders a successful response' do
#     get new_event_url
#     expect(response).to be_successful
#   end
# end

# describe 'GET /edit' do
#   it 'renders a successful response' do
#     event = create_event
#     get edit_event_url(event)
#     expect(response).to be_successful
#   end
# end

# describe 'POST /create' do
#   it_behaves_like 'valid and invalid parameters for POST /create'
# end

# describe 'PATCH /update' do
#   it_behaves_like 'valid and invalid parameters for PATCH /update'
# end

# describe 'DELETE /destroy' do
#   it_behaves_like 'destroy action'
# end

#   private

# def create_event
#   Event.create!(valid_attributes)
# end

# shared_examples 'valid and invalid parameters for POST /create' do
#   context 'with valid parameters' do
#     it 'creates a new Event' do
#       expect { post_event(valid_attributes) }.to change(Event, :count).by(1)
#     end

#     it 'redirects to the created event' do
#       post_event(valid_attributes)
#       expect(response).to redirect_to(event_url(Event.last))
#     end
#   end

#   context 'with invalid parameters' do
#     it 'does not create a new Event' do
#       expect { post_event(invalid_attributes) }.not_to change(Event, :count)
#     end

#     it 'renders a response with 422 status' do
#       post_event(invalid_attributes)
#       expect(response).to have_http_status(:unprocessable_entity)
#     end
#   end
# end

# shared_examples 'valid and invalid parameters for PATCH /update' do
#   context 'with valid parameters' do
#     it 'updates the requested event' do
#       event = create_event
#       patch_event(event)
#       event.reload
#       skip('Add assertions for updated state')
#     end

#     it 'redirects to the event' do
#       event = create_event
#       patch_event(event)
#       event.reload
#       expect(response).to redirect_to(event_url(event))
#     end
#   end

#   context 'with invalid parameters' do
#     it 'renders a response with 422 status' do
#       event = create_event
#       patch_event(event, invalid_attributes)
#       expect(response).to have_http_status(:unprocessable_entity)
#     end
#   end
# end

# shared_examples 'destroy action' do
#   it 'destroys the requested event' do
#     event = create_event
#     expect { delete_event(event) }.to change(Event, :count).by(-1)
#   end

#   it 'redirects to the events list' do
#     event = create_event
#     delete_event(event)
#     expect(response).to redirect_to(events_url)
#   end
# end

# def post_event(attributes)
#   post events_url, params: { event: attributes }
# end

# def patch_event(event, attributes = valid_attributes)
#   patch event_url(event), params: { event: attributes }
# end

# def delete_event(event)
#   delete event_url(event)
# end
