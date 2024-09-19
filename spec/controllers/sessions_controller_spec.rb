require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid password" do
      it "authenticates and redirects to meetings path" do
        post :create, params: { password: 'TxAMHeat#2k13' }
        expect(session[:authenticated]).to be true
        expect(response).to redirect_to(meetings_path)
        expect(flash[:notice]).to eq('Successfully authenticated.')
      end
    end

    context "with invalid password" do
      it "does not authenticate and re-renders the new template with an alert" do
        post :create, params: { password: 'wrongpassword' }
        expect(session[:authenticated]).to be_nil
        expect(response).to render_template(:new)
        expect(flash.now[:alert]).to eq('Invalid password')
      end
    end
  end
end
