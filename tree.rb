class Tree
  attr_accessor :payload, :children

  def initialize(payload, children)
    @payload = payload
    @children = children
  end

  # depth search using recursion
  def depth_search(node, payload)
   	if node.nil?
  		return nil
  	else
  		puts node.payload
  		if payload == node.payload
	  		puts "found => payload=#{payload}, node.payload=#{node.payload}"
	  		return node
	  	else 	
	  		result = depth_search(node.children[0], payload)
	  		if !result.nil?
	  			return result
	  		else
					depth_search(node.children[1], payload)
	  		end
	  	end
	  end
  end

  # breadth search using queue & recursion
  def breadth_search(node, payload, queue=nil)
  	queue = MyQueue.new if queue.nil?
  	if node.nil?
  		return nil
  	else
  		child0 = node.children[0]
  		child1 = node.children[1]

  		# enqueue all children
  		queue.enqueue(child0) if !child0.nil?
  		queue.enqueue(child1) if !child1.nil?

  		# dequeue
  		current_node = queue.dequeue
  		puts current_node.payload
  		if current_node.payload == payload
	  		puts "found => payload=#{payload}, current_node.payload=#{current_node.payload}"
  			return current_node 
  		end
  		return nil if queue.nil?
  		
			if !current_node.children[0].nil? || !current_node.children[1].nil?
  			# if a child exists, update current node and recurse
				breadth_search(current_node, payload, queue)
			else
				# if no children, dequeue and recurse
				current_node = queue.dequeue
  			puts current_node.payload
	  		if current_node.payload == payload
		  		puts "found => payload=#{payload}, current_node.payload=#{current_node.payload}"
	  			return current_node 
	  		end
  			return nil if queue.nil?
				breadth_search(current_node, payload, queue)
			end

  	end
  end

  def print_tree_depth()
  	if !self.nil?
  		puts self.payload
  		self.children[0].print_tree_depth() if !self.children[0].nil?
  		self.children[1].print_tree_depth() if !self.children[1].nil?
  	end
  end

end

class MyQueue
	  def initialize
    @queue = []
  end

  def enqueue(item)
    @queue.push(item)
  end

  def dequeue
    @queue.shift
  end
end


# The "Leafs" of a tree, elements that have no children
deep_fifth_node = Tree.new(5, [])
eleventh_node = Tree.new(11, [])
fourth_node   = Tree.new(4, [])

# The "Branches" of the tree
ninth_node = Tree.new(9, [fourth_node])
sixth_node = Tree.new(6, [deep_fifth_node, eleventh_node])
seventh_node = Tree.new(7, [sixth_node])
shallow_fifth_node = Tree.new(5, [ninth_node])


# The "Trunk" of the tree
trunk   = Tree.new(2, [seventh_node, shallow_fifth_node])

puts "\ntrunk.print_tree_depth"
trunk.print_tree_depth()

puts "\ntrunk.depth_search 5, 11, 20"
node = trunk.depth_search(trunk, 5)
node = trunk.depth_search(trunk, 11)
node = trunk.depth_search(trunk, 20)


puts "\ntrunk.breadth_search 5, 11, 20"
node = trunk.breadth_search(trunk, 5)
node = trunk.breadth_search(trunk, 11)
#node = trunk.breadth_search(trunk, 20)
