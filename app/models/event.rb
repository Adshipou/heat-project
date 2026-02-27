require "digest"

class Event < ApplicationRecord
  has_many :events_members
  has_many :members, through: :events_members

  CHECK_IN_WINDOW_SECONDS = 10.minutes.to_i

  def current_check_in_code(now: Time.current)
    code_for_time(now: now)
  end

  def check_in_expires_in_seconds(now: Time.current)
    CHECK_IN_WINDOW_SECONDS - (now.to_i % CHECK_IN_WINDOW_SECONDS)
  end

  def valid_check_in_code?(candidate_code, now: Time.current)
    normalized_code = candidate_code.to_s.strip
    return false unless normalized_code.match?(/\A\d{6}\z/)

    ActiveSupport::SecurityUtils.secure_compare(normalized_code, current_check_in_code(now: now))
  end

  private

  def code_for_time(now:)
    time_window = now.to_i / CHECK_IN_WINDOW_SECONDS
    seed = "#{id}:#{created_at.to_i}:#{time_window}:#{Rails.application.secret_key_base}"
    hex = Digest::SHA256.hexdigest(seed).first(12)
    format("%06d", hex.to_i(16) % 1_000_000)
  end
end
