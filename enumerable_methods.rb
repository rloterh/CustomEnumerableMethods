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

  def my_none?(param = nil, &block)
    !my_any?(param, &block)
  end

  def my_count(param = nil)
    indexer = 0
    if block_given?
      my_each { |i| indexer += 1 if yield(i) == true }
    elsif param.nil?
      my_each { indexer += 1 }
    else
      my_each { |i| indexer += 1 if i == param }
    end
    indexer
  end

  def my_map(proc = nil)
    new_array = []
    return enum_for unless proc || block_given?

    my_map.each { |e| new_array << (proc ? proc.call(e) : yield(e)) }
    new_array
  end

  def my_inject(param1 = nil, sym = nil)
    raise LocalJumpError if param1.nil? && !block_given?

    arr = self.to_a
    if block_given?
      acc = param1 || arr[0]
      start = param1 ? 0 : 1
      (start..arr.length - 1).each { |i| acc = yield(acc, arr[i]) }
    else
      acc = param1.is_a?(symbol) ? arr[0] : param1
      start = param1.is_a?(symbol) ? 1 : 0
      symbol = sym || param1

      (start..arr.length - 1).each { |i| acc = acc.send(symbol, arr[i]) }
    end
    acc
  end

  def check_pattern(index, param)
    return index.is_a?(param) if param.is_a? Class
    return param.match?(index) if param.is_a? Regexp

    index == param
  end
end

def multiply_els(arr)
  arr.my_inject { |acc, element| acc * element }
end
