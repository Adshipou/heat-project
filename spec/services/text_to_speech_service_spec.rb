require 'rails_helper'

RSpec.describe TextToSpeechService do
  describe '.synthesize' do
    let(:text) { 'Hello, world!' }
    let(:synthesized_audio_content) { 'AudioContent' }
    let(:mock_client) { instance_double("Google::Cloud::TextToSpeech::Client") }

    before do
      allow(Google::Cloud::TextToSpeech).to receive(:text_to_speech).and_return(mock_client)
      allow(mock_client).to receive(:synthesize_speech).and_return(double(audio_content: synthesized_audio_content))
    end

    it 'calls the Google Cloud Text-to-Speech API with expected parameters' do
      described_class.synthesize(text)

      expect(mock_client).to have_received(:synthesize_speech).with(
        input: { text: },
        voice: { language_code: "en-US", ssml_gender: "NEUTRAL" },
        audio_config: { audio_encoding: "MP3" }
      )
    end

    it 'returns the audio content' do
      result = described_class.synthesize(text)

      expect(result).to eq(synthesized_audio_content)
    end
  end
end
