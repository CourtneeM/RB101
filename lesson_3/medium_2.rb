# Q1
# def fun_with_ids
#   a_outer = 42
#   b_outer = "forty two"
#   c_outer = [42]
#   d_outer = c_outer[0]
#   # declared the 4 variables and assigned their own values

#   a_outer_id = a_outer.object_id
#   b_outer_id = b_outer.object_id
#   c_outer_id = c_outer.object_id
#   d_outer_id = d_outer.object_id
#   # Declared 4 variables and assigned the object_id of the original 4 variables

#   puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
#   puts "b_outer is #{b_outer} with an id of: #{b_outer_id} before the block."
#   puts "c_outer is #{c_outer} with an id of: #{c_outer_id} before the block."
#   puts "d_outer is #{d_outer} with an id of: #{d_outer_id} before the block."
#   puts
#   # Display each original variable along with their object id

#   1.times do
#     a_outer_inner_id = a_outer.object_id
#     b_outer_inner_id = b_outer.object_id
#     c_outer_inner_id = c_outer.object_id
#     d_outer_inner_id = d_outer.object_id
#     # Declare another set of 4 variables and assign the same object_id as before

#     puts "a_outer id was #{a_outer_id} before the block and is: #{a_outer_inner_id} inside the block."
#     puts "b_outer id was #{b_outer_id} before the block and is: #{b_outer_inner_id} inside the block."
#     puts "c_outer id was #{c_outer_id} before the block and is: #{c_outer_inner_id} inside the block."
#     puts "d_outer id was #{d_outer_id} before the block and is: #{d_outer_inner_id} inside the block."
#     puts
#     # Display the sets of object_id variables, should be the same object_id for each set

#     a_outer = 22
#     b_outer = "thirty three"
#     c_outer = [44]
#     d_outer = c_outer[0]
#     # Reassign the original 4 variables to new values

#     puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after."
#     puts "b_outer inside after reassignment is #{b_outer} with an id of: #{b_outer_id} before and: #{b_outer.object_id} after."
#     puts "c_outer inside after reassignment is #{c_outer} with an id of: #{c_outer_id} before and: #{c_outer.object_id} after."
#     puts "d_outer inside after reassignment is #{d_outer} with an id of: #{d_outer_id} before and: #{d_outer.object_id} after."
#     puts
#     # The original 4 variables will be different, but the object_id variables shouldn't have changed.

#     a_inner = a_outer
#     b_inner = b_outer
#     c_inner = c_outer
#     d_inner = c_inner[0]
#     # Declare new variables and assign values to their outer counterparts

#     a_inner_id = a_inner.object_id
#     b_inner_id = b_inner.object_id
#     c_inner_id = c_inner.object_id
#     d_inner_id = d_inner.object_id
#     # Declare inner_id variables and assign their values to the object_id of their counterparts, which will be the same object_id as the outer variables.

#     puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the block (compared to #{a_outer.object_id} for outer)."
#     puts "b_inner is #{b_inner} with an id of: #{b_inner_id} inside the block (compared to #{b_outer.object_id} for outer)."
#     puts "c_inner is #{c_inner} with an id of: #{c_inner_id} inside the block (compared to #{c_outer.object_id} for outer)."
#     puts "d_inner is #{d_inner} with an id of: #{d_inner_id} inside the block (compared to #{d_outer.object_id} for outer)."
#     puts
#     # the inner_id should match the associated outer_id
#   end

#   puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the block."
#   puts "b_outer is #{b_outer} with an id of: #{b_outer_id} BEFORE and: #{b_outer.object_id} AFTER the block."
#   puts "c_outer is #{c_outer} with an id of: #{c_outer_id} BEFORE and: #{c_outer.object_id} AFTER the block."
#   puts "d_outer is #{d_outer} with an id of: #{d_outer_id} BEFORE and: #{d_outer.object_id} AFTER the block."
#   puts
#   # The outer variable values will be their newly assigned values from the loop.
#   # The outer_id will be their original values.
#   # outer.object_id will be based off of their new values from the loop.

#   puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
#   puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
#   puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
#   puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
#   # Error, the inner variables were declared inside of the loop, not accessible outside of it.
#   # Rescue will keep the error from showing and instead display the puts that follows it.
# end
# fun_with_ids
# -----------------------------------------------------------------------------

# Q2
# def fun_with_ids
#   a_outer = 42
#   b_outer = "forty two"
#   c_outer = [42]
#   d_outer = c_outer[0]
#   # Declare 4 variables and assign each with its own value.

