require 'sinatra'
require 'sinatra/reloader'

set :secret_number, rand(101)
set :guesses, 8

get '/' do
	guess = params['guess']
	if settings.guesses == 0
		settings.guesses = 8
		settings.secret_number = rand(101)
		message = "You have run out of guesses, please try again"
	else
		settings.guesses -= 1
		message = check_number(guess)
	end
	erb :index, :locals => {:number => settings.secret_number, :message => message, :guess => guess}
end

def check_number(guess)
	if guess.nil?
		return message = "Guess the number (0-100)"
	end
	diff = settings.secret_number - guess.to_i
	if diff < 0
		message = "Your guess of #{guess} is too high"
	elsif diff > 0
		message = "Your guess of #{guess} is too low"
	else
		settings.secret_number = rand(101)
		settings.guesses = 8
		message = "You have guessed correctly, the secret number was #{guess}"
	end
		
end