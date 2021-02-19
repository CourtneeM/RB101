# Q1
# if false
#   greeting = "hello world"
# end

# greeting => nil, the variable is still initialized even though the if block isn't executed
# -----------------------------------------------------------------------------

# Q2
# greetings = { a: 'hi' }
# informal_greeting = greetings[:a]
# informal_greeting << ' there'

# puts informal_greeting  #  => "hi there"
# puts greetings => { a: 'hi there' }
# -----------------------------------------------------------------------------

# Q3
# A) "one is: one", "two is: two", "three is: three"
# B) "one is: one", "two is: two", "three is: three"
# C) "one is: two", "two is: three", "three is: one"
# -----------------------------------------------------------------------------

# Q4
# def dot_separated_ip_address?(input_string)
#   dot_separated_words = input_string.split('.')
#   return false if dot_separated_words.size != 4

#   while dot_separated_words.size > 0 do
#     word = dot_separated_words.pop
#     return false unless is_an_ip_number?(word)
#   end
#   true
# end
