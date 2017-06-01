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
  				for i_offset in -1*n .. n
  					process_i = i + i_offset
  					process_i = 0 if process_i < 0 										# boundary condition
  					process_i = i_length-1 if process_i > i_length-1	# boundary condition
  					process_array = temp_array[process_i]
  					if  i_offset == -1*n # 1st
							set_length = 1 
						else
							if i_offset <= 0
								set_length = set_length + 2
							else
								set_length = set_length - 2
							end
						end
  					set_values_in_1d_array(process_array, j, set_length, 1)
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

	private

	def set_values_in_1d_array(array, index, set_length, value=1)
		start = index - (set_length-1)/2
		start = 0 if start < 0
		final = index + (set_length-1)/2
		final = array.length-1 if final > array.length-1
		for i in start..final
			array[i] = value
		end
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
		puts "== input array 1"
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
		puts "== input array 1"
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
		puts "== input array 1"
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
		puts "== input array 2"
		image.output_image
		puts "== blur_simple"
		image.blur_simple
		image.output_image
	end

end



ImageTest.test_reverse
ImageTest.test_blur_simple
ImageTest.test_blur