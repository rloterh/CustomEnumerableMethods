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

  def my_map
    return to_enum(:my_map) unless block_given?

    new_array = []
    my_each { |i| new_array << yield(i) }
    new_array
  end

  def my_inject(param1 = nil, param2 = nil, &block)
    array = to_a.dup
    (inject, var, array) = get_inject_and_var(param1, param2, array, block_given?)
    inject = if var inject_var(array, var, inject)
             else inject_block(array, inject, &block)
             end
    inject
  end

  def check_pattern(index, param)
    return index.is_a?(param) if param.is_a? Class
    return param.match?(index) if param.is_a? Regexp

    index == param
  end

  def get_inject_and_var(param1, param2, array, block)
    param1 = array.shift if param1.nil? && block
    return [param1, nil, array] if block
    return [array.shift, param1, array] if param2.nil?

    [param1, param2, array]
  end

  def inject_var(array, var, inject)
    array[0..-1].my_each { |i| inject = inject.send(var, i) }
    inject
  end

  def inject_block(array, inject, &block)
    raise LocalJumpError, 'no block given' unless block

    array[0..-1].my_each { |i| inject = block.yield(inject, i) }
    inject
  end
end

def multiply_els(array)
  array.my_inject { |mul, n| mul * n }
end
