# Q1
# str = "The Flintstones Rock!"
# 10.times do
#   puts str
#   str.prepend("\s")
# end
# || 10.times { |number| puts (" " * number) + "The Flintstones Rock!" }
# -----------------------------------------------------------------------------

# Q2
# puts "the value of 40 + 2 is " + (40 + 2) => Error because 40 + 2 is an integer, not a string
# (40 + 2).to_s || #{40 + 2}
# -----------------------------------------------------------------------------

# Q3
# def factors(number)
#   if number <= 0
#     puts 'Cannot enter zero or a negative number'
#   else
#     divisor = number
#     factors = []
#     while divisor != 0
#       factors << number / divisor if number % divisor == 0
#       divisor -= 1
#     end
#     factors
#   end
# end
# % is the modulus operator, this returns the remainder of the two operands.
# If the remainder is zero, this means the divisor is a factor of the number.
# Putting factors as the last line ensures this is what the method will return
# -----------------------------------------------------------------------------

# Q4
# rolling_buffer1 would mutate the original buffer array that is passed in as a parameter
# rolling_buffer2 would not mutate the original input_array since the changes are saved to a new array.
# -----------------------------------------------------------------------------

# Q5
# limit is not accessible to the fib method. It needs to be passed in as an argument.
# -----------------------------------------------------------------------------

# Q6
# 34
# -----------------------------------------------------------------------------

# Q7
# Yes, demo_hash is referencing the same value as munsters.
# family_member["age"] += 42 => these operations will mutate the hash
# -----------------------------------------------------------------------------

# Q8
# "paper"
# -----------------------------------------------------------------------------

# Q9
# "no"
