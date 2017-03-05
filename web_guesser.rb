require 'sinatra'
require 'sinatra/reloader'


class WebGuesser
  attr_reader :number, :response

  def initialize
    @number = rand(100)
  end

  RESPONSE = {
    too_high: "too high",
    way_too_high: "way too high",
    too_low: "too low",
    way_too_low: "way too low",
    correct: "You got it right! The number is #{@number}",
    waiting: "Please enter a guess"
  }

  BGCOLORS = {
  way_too_high: "#d10000",
  too_high: "#f7d4d4",
  way_too_low: "#d10000",
  too_low: "#f7d4d4",
  correct: "#015b0f",
  }


  def build_response(guess)
    return RESPONSE[:way_too_high] if (guess - number ) > 5
    return RESPONSE[:too_high] if guess > number
    return RESPONSE[:way_too_low] if (guess - number ) < -5
    return RESPONSE[:too_low] if guess < number
    return RESPONSE[:correct] if guess == number
  end

  def background_color(guess)
    return BGCOLORS[:way_too_high] if (guess - number ) > 5
    return BGCOLORS[:too_high] if guess > number
    return BGCOLORS[:way_too_low] if (guess - number ) < -5
    return BGCOLORS[:too_low] if guess < number
    return BGCOLORS[:correct] if guess == number
  end
end

  # def activate_cheat(cheat)
  #    if cheat == "true"
  #     return "cheat code is active: the correct answer is #{@number}"
  #   end
  # end

web_guesser = WebGuesser.new

get '/' do
  guess = params['guess'].to_i
  # cheat_code = params['cheat_code']
  erb :index, :locals => {
        :message => web_guesser.build_response(guess),
        :background => web_guesser.background_color(guess),
        # :cheat_code => web_guesser.activate_cheat(cheat_code)
      }
end
