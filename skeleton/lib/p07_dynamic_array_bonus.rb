require 'byebug'
class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  include Enumerable

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0

  end

  def [](i)

    return nil if i >= @count || -i >@count
    if i < 0
      i = @count + i
    end
    @store[i]
  end

  def []=(i, val)
    if i < 0
      i = @count + i
    end

    while i > capacity
      resize!
    end

    @count = i + 1 if i >= @count

    @store[i] = val

  end

  def capacity
    @store.length
  end

  def include?(val)
    each do |el|
      return true if el == val
    end
    false
  end

  def push(val)
    resize! if @count >= capacity
    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    old_length = @count
    resize! if @count >= capacity
    idx = 0
    while(idx < (old_length + 1))
      # debugger
      next_item = @store[idx]
      @store[idx] = val
      val = next_item
      idx +=1
    end
    @count +=1
  end

  def pop
    return nil if @count == 0
    val = @store[@count-1]
    @store[@count-1] = nil
    @count -= 1
    val
  end

  def shift
    return nil if @count == 0
    val = @store[0]
    idx = 0
    while(idx < @count - 1)
      @store[idx] = @store[idx+1]
      idx +=1
    end
    @store[@count - 1] = nil
    @count -= 1
    val
  end

  def first
    return @store[0]
  end

  def last
    return @store[@count-1]
  end

  def each(&prc)
    i = 0
    while i < @count
      prc.call(@store[i])
      i+=1
    end
    @store
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    idx=0
    while(idx < @count)
      return false if self[idx] != other[idx]
      idx+=1
    end
      true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    old_array = @store
    old_length = capacity
    @store = StaticArray.new(capacity * 2)
    i = 0
    while i < old_length
      @store[i] = old_array[i]
      i += 1
    end
  end
end

# arr = DynamicArray.new(3)
# arr.push(1)
# arr.push(2)
# arr.unshift(0)
# p arr

a = StaticArray.new(8)
p a
