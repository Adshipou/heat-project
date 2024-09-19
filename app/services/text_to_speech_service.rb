# app/services/text_to_speech_service.rb

class TextToSpeechService
  def self.synthesize(text)
    client = Google::Cloud::TextToSpeech.text_to_speech

    input_text = { text: }

    voice = {
      language_code: "en-US",
      ssml_gender: "NEUTRAL"
    }

    audio_config = {
      audio_encoding: "MP3"
    }

    response = client.synthesize_speech(
      input: input_text,
      voice:,
      audio_config:
    )

    response.audio_content
  end
end
