DICTIONARY = File.readlines("dictionary.txt").map(&:chomp)

#Break this down into two methods
def find_chain(start_word, end_word, dictionary)

  current_words = []
  new_words = []
  current_words << start_word
  sized_dict = dictionary.select { |d_word| start_word.size == d_word.size }

  visited_words = {start_word => nil}
  found_target = false

  #Would need to write a check if theres is no path
  while !found_target

    current_words.each do |word|

       adjacent_words(word, sized_dict).each do |adj_word|

         new_words << adj_word unless visited_words.has_key?(adj_word)
         visited_words[adj_word] = word unless visited_words.has_key?(adj_word)
       end

    end

    if new_words.include?(end_word)
      found_target = true
    else
      current_words = new_words
      new_words = []
    end

  end

  build_chain(visited_words, end_word)
end


def adjacent_words(word, dictionary)
  dictionary.select do |s_word|
    counter = 0
    word.split('').each_with_index do |letter, i|
      counter += 1 if letter != s_word[i]
    end

    true if counter == 1
  end
end


def build_chain(visited_words, word)
  chain = []
  vw_copy = visited_words.dup
  pred = word

  until pred.nil?
    chain.unshift(pred)
    pred = vw_copy[pred]
  end

  chain
end

p find_chain(ARGV[0], ARGV[1], DICTIONARY)