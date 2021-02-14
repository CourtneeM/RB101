# Build a mortgage calculator

# input: 3 integers - loan amount, yearly interest rate, loan duration in years
# output: a string containing the monthly interest rate, loan duration in months, monthly payment

# Test Cases:
# input: 10000, 10%, 10
# output: $132.15
# input: 20000, 5%, 8
# output: $253.20
# input: 100000, 8%, 15
# output: $955.65

# Algorithm:
# Ask the user for the loan amount and save to a variable called loan_amount
# Ask the user for the APR and save to a variable called apr (ask for it in percentage)
# Ask the user for the loan duration in years and save to a variable called loan_duration_years
# Validate each of the user inputs
#   Create a loop that checks if the user input is a number
#   If false, print a message asking for correct input and save input to original variable
#   Break loop if true
# Calculate the monthly interest rate and save to a variable called monthly_interest_rate
#   monthly_interest_rate = apr / 12
# Calculate the loan duration in months and save to a variable called loan_duration_months
#   loan_duration_months = loan_duration_years * 12
# Calculate the monthly payment by using the formula:
# monthly_payment = loan_amount * (monthly_interest_rate / (1 - (1 + monthly_interest_rate)**(-loan_duration_months)))
# Print a string containing monthly_interest_rate, loan_duration_months, monthly_payment

# Pseudo-Code

# START

# # Given 3 integers, calculate the monthly payment amount for the given APR and loan duration.

# GET loan_amount, apr, loan_duration_years
# LOOP
#   BREAK if valid_number?(check variable for validity)
#   PRINT message asking for correct input
#   GET input to replace incorrect variable

# SET monthly_interest_rate = apr / 12
# SET loan_duration_months = loan_duration_years * 12
# SET monthly_payment = loan_amount * (monthly_interest_rate / (1 - (1 + monthly_interest_rate)**(-loan_duration_months)))

# PRINT string with monthly_interest_rate, loan_duration_months, monthly_payment

# END

# ---------------------------------------------------------------------------

def valid_number?(num)
  if num.to_i.zero? || num.to_f.zero?
    false
  elsif num.to_i.to_s == num || num.to_f.to_s == num
    'valid'
  else
    false
  end
end

def apr_to_monthly_interest(apr)
  (apr.to_f / 100) / 12
end

def year_to_month_loan_duration(loan_duration_years)
  loan_duration_years.to_i * 12
end

def calculate_monthly_payment(loan_amount,
                              monthly_interest_rate,
                              loan_duration_months)
  loan_amount.to_i * (monthly_interest_rate / (1 -
  (1 + monthly_interest_rate)**(-loan_duration_months)))
end

def prompt(message)
  puts "=> #{message}"
end

prompt("Welcome to Mortgage Calculator!")

loan_amount = 0
loop do
  prompt("What is the loan amount?")
  loan_amount = gets.chomp

  break if valid_number?(loan_amount)

  prompt("You entered: #{loan_amount}. That is not a valid input.")
end

apr = 0
loop do
  prompt("What is the APR? Type the percentage without %. (Ex. 5% would be 5)")
  apr = gets.chomp

  break if valid_number?(apr)

  prompt("You entered: #{apr}. That is not a valid input.")
end

loan_duration_years = 0
loop do
  prompt("What is the duration of the loan in years?")
  loan_duration_years = gets.chomp

  break if valid_number?(loan_duration_years)

  prompt("You entered: #{loan_duration_years}. That is not a valid input.")
end

monthly_interest_rate = apr_to_monthly_interest(apr)
loan_duration_months = year_to_month_loan_duration(loan_duration_years)
monthly_payment = calculate_monthly_payment(loan_amount,
                                            monthly_interest_rate,
                                            loan_duration_months)

puts "Your monthly payment will be $#{monthly_payment.round(2)} "\
     "with an APR of #{apr.to_f.round(2)}% and "\
     "loan duration of #{loan_duration_years.to_f.round(2)} years."

