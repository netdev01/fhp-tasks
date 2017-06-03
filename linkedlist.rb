
class LinkedListNode
	attr_accessor :value, :next_node

	def initialize(value, next_node=nil)
		@value = value
		@next_node = next_node # LIFO
	end

	def self.reverse_list1(list)
		stack = Stack.new
		new_list = nil
		while !list.nil?
			value = stack.push(list.value)
			list = list.next_node
		end
		# This linkedlist is FILO, with regard to the "head" node (list)
		# The stack is LIFO, stored with the same linkedList design FILO.
		# So the internal linkedlist of the stack is already in reserve order.
		new_list = stack.get_linkedlist
		return new_list
	end

	def self.reverse_list2(list, previous=nil)

		return nil if list.nil?
=begin
		return nil if list.nil?
		if list.next_node.nil?
			list.next_node = previous
		else
			list.next_node = nil if previous.nil?
			reverse_list2(list->next_node, list)
		end
=end
	end

	def self.append_node(list, stack)
		if !stack.nil?
			value = stack.pop
			LinkedListNode.new(value, list)
			append_node(list, stack)
		end
	end

	def self.print_values(list_node)
		if !list_node.nil?
			print "#{list_node.value} --> "
			print_values(list_node.next_node)
		else
			print "nil\n"
			return
		end
	end

end

class Stack
	attr_reader :data

	def initialize
		@data = nil
	end

	# Push a value onto the stack
	def push(value)
		if @data.nil? 
			@data = LinkedListNode.new(value) 
		else
			@data = LinkedListNode.new(value, @data)
		end
	end

	def pop
		if !@data.nil?
			value = @data.value
			@data = @data.next_node
			return value
		end
	end

	def get_linkedlist
		return @data
	end

	def print_values
		puts "print stack as linked list"
		LinkedListNode.print_values(@data)
	end

end

puts "\n===== LinkedListNode new"
node1 = LinkedListNode.new(37)
node2 = LinkedListNode.new(99, node1)
node3 = LinkedListNode.new(12, node2)
LinkedListNode.print_values(node1)
LinkedListNode.print_values(node2)
LinkedListNode.print_values(node3)

puts "\n===== reverse_list1"
revlist = LinkedListNode.reverse_list1(node3)
LinkedListNode.print_values(revlist)
revlist = LinkedListNode.reverse_list1(revlist)
LinkedListNode.print_values(revlist)

puts "\n===== reverse_list2"
revlist = LinkedListNode.reverse_list2(node3)
LinkedListNode.print_values(revlist)
revlist = LinkedListNode.reverse_list2(revlist)
LinkedListNode.print_values(revlist)

puts "\n===== Stack push twice: 3, 5"
stack1 = Stack.new
stack1.push(3)
stack1.push(5)
puts "pop twice: " +  stack1.pop.to_s + " " + stack1.pop.to_s