def caesar_cipher(string, factor)
  # create array of all letters
  dict = 'abcdefghijklmnopqrstuvwxyz'.split('')

  new_string = ''

  string.each_char do |char|
    if !dict.include?(char.downcase)
      # Concat to keep punctuation and spaces unchanged
      new_string += char
    else
      idx = dict.index(char.downcase) + factor # idx is the transformed dictionary index for the char.

      # To wrap, add or subtract 26 (if pos or neg, respectively) from idx until it is within 0-25 range
      while idx >= 25 || idx <= -25
        idx >= 25 ? idx -= 26 : idx += 26
      end

      # To maintain capitalization
      new_string += char.upcase == char ? dict[idx].upcase : dict[idx]
    end
  end

  new_string
end
