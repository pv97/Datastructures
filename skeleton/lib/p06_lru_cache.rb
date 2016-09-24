require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    #returns link if it exists
    link = @map[key]

    if link.nil?
      result = @prc.call(key)
      link = @store.insert(key, result)
      @map[key] = link
      eject! if count > @max
    else
      update_link!(link)
    end
    link.val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    prc.call(key)
  end

  def update_link!(link)
    key = link.key
    val = link.val
    # suggested helper method; move a link to the end of the list
    @store.remove(key)
    link = @store.insert(key,val)
    @map[key] = link
  end

  def eject!
    p "ejected"
    key = @store.first.key
    @store.remove(key)
    @map.delete(key)
  end

end
