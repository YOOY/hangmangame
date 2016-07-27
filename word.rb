# the logic is
# 1. random_guess to pick from the vowel first,
#    until vowel is empty then pick from consonant
# 2. if the return result has any non-star char, then goes to smart_guess
# 3. in the smart_guess, it will prepare the regex according to the current result and the used chars.
#    Then use the regex to search from the dictionary file "words"
# 4. after get all the possible words from dictionary file, select the char that appears most.
#    if the char is used before then get the second most char.
# 5. if there is no possible_result from words, which means we can't find the correct Word from dictionary,
#    then goes to random_guess

module Word
  def reset_word_algorithm
    @vowel = %w(a e i o u)
    @consonant = ('a' .. 'z').to_a - @vowel
    @used_char = []
    @current_result = nil
  end

  def get_a_char(current_result)
    @current_result = current_result
    char = if current_result =~ /[^\*]/
             smart_guess
           else
             random_guess
           end
    block_the_char_from_being_used_again char
    char
  end

  def smart_guess
    dictionary = File.join(File.dirname(__FILE__) + '/dictionary')

    regex = @current_result.downcase.gsub(/\*/, "[^#{@used_char.join}]")
    possible_result = File.open(dictionary).grep(Regexp.new("^#{regex}$"))
    char = possible_result.empty? ? random_guess : get_most_possible_char(possible_result)

    char.nil? ? random_guess : char
  end

  def random_guess
    if @vowel.empty?
      @consonant.shuffle!.pop
    else
      @vowel.shuffle!.pop
    end
  end

  # the possible_result looks like ['word1\n', 'word2\n',...]
  # 1. to make the possible_result become [['a', ['a','a','a'...]], ['c', ['c','c',...]]]
  # 2. sort the array by the occurrence of each char which is ['a','a',...]
  # 3. return the most occurrence char which has not been used.
  def get_most_possible_char(possible_result)
    char = nil
    chars = possible_result.map(&:chomp).map{|a| a.split("")}.flatten.group_by(&:itself)
    chars.sort_by{|b| b[1].size}.reverse.each do |sorted_chars|
      unless @used_char.include? sorted_chars[0]
        char = sorted_chars[0]
        break
      end
    end
    char
  end

  def block_the_char_from_being_used_again(char)
    @used_char << char
    @vowel = @vowel - @used_char
    @consonant = @consonant - @used_char
  end
end
