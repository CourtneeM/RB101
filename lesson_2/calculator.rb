messages = {
  welcome: "Welcome to Calculator! Enter your name:",
  invalid_name: "Make sure to use a valid name.",
  invalid_number: "Hmm... that doesn't look like a valid number",
  first_num_prompt: "What's the first number?",
  second_num_prompt: "What's the second number?",
  calculate_again?: "Do you want to perform another calculation? (Y to calculate again)",
  goodbye: "Thank you for using the calculator. Good bye!",
}

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  (num =~ /\D/).nil?
end

def number?(num)
  (num =~ /\D/) != 0
end

def operation_to_message(op)
  operator = case op
             when '1'
               'Adding'
             when '2'
               'Subtracting'
             when '3'
               'Multiplying'
             when '4'
               'Dividing'
             end
  operator
end

prompt(messages[:welcome])

name = ''
loop do # validate name
  name = Kernel.gets.chomp

  if name.empty?
    prompt(messages[:invalid_name])
  else
    break
  end
end

prompt("Hi #{name}!")

loop do # main loop
  number1 = ''
  loop do # validate number1
    prompt(messages[:first_num_prompt])
    number1 = Kernel.gets.chomp

    if valid_number?(number1)
      break
    else
      prompt(messages[:invalid_number])
    end
  end

  number2 = ''
  loop do # validate number2
    prompt(messages[:second_num_prompt])
    number2 = Kernel.gets.chomp

    if valid_number?(number2)
      break
    else
      prompt(messages[:invalid_number])
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG

  prompt(operator_prompt)

  operator = ''
  loop do # validate operator
    operator = Kernel.gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt("Must choose 1, 2, 3 or 4")
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  result = case operator
           when "1"
             number1.to_f + number2.to_f
           when "2"
             number1.to_f - number2.to_f
           when "3"
             number1.to_f * number2.to_f
           when "4"
             number1.to_f / number2.to_f
           end

  prompt("The result is #{result}")

  prompt(messages[:calculate_again?])
  answer = Kernel.gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(messages[:goodbye])
