# frozen_string_literal: true

require './spec'

describe(Enumerable) do
  let(:example_array) { [10, 20, 30, 40] }
  let(:example_range) { (1...5) }
  let(:rand_num) { rand(5) }
  let(:test_block) { proc { |element| element.even? } }

  describe('#my_each') do
    context('when called with a block') do
      it('returns an array when called on array') do
        expect(example_array.my_each { test_block }).to(eql(example_array.each { test_block }))
      end

      it('returns an range when called on a range') do
        expect(example_range.my_each { test_block }).to(eql(example_range.each { test_block }))
      end
    end

    context('when called without a block') do
      it('returns an array enumerator when called on an array without a block') do
        expect(example_array.my_each.class).to(eql(example_array.each.class))
      end

      it('returns a range enumerator when called on a range without a block') do
        expect(example_range.my_each.class).to(eql(example_range.each.class))
      end
    end
  end

  describe('#my_select') do
    context('when called with a block') do
      it('returns an array of values that yield true when called on array') do
        expect(example_array.my_select { test_block }).to(eql(example_array.select { test_block }))
      end

      it('returns an array of values that yield true when called on a range') do
        expect(example_range.my_select { test_block }).to(eql(example_range.select { test_block }))
      end
    end

    context('when called without a block') do
      it('returns an array enumerator when called on an array without a block') do
        expect(example_array.my_select.class).to(eql(example_array.select.class))
      end

      it('returns a range enumerator when called on a range without a block') do
        expect(example_range.my_select.class).to(eql(example_range.select.class))
      end
    end
  end

  describe('#my_all?') do
    context('when called with only a block') do
      it('returns true if all elements in the array yield true; otherwise, false') do
        expect(example_array.my_all? { test_block }).to(eql(example_array.all? { test_block }))
      end

      it('returns true if all elements in the range yield true; otherwise, false') do
        expect(example_range.my_all? { test_block }).to(eql(example_range.all? { test_block }))
      end
    end

    context('when called with only an argument') do
      it('returns true if the argument equals all the elements in the array; otherwise, false') do
        expect(example_array.my_all?(rand_num)).to(eql(example_array.all?(rand_num)))
      end

      it('returns true if the argument equals all the elements in the range; otherwise, false') do
        expect(example_range.my_all?(rand_num)).to(eql(example_range.all?(rand_num)))
      end
    end

    context('when called with a block and an argument') do
      it('neglects the block and use the argument') do
        expect(example_array.my_all?(rand_num) { test_block }).to(eql(example_array.all?(rand_num) { test_block }))
      end

      it('neglects the block and use the argument') do
        expect(example_range.my_all?(rand_num) { test_block }).to(eql(example_range.all?(rand_num) { test_block }))
      end
    end

    context('when called with no block and no argument') do
      it('returns true if all element of the array are truthy; otherwise, false') do
        expect(example_array.my_all?).to(eql(example_array.all?))
      end

      it('returns true if all element in the range are truthy; otherwise, false') do
        expect(example_range.my_all?).to(eql(example_range.all?))
      end
    end
  end

  describe('#my_any?') do
    context('when called with only a block') do
      it('returns true if any elements in the array yield true; otherwise, false') do
        expect(example_array.my_any? { test_block }).to(eql(example_array.any? { test_block }))
      end

      it('returns true if any elements in the range yield true; otherwise, false') do
        expect(example_range.my_any? { test_block }).to(eql(example_range.any? { test_block }))
      end
    end

    context('when called with only an argument') do
      it('returns true if the argument equals any the elements in the array; otherwise, false') do
        expect(example_array.my_any?(rand_num)).to(eql(example_array.any?(rand_num)))
      end

      it('returns true if the argument equals any the elements in the range; otherwise, false') do
        expect(example_range.my_any?(rand_num)).to(eql(example_range.any?(rand_num)))
      end
    end

    context('when called with a block and an argument') do
      it('neglects the block and use the argument') do
        expect(example_array.my_any?(rand_num) { test_block }).to(eql(example_array.any?(rand_num) { test_block }))
      end

      it('neglects the block and use the argument') do
        expect(example_range.my_any?(rand_num) { test_block }).to(eql(example_range.any?(rand_num) { test_block }))
      end
    end

    context('when called with no block and no argument') do
      it('returns true if any element of the array are truthy; otherwise, false') do
        expect(example_array.my_any?).to(eql(example_array.any?))
      end

      it('returns true if any element in the range are truthy; otherwise, false') do
        expect(example_range.my_any?).to(eql(example_range.any?))
      end
    end
  end

  describe('#my_none?') do
    context('when called with only a block') do
      it('returns true if no elements in the array yield true; otherwise, false') do
        expect(example_array.my_none? { test_block }).to(eql(example_array.none? { test_block }))
      end

      it('returns true if no elements in the range yield true; otherwise, false') do
        expect(example_range.my_none? { test_block }).to(eql(example_range.none? { test_block }))
      end
    end

    context('when called with only an argument') do
      it('returns true if the argument does not equals any of the elements in the array; otherwise, false') do
        expect(example_array.my_none?(rand_num)).to(eql(example_array.none?(rand_num)))
      end

      it('returns true if the argument does not equals any of the elements in the range; otherwise, false') do
        expect(example_range.my_none?(rand_num)).to(eql(example_range.none?(rand_num)))
      end
    end

    context('when called with a block and an argument') do
      it 'neglects the block and use the argument' do
        expect(example_array.my_none?(rand_num) { test_block }).to(eql(example_array.none?(rand_num) { test_block }))
      end

      it('neglects the block and use the argument') do
        expect(example_range.my_none?(rand_num) { test_block }).to(eql(example_range.none?(rand_num) { test_block }))
      end
    end

    context('when called with no block and no argument') do
      it('returns false if the array contains at least one truthy value; otherwise, true') do
        expect(example_array.my_none?).to(eql(example_array.none?))
      end

      it('returns false if the range contains at least one truthy value; otherwise, true') do
        expect(example_range.my_none?).to(eql(example_range.none?))
      end
    end
  end

  describe('#my_count') do
    context('when called with only a block') do
      it('returns the number of elements in the array for which the given block yields true') do
        expect(example_array.my_count { test_block }).to(eql(example_array.count { test_block }))
      end

      it('returns the number of elements in the range for which the given block yields true') do
        expect(example_range.my_count { test_block }).to(eql(example_range.count { test_block }))
      end
    end

    context('when called with only an argument') do
      it('returns the number of elements in the array that equals the given argument') do
        expect(example_array.my_count(rand_num)).to(eql(example_array.count(rand_num)))
      end

      it('returns the number of elements in the range that equals the given argument') do
        expect(example_range.my_count(rand_num)).to(eql(example_range.count(rand_num)))
      end
    end

    context('when called with a block and an argument') do
      it('neglects the block and use the argument') do
        expect(example_array.my_count(rand_num) { test_block }).to(eql(example_array.count(rand_num) { test_block }))
      end

      it('neglects the block and use the argument') do
        expect(example_range.my_count(rand_num) { test_block }).to(eql(example_range.count(rand_num) { test_block }))
      end
    end

    context('when called with no block and no argument') do
      it('returns the number of elements in the array') do
        expect(example_array.my_count).to(eql(example_array.count))
      end

      it('returns the number of elements in the range') do
        expect(example_range.my_count).to(eql(example_range.count))
      end
    end
  end
