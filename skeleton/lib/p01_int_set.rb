class MaxIntSet
  def initialize(max)
    @store = Array.new(max) { false }
    @max = max
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    return false unless num.is_a? FixNum
    true
  end

  def validate!(num)
    raise "not a number" unless is_valid?(num)
    raise "Out of bounds" if num >= @max || num < 0
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    self[num] << num
    @count+=1
    resize! if @count > num_buckets
  end

  def remove(num)
    self[num].delete(num)
    @count -=1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    arr = @store
    @store = Array.new(num_buckets * 2) {Array.new}
    @count = 0
    arr.each do |bucket|
      bucket.each do |el|
        insert(el)
      end
    end
  end
end
