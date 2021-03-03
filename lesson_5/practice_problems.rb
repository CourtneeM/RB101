# 1. How would you order this array of number strings by descending numeric value?
# arr = ['10', '11', '9', '7', '8']

# p arr.sort { |a, b| b.to_i <=> a.to_i }

# -----------------------------------------------------------------------------

# 2. How would you order this array of hashes based on the year of publication of each book, from the earliest to the latest?

# books = [
#   {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
#   {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
#   {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
#   {title: 'Ulysses', author: 'James Joyce', published: '1922'}
# ]

# p books.sort_by { |book| book[:published] }

# -----------------------------------------------------------------------------

# 3. For each of these collection objects demonstrate how you would reference the letter 'g'.

# arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
# p arr1[2][1][3]

# arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
# p arr2[1][:third][0]

# arr3 = [['abc'], ['def'], {third: ['ghi']}]
# p arr3[2][:third][0][0]

# hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
# p hsh1['b'][1]

# hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
# p hsh2[:third].keys[0]

# -----------------------------------------------------------------------------

# 4. For each of these collection objects where the value 3 occurs, demonstrate how you would change this to 4.

# arr1 = [1, [2, 3], 4]
# p arr1[1][1] = 4

# arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]
# p arr2[2] = 4

# hsh1 = {first: [1, 2, [3]]}
# p hsh1[:first][2][0] = 4

# hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
# p hsh2[['a']][:a][2] = 4

# -----------------------------------------------------------------------------

# 5. Figure out the total age of just the male members of the family.

# munsters = {
#   "Herman" => { "age" => 32, "gender" => "male" },
#   "Lily" => { "age" => 30, "gender" => "female" },
#   "Grandpa" => { "age" => 402, "gender" => "male" },
#   "Eddie" => { "age" => 10, "gender" => "male" },
#   "Marilyn" => { "age" => 23, "gender" => "female"}
# }

# total_male_age = 0

# munsters.each { |_, details| total_male_age += details["age"] if details["gender"] == "male" }
# p total_male_age

# -----------------------------------------------------------------------------

# 6. Print out the name, age and gender of each family member:

# munsters = {
#   "Herman" => { "age" => 32, "gender" => "male" },
#   "Lily" => { "age" => 30, "gender" => "female" },
#   "Grandpa" => { "age" => 402, "gender" => "male" },
#   "Eddie" => { "age" => 10, "gender" => "male" },
#   "Marilyn" => { "age" => 23, "gender" => "female"}
# }
# munsters.each do |name, details|
#   p "#{name} is a #{details["age"]}-year-old #{details["gender"]}."
# end

# -----------------------------------------------------------------------------
# 7. Given this code, what would be the final values of a and b?

# a = 2
# b = [5, 8]
# arr = [a, b]

# arr[0] += 2
# arr[1][0] -= a

# a => 2
# b => [3, 8]

# -----------------------------------------------------------------------------

# 8. Using the each method, write some code to output all of the vowels from the strings.

# hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

# hsh.each_value do |arr|
#   arr.each do |string|
#     string.chars { |char| puts char if char.match(/[aeiou]/) }
#   end
# end

# -----------------------------------------------------------------------------

# 9. Return a new array of the same structure but with the sub arrays being ordered (alphabetically or numerically as appropriate) in descending order.

# arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

# arr.map! do |sub_arr|
#   sub_arr.sort { |a, b| b <=> a }
# end

# p arr

# -----------------------------------------------------------------------------

# 10. Without modifying the original array, use the map method to return a new array identical in structure to the original but where the value of each integer is incremented by 1.

# hsh = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hash|
#   hash.map { |key, value| [key, value + 1] }.to_h
# end

# p hsh

# -----------------------------------------------------------------------------

# 11. Use a combination of methods, including either the select or reject method, to return a new array identical in structure to the original but containing only the integers that are multiples of 3.

# arr = [[2], [3, 5, 7], [9], [11, 13, 15]]
# multiples_of_three = arr.map do |sub_arr|
#   sub_arr.select { |num| num % 3 == 0 }
# end

# p multiples_of_three

# -----------------------------------------------------------------------------

# 12. Without using the Array#to_h method, write some code that will return a hash where the key is the first item in each sub array and the value is the second item.

# arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]

# p arr.each_with_object({}) { |el, hash| hash[el[0]] = el[1] }

# -----------------------------------------------------------------------------

# 13. Return a new array containing the same sub-arrays as the original but ordered logically by only taking into consideration the odd numbers they contain.

# arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

# p arr.sort { |a, b| b <=> a }

# -----------------------------------------------------------------------------

# 14. Write some code to return an array containing the colors of the fruits and the sizes of the vegetables. The sizes should be uppercase and the colors should be capitalized.

# hsh = {
#   'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
#   'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
#   'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
#   'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
#   'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
# }

# result = hsh.each_with_object([]) do |(_, details), arr|
#   arr << details[:colors].map(&:capitalize) if details[:type] == 'fruit'
#   arr << details[:size].upcase if details[:type] == 'vegetable'
# end

# p result

# -----------------------------------------------------------------------------

# 15. Write some code to return an array which contains only the hashes where all the integers are even.

# arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

# even_integers = arr.select do |hash|
#   hash.select do |_, sub_arr|
#     break if sub_arr.any?(&:odd?)

#     true
#   end
# end

# p even_integers

# -----------------------------------------------------------------------------

# 16. Write a method that returns one UUID when called with no parameters.

# Each UUID consists of 32 hexadecimal characters, and is typically broken into 5 sections like this 8-4-4-4-12 and represented as a string.
# It looks like this: "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"

# def random_letter
#   ('a'..'z').to_a.sample
# end

# def random_number
#   rand(0..9).to_s
# end

# uuid = ""

# 32.times do
#   random_character = [random_letter, random_number].sample
#   uuid << '-' if uuid.size == 8 || uuid.size == 13 || uuid.size == 18 || uuid.size == 23
#   uuid << random_character
# end

# p uuid
