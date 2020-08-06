module Enumerable
  def my_each
    return to_enum(:my_each) unlessblock_given?
    array = to_a.dup
    i = 0
    while i < array.length
      yield array[i]
      i += 1
    end
    self
  end