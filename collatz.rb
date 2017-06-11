def collatz(n)
	seq = []
	seq << n
	while n >= 2 do
		if n.even?
			n = n/2
		else
			n = 3*n + 1
		end
		seq << n
	end
	return seq
end

def longest(n)
	seq_longest = []
	for i in 1..n
		seq = collatz(i)
		# puts "#{i} => #{seq.length}"
		seq_longest = seq if seq.length > seq_longest.length 
	end
	print_seq(seq_longest)
	return seq_longest
end

def print_seq(list, i=0)
	puts "#{list[0]}, length=#{list.length}" if i==0 
	if i < list.length
		print "#{list[i]} --> "
		print_seq(list, i+1)
	else
		return
	end
end

require 'benchmark'

n = 10000000
Benchmark.bm do |x|
	x.report("1000000") { longest(n) } 
end