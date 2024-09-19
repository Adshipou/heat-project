require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:valid_attributes) do
    { event_name: 'Test Event', event_datetime: DateTime.now }
  end

  before(:each) do
    @event = Event.create(valid_attributes)
    session[:authenticated] = true
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: @event.id }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: @event.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Event" do
        expect do
          post :create, params: { event: valid_attributes }
        end.to change(Event, :count).by(1)
      end

      it "redirects to the created event" do
        post :create, params: { event: valid_attributes }
        expect(response).to redirect_to(Event.last)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      let(:new_attributes) do
        { event_name: 'Updated Event' }
      end

      it "updates the requested event" do
        patch :update, params: { id: @event.id, event: new_attributes }
        @event.reload
        expect(@event.event_name).to eq('Updated Event')
      end

      it "redirects to the event" do
        patch :update, params: { id: @event.id, event: valid_attributes }
        expect(response).to redirect_to(@event)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested event" do
      expect do
        delete :destroy, params: { id: @event.id }
      end.to change(Event, :count).by(-1)
    end

    it "redirects to the events list" do
      delete :destroy, params: { id: @event.id }
      expect(response).to redirect_to(events_url)
    end
  end
end
