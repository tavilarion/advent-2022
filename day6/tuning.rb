class Tuning
	def initialize(message)
		@message = message
		@queue = @message[0..13]
		@chars = {}
	end

	def tune
		count = 14
		
		message[14..].each do |chr|
			count += 1
			queue.shift
			queue << chr
			
			return count if unique?
		end 
	end

	private

	attr_reader :message, :queue, :chars

	def unique?
		chars.clear

		queue.each do |chr|
			return false if chars.key?(chr)

			chars[chr] = 1
		end

		true
	end	
end

msg = File.read('input.txt').chomp.chars
puts Tuning.new(msg).tune