end

RSpec.describe Enumerable do
  let(:test_arr1) { [34, 100, 1, 3, 5] }
  let(:test_arr2) { %w[Rick Ricky Buck James] }
  let(:test_arr3) { [34.5, 17.8, 56.8, 32.1] }
  let(:mixed_array) { [1, 2, 3, :sym, (1..10), { name: 'michgolden', job: 'software engineer' }] }
  let(:array_strings) { %w[foo bar] }
  let(:array_of_integers_and_strings) { test_arr1 + test_arr2 }
  let(:array_nils) { [nils, nils, nils] }
  let(:array_one_nil) { [1, nil, 5] }
  let(:hash) { { name: 'Michgolden' } }
  let(:hash_of_strings) { { 'name' => 'michgolden', 'school' => 'Microverse', 'skill' => 'Full stack dev' } }
  let(:range) { (1..20) }

  describe '#my_each' do
    context 'If no block returns to enum like #each' do
      it do
        expect(test_arr1.my_each).to be_an(Enumerator)
      end
    end

    context 'Expect to run a block like #each' do
      it do
        test = test_arr1.each { |num| p num * 2 }
        expect(test_arr1.my_each { |num| p num * 2 }).to eq(test)
      end
    end
  end

  describe '#my_each_with_index' do
    context 'If no block returns to enum like #each' do
      it do
        expect(test_arr1.my_each_with_index).to be_an(Enumerator)
      end
    end

    context 'Expect to run a block like #each_with_index' do
      it do
        test = test_arr1.each_with_index { |num, ind| num + ind }
        expect(test_arr1.my_each_with_index { |num, ind| num + ind }).to eq(test)
      end
    end

    context 'Expect to run a string like #each_with_index' do
      it do
        test = test_arr2.each_with_index { |name, ind| "Name: #{name}, Index: #{ind}" }
        expect(test_arr2.my_each_with_index { |name, ind| "Name: #{name}, Index: #{ind}" }).to eq(test)
      end
    end
  end

  describe '#my_select' do
    context 'If no block returns to enum like #select' do
      it do
        expect(test_arr1.select).to be_an(Enumerator)
      end
    end
    context 'Test1: Selects elements like #select' do
      it do
        test = test_arr1.select(&:odd?)
        expect(test_arr1.my_select(&:odd?)).to eq(test)
      end
    end
    context 'Test2: Selects elements like #select' do
      it do
        test = test_arr3.select { |num| num.to_f > 32.1 }
        expect(test_arr3.my_select { |num| num.to_f > 32.1 }).to eq(test)
      end
    end
  end

  describe '#my_all' do
    context 'If no block runs like #all' do
      it do
        expect(test_arr1.my_all?).to be_truthy
      end
    end
    context 'Integers: is identical to #all with integers' do
      it do
        test = test_arr1.all? { |n| n.is_a? Integer }
        expect(test_arr1.my_all? { |n| n.is_a? Integer }).to eq(test)
      end
    end
    context 'Strings: is identical to #all with strings' do
      it do
        test = test_arr2.all? { |n| n.is_a? String }
        expect(test_arr2.my_all? { |n| n.is_a? String }).to eq(test)
      end
    end
    context 'Regex 1: all strings match' do
      it 'should return true' do
        expect(test_arr2.my_all?(/\w+/)).to be_truthy
      end
    end
    context 'Regex 2: one or more strings don\'t match' do
      it 'should return false' do
        expect(array_of_integers_and_strings.my_all?(/\d+/)).to be_falsy
      end
    end
  end

  describe '#my_any' do
    context 'Runs no block given like #any' do
      it do
        expect(test_arr1.my_any?).to be_truthy
      end
    end
    context 'String: is identical to #any with strings' do
      it do
        test = test_arr2.any? { |n| n.is_a? String }
        expect(test_arr2.any?).to eq(test)
      end
    end
    context 'Integers: is identical to #any with integers' do
      it do
        test = test_arr1.any? { |n| n.is_a? Integer }
        expect(test_arr1.my_any?).to eq(test)
      end
    end
    context 'Regex: is identical to #any with regex' do
      it 'should be true' do
        test = array_strings.any?(/Ri/)
        expect(array_strings.my_any?(/Ri/)).to eq(test)
      end
    end
  end

  describe '#my_none' do
    context 'Returns to false like #none if no block' do
      it 'should equal false' do
        expect(test_arr1.my_none?).to be_falsy
      end
    end
    context 'String: is identical to none with strings' do
      it do
        test = test_arr2.none? { |n| n.is_a? String }
        expect(test_arr2.my_none? { |n| n.is_a? String }).to eq(test)
      end
    end
  end
  context 'Integers: is identical to none with integers' do
    it do
      test = test_arr1.none? { |n| n.is_a? Integer }
      expect(test_arr1.my_none? { |n| n.is_a? Integer }).to eq(test)
    end
  end

  describe '#my_count' do
    context 'runs no block similar to #count' do
      it do
        expect(array_of_integers_and_strings.my_count).to eq(9)
      end
    end
    context 'is identical to #count using parameter' do
      it do
        expect(test_arr1.my_count(34)).to eq(1)
      end
    end
    context 'identical to #count when block is given' do
      it do
        expect(test_arr3.my_count { |n| n > 32.1 }).to eq(2)
      end
    end
  end

  describe '#my_map' do
    context 'runs no block same as #map' do
      it do
        expect(test_arr1.my_map).to be_an(Enumerator)
      end
    end
    context 'runs a block like #map' do
      it do
        test = test_arr1.map { |n| n * 2 }
        expect(test_arr1.my_map { |n| n * 2 }).to eq(test)
      end
    end
    context 'runs a proc like #map' do
      it do
        block = proc { |_key, _val| _val = 'Michgolden Ukeje' }
        expect(hash.my_map(&block)).to eq(['Michgolden Ukeje'])
      end
    end
  end

  describe '#my_inject' do
    context 'runs like #inject' do
      it 'using block, no proc' do
        test = test_arr1.inject { |n1, n2| n1 + n2 }
        expect(test_arr1.my_inject { |n1, n2| n1 + n2 }).to eq(test)
      end
      it 'passing a proc' do
        block = proc { |num1, num2| num1 + num2 }
        test = test_arr1.inject(&block)
        expect(test_arr1.my_inject(&block)).to eq(test)
      end
      it 'accepts a sym' do
        test = test_arr2.inject(:+)
        expect(test_arr2.my_inject(:+)).to eq(test)
      end
      it 'using two arguments' do
        test = range.inject(2, :*)
        expect(range.my_inject(2, :*)).to eq(test)
      end
      it 'using block and an argument' do
        test = range.inject(4) { |num1, num2| num1 + num2 }
        expect(range.my_inject(4) { |num1, num2| num1 + num2 }).to eq(test)
      end
    end
  end
