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

  def my_map(&_proc)
    array = to_a
    new_array = []
    array.my_each { |i| new_array.push(yield i) }
    new_array
  end

  def my_inject(*params)
    array = to_a
    param1 = params[0]
    param2 = params[1]
    all_params = param1 && param2
    first_param = param1 && !param2
    no_param = !param1
    memo = (only_param && !block_given?) || (no_param && block_given?) ? array[0] : param1
    if block_given?
      array.drop(1).my_each { |i| memo = yield memo, i } if no_param
      array.my_each { |i| memo = yield memo, i } if first_param
    else
      array.drop(1).my_each { |i| memo = memo.send(param1, i) } if first_param
      array.my_each { |i| memo = memo.send(param2, i) } if all_params
    end
    memo
  end

  def check_pattern(index, param)
    return index.is_a?(param) if param.is_a? Class
    return param.match?(index) if param.is_a? Regexp

    index == param
  end
end

def multiply_els(array)
  array.my_inject { |mul, n| mul * n }
end
