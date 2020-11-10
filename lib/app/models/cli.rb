require "tty-prompt"
require "pry"
# require_relative '../config/environment'
# require_all 'lib'

class CLI
    @@user = nil
    @@plants = []
    @@gardenplant = [] 
    def load_plants
        @@plants = Plant.all.map{|plant|plant}
    end



    # def create_plants
    #     fern = Plant.create(name: "fern")
    #     cactus = Plant.create(name: "Cactus")
    #     flower = Plant.create(name: "Flower")
    #     @@plants = [fern, cactus, flower]
    # end

    
    def greet
        prompt = TTY::Prompt.new
        system("clear")
        welcome = prompt.select("Welcome to Zen Garden!") do |menu|
            menu.choice 'Sign Up'
            menu.choice 'Login'
            menu.choice 'Quit'
        end

        if welcome == 'Login'

            if @@user = Garden.login
                true
            else
                self.greet
             end

        elsif welcome == 'Sign Up'

            @@user = Garden.signup
        elsif welcome == 'Quit'
            puts "See you later!"
            ##need to exit out of program 
        end 
    end

    def menu
        prompt = TTY::Prompt.new
        system("clear")
        option = prompt.select("What would you like to do today?") do |menu|
            menu.choice 'Plant new plants in my garden'
            menu.choice 'View my garden'
            menu.choice 'Harvest my garden'
            menu.choice 'Rename my garden'
        end

        if option == 'Plant new plants in my garden'
            menu_2
        elsif option == 'View my garden' 
            puts "#{@@user.plants.map{|plant|plant.name}}"
            
        elsif option == 'Harvest my garden'
            @@user.plants.destroy_all
            @@user.save
        elsif option == 'Rename my garden'
            system("clear")
            puts "What would you like to rename your garden to?"
            @@user.garden_name = gets.chomp
            @@user.save    
        end
    end

    def menu_2
        prompt = TTY::Prompt.new
        system("clear")
        plant_selection = prompt.select("What would you like to plant today?") do |menu|
            menu.choice 'Fern'
            menu.choice 'Cactus'
            menu.choice 'Flower'
        end

        if plant_selection == 'Fern'
            plant = Plant.all.find_by(name: "fern")
            @@user.plant_plant_in_garden(plant)
        elsif plant_selection == 'Cactus'
            plant = Plant.all.find_by(name: "cactus")
            @@user.plant_plant_in_garden(plant)
        elsif plant_selection == 'Flower'
            plant = Plant.all.find_by(name: "flower")
            @@user.plant_plant_in_garden(plant)
            ##create a back option
        end
    end

    
    # def add_favorite_snack(recipe)
    #     FavoriteSnack.create(snacker_id: self.id, recipe_id: recipe.id, name: recipe.name)
    # end



end