end

RSpec.describe Enumerable do
  let(:arr) { [4, 5, 8, 2, 1, 9, 3, 7, 6] }
  let(:new_arr) { [] }

  describe '#my_each' do
    let(:new_arr_each) { [] }
    it 'iterate through array elements' do
      my_array = []
      original_array = []
      arr.my_each { |n| my_array << n * 2 }
      arr.each { |n| original_array << n * 2 }
      expect(my_array).to eql(original_array)
    end
  end

  describe '#my_each_with_index' do
    it 'returns indexes of elements in an array' do
      %w[mi cro ver se].my_each_with_index { |_elem, index| new_arr << index }
      expect(new_arr).to eql([0, 1, 2, 3])
    end
  end

  describe '#my_count' do
    it 'return the count of elements that evalute to true' do
      expect(arr.my_count { |i| i < 6 }).to eq(5)
    end
  end

  describe '#my_map' do
    it 'returns a new array with the results of running through the block once on a given array' do
      answer = arr.my_map { |num| num**2 }
      expect(answer).to eql(arr.map { |num| num**2 })
    end
  end

  describe '#my_none' do
    it 'returns true if none of the elements meet criteria defined in the block' do
      expect(arr.my_none? { |num| num == 10 }).to eq(true)
    end
  end

  describe '#my_select' do
    it 'return selected value in an array base on the given block' do
      expect(arr.my_select(&:odd?)).to eq([5, 1, 9, 3, 7])
    end
  end
