# Q1
# numbers = [1, 2, 2, 3]
# numbers.uniq

# puts numbers
# This will print out 1, 2, 2, 3 with each on a separate line
# ------------------------------------------------------------

# Q2
# 1. what is != and where should you use it
#   This is the not equal to operator. It is normally used in conditional expressions.
# 2. put ! before something, like !user_name
#   This would provide the opposite Boolean value of whatever value it returned.
#   Ex. !true would be false, !false would be true
# 3. put ! after something, like words.uniq!
#   This would mutate whatever it is being called on, generally.
#   In the example, this would mutate the words array to only contain unique values.
# 4. put ? before something
#   This would give a syntax error.
# 5. put ? after something
#   Normally used after a value as a ternary operator.
# 6. put !! before something, like !!user_name
#   This would return the original Boolean value.
#   The first ! would be the opposite Boolean value, and then next ! would be back to the original Boolean.
# ------------------------------------------------------------

# Q3
# advice = "Few things in life are as important as house training your pet dinosaur."
# advice[6] = 'urgent' || advice.gsub!("important", "urgent")
# ------------------------------------------------------------

# Q4
# numbers = [1, 2, 3, 4, 5]
# numbers.delete_at(1) -> This would delete the value at index 1 of the numbers array.
# numbers.delete(1) -> This would delete the value 1 from the numbers array.
# Both of these methods will return the removed item.
# ------------------------------------------------------------

# Q5
# 42.cover?(10..100) || 42.between?(10, 100) || (10..100).include?(42)
# ------------------------------------------------------------

# Q6
# famous_words = "seven years ago"
# "Four score and " + famous_words
# famous_words.prepend("Four score and ")
# "Four score and " << famous_words
# famous_words.insert(0, "Four score and ")
# famous_words = famous_words.split.unshift("Four", "score", "and").join(" ")
# ------------------------------------------------------------

# Q7
# flintstones.flatten!
# ------------------------------------------------------------

# Q8
# flintstones.assoc('Barney')
