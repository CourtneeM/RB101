# 1. Convert the given array to a hash, using the names as keys and position in the array as values.

# flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
# flintstones_hash = {}

# flintstones.each_with_index { |name, index| flintstones_hash[name] = index }
# p flintstones_hash

# -----------------------------------------------------------------------------

# 2. Add all the ages from the following hash

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# total_ages = ages.reduce(0) do |sum, pair|
#   key, value = pair
#   sum + value
# end

# p total_ages

# -----------------------------------------------------------------------------

# 3. Remove people with age >= 100 from the following hash.

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# ages.delete_if { |_, value| value >= 100 }
# p ages

# -----------------------------------------------------------------------------

# 4. Pick out the minimum age from the following hash.

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
# p ages.values.min

# -----------------------------------------------------------------------------

# 5. Find the index of the first name that starts with "Be" in the following array.

# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
# name_index = 0
# flintstones.each_with_index { |name, index| name_index = index if name.start_with?("Be") }
# p name_index

# -----------------------------------------------------------------------------

# 6. Amend the following array so that the names are all shortened to just the first three characters.

# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# p flintstones.map! { |name| name[0, 3] }

# -----------------------------------------------------------------------------

# 7. Create a hash that expresses the frequency with which each letter occurs in this string.

# statement = "The Flintstones Rock"
# frequency = Hash.new(0)

# statement.chars do |char|
#   frequency[char] += 1 if char.match(/[a-zA-z]/)
# end
# p frequency

# -----------------------------------------------------------------------------

# 8. What happens when we modify an array while we are irterating over it? What would be output by this code?

# numbers = [1, 2, 3, 4]
# numbers.each do |number|
#   p number
#   numbers.shift(1)
# end
# p numbers
# output: 1, 3
# => [3, 4]

# What about this code?
# numbers = [1, 2, 3, 4]
# numbers.each do |number|
#   p number
#   numbers.pop(1)
# end
# p numbers
# output: 1, 2
# => [1, 2]

# -----------------------------------------------------------------------------

# 9. Write a method that capitalizes each word in a string.

# def capitalize_each_word(str)
#   str.split.map(&:capitalize).join(' ')
# end

# p capitalize_each_word('the flintstones rock')

# -----------------------------------------------------------------------------

# 10. Modify the following hash such that each memeber of the Munster family has an additional "age_group" key that has one of three values describing the age group the family member is in (kid, adult, or senior).
# kid = 0-17, adult = 18-64, senior = 65+

# munsters = {
#   "Herman" => { "age" => 32, "gender" => "male" },
#   "Lily" => { "age" => 30, "gender" => "female" },
#   "Grandpa" => { "age" => 402, "gender" => "male" },
#   "Eddie" => { "age" => 10, "gender" => "male" },
#   "Marilyn" => { "age" => 23, "gender" => "female"}
# }

# munsters.keys.each do |name|
#   case munsters[name]['age']
#   when 0..17 then munsters[name]['age group'] = 'kid'
#   when 18..64 then munsters[name]['age group'] = 'adult'
#   when 65..nil then munsters[name]['age group'] = 'senior'
#   end
# end

# p munsters
