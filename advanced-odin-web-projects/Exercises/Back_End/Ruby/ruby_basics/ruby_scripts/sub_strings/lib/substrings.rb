def substrings(string, dictionary)
  # Create a downcased array of words from string without punctuation
  words = string.scan(/\w+/).map { |word| word.downcase }
  # Count how many times the words in dictionary appear in our array of words, and return the results in a hash
  dictionary.each_with_object(Hash.new(0)) do |substring, sub_dict|
    words.each { |word| word.include?(substring.downcase) ? sub_dict[substring] += 1 : next }
  end
end
