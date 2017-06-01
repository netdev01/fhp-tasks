class Image

  attr_accessor :array

  def initialize(array)
    self.array = array
  end

  def output_image
  	output = ''
  	self.array.each do |row|
  		row.each do |cell|
  			output = output + ' ' + cell.to_s
  		end
  		output = output + "\n"
  	end
  	puts output
  end

  #
  # Task: BlurImage #1
  # Reverse the image
  #
  def reverse
  	array = self.array
		temp_array = []
		until array.empty?
			temp_row = []
			curr_row = array.pop
			temp_row.push(curr_row.pop) until curr_row.empty?
			temp_array.push(temp_row)
		end
		self.array = temp_array
  end

  #
  # Task: BlurImage #3
  # Method 1: pattern processing
  #
  def blur(n=1)

		puts "\n== blur(#{n})"

  	array = self.array
  	temp_array = Marshal.load( Marshal.dump(array) )

  	# iterate through each cell
  	i_length = array.length
  	for i in 0..i_length-1
  		row = array[i]
  		for j in 0..row.length-1

  			# process cell with 1
  			if 1 == array[i][j]

  				# We will process from the 1st affected row down to the last affected row.
  				# i_offset is the row offset from the original cell (j,j) with 1
  				# then we will determine the start and end index for j
  				for i_offset in -1*n .. n

  					# determine current i to blur
  					i_current = i + i_offset

  					# boundary condition for i
  					i_current = 0 if i_current < 0 
  					i_current = i_length-1 if i_current > i_length-1

  					# determine current start j to end j to blur
  					if i_offset <= 0 #rows above + including the original row
							j_start = j - (n + i_offset)
							j_end 	= j + (n + i_offset)
						else # rows below the original row
							j_start = j - (n - i_offset)
							j_end 	= j + (n - i_offset)
						end

						# boundary condition for j
						j_start = 0 if j_start < 0
						j_end = row.length - 1 if j_end > row.length - 1

						# actual blurring
						for current_j in j_start..j_end
							temp_array[i_current][current_j] = 1
						end
						
  				end

  				temp_array[i][j] = 2 # to see the original x,y easier

  			end

  		end
  	end

  	self.array = temp_array

  end

  #
  # Task: BlurImage #3
  # Method 2: regression
  # Cleanest code
  #
  def blur2(n=1)
		puts "\n== blur2(#{n})"
  	array = self.array
  	temp_array = Marshal.load( Marshal.dump(array) )
  	# iterate through each cell
  	i_length = array.length
  	for i in 0..i_length-1
  		row = array[i]
  		for j in 0..row.length-1
  			if 1 == array[i][j] # process cell with 1
  				blur2_helper(temp_array, i_length, row.length, i, j, n)
  				temp_array[i][j] = 2 # to see original i,j easier
  			end
  		end
  	end
  	self.array = temp_array
  end

  # can be private, but leave it her for easy reference
  def blur2_helper(array, x_len, y_len, x, y, step=1)
		if x >=0 && x <= x_len-1 && y >=0 && y <= y_len-1
	  	if step <= 0
	  		array[x][y] = 1
	  	else
	  		blur2_helper(array, x_len, y_len, x+1, y,   step-1)
	  		blur2_helper(array, x_len, y_len, x-1, y,   step-1)
	  		blur2_helper(array, x_len, y_len, x,   y+1, step-1)
	  		blur2_helper(array, x_len, y_len, x,   y-1, step-1)
	  		blur2_helper(array, x_len, y_len, x+1, y+1, step-2)
	  		blur2_helper(array, x_len, y_len, x-1, y-1, step-2)
	  	end
	  end
  end

  #
  # Task: BlurImage #3
  # Metho 3: offset hash table created through regression
  # Should be the fastest code
  #
  def blur3(n) 
		puts "\n== blur3(#{n})"
  	array = self.array
  	temp_array = Marshal.load( Marshal.dump(array) )
  	offset = get_blur3_offset(n)
  	# iterate through each cell
  	i_length = array.length
  	for i in 0..i_length-1
  		row = array[i]
  		for j in 0..row.length-1
  			if 1 == array[i][j] # process cell with 1
  				offset.each do |key, value|
	  				i_blur = i + value[:x].to_i
	  				j_blur = j + value[:y].to_i
	  				# boundary conditions
						i_blur = 0 if i_blur < 0
						i_blur = i_length - 1 if i_blur > i_length - 1
						j_blur = 0 if j_blur < 0
						j_blur = row.length - 1 if j_blur > row.length - 1
  					temp_array[i_blur][j_blur] = 1
					end
  				temp_array[i][j] = 2 # to see original i,j easier
  			end
  		end
  	end
  	self.array = temp_array
  end

  def get_blur3_offset(step=1, offset=nil)
  	offset = Hash.new if offset.nil?
	  get_blur3_offset_helper(offset, 0, 0, step)
	  return offset
  end

  def get_blur3_offset_helper(offset, x, y, step)
  	if step >= 0
  		key = "#{x}:#{y}"
  		offset[key] = {:x => x, :y => y} if !offset.key?(key.to_sym)
  		get_blur3_offset_helper(offset, x+1, y, 	step-1)
  		get_blur3_offset_helper(offset, x-1, y, 	step-1)
  		get_blur3_offset_helper(offset, x,	 y+1, step-1)
  		get_blur3_offset_helper(offset, x,	 y-1, step-1)
	  	get_blur3_offset_helper(offset, x+1, y+1, step-2)
	  	get_blur3_offset_helper(offset, x-1, y-1, step-2)
  	end
  end

  # Task: BlurImage #2
  def blur_simple
		puts "\n== blur_simple"
  	array = self.array
  	# Make a copy of array, used for blurring
  	# Use self.array to keep track of original 1s
  	temp_array = Marshal.load( Marshal.dump(array) )
  	i_length = array.length
  	for i in 0..i_length-1
  		row = array[i]
  		j_length = row.length
  		for j in 0..j_length-1
  			if 1 == array[i][j]
  				temp_array[i-1][j] = 1 if i-1 >= 0
  				temp_array[i+1][j] = 1 if i+1 <= i_length-1
  				temp_array[i][j-1] = 1 if j-1 >= 0
  				temp_array[i][j+1] = 1 if j+1 <= j_length-1
  				temp_array[i][j] = 2 # to see the original x,y easier
  			end
  		end
  	end
  	self.array = temp_array
  end

