class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList

  include Enumerable

  def initialize
    @head = Link.new()
    @tail = Link.new()
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    return true if @head.next == @tail || @tail.prev == @head
    false
  end

  def get(key)
    current = first
    until current.key == key || current == @tail
      current = current.next
    end
    current.val
  end

  def include?(key)
    current = first
    until current.key == key || current == @tail
      current = current.next
    end
    return true if current != @tail
    false
  end

  def insert(key, val)
    new_link = Link.new(key,val)
    last = @tail.prev
    last.next = new_link
    new_link.prev = last
    new_link.next = @tail
    @tail.prev = new_link
    new_link
  end

  def remove(key)
    current = first

    until current.key == key || current == @tail
      current = current.next
    end

    unless current == @tail
      later = current.next
      prev = current.prev
      later.prev = prev
      prev.next = later
    end
  end

  def each(&prc)
    current = first

    until current == @tail
      prc.call(current)
      current = current.next
    end

    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
