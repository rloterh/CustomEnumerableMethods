module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    array = to_a.dup
    i = 0
    while i < array.length
      yield array[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each) unless block_given?
    array = to_a.dup
    indexer = 0
    i = 0
    while i < array.length
      yield(array[i], indexer)
      indexer += 1
      i += 1
    end
    self
  end
  
  def my_select
    return to_enum(:my_select) unless block_given?
    array = []
    my_each { |i| array << i if yield(i) }
    array
  end

  def my_all?(param = nil)
    if block_given?
      my_each { |i| return false unless yield(i) }
    elsif param.nil?
      my_each { |i| return false unless i }
    else
      my_each { |i| return false unless check_pattern(i, param) }
    end
    true
  end

  def my_any?(param = nil, &block)
    if block
      my_each { |i| return true if block.yield(i) }
    elsif param.nil?
      my_each { |i| return true if i }
    else
      my_each { |i| return true if check_pattern(i, param) }
    end
    false
  end

  