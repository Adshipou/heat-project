module ApplicationHelper
  def external_url(raw_url)
    url = raw_url.to_s.strip
    return "#" if url.empty?

    # Keep allowed absolute URLs as-is.
    if url.match?(%r{\Ahttps?://}i) || url.match?(%r{\Amailto:}i)
      return url
    end

    # Block potentially unsafe schemes.
    return "#" if url.match?(%r{\A(?:javascript|data):}i)

    # Treat bare host/path values as HTTPS links.
    "https://#{url}"
  end
end
