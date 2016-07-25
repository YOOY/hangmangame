module ResponseHandler
  def process_start_response(resp)
    @sessionid = resp['sessionId']
    @total_words = resp['data']['numberOfWordsToGuess'].to_i
    @wrong_allowed = resp['data']['numberOfGuessAllowedForEachWord'].to_i
    p @sessionid
  end

  def process_get_new_word_response(resp)
    @guess_result = resp['data']['word']
  end

  def process_guess_response(resp)
    @wrong_count = resp['data']['wrongGuessCountOfCurrentWord'].to_i
    @guess_result = resp['data']['word']
  end

  def process_result_response(resp)
    p resp
    @score = resp['data']['score'].to_i
  end

  def process_submit_response(resp)
    p resp
  end
end
