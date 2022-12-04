class Rps
	SCORE_MAP = {
		'A' => {
			'X' => 3,
			'Y' => 4,
			'Z' => 8
		},
		'B'	=> {
			'X' => 1,
			'Y' => 5,
			'Z' => 9
		},
		'C' => {
			'X' => 2,
			'Y' => 6,
			'Z' => 7
		}
	}.freeze

	def initialize(file_path:)
		@file_path = file_path
	end

	def score
		s = 0

		with_row_data do |x, y|
			s = s + SCORE_MAP[x][y]
		end

		s
	end

	private

	attr_reader :file_path

	def with_row_data
		File.foreach(file_path) do |line|
			data = line.chomp.split(' ')
			yield(data[0], data[1])
		end
	end

	def win_score(x, y)
		case x
			when 'A'
				return 6 if y == 'Y'
				return 0 if y == 'Z'
				return 3
			when 'B'
				return 6 if y == 'Z'
				return 0 if y == 'X'
				return 3
			when 'C'	
				return 6 if y == 'X'
				return 0 if y == 'Y'
				return 3
		end
	end
end

puts Rps.new(file_path: 'input.txt').score
