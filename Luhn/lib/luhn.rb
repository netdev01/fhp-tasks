module Luhn
  def self.is_valid?(number)
    digits = number.to_s.split(%r{\s*}).map(&:to_i) # remove space
    # digits = number.chars.to_a.map(&:to_i)
    sum = 0
    count = 0
    for index in (digits.length-1).downto(0)
    	count = count + 1
    	value = digits[index]
    	if count.even?
    		value = digits[index] * 2
    		value = value-9 if value >= 10
    		digits[index] = value
    	end
    	sum = sum + value
    end
  	sum % 10 > 0 ? (return false) : (return true) 
  end
end