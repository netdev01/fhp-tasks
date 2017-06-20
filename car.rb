class Car

	attr_accessor :manufacture, :model, :year, :engine_size, :price

	@price = 0

	def initialize(manufacture, model, year, engine_size)
		@manufacture = manufacture
		@model			 = model
		@year				 = year
    @engine_size = engine_size
  end

  def to_s
    "Car: #{@manufacture}, #{@model}, #{@year}, #{@engine_size}cc, $#{@price}"
  end

end

rav4 = Car.new("Toyota", "RAV4", 2012, 2500)
puts rav4.to_s

rav4.price = 12000
puts rav4.to_s


