def caesar_cipher(string, factor)
  # create array of all letters
  dict = 'abcdefghijklmnopqrstuvwxyz'.split('')
  new_string = ''
  string.each_char do |char|
    if !dict.include?(char.downcase) # To keep punctuation and spaces unchanged, simply concat
      new_string += char
    else
      idx = dict.index(char.downcase) + factor # idx is the transformed dictionary index for the char.
      while idx >= 25 || idx <= -25 # To wrap, add or subtract 26 (if pos or neg, respectively) from idx until it is within 0-25 range
        idx >= 25 ? idx -= 26 : idx += 26 # idx will now match the appropriately transformed dictionary index
      end
      new_string += char.upcase == char ? dict[idx].upcase : dict[idx]   # To maintain capitalization
    end
  end
  new_string
end
