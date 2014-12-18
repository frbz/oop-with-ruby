class Board

	def initialize
		@grid = Hash.new
		@wins = [ 
			[1, 2, 3], [4, 5, 6], [7, 8, 9],
			[1, 4, 7], [2, 5, 8], [3, 6, 9],
			[1, 5, 9], [3, 5, 7]
		]
	end

	def new_game
		(1..9).each { |n| @grid[n] = "-" }
	end

	def display
		@grid.each do |k, v|
			if k == 4 || k == 7
				print "\n#{v} "
			else
				print v + " "
			end
		end
		puts
	end

	def action(player, tile)
		if @grid[tile] == "-"
			@grid[tile] = player == 1 ?  "X" : "O"
			return false
		else 
			return true
		end
	end

	def victory?
		@wins.each do |a|
			if a.all? { |s| @grid[s] == "X" }
				puts "Player 1 wins!"
				exit
			elsif a.all? { |s| @grid[s] == "O" }
				puts "Player 2 wins!"
				exit
			end
		end
		return false
	end

	def draw?
		if self.victory? == false
			if @grid.none? { |k, v| v == "-"}
				puts "The game is a draw!"
				exit
			end
		end
		return false
	end	

end

class Engine

	def initialize
		@game = Board.new
	end

	def start
		@game.new_game
		puts "Welcome to Tic Tac Toe."
		puts "The tiles are numbered from 1 (top left) through 9 (bottom right)."
		puts "Your goal is simple to get 3 x's in a row for Player 1 or o's for Player 2."
		puts "Enjoy and good luck!"
		@game.display
	end

	def move(player)
		player += 2 if player == 0
		puts "Player #{player} choose the tile (1-9) you wish to mark."
		tile = gets.chomp.to_i
		if (1..9).include? tile
			duplicate = @game.action(player, tile)
			if duplicate == true
				puts "Tile is already filled. Choose another one..."
				self.move(player)
			end
		else
			puts "Wrong Input! Try again Player #{player}..."
			self.move(player)
		end
	end

	def turns
		@turn = 1
		while @game.draw? == false
			self.move(@turn % 2)
			@game.display
			@game.victory?
			@turn += 1
		end
	end

end

play = Engine.new
play.start
play.turns