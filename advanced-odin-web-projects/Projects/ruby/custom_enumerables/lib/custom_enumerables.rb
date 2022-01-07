module Enumerable
  def my_each # Identical method to #each
    arr = self.instance_of?(Hash) ? self.to_a : self
    i = 0
    if block_given?
      arr.count.times do
        yield arr[i]
        i += 1
      end
    else
      return self.to_enum 
    end

    self 
  end

  def my_each_with_index
    arr = self.instance_of?(Hash) ? self.to_a : self
    i = 0
    if block_given?
      arr.count.times do
        yield arr[i], i
        i += 1
      end
    else
      return self.to_enum 
    end

    self 
  end

  
end





