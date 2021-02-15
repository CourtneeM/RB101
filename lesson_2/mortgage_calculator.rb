def valid_loan?(loan_amount)
  if loan_amount.to_i <= 0 || loan_amount.to_f <= 0
    false
  else
    loan_amount.to_i.to_s == loan_amount || loan_amount.to_f.to_s == loan_amount
  end
end

def valid_apr?(apr)
  if apr.to_i < 0 || apr.to_f < 0
    false
  else
    apr.to_i.to_s == apr || apr.to_f.to_s == apr
  end
end

def valid_year?(loan_duration_years)
  if loan_duration_years.to_i <= 0
    false
  else
    loan_duration_years.to_i.to_s == loan_duration_years
  end
end

def get_loan_amount
  loop do
    prompt("What is the loan amount?")
    loan_amount = gets.chomp

    return loan_amount if valid_loan?(loan_amount)

    prompt("You entered: #{loan_amount}. That is not a valid input.")
  end
end

def get_apr
  loop do
    prompt("What is the APR?")
    prompt("(Example: 5% would be 5 or 0.5% would be 0.5)")
    apr = gets.chomp
    return apr if valid_apr?(apr)

    prompt("You entered: #{apr}. That is not a valid input.")
  end
end

def get_loan_duration_years
  loop do
    prompt("What is the duration of the loan in years?")
    loan_duration_years = gets.chomp

    return loan_duration_years if valid_year?(loan_duration_years)

    prompt("You entered: #{loan_duration_years}. That is not a valid input.")
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
  loan_amount.to_f * (monthly_interest_rate / (1 -
  (1 + monthly_interest_rate)**(-loan_duration_months)))
end

def display_results(monthly_payment)
  prompt("Your monthly payment will be $#{format('%.2f', monthly_payment)}.")
end

def calculate_again?
  prompt("Would you like to calculate another monthly payment?")

  loop do
    prompt("Y to calculate again, N to exit.")
    answer = gets.chomp

    case answer.downcase
    when 'y', 'yes' then return true
    when 'n', 'no' then return false
    else prompt("That's not a valid choice.")
    end
  end
end

def display_welcome_message
  prompt("Welcome to Mortgage Calculator!")
end

def display_goodbye_message
  prompt("Thank you for using Mortgage Calculator!")
  prompt("Goodbye.")
end

def clear_screen
  system("cls") || system("clear")
end

def prompt(message)
  puts "=> #{message}"
end

display_welcome_message

loop do
  loan_amount = get_loan_amount
  apr = get_apr
  loan_duration_years = get_loan_duration_years

  monthly_interest_rate = apr_to_monthly_interest(apr)
  loan_duration_months = year_to_month_loan_duration(loan_duration_years)
  monthly_payment = calculate_monthly_payment(loan_amount,
                                              monthly_interest_rate,
                                              loan_duration_months)

  display_results(monthly_payment)

  break unless calculate_again?

  clear_screen
end

display_goodbye_message
