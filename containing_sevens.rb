# frozen_string_literal: true

# Problem 1
# This is a one of the quiz problems, so just commit into this repository

# 1. g(1000) = 271
# 2. computer program to compute g(N)

def g(num)
  raise ArgumentError, 'Input is not a integer' unless num.is_a?(Integer)

  count = 0
  (1..num).each do |n|
    while n > 0
      if n % 10 == 7
        count += 1

        break
      end
      n /= 10
    end
  end
  count
end
