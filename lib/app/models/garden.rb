require "tty-prompt"
class Garden < ActiveRecord::Base
    has_many :gardenplants
    has_many :plants, through: :gardenplants
    @@prompt = TTY::Prompt.new


    def self.signup
        username = @@prompt.ask("What is your username?")
        password = @@prompt.mask("What is your password?")
        garden_name = @@prompt.ask("What would you like to name your garden?")
        user = self.create(username: username, password: password, garden_name: garden_name)
        return true
    end

    def self.login
        found = false
        until found == true
            username = @@prompt.ask("What is your username?")
            password = @@prompt.mask("What is your password?")
            if self.find_by(username: username, password: password)
                return true
            else 
                puts "User not found, please try again."
            end
        end
    end

# gardens

# username        password        garden_name

# melissa         123             gardeny

    def see_my_plants
        self.plants 
    end

    def plant_count
        self.plants.count
    end

    def view
        self.gardenplants
    end

end

