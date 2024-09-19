require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  describe '#update_resource' do
    let(:user) { FactoryBot.create(:user, provider: 'google_oauth2', email: 'original@example.com') }

    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
    end

    context 'when the user is from google_oauth2' do
      it 'updates the user without requiring the current password' do
        controller.update_resource(user, { email: 'newemail@example.com', password: 'newpassword' })
        expect(user.email).to eq('newemail@example.com')
      end
    end
  end
end
