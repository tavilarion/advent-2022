class CaloriesCounter
	def initialize(file_path:)
		@file_path = file_path
	end

	def max_calories
		max1 = 0
		max2 = 0
		max3 = 0
		s = 0

		File.foreach(file_path) do |line|
			if line.chomp.empty?
				if max1 < s
					max3 = max2
					max2 = max1
					max1 = s
				elsif max2 < s
					max3 = max2
					max2 = s
				elsif max3 < s	
					max3 = s
				end
				s = 0
				next
			end	
			s += line.to_i
		end

		max1 + max2 + max3
	end

	private

	attr_reader :file_path
end


puts CaloriesCounter.new(file_path: 'input_calories.txt').max_calories
