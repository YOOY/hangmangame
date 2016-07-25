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

  def start_request
    send_request('action' => 'startGame', 'playerId' => '')
  end

  def get_new_word_request
    send_request('action' => 'nextWord', 'sessionId' => @sessionid)
  end

  def guess_request(word)
    send_request('action' => 'guessWord', 'sessionId' => @sessionid, 'guess' => word.upcase)
  end

  def result_request
    send_request('action' => 'getResult', 'sessionId' => @sessionid)
  end

  def submit_request
    send_request('action' => 'submitResult', 'sessionId' => @sessionid)
  end
end