end

# when .all? should return true
RSpec.describe Enumerable do
  describe 'my_all? should return true when all items' do
    it 'are truthy' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eq(true)
    end

    it 'in block yield true' do
      a = %w[ant bear cat]
      expect(a.my_all? { |word| word.length >= 3 }).to eq(true)
    end

    it 'match a pattern' do
      expect(%w[i am a string].my_all?(String)).to eq(true)
    end
  end

  # when .all? should return false

  describe '.all? should return false when some element' do
    it 'is falsy' do
      expect([nil, true, 99].my_all?).not_to eq(true)
    end

    it 'in block yield false' do
      a = %w[ant bear cat]
      expect(a.my_all? { |word| word.length >= 4 }).not_to eq(true)
    end
  end
end
# when .any? should return true
RSpec.describe Enumerable do
  describe '.any? should return true when any item' do
    it 'is truthy' do
      expect([nil, true, 99].my_any?).to be true
    end

    it 'in block yields true' do
      a = %w[ant bear cat]
      expect(a.my_any? { |word| word.length >= 3 }).to be true
    end

    it 'matches a pattern' do
      a = [nil, true, 99]
      expect(a.my_any?(Integer)).to be true
    end
  end

  # when .any? should return false
  describe '.any? should return false when no item' do
    it 'is truthy' do
      expect([nil, false, nil].my_any?).to be false
    end

    it 'in block yields true' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 5 }).to be false
    end

    it 'exists in enumerable' do
      expect([].my_any?).to be false
    end

    it 'matches a pattern' do
      expect(%w[ant bear cat].my_any?(/d/)).to be false
    end
  end
