require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash
    resize! if @count >= num_buckets
    unless self[num].include?(num)
      self[num] << num
      @count += 1
    end
  end

  def include?(key)
    num = key.hash
    self[num].include?(num)
  end

  def remove(key)
    num = key.hash
    if self[num].include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    # byebug
    current_el = @store.flatten
    new_buckets = num_buckets * 2
    @store = Array.new(new_buckets) { Array.new }
    @count = 0
    current_el.each do |el|
      insert(el)
    end
  end

end
