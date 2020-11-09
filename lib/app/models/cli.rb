require "tty-prompt"
require "pry"

class CLI
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



    def menu
        prompt = TTY::Prompt.new
        system("clear")
        option = prompt.select("What would you like to do today?") do |menu|
            menu.choice 'View my garden'
            menu.choice 'Harvest my garden'
            menu.choice 'Rename my garden'
        end

        if option == 'View my garden'
            self.view 
        elsif option == 'Harvest my garden'
            #some code here
        elsif option == 'Rename my garden'
            #some code here
        end



    end



end

