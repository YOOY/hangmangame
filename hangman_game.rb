require './request_processor'
require './word'
class HangmanGame
  include RequestProcessor
  include Word

  def play
    start_game
    while more_words?
      give_me_a_word
      while need_to_guess?
        make_a_guess(get_a_char(@guess_result))
      end
    end
    get_my_result
  end

  private
  def start_game
    p '======Game Start======'
    get_setting(send_request('action' => 'startGame', 'playerId' => ''))
  end

  def give_me_a_word
    p '======New Word========'
    reset
    resp = send_request('action' => 'nextWord', 'sessionId' => @sessionid)
    @guess_result = resp['data']['word']
    deduct_total_words
    reset_for_new_word
  end

  def make_a_guess(word)
    resp = send_request('action' => 'guessWord', 'sessionId' => @sessionid, 'guess' => word.upcase)
    @wrong_count = resp['data']['wrongGuessCountOfCurrentWord'].to_i
    @guess_result = resp['data']['word']
    p "Guess : #{word.upcase} Guess Result : #{@guess_result} Wrong Count : #{@wrong_count}"
  end

  def get_my_result
    resp = send_request('action' => 'getResult', 'sessionId' => @sessionid)
    p resp
  end

  def submit_result
    resp = send_request('action' => 'submitResult', 'sessionId' => @sessionid)
  end

  def get_setting(resp)
    @sessionid = resp['sessionId']
    @total_words = resp['data']['numberOfWordsToGuess'].to_i
    @wrong_allowed = resp['data']['numberOfGuessAllowedForEachWord'].to_i
  end

  def need_to_guess?
    @guess_result =~ /\*/ && @wrong_count < @wrong_allowed
  end

  def deduct_total_words
    @total_words -= 1
    p "=====Word left : #{@total_words}======"
  end

  def reset_for_new_word
    @wrong_count = 0
    @guess_result =  '*'
  end

  def more_words?
    @total_words > 0
  end
end

HangmanGame.new.play
