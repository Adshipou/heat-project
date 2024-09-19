# app/controllers/speeches_controller.rb
class SpeechesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :read_and_convert]

  def create
    text = params[:text]
    audio_content = TextToSpeechService.synthesize(text)

    send_data audio_content, type: "audio/mp3", disposition: "inline"
  end

  def read_and_convert
    text_content = request.body.read

    if text_content.present?
      audio_content = TextToSpeechService.synthesize(text_content)

      send_data audio_content, type: "audio/mp3", disposition: "inline"
    else
      render plain: 'No text content provided', status: :unprocessable_entity
    end
  end
end
