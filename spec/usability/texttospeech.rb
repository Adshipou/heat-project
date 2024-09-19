require 'rails_helper'

describe SpeechesController do
  describe '#read_and_convert' do
    context 'when no text content provided' do
      it 'renders error message and returns status code 422' do
        post :read_and_convert, params: {}

        expect(response.body).to eq('No text content provided')
        expect(response.status).to eq(422)
      end
    end

    context 'when TextToSpeechService.synthesize raises an error' do
      it 'renders error message and returns status code 500' do
        allow(TextToSpeechService).to receive(:synthesize).and_raise(StandardError)

        post :read_and_convert, params: { text: 'Some text content' }

        expect(response.body).to eq('Internal Server Error')
        expect(response.status).to eq(500)
      end
    end

    context 'when valid text content provided' do
      it 'converts and returns audio content' do
        allow(TextToSpeechService).to receive(:synthesize).and_return('audio_content_mock')

        post :read_and_convert, params: { text: 'Some valid text content' }

        expect(response.body).to eq('audio_content_mock')
        expect(response.content_type).to eq('audio/mp3')
        expect(response.status).to eq(200)
      end
    end
  end
end
