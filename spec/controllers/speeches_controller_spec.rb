require 'rails_helper'

RSpec.describe SpeechesController, type: :request do
  before do
    allow(TextToSpeechService).to receive(:synthesize).and_return('mocked_audio_content')
  end

  describe 'POST #create' do
    let(:valid_text) { 'Hello, world!' }

    it 'returns a success response' do
      post speeches_path, params: { text: valid_text }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #read_and_convert' do
    let(:valid_text) { 'Hello, world!' }
    let(:invalid_text) { '' }

    it 'returns a success response with valid text content' do
      post '/read_and_convert', params: valid_text, headers: { "CONTENT_TYPE" => "text/plain" }
      expect(response).to have_http_status(:success)
    end

    it 'returns an error with no text content' do
      post '/read_and_convert', params: invalid_text, headers: { "CONTENT_TYPE" => "text/plain" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
