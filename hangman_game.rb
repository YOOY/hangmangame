require File.join(File.dirname(__FILE__) + '/request_processor')
require File.join(File.dirname(__FILE__) + '/response_handler')
require File.join(File.dirname(__FILE__) + '/word')

class HangmanGame
  include RequestProcessor
  include ResponseHandler
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
    submit_result
  end

  private
  def start_game
    p '======Game Start======'
    process_start_response(start_request)
  end

  def give_me_a_word
    p '======New Word========'
    process_get_new_word_response(get_new_word_request)
    reset_wrong_count
    reset_word_algorithm
    deduct_total_words
  end

  def make_a_guess(word)
    process_guess_response(guess_request(word))
    p "Guess : #{word.upcase} Guess Result : #{@guess_result} Wrong Count : #{@wrong_count}"
  end

  def get_my_result
    process_result_response(result_request)
  end

  # the highest score i got is 1363
  # so submit result only if the score is higher
  def submit_result
    process_submit_response(submit_request) if @score > 1363
  end

  def need_to_guess?
    @guess_result =~ /\*/ && @wrong_count < @wrong_allowed
  end

  def deduct_total_words
    @total_words -= 1
    p "=====Word left : #{@total_words}======"
  end

  def more_words?
    @total_words > 0
  end

  def reset_wrong_count
    @wrong_count = 0
  end
end

HangmanGame.new.play
