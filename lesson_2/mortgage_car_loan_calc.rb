# Build a mortgage calculator

# input: three integers (loan amount, APR, loan duration)
# output: an integer

# things to consider:
# - need to convert APR into monthly interest rate
# - is loan duration in months or years
# - accept interest rate as a percentage then convert to decimal
# - monthly payment = loan amount * (monthly interest rate / (1 - (1 + monthly interest rate)**(-loan duration in months)))
# - need integer/float validation

# Test Cases:
# mortage_calculator(20000, 12, 5) => $444.89
# mortage_calculator(100000, 8, 10) => $1,213.28
# mortage_calculator(5000, 26, 3) => $201.45

# Algorithm:
# Get three integers from user, loan_amount, apr, loan_duration_in_years
# Calculate the monthly interest rate, monthly_interest_rate = (apr / 100) / 12
# Calculate the loan duration in months, loan_duration_in_months = loan_duration_in_years / 12
# Calculate the monthly payment, monthly_payment = loan_amount * (monthly_interest_rate / (1 - (1 + monthly_interest_rate)**(-loan_duration_in_months)))

# ------------------------------------

# Pseudo-Code

# START

# Given three integers, loan amount, apr, loan duration, calculate the monthly payment for a mortgage

# SET monthly_interest_rate = (apr / 100) / 12
# SET loan_duration_in_months = loan_duration_in_years * 12
# SET monthly_payment = loan_amount * (monthly_interest_rate / (1 - (1 + monthly_interest_rate)**(-loan_duration_in_months)))

# PRINT monthly_payment

# END

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  if num < 0
    return false
  end
  num != 0 || num != 0.0
end

def mortgage_calculator(loan_amount, apr, loan_duration_in_years)
  monthly_interest_rate = (apr / 100) / 12
  loan_duration_in_months = loan_duration_in_years * 12
  monthly_payments = loan_amount * (monthly_interest_rate / (1 - (1 + monthly_interest_rate)**(-loan_duration_in_months)))

  puts "Each monthly payment will be $#{monthly_payments.round(2)} for a $#{'%.2f' % loan_amount} loan at #{apr}% APR for #{loan_duration_in_years} years"
end

prompt("Welcome to Mortgage Calculator!")

loop do
  prompt("Please enter the loan amount:")
  loan_amount = gets.chomp.to_f
  loop do
    break if valid_number?(loan_amount)
    prompt("Hmm... that doesn't look like a valid number. Try again.")
    loan_amount = gets.chomp.to_f
  end

  prompt("Please enter the APR:")
  apr = gets.chomp.to_f
  loop do
    break if valid_number?(apr)
    prompt("Hmm... that doesn't look like a valid number. Try again.")
    apr = gets.chomp.to_f
  end

  prompt("Please enter the loan duration in years:")
  loan_duration_in_years = gets.chomp.to_i
  loop do
    break if valid_number?(loan_duration_in_years)
    prompt("Hmm... that doesn't look like a valid number. Try again.")
    loan_duration_in_years = gets.chomp.to_i
  end

  mortgage_calculator(loan_amount, apr, loan_duration_in_years)

  prompt("Would you like to calculate another loan? (Y to continue or N to exit)")
  answer = gets.chomp.downcase
  break if answer != 'y'
end

prompt("Thank you for using Mortgage Calculator. Goodbye!")