#   a_outer_id = a_outer.object_id
#   b_outer_id = b_outer.object_id
#   c_outer_id = c_outer.object_id
#   d_outer_id = d_outer.object_id
#   # Declare 4 variables containing the object id of the original 4 variables.

#   puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
#   puts "b_outer is #{b_outer} with an id of: #{b_outer_id} before the block."
#   puts "c_outer is #{c_outer} with an id of: #{c_outer_id} before the block."
#   puts "d_outer is #{d_outer} with an id of: #{d_outer_id} before the block."
#   puts
#   # Display the original 4 variables and their object id variables.

#   an_illustrative_method(a_outer, b_outer, c_outer, d_outer, a_outer_id, b_outer_id, c_outer_id, d_outer_id)
#   # method call with all of the previously declared variables as arguments.

#   puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the method call."
#   puts "b_outer is #{b_outer} with an id of: #{b_outer_id} BEFORE and: #{b_outer.object_id} AFTER the method call."
#   puts "c_outer is #{c_outer} with an id of: #{c_outer_id} BEFORE and: #{c_outer.object_id} AFTER the method call."
#   puts "d_outer is #{d_outer} with an id of: #{d_outer_id} BEFORE and: #{d_outer.object_id} AFTER the method call."
#   puts
#   # Display original outer variable values.
#   # Display original outer variable object ids.
#   # Display original outer variable object ids.

#   puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
#   puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
#   puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
#   puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
#   puts
#   # Error, inner variables are not accessible from the outer scope.
#   # Rescue will prevent an error and will display the puts.
# end

# def an_illustrative_method(a_outer, b_outer, c_outer, d_outer, a_outer_id, b_outer_id, c_outer_id, d_outer_id)

#   puts "a_outer id was #{a_outer_id} before the method and is: #{a_outer.object_id} inside the method."
#   puts "b_outer id was #{b_outer_id} before the method and is: #{b_outer.object_id} inside the method."
#   puts "c_outer id was #{c_outer_id} before the method and is: #{c_outer.object_id} inside the method."
#   puts "d_outer id was #{d_outer_id} before the method and is: #{d_outer.object_id} inside the method."
#   puts
#   # Display the ids of the original variables.
#   # Display the ids of the parameters, which is referencing the same object_id as the originals.

#   a_outer = 22
#   b_outer = "thirty three"
#   c_outer = [44]
#   d_outer = c_outer[0]
#   # Reassigning the method variables to the different values, so different object.

#   puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after."
#   puts "b_outer inside after reassignment is #{b_outer} with an id of: #{b_outer_id} before and: #{b_outer.object_id} after."
#   puts "c_outer inside after reassignment is #{c_outer} with an id of: #{c_outer_id} before and: #{c_outer.object_id} after."
#   puts "d_outer inside after reassignment is #{d_outer} with an id of: #{d_outer_id} before and: #{d_outer.object_id} after."
#   puts
#   # Displays the new values.
#   # Displays the original object_id.
#   # Display a new object_id.

#   a_inner = a_outer
#   b_inner = b_outer
#   c_inner = c_outer
#   d_inner = c_inner[0]
#   # Declare inner variables and assign to the new outer variables

#   a_inner_id = a_inner.object_id
#   b_inner_id = b_inner.object_id
#   c_inner_id = c_inner.object_id
#   d_inner_id = d_inner.object_id
#   # Declare inner_id and assign to the inner object_id, which is the same as the outer object_id.

#   puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the method (compared to #{a_outer.object_id} for outer)."
#   puts "b_inner is #{b_inner} with an id of: #{b_inner_id} inside the method (compared to #{b_outer.object_id} for outer)."
#   puts "c_inner is #{c_inner} with an id of: #{c_inner_id} inside the method (compared to #{c_outer.object_id} for outer)."
#   puts "d_inner is #{d_inner} with an id of: #{d_inner_id} inside the method (compared to #{d_outer.object_id} for outer)."
#   puts
#   # Displays the inner value, same as outer.
#   # Displays the inner object id, same as outer.
#   # Displays the outer object id.
# end
# fun_with_ids
# -----------------------------------------------------------------------------

# Q3
# The string will not be mutated, but the array will be.
# -----------------------------------------------------------------------------

# Q4
# The string will be mutated, the array will not.
# -----------------------------------------------------------------------------

# Q5
# Make the method explicitly return the modified parameters.
# -----------------------------------------------------------------------------

# Q6
# remove the if statement and have the method body only contain, color == "blue" || color == "green"
# This will return true if either are true.
