class Code

	def initialize
		make_code
	end

	def get_colors
		@colors = @code.map do |n|
	 	n.gsub(/\d+/, 
				"1" => "Red", "2" => "Blue", "3"  => "Yellow", "4" => "Green")
		end
		return @colors.join(" ")
	end

	def make_code
		@code = []
		@numbers = ["1", "2", "3", "4"]
		4.times { |n| @code << @numbers.sample }
	end

	def check_ball?(color, slot)
		if @code[slot] == color
			return "b"
		elsif @temp.include? color
			return "w"
		else
			return ""
		end
	end

	def check_guess?(guess)
		@temp = @code
		@pins = []
		guess.each_with_index do |g, i|
			@pins << check_ball?(g, i)
		end
		return @pins.sort.join
	end

end

class Engine

	def initialize
 		@code = Code.new
	end

	def codebreaker
		@counter = 0
		while @counter < 12
			puts @solution = @code.check_guess?(input)
			@counter += 1
			winner if @solution == "bbbb"
		end
		loser
	end

	def input
		puts "Enter the code: Red = 1, Blue = 2, Yellow = 3, Green = 4."
		gets.chomp.split("")
	end

	def winner
		puts "You cracked the code well done!"
		puts "#{@code.get_colors} was the code like you already knew."
		exit
	end

	def loser
		puts "You lost as you were unable to break the code."
		puts "The code was: #{@code.get_colors}"
		puts "Better luck next time!"
	end

end

class Menu

	def initialize
		@engine = Engine.new
	end

	def start
		puts "Welcome to Mastermind!"
		puts "Your goal is to break the secret code."
		puts "The code consists of 4 colored balls (red, blue, yellow and green)."
		puts "If you can crack the code within 12 tries you win the game."
		puts "Each time you correctly guess the position and color of a ball you get a black pin"
		puts "and if you guess a color that is in the code, but not at that position you get a white pin."
		puts "Pins are hints to help you win the game."
		puts "Good luck!"
		@engine.codebreaker
	end

end


game = Menu.new
game.start