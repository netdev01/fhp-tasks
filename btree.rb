class BinaryTree
	
  attr_accessor :payload, :left, :right

  def initialize(payload, left, right)
    @payload = payload
    @left = left
    @right = right
  end

  def self.sort(array)

  	btree = nil
	  array.each do |item|
	  	if btree.nil?
	  		btree = BinaryTree.new(item, nil, nil) 
	  	else
  			self.add_node(btree, item)
  		end
  	end

  	puts "print_tree_depth"
  	self.print_tree_depth(btree)
  	puts "====="

  	array = []
  	self.to_array(btree, array)
  	puts "array #{array}"
  	return array

  end

  def self.add_node(btree, item)
  	if item.to_i < btree.payload.to_i
  		if btree.left.nil?
  			btree.left = BinaryTree.new(item, nil, nil)
  		else
  			self.add_node(btree.left, item)
  		end
  	else
  		if btree.right.nil?
  			btree.right = BinaryTree.new(item, nil, nil)
  		else
  			self.add_node(btree.right, item)
  		end
  	end
  end

  def self.to_array(btree, array)
  	if !btree.nil?
  		self.to_array(btree.left, array)
  		array << btree.payload
  		self.to_array(btree.right, array)
  	end
  end

  def self.print_tree_depth(btree)
  	if !btree.nil?
  		self.print_tree_depth(btree.left)
  		puts btree.payload
  		self.print_tree_depth(btree.right)
  	end
  end

end

seven = BinaryTree.new(7, nil, nil)
five  = BinaryTree.new(5, nil, nil)
four  = BinaryTree.new(4, nil, nil)
six   = BinaryTree.new(6, nil, seven)
three = BinaryTree.new(3, nil, six)
two   = BinaryTree.new(2, four, five)
trunk = BinaryTree.new(1, two, three)

puts "print_tree_depth()"
BinaryTree.print_tree_depth(trunk)
puts "====="

array = [7, 4, 9, 1, 6, 14, 10]
puts "array #{array}"
puts "sort()"
btree = BinaryTree.sort(array)