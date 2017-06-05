def iterative_fib(n)
	fib = [0,1]
	for i in 2..n-1
		fib[i] = fib[i-1] + fib[i-2]
	end
	index = n-1
	index = 0 if n <= 0
	return fib[index]
end

def recursive_fib(n)
	return 0 if n-1 <= 0
	return 1 if n-1 == 1
	return recursive_fib(n-1) + recursive_fib(n-2)
end

def recursive_fib2(n, memo = {})
  if n == 0 || n == 1
    return n
  end
  memo[n] ||= recursive_fib2(n-1, memo) + recursive_fib2(n-2, memo)
end

require 'benchmark'
n = 35
Benchmark.bm do |x|
	x.report("iterative_fib") { iterative_fib(n) } 
	x.report("recursive_fib") { recursive_fib(n) } 
	x.report("recursive_fib2") { recursive_fib2(n) } 
end