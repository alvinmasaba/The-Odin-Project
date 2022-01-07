module Enumerable
  def my_each # Identical method to #each
    arr = self.instance_of?(Hash) ? self.to_a : self
    i = 0
    arr.count.times do
      yield arr[i]
      i += 1
    end

    return self 
  end
end

a = {:a=>1, :b=>2, :c=>3}

a.my_each { |x| puts x*2 }

