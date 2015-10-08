class Peg_operations

	def check_for_matches(hidden, guess)

		# first check for pegs that are in the correct position
		hidden_not_matched=[]
		guess_not_matched=[]
		hidden.each_with_index do |peg, index|
			if peg!=guess[index]
				hidden_not_matched << peg
				guess_not_matched << guess[index]
			end
		end
		right_position = 4-hidden_not_matched.length

		# next check for pegs that are the correct color but in the wrong position
		right_color=0
		guess_not_matched.each do |guessed|
			if hidden_not_matched.include?(guessed)
				right_color +=1
				hidden_not_matched.delete(guessed)
			end
		end
		return [right_position, right_color]
	end



	def generate_random
		4.times.map{rand(1..6)}
	end

end



class Games
	def human_guessing

		pegs=Peg_operations.new

		hidden = pegs.generate_random

		result=[0,0]
		number_of_guesses=1

		  while result[0] < 4 && number_of_guesses < 13

			print "enter your guess # #{number_of_guesses}: "
			guess=gets.chomp
			# format and validate the guess
			guess=guess.split(",")

			if guess== ["q"] 
				print "exiting...\n"
				return
			end

			guess = guess.map {|g| g.to_i}

			if guess.length != 4 || guess.any? {|g| g < 1 || g >7 }
				print "guesses must be four numbers in the range 1-6 separated by commas.\n"


			else
				# report result of guess
				result = pegs.check_for_matches(hidden, guess)

				if result[0]==4
					print "you win!\n"
					return

				else
				print "#{result[0]} are the correct color and in the correct position, #{result[1]} are the correct color but incorrect position\n"
				number_of_guesses += 1
				end
			end
		  end
		print "you didn't win. The hidden pegs were #{hidden}\n"
	end


	def computer_guessing

		pegs=Peg_operations.new

		feedback=[0,0]
		number_of_guesses=1

  		  current_guess = pegs.generate_random
		  while feedback[0] < 4 && number_of_guesses < 13 
			print "my guess is (#{number_of_guesses}): #{current_guess}\n"
			print "how did I do? "
			feedback=gets.chomp
			# format and validate the feedback
			feedback=feedback.split(",")

			if feedback== ["q"] 
				print "exiting...\n"
				return
			end

			feedback = feedback.map {|g| g.to_i}

			if feedback.length != 2 || feedback.reduce(:+) > 4
				print "feedback must be two numbers separated by commas which add up to 4.\n"
				feedback[0]=0
			else

				if feedback[0]==4
					print "I win.\n"
					return

				else
				number_of_guesses += 1
				current_guess = pegs.generate_random
				end
			end
		  end
		print "I didn't win.\n"
	end

end

class Intro
	def game_select
		print "\nMastermind game\n"

		print "This is a computer version of the Master Mind board game. The objective is\n"
		print "to guess the 'colors' of four 'pegs' using feedback about each guess. Colors\n"
		print "are represented by the numbers 1-6. Feedback consists of number of pegs that\n"
		print "are the correct color and in the correct position, plus number of pegs that\n"
		print "are the correct color but in the wrong position. Up to 12 guesses are allowed.\n\n"

		print "computer or person guess? (c for computer, q for quit, ENTER for person)"
		game=Games.new
		game_selection=gets.chomp
		if game_selection == "q"
		print "quit.\n"
			return
		elsif game_selection == "c" 
			print "Computer guessing selected.\n"
			print "\nPlease note: This is a 'non AI' version where the computer simply makes random\n"
			print "guesses until it is successful. This was assigned as part 1 of an Odin bootcamp\n"
			print "project. Check back for an AI version in the future\n\n"
			
			game.computer_guessing
		else 
			print "Human guessing selected.\n"
			game.human_guessing
		end
	end


end


starter=Intro.new
starter.game_select

