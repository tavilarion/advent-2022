class Stack
	STACKS = [
		[],
		['R', 'G', 'H', 'Q', 'S', 'B', 'T', 'N'],
		['H', 'S', 'F', 'D', 'P', 'Z', 'J'],
		['Z', 'H', 'V'],
		['M', 'Z', 'J', 'F', 'G', 'H'],
		['T', 'Z', 'C', 'D', 'L', 'M', 'S', 'R'],
		['M', 'T', 'W', 'V', 'H', 'Z', 'J'],
		['T', 'F', 'P', 'L', 'Z'],
		['Q', 'V', 'W', 'S'],
		['W', 'H', 'L', 'M', 'T', 'D', 'N', 'C']
	]

	def initialize(file_path)
		@file_path = file_path
	end

	def end_state
		with_line do |line|
			res = line.split
			move(res[1].to_i, res[3].to_i, res[5].to_i)
		end

		result
	end

	private

	attr_reader :file_path

	def with_line
		File.foreach(file_path) do |line|
			yield(line.chomp)
		end
	end

	def move(q, source, dest)
		len = STACKS[source].size
		STACKS[dest] += STACKS[source][len - q..len - 1]
		STACKS[source] = STACKS[source][0..len - q - 1]
	end

	def result
		STACKS.map { |stack| stack.last }.join
	end
end

puts Stack.new('input.txt').end_state
