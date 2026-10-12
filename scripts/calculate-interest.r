#!/usr/bin/env Rscript

# Function to calculate total interest
calculate_total_interest <- function(principal, apr, months) {
  if (apr == 0) return(0)

  monthly_rate <- (apr / 100) / 12
  monthly_payment <- (principal * monthly_rate * (1 + monthly_rate)^months) /
                     ((1 + monthly_rate)^months - 1)

  total_interest <- (monthly_payment * months) - principal
  return(total_interest)
}

# Capture command line arguments
args <- commandArgs(trailingOnly = TRUE)

# Validation: Ensure 3 arguments are provided
if (length(args) < 3) {
  stop("Usage: ./interest_calc.R <principal> <apr> <months>\nExample: ./interest_calc.R 25000 5.5 60")
}

# Convert arguments to numbers
p <- as.numeric(args[1])
a <- as.numeric(args[2])
m <- as.numeric(args[3])

# Calculate and print result
result <- calculate_total_interest(p, a, m)
cat(paste0("Total Interest Paid: $", round(result, 2), "\n"))
