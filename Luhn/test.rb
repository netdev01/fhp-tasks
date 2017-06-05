  def is_valid?(number)
    digits = number.to_s.split(%r{\s*}).map(&:to_i) # remove space
    puts "====="
    puts "digits = #{number}"
    puts "digits = #{digits}"
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
    puts "digits = #{digits}"
    puts "sum = #{sum}"
  	sum % 10 > 0 ? (return false) : (return true) 
  end



  puts is_valid?(4194560385008504)
  puts is_valid?(4194560385008505)
  puts is_valid?(377681478627336)
  puts is_valid?(377681478627337)
