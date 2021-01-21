require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrays < Neo::Koan
  def test_creating_arrays
    empty_array = Array.new
    assert_equal Array, empty_array.class
    assert_equal 0, empty_array.size
  end

  def test_array_literals
    array = Array.new
    assert_equal [], array

    array[0] = 1
    assert_equal [1], array

    array[1] = 2
    assert_equal [1, 2], array

    array << 333
    assert_equal [1, 2, 333], array
  end

  def test_accessing_array_elements
    array = [:peanut, :butter, :and, :jelly]

    assert_equal :peanut, array[0]
    assert_equal :peanut, array.first
    assert_equal :jelly, array[3]
    assert_equal :jelly, array.last
    assert_equal :jelly, array[-1]
    assert_equal :butter, array[-3]
  end

  def test_slicing_arrays
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut], array[0,1] #ary[start, length], not ary[element, element]
    assert_equal [:peanut, :butter], array[0,2]
    assert_equal [:and, :jelly], array[2,2]
    assert_equal [:and, :jelly], array[2,20]
    assert_equal [], array[4,0] # ??? see comment below
    assert_equal [], array[4,100]
    assert_equal nil, array[5,0] # ??? see comment below
    
    # Your confusion stems from the lack of a definition for an index being "at the end of the range". 
    # For any array arr, the index i is at the end of the range when i equals arr.size, that is, when the index equals the index 
    # of the last element plus one.
    # For a[5,1] #=> [], 5, the starting index, is "at the end of the range", 
    # since a.size #=> 5. Therefore, by the doc, this should return an empty array regardless of the value 
    # of the second argument (which is better described as the "size", rather than the "index").
    # 
    # More on: https://stackoverflow.com/questions/46572286/special-cases-of-ruby-array-slicing

  end

  def test_arrays_and_ranges
    assert_equal Range, (1..5).class
    assert_not_equal [1,2,3,4,5], (1..5)
    assert_equal [1,2,3,4,5], (1..5).to_a
    assert_equal [1,2,3,4], (1...5).to_a
  end

  def test_slicing_with_ranges
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut, :butter, :and], array[0..2]
    assert_equal [:peanut, :butter], array[0...2]
    assert_equal [:and, :jelly], array[2..-1]
  end

  def test_pushing_and_popping_arrays
    array = [1,2]
    array.push(:last)

    assert_equal [1, 2, :last], array

    popped_value = array.pop
    assert_equal :last, popped_value # :last not [:last], ojo
    assert_equal [1, 2], array
  end

  def test_shifting_arrays
    array = [1,2]
    array.unshift(:first)

    assert_equal [:first, 1, 2], array

    shifted_value = array.shift
    assert_equal :first, shifted_value # and not [:first]
    assert_equal [1,2], array
  end

end
