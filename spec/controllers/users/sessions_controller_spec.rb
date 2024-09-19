require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  describe '#after_sign_out_path_for' do
    it 'redirects to the root path after sign out' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      expect(controller.after_sign_out_path_for(:user)).to eq root_path
    end
  end

  describe '#after_sign_in_path_for' do
    it 'redirects to the root path after sign in' do
      user = FactoryBot.create(:user)
      sign_in user
      expect(controller.after_sign_in_path_for(user)).to eq root_path
    end
  end
end