end

RSpec.describe Enumerable do
  let(:array) { Array.new(100) { rand(1...10) } }

  describe '#my_count' do
    it 'when no block or argument is given returns the length of enum' do
      expect(array.my_count).to eql(array.count)
    end
    it ' If an argument is given, the number of items in enum that are equal to item are counted' do
      expect(array.my_count(2)).to eql(array.count(2))
    end
  end
end

RSpec.describe Enumerable do
  describe '#my_each' do
    it 'returns an enumerator when no block is given' do
      enumerator = [1, 2, 3, 4, 5].my_each
      expect(enumerator.my_each).to be_a(Enumerator)
    end

    it 'yields an item per iteration when a block is given' do
      expect do |b|
        [1, 2, 3, 4].my_each(&b)
      end.to yield_successive_args(1, 2, 3, 4)
    end
  end
end
RSpec.describe Enumerable do
  describe '.each_with_index should return' do
    it 'an enumerator when no block is given' do
      enumerator = [1, 2, 3, 4, 5].my_each_with_index
      expect(enumerator).to be_an Enumerator
    end

    describe 'correct ele, index pairs on each iteration' do
      it 'when a list of items is passed in' do
        expect do |b|
          [1, 2, 3].my_each_with_index(&b)
        end.to yield_successive_args([1, 0], [2, 1], [3, 2])
      end
    end
  end
end

RSpec.describe Enumerable do
  describe '.inject' do
    it 'should add correctly when :+ symbol is used' do
      expect((5..10).my_inject(:+)).to eql 45
    end

    it 'should add correctly when a block is used' do
      expect((5..10).my_inject { |a, c| a + c }).to eql 45
    end

    it 'should multiply correctly when :* symbol is used' do
      expect((5..10).my_inject(:*)).to eql 151_200
    end

    it 'should multiply correctly when a block is used' do
      expect((5..10).my_inject { |a, c| a * c }).to eql 151_200
    end

    it 'should evaluate a binary operation correctly when given a block' do
      longest = %w[cat sheep bear].my_inject do |memo, word|
        memo.length > word.length ? memo : word
      end
      expect(longest).to match(/sheep/)
    end
  end
end

RSpec.describe Enumerable do
  let(:arr) { Array.new(100) { rand(1...10) } }
  let(:b) { proc { |num| num < (0 + 100) * 2 } }

  describe '#my_map' do
    it 'to return a new array with the executed block output' do
      expect(arr.my_map { |n| n * 2 }).to eql(arr.map { |n| n * 2 })
    end
    it 'to return a new array with the executed proc output' do
      expect(arr.my_map(&b)) .to eql(arr.map(&b))
    end
  end
end

RSpec.describe Enumerable do
  context '.none? should return true when no item' do
    it 'exists in enumerable' do
      expect([].my_none?).to be true
    end

    it 'in block yields true' do
      a = %w[ant bear cat]
      expect(a.my_none? { |word| word.length >= 5 }).to be true
    end

    it 'matches a pattern' do
      expect(%w[ant bear cat].my_none?(/d/)).to be true
    end

    it 'is truthy - example 1' do
      expect([nil].my_none?).to be true
    end

    it 'is truthy - example 2' do
      expect([nil, false].my_none?).to be true
    end
  end

  # when .any? should return false
  describe '.none? should return false when some item' do
    it 'in block yields true' do
      expect(%w[ant bear cat].my_none? { |word| word.length >= 4 }).to be false
    end

    it 'is truthy' do
      expect([nil, false, true].my_none?).to be false
    end

    it 'matches a pattern' do
      expect([1, 3.14, 42].my_none?(Float)).to be false
    end
  end
end

RSpec.describe Enumerable do
  let(:array) { Array.new(100) { rand(1...10) } }

  describe '#my_select' do
    it 'when no block or argument is given returns an enumerator' do
      expect(array.my_select).to be_a(Enumerator)
    end
    it 'Returns an array containing all elements of enum for which the given block returns a true value.' do
      expect(array.my_select(&:even?)).to eql(array.select(&:even?))
    end
  end
end
