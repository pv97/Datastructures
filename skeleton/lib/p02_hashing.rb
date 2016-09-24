class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_value = 0
    self.each_with_index do |el,i|
      hash_value = hash_value^(el.hash+i)
    end
    hash_value
  end
end

class String
  def hash
    hash_value = 0
    self.chars.each_with_index do |el,i|
      hash_value = hash_value^(el.ord+i)
    end
    hash_value
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_value = 0
    self.each do |key,value|
      hash_value = hash_value^(key.hash+10*value.hash)
    end
    hash_value
  end
end
