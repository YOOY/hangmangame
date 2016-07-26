# Hangman game

##This is the interview exam of Strikingly.
##For more detail please see [Strikingly github page](https://github.com/strikingly/strikingly-interview-test-instructions)

How to start :    
```shell
 ruby hangman_game.rb
```

The code has five files :   
**1. hangman_game.rb**    

   the main program, it deduct the total words everytime it get new word from server    
   it also count the error trial for each word, get new word if the error trial equals to the max error trial    

**2. request_processor.rb**    

   it contain all the logic of sending and receiving https request and response    
   due to its functinality, it will not process the response    

**3. response_handler.rb**    

   when getting the https response, it will set the apporiate instance variable according to the response    

**4. word.rb**    

   algorithm of how to guess the word.    
   the core idea is to guess the most likely char.    
   at the beginning, it will use vowel chars as they exist in almost every words.    
   when we get first correct char, then it start to look for the dictionary for the most likely words    
   in order to look for the most likely words, it use regular expression to serch.    
   the regex is formed according to the result from guess response and the chars have been used.    
      for example:     
         the response is '\*A\*\*A\*', and the used chars are 'A, B, R, Y'    
         then the regex will looks like : '[^abry]A[^abry][^abry]A[^abry]'    
   after getting the possible words from dictionary, it then split each words into chars and count which char appears most    
   if the char with most occurrence is used before, then get the second occurrence char    

**5. words**    

   it's a dictionary file, it combine the /usr/share/dict/words from ubuntu and MAC.    

