require 'byebug'
class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    validate!(num)
    @store[num - 1] = true
  end

  def remove(num)
    @store[num - 1] = false
  end

  def include?(num)
    @store[num - 1]
  end

  private

  def is_valid?(num)
    num > 0 && num <= @max
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = num % num_buckets
    self[bucket] << num unless @store[bucket].include?(num)
  end


  def remove(num)
    bucket = num % num_buckets
    self[bucket].delete(num) if @store[bucket].include?(num)
  end

  def include?(num)
    bucket = num % num_buckets
    self[bucket].include?(num)
  end

  private

  def [](num)
    @store[num]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    # byebug
    resize! if @count >= num_buckets
    unless @store[bucket(num)].include?(num)
      @store[bucket(num)] << num
      @count += 1
    end
  end

  def remove(num)
    if @store[bucket(num)].include?(num)
      @store[bucket(num)].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  def bucket(num)
    num % num_buckets
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

# a = ResizingIntSet.new(20)
# el = (10..30).to_a
# el.each do |int|
#   a.insert(int)
# end
# p a
