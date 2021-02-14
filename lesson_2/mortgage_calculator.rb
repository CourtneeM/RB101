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

# SET monthly_interest_rate = apr / 12
# SET loan_duration_months = loan_duration_years * 12
# SET monthly_payment = loan_amount * (monthly_interest_rate / (1 - (1 + monthly_interest_rate)**(-loan_duration_months)))

# PRINT string with monthly_interest_rate, loan_duration_months, monthly_payment 

# END

# ---------------------------------------------------------------------------

def calculate_monthly_payment(loan_amount, monthly_interest_rate, loan_duration_months)
  loan_amount.to_i * (monthly_interest_rate / (1 - (1 + monthly_interest_rate)**(-loan_duration_months)))
end

def apr_to_monthly_interest(apr)
  (apr.to_f / 100) / 12
end

def year_to_month_loan_duration(loan_duration_years)
  loan_duration_years.to_i * 12
end

def prompt(message)
  puts "=> #{message}"
end

prompt("Welcome to Mortgage Calculator!")

prompt("What is the loan amount?")
loan_amount = gets.chomp

prompt("What is the APR? Type the percentage without %. (Ex. 5% would be 5)")
apr = gets.chomp

prompt("What is the duration of the loan in years?")
loan_duration_years = gets.chomp

monthly_interest_rate = apr_to_monthly_interest(apr)
loan_duration_months = year_to_month_loan_duration(loan_duration_years)
monthly_payment = calculate_monthly_payment(loan_amount, monthly_interest_rate, loan_duration_months)

puts "Your monthly payment will be $#{monthly_payment.round(2)} with an APR of #{apr}% and loan duration of #{loan_duration_years} years."