end 

class ImageTest

	def self.new_image(n)
		puts "\n== create image #{n}"
		case n
		when 1
			image = Image.new([
		  [0, 0, 0, 0, 0, 0],
		  [0, 0, 0, 0, 0, 0],
		  [0, 0, 1, 0, 0, 0],
		  [0, 0, 0, 0, 0, 0],
		  [0, 0, 0, 0, 0, 0],
		  [0, 0, 0, 0, 0, 1]
		])
		else
			image = Image.new([
		  [0, 0, 0, 0, 0, 0 , 0, 0, 0],
		  [0, 0, 0, 0, 0, 0 , 0, 0, 0],
		  [0, 0, 0, 0, 0, 0 , 0, 0, 0],
		  [0, 0, 0, 0, 0, 0 , 0, 0, 0],
		  [0, 0, 0, 1, 0, 0 , 0, 0, 0],
		  [0, 0, 0, 0, 0, 0 , 0, 0, 0],
		  [0, 0, 0, 0, 0, 0 , 0, 0, 0],
		  [0, 0, 0, 0, 0, 0 , 0, 0, 0],
		  [0, 0, 0, 0, 0, 0 , 0, 0, 0],
		  [0, 0, 0, 0, 0, 0 , 1, 0, 0],
		  [0, 0, 0, 0, 0, 0 , 0, 0, 0],
		  [1, 0, 0, 0, 0, 0 , 0, 0, 0],
		  [0, 0, 0, 0, 0, 0 , 0, 0, 0]
		])
		end
		return image
	end

	def output_hash(h)
  	h.each do |key, value|
			p "#{key}:#{value}"
  	end
	end

	def self.test_offset
		image = ImageTest.new_image(1)
		image.get_blur_offset(2, nil)
	end

	def self.test_get_blur
		puts "\n===== test_get_blur\n"
		image = ImageTest.new_image(1)
		offset = Hash.new
		offset = image.get_blur_offset(offset, 3, 3, 2)
		output_hash(offset)
	end

	def self.test_reverse
		puts "\n===== test_reverse\n"
		image = ImageTest.new_image(2)
		image.output_image
		puts "\n== reverse"
		image.reverse
		image.output_image
		puts "\n== reverse back"
		image.reverse
		image.output_image

	end

def self.test_blur3
		puts "\n===== test_blur3\n"

		image = ImageTest.new_image(1)
		image.output_image
		image.blur3(1)
		image.output_image

		image = ImageTest.new_image(1)
		image.output_image
		image.blur3(2)
		image.output_image

		image = ImageTest.new_image(2)
		image.output_image
		image.blur3(2)
		image.output_image

		image = ImageTest.new_image(2)
		image.output_image
		image.blur3(3)
		image.output_image

	end

	def self.test_blur2
		puts "\n===== test_blur2\n"

		image = ImageTest.new_image(1)
		image.output_image
		image.blur2(1)
		image.output_image

		image = ImageTest.new_image(1)
		image.output_image
		image.blur2(2)
		image.output_image

		image = ImageTest.new_image(2)
		image.output_image
		image.blur2(2)
		image.output_image

		image = ImageTest.new_image(2)
		image.output_image
		image.blur2(3)
		image.output_image

	end

	def self.test_blur
		puts "\n===== test_blur\n"

		image = ImageTest.new_image(1)
		image.output_image
		image.blur(1)
		image.output_image

		image = ImageTest.new_image(1)
		image.output_image
		image.blur(2)
		image.output_image

		image = ImageTest.new_image(2)
		image.output_image
		image.blur(2)
		image.output_image

		image = ImageTest.new_image(2)
		image.output_image
		image.blur(3)
		image.output_image

	end

	def self.test_blur_simple
		puts "\n===== test_blur_simple\n"

		image = ImageTest.new_image(1)
		image.output_image
		image.blur_simple
		image.output_image

		image = ImageTest.new_image(2)
		image.output_image
		image.blur_simple
		image.output_image
	end

end

ImageTest.test_blur3

=begin
ImageTest.test_reverse
ImageTest.test_blur_simple
ImageTest.test_blur
ImageTest.test_blur2
ImageTest.test_offset
=end