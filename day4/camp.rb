class Camp
	def initialize(file_path)
		@file_path = file_path
		@counter = 0
	end

	def result
		with_line do |line|
			res = line.split(',')
			interval1 = res[0].split('-').map(&:to_i)
			interval2 = res[1].split('-').map(&:to_i)

			@counter += 1 if overlap?(interval1[0], interval1[1], interval2[0], interval2[1])
		end

		counter
	end

	private

	attr_accessor :file_path, :counter

	def with_line
		File.foreach(file_path) do |line|
			yield line.chomp
		end
	end

	def overlap?(x1, y1, x2, y2)
		return true if x2 >= x1 && x2 <= y1
		return true if x1 >= x2 && x1 <= y2

		false 
	end
end

puts Camp.new('input.txt').result
