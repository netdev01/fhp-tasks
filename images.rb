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

  # reverse the image
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

  # blur the 1s in the array within Manhattan Distance
  def blur(n=1)

  	array = self.array

  	# Make a copy of array, used for blurring
  	# Use self.array to keep track of original 1s
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

  			end

  		end
  	end

  	self.array = temp_array

  end

  def blur_simple
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
  			end
  		end
  	end
  	self.array = temp_array
  end

end 

class ImageTest

	def self.test_reverse

		puts "\n=====test_reverse\n\n"

		image = Image.new([
		  [0, 0, 0, 0],
		  [0, 1, 0, 0],
		  [0, 0, 0, 1],
		  [0, 0, 0, 0]
		])
		puts "== input array 1"
		image.output_image
		puts "== reverse"
		image.reverse
		image.output_image
		puts "== reverse back"
		image.reverse
		image.output_image

	end

	def self.test_blur

		puts "\n===== test_blur\n\n"

		image = Image.new([
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
		  [0, 1, 0, 0],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0]
		])
		puts "== input array #1"
		image.output_image
		puts "== blur(1)"
		image.blur(1)
		image.output_image

		image = Image.new([
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
		  [0, 1, 0, 0],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0]
		])
		puts "== input array #1"
		image.output_image
		puts "== blur(2)"
		image.blur(2)
		image.output_image

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
		  [0, 0, 0, 0, 0, 0 , 0, 0, 0],
		  [0, 0, 0, 0, 0, 0 , 0, 0, 0],
		  [0, 0, 0, 0, 0, 0 , 0, 0, 0],
		  [0, 0, 0, 0, 0, 0 , 0, 0, 1]
		])
		puts "== input array #2"
		image.output_image
		puts "== blur(2)"
		image.blur(2)
		image.output_image

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
		  [0, 0, 0, 0, 0, 0 , 0, 0, 0],
		  [0, 0, 0, 0, 0, 0 , 0, 0, 0],
		  [0, 0, 0, 0, 0, 0 , 0, 0, 0],
		  [0, 0, 0, 0, 0, 0 , 0, 0, 1]
		])
		puts "== input array #2"
		image.output_image
		puts "== blur(3)"
		image.blur(3)
		image.output_image

	end

	def self.test_blur_simple

		puts "\n===== test_blur_simple\n\n"

		image = Image.new([
		  [0, 0, 0, 0, 0],
		  [0, 1, 0, 0, 0],
		  [0, 0, 0, 1, 0],
		  [0, 0, 0, 1, 0],
		  [1, 0, 0, 0, 0],
		  [0, 0, 0, 0, 0]
		])
		puts "== input array #1"
		image.output_image
		puts "== blur_simple"
		image.blur_simple
		image.output_image

		image = Image.new([
		  [0, 0, 0, 0],
		  [0, 0, 1, 0],
		  [0, 0, 0, 0],
		  [0, 1, 0, 0],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0]
		])
		puts "== input array #2"
		image.output_image
		puts "== blur_simple"
		image.blur_simple
		image.output_image

	end

end



ImageTest.test_reverse
ImageTest.test_blur_simple
ImageTest.test_blur