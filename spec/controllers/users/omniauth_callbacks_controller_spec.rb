# spec/controllers/users/omniauth_callbacks_controller_spec.rb

require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  describe "#google_oauth2" do
    let(:user) { create(:user) }
    let(:auth) do
      OmniAuth::AuthHash.new({
                               provider: 'google_oauth2',
                               uid: '123456',
                               info: {
                                 email: user.email,
                                 name: 'Test User', # Set a name for testing purposes
                                 image: 'http://example.com/avatar.jpg'
                               }
                             })
    end

    before do
      request.env['devise.mapping'] = Devise.mappings[:user]
      request.env['omniauth.auth'] = auth
    end

    context "when user is present" do
      before do
        allow(User).to receive(:from_omniauth).and_return(user)
      end

      it "signs out all scopes" do
        expect(controller).to receive(:sign_out_all_scopes)
        post :google_oauth2
      end

      it "sets success flash message" do
        post :google_oauth2
        expect(flash[:success]).to eq(I18n.t('devise.omniauth_callbacks.success', kind: 'Google'))
      end

      it "signs in the user and redirects to the root path" do
        post :google_oauth2
        expect(response).to redirect_to(root_path)
        expect(controller.current_user).to eq(user)
      end
    end

    context "when user is not present" do
      before do
        allow(User).to receive(:from_omniauth).and_return(nil)
      end

      it "sets alert flash message" do
        post :google_oauth2
        expect(flash[:alert]).to eq(I18n.t('devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."))
      end

      it "redirects to the new user session path" do
        post :google_oauth2
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "#after_omniauth_failure_path_for" do
    it "is called" do
      controller = described_class.new
      allow(controller).to receive(:new_user_session_path) # Stubbing the method call
      controller.send(:after_omniauth_failure_path_for, nil)
      expect(controller).to have_received(:new_user_session_path)
    end
  end
end
