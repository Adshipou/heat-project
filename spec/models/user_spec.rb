require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.from_omniauth' do
    let(:auth) do
      OmniAuth::AuthHash.new({
                               provider: 'google_oauth2',
                               uid: '123456789',
                               info: {
                                 email: 'user@example.com',
                                 name: 'John Doe',
                                 image: 'http://image.example.com'
                               }
                             })
    end

    context 'when the user does not exist' do
      it 'creates a new user' do
        expect { User.from_omniauth(auth) }.to change(User, :count).by(1)
      end

      it 'assigns the user attributes correctly' do
        user = User.from_omniauth(auth)
        expect(user.email).to eq('user@example.com')
        expect(user.full_name).to eq('John Doe')
        expect(user.avatar_url).to eq('http://image.example.com')
      end
    end

    context 'when the user already exists' do
      before { User.from_omniauth(auth) }

      it 'does not create a new user' do
        expect { User.from_omniauth(auth) }.not_to change(User, :count)
      end
    end
  end

  describe 'devise modules' do
    it 'includes devise :database_authenticatable' do
      expect(User.devise_modules).to include(:database_authenticatable)
    end

    it 'includes devise :registerable' do
      expect(User.devise_modules).to include(:registerable)
    end

    it 'includes devise :recoverable' do
      expect(User.devise_modules).to include(:recoverable)
    end

    it 'includes devise :rememberable' do
      expect(User.devise_modules).to include(:rememberable)
    end

    it 'includes devise :validatable' do
      expect(User.devise_modules).to include(:validatable)
    end

    it 'includes devise :omniauthable' do
      expect(User.devise_modules).to include(:omniauthable)
    end
  end
end
