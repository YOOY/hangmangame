require 'net/http'
require 'json'

module RequestProcessor
  def send_request(data)
    uri = URI.parse('')
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    req = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')
    req.body = data.to_json
    response = https.request(req)
    JSON.parse response.body
  end
end
