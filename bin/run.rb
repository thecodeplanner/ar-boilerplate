require_relative '../config/environment'

def greet
    prompt = TTY::Prompt.new
    system("clear")
    welcome = prompt.select("Welcome to Zen Garden!") do |menu|
        menu.choice 'Sign Up'
        menu.choice 'Login'
        menu.choice 'Quit'
    end

    if welcome == 'Login'
        Garden.login
    elsif welcome == 'Sign Up'
        Garden.signup
    elsif welcome == 'Quit'
        puts "Goodbye!"
    end 

end

greet 


# puts "The CLI goes here!"