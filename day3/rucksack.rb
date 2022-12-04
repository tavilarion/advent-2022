class Rucksack
	def initialize(file_path:)
		@file_path = file_path
		post_initialize
	end

	def total
		with_lines do |l1, l2, l3|
			compute(convert(l1), convert(l2), convert(l3))
		end

		sum
	end

	private 

	attr_reader :file_path, :a, :b, :c, :sum, :input

	def with_lines
		input.each_with_index do |_e, i|
			if (i + 1) % 3 == 0
				yield(input[i-2], input[i-1], input[i])
			end
		end	
	end

	def compute(x, y, z)
		reset!

		x.each_with_index do |_e, i|
			a[x[i]] = 1
		end

		y.each_with_index do |_e, i|
			b[y[i]] = 1
		end

		z.each_with_index do |_e, i|
			c[z[i]] = 1
		end

		a.each_with_index do |e, i|
			@sum = @sum + i if e == 1 && b[i] == 1 && c[i] == 1
		end
	end

	def post_initialize
		@a = Array.new(53)
		@b = @a.dup
		@c = @a.dup
		@sum = 0
		@input = IO.readlines(file_path, chomp: true)
	end

	def reset!
		a.each_with_index { |_v, i| a[i] = 0; b[i] = 0; c[i] = 0 }
	end

	def convert(str)
		str.split('').map do |c| 
			if c == c.upcase
				c.ord - 38 
			else
				c.ord - 96	
			end	
		end
	end
end

puts Rucksack.new(file_path: 'input.txt').total
