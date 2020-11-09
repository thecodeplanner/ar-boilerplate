require "tty-prompt"
class Garden < ActiveRecord::Base
    has_many :gardenplants
    has_many :plants, through: :gardenplants
    @@prompt = TTY::Prompt.new


    def self.signup
        username = @@prompt.ask("What is your username?")
        password = @@prompt.mask("What is your password?")
        garden_name = @@prompt.ask("What would you like to name your garden?")
        self.create(username: username, password: password, garden_name: garden_name)
    end

    def self.login
        username = @@prompt.ask("What is your username?")
        password = @@prompt.mask("What is your password?")
        self.find_by(username: username, password: password)
    end

    def see_my_plants
        self.plants 
    end

    def plant_count
        self.plants.count
    end

end

