require 'pry'

class Monkey
	def initialize(data = {})
		@items = data[:items]
		@operation = data[:operation]
		@test_val = data[:test_val]
		@success = data[:success]
		@failure = data[:failure]
		@inspected = 0
	end

	attr_reader :items, :operation, :test_val, :success, :failure, :inspected

	def to_s
		"#{items} #{operation} #{test_val} #{success} #{failure}"
	end

	def add_item(item)
		items << item
	end

	def reset
		@inspected += items.count
		@items = []
	end
end

class Builder
	def initialize(file_path)
		@input = File.readlines(file_path).map(&:chomp)
	end

	def build
		monkeys = []

		(0..input.length - 1).step(7) do |i|
			monkeys << Monkey.new({
				items:     items(input[i + 1]),
				operation: operation(input[i + 2]),
				test_val:      read_nr(input[i + 3]),
				success:   read_nr(input[i + 4]),
				failure:      read_nr(input[i + 5])
			})
		end

		monkeys
	end

	private

	attr_reader :input

	def items(line)
		line.split(': ').last.split(', ').map(&:to_i)
	end

	def operation(line)
		line.split('= ').last
	end

	def read_nr(line)
		line.split.last.to_i
	end
end

class Game
	class << self
		def play_round(monkeys)
			monkeys.each_with_index do |monkey, i|
				monkey.items.each do |item|
					old = item
					result = eval(monkey.operation) % 9699690

					if result % monkey.test_val == 0
						monkeys[monkey.success].add_item(result)
					else
						monkeys[monkey.failure].add_item(result)
					end
				end

				monkey.reset
			end
		end
	end	
end

monkeys = Builder.new('input.txt').build

10000.times { |_i| Game.play_round(monkeys) }

puts monkeys.sort_by(&:inspected).map(&:inspected)
