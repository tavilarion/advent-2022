require 'pry'
class Cathode
	def initialize(file_path)
		@file_path = file_path
	end

	STEPS = [40, 80, 120, 160, 200, 240]

	def cycles
		x = 1
		s = 0
		skip = false
		clock = 0
		f = File.new(file_path)
		k = 0

		240.times do |i|
			clock = i + 1
			x += k unless skip
			
			if i % 40 == x || i % 40 == x+1 || i % 40 == x-1
				print '#'
			else
			  print '.'	
			end

			puts if STEPS.include? i+1

			if skip
				skip = false
				next
			end

			res = f.readline.chomp.split

			if res.first == 'noop'
				k = 0 
				next
			end

			skip = true
			k = res.last.to_i
		end

		f.close
	end

	private

	attr_reader :file_path

	def each_line
		File.foreach(file_path) { |line| yield line.chomp }
	end
end

Cathode.new('input.txt').cycles
