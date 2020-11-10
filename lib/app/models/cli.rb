require "tty-prompt"
require "pry"
# require_relative '../config/environment'
# require_all 'lib'

class CLI
    @@user = nil
    @@plants = []
    @@gardenplant = [] 
    @@prompt = TTY::Prompt.new


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
        system("clear")
        welcome = @@prompt.select("Welcome to Zen Garden!") do |menu|
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
        system("clear")
        option = @@prompt.select("What would you like to do today?") do |menu|
            menu.choice 'Plant new plants in my garden'
            menu.choice 'View my garden'
            menu.choice 'Harvest my garden'
            menu.choice 'Rename my garden'
        end

        if option == 'Plant new plants in my garden'
            self.menu_2
        elsif option == 'View my garden'
            self.view_my_garden
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
        system("clear")
        plant_selection = @@prompt.select("What would you like to plant today?") do |menu|
            menu.choice 'Fern'
            menu.choice 'Cactus'
            menu.choice 'Flower'
        end

        if plant_selection == 'Fern'
            plant = Plant.all.find_by(name: "fern")
            @@user.plant_plant_in_garden(plant)
            puts "Nice choice! Ferns are known for their calming properties." 
            
        elsif plant_selection == 'Cactus'
            plant = Plant.all.find_by(name: "cactus")
            @@user.plant_plant_in_garden(plant)
            puts "Great job! Be careful of their spikes!"

        elsif plant_selection == 'Flower'
            plant = Plant.all.find_by(name: "flower")
            @@user.plant_plant_in_garden(plant)
            puts "It's always a good idea to wake up and smell the flowers!"
            
        end
    end

    # def menu_3
    #     selection = @@prompt.select("What would you like to do next") do |menu|
    #         menu.choice 'View My Garden'
    #         menu.choice 'Plant Another Plant'
    #         menu.choice 'Main menu'
    #         menu.choice 'Quit'
    #     end

    # end

    def view_my_garden
        system("clear") 
        puts "Here are all of your plants:"  
        x = 1
        plants = @@user.plants.map{|plant|plant.name}
        plants.each do |plant|    
            puts "#{x}. #{plant}"
            x += 1
        end
                    
        option2 = @@prompt.select("Your garden is looking fabulous! What would you like to do next?") do |menu|
            menu.choice 'Water My Plants'
            menu.choice "Check My Plants' Status' "
            menu.choice 'Plant More plants'
            menu.choice 'Return to Main Menu'
            menu.choice 'Quit'
        end


        if option2 == 'Water My Plants'
            self.water_my_plants 
        elsif option2 == "Check My Plants' Status' "
            ## need code 
        elsif option2 == 'Plant More plants'
            self.menu_2
        elsif option2 == 'Return to Main Menu'
            self.menu
        elsif option2 == 'Quit'
            puts "Bye!"
        end
    end

    def water_my_plants
        system("clear")
        plants = @@user.plants.map{|plant|plant.name}
        
      
        
        option2 = @@prompt.select("Which plant would you like to water?") do |menu|
            x = 0
            plants.each do |plant| 
                x += 1
                menu.choice "#{x}. #{plant}"
            end

        end

    end



end


