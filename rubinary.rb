# No arithmetic was used in the making of this module...

# Just renaming ^ (the bitshift operator for XOR) to make its use explicit in the half_adder
def exclusive_or (p,q)
  p ^ q
end

# Same for & - it's going to be used for the carry_out of the half adder
def carry_out (p,q)
  p & q
end

# This is a half adder.
# It returns an array of length two.
# The first element is the sum of the two bits.
# The second is the 'carry out' - whether a bit is carried over to the next position in the calculation.
# It's not a full adder as it's got no way of taking a 'carry in', a carry out from the last bit calculated.
def half_adder (p,q)
  return exclusive_or(p,q), carry_out(p,q)
end

# A full adder
# Which is two half adders glued together, with an OR gate tacked on to see if anything is carried over to the next bit.
# The first adder adds the two bits (and produces a carry out result).
# The second adder then adds the sum result of the first adder to the carry in bit.
# The OR gate then sets the bit to 1 if either of the adders produced a carry out.
# The adder then returns the sum from the second adder as the value of the resultant bit, with the resut from the OR gate as the new carry out. 
def full_adder (p, q, carry_in=0)
  first_adder = half_adder(p,q)
  second_adder = half_adder(first_adder[0],carry_in)
  carry_out = first_adder[1] | second_adder[1]
  sum_out = second_adder[0]
  return sum_out, carry_out
end

# An n bit adder
# This works as a series of full adders strung together
# We keep adding adders (don't laugh) until we run out of bits to add
def n_bit_adder (p,q)
  result=[]
  p_array = p.to_s(2).split("")
  q_array = q.to_s(2).split("")
  p_array.map! {|digit| digit.to_i}
  q_array.map! {|digit| digit.to_i}
  padded_input = even_the_bit_lengths(p_array,q_array)
  p_array = padded_input[0]
  q_array = padded_input[1]
  carry_in = 0
  while p_array.length != 0
    full_adder_out = full_adder(p_array.pop, q_array.pop, carry_in)
    result.unshift(full_adder_out[0])
    carry_in = full_adder_out[1]
  end
  result.unshift(carry_in)
  result
end

# This takes a number of arrays as inputs, determines the length of the longest, and pads the rest with 0s until they're the sames length
# If we don't do this is becomes awkward to add numbers with different bit lengths
def even_the_bit_lengths(*numbers)
  longest_length = numbers.max {|a, b| a.length <=> b.length}.length
  numbers.map! do |number|
    while number.length != longest_length
      number.unshift(0)
    end
    number
  end
  numbers
end

# Our inputs might not be neat - they might be an integer (not so bad), a string of 1s and 0s (a little worse), an array of 1s and 0s (either strings or integers), or even an array of booleans.
# So let's try and deal with all of them

def input_validation(input)
  case input
  when Array
    puts "It's an Array"
    valid_array(input)
    array_to_binary_array(input)
  when String
    puts "A string"
    string_to_binary_array(input)
  when Fixnum
    puts "Integer"
    fixnum_to_binary_array(input)
  else puts "God knows!"
  end
end

# This method deals with an array input, and will change the values in it (whether ones, zeros, trues or falses), to just 1s and 0s.
def valid_array(input_array)
  test = input_array.detect do |digit|
    (digit != 1) and (digit != 0) and (digit != "1") and (digit != "0") and (digit != true) and (digit != false)
  end
  if test.nil? ?+
end

# def make_bit_array_from_integer

puts n_bit_adder(27,4).join.to_i(2)

input_validation([])

puts  array_to_binary_array([1, 1])
# puts n_bit_adder(2,3)