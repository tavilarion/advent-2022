require 'pry'
class Elevation
	def initialize(file_path)
		@file_path = file_path
		post_initialize
	end

	def step_count
		while true
			if queue.empty?
				print_map
				break
			end
			step(queue.shift)
		end
	end

	private

	attr_reader :file_path, :grid, :start, :dest, :queue, :map

	def post_initialize
		@grid = []
		@map = []

		File.foreach(file_path) do |line|
			grid << line.chomp.split('').map { |e| e.ord - 96 }
			map << Array.new(grid.last.length, 0)
		end

		@start = { x: 20, y: 88 }
		# @dest = { x: 20, y: 88 }
		@queue = [@start]
		@map[start[:x]][start[:y]] = -1
		@grid[start[:x]][start[:y]] = 26
		# @grid[dest[:x]][dest[:y]] = 26
	end

	def destination?
		map[dest[:x]][dest[:y]] != 0
	end

	def step(pos)
		if pos[:x] == 0 && pos[:y] == 0
			add_to_queue(prev_step: pos, next_step: { x: pos[:x] + 1, y: pos[:y] })
			add_to_queue(prev_step: pos, next_step: { x: pos[:x], y: pos[:y] + 1 })
		elsif pos[:x] == 0
			add_to_queue(prev_step: pos, next_step: { x: pos[:x] + 1, y: pos[:y] })
			add_to_queue(prev_step: pos, next_step: { x: pos[:x], y: pos[:y] + 1 }) if pos[:y] < map[pos[:x]].length - 1
			add_to_queue(prev_step: pos, next_step: { x: pos[:x], y: pos[:y] - 1 })
		elsif pos[:y] == 0
			add_to_queue(prev_step: pos, next_step: { x: pos[:x] + 1, y: pos[:y] }) if pos[:x] < map.length - 1
			add_to_queue(prev_step: pos, next_step: { x: pos[:x], y: pos[:y] + 1 })
			add_to_queue(prev_step: pos, next_step: { x: pos[:x] - 1, y: pos[:y] })
		else
		  add_to_queue(prev_step: pos, next_step: { x: pos[:x] + 1, y: pos[:y] }) if pos[:x] < map.length - 1
			add_to_queue(prev_step: pos, next_step: { x: pos[:x], y: pos[:y] + 1 }) if pos[:y] < map[pos[:x]].length - 1
			add_to_queue(prev_step: pos, next_step: { x: pos[:x], y: pos[:y] - 1 })
			add_to_queue(prev_step: pos, next_step: { x: pos[:x] - 1, y: pos[:y] })	
		end 	
	end

	def add_to_queue(prev_step:, next_step:)
		if can_step?(prev_step: prev_step, next_step: next_step)
			if grid[next_step[:x]][next_step[:y]] == 1
				puts map[prev_step[:x]][prev_step[:y]] + 1
				exit(0)
			end
			queue << next_step
			if map[prev_step[:x]][prev_step[:y]] == -1
				map[next_step[:x]][next_step[:y]] = 1
			else
				map[next_step[:x]][next_step[:y]] = map[prev_step[:x]][prev_step[:y]] + 1
			end	
		end
	end

	def can_step?(prev_step:, next_step:)
		map[next_step[:x]][next_step[:y]] == 0 && 
		grid[prev_step[:x]][prev_step[:y]] - grid[next_step[:x]][next_step[:y]] <= 1
	end	

	def print_map
		map.each do |row|
			row.each { |r| print r }
			puts
		end
		true
	end
end

puts Elevation.new('input.txt').step_count
