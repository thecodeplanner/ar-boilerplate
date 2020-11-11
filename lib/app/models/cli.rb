require "tty-prompt"
require "pry"
# require_relative '../config/environment'
# require_all 'lib'

class CLI
    @@user = nil
    #@@gardenplant = [] 
    @@prompt = TTY::Prompt.new

    def greet
        system("clear")
        welcome = @@prompt.select("Welcome to Zen Garden!") do |menu|
            menu.choice 'Sign Up'
            menu.choice 'Login'
            menu.choice 'Quit'
        end

        if welcome == 'Login'

            if @@user = Garden.login
                self.menu
            else
                self.greet
             end

        elsif welcome == 'Sign Up'
            @@user = Garden.signup
            self.menu
        elsif welcome == 'Quit'
            puts "See you later!"
        end       
    end

    def menu
        system("clear")
        option = @@prompt.select("What would you like to do today?") do |menu|
            menu.choice 'Plant in my garden'
            menu.choice 'View my garden'
            menu.choice 'Switch User'
            menu.choice 'Quit'
        end

        if option == 'Plant in my garden'
            self.plant_in_my_garden
        elsif option == 'View my garden'
            self.view_my_garden  
        elsif option == 'Switch User'
            self.greet
        elsif option == 'Quit'
            puts "Bye!"
        end
    end

    def plant_in_my_garden
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
            self.menu_2
        elsif plant_selection == 'Cactus'
            plant = Plant.all.find_by(name: "cactus")
            @@user.plant_plant_in_garden(plant)
            puts "Great job! Be careful of their spikes!"
            self.menu_2
        elsif plant_selection == 'Flower'
            plant = Plant.all.find_by(name: "flower")
            @@user.plant_plant_in_garden(plant)
            puts "It's always a good idea to wake up and smell the flowers!"
            self.menu_2
        end

    end

    def view_my_garden
        system("clear")
        puts "Welcome to #{@@user.garden_name}!"
        if @@user.plants.empty?
            puts "Sorry you do not have any plants yet." 
            self.menu_2
        else
        puts ""
        puts "Here are all of your plants:" 
        x = 1
        gp = Gardenplant.all.select{|gp|gp.garden==@@user}
       # @@user.plants.map{|plant|plant.name}

        gp.each do |gp|    
            puts "#{x}. #{gp.plant.name}"
            x += 1
            end
            self.menu_2
        end
    end

    def water_my_plants
        system("clear")
        if @@user.plants.empty?
            puts "Sorry you do not have any plants yet." 
            self.menu_2
        else
            gp_array = Gardenplant.all.select{|gp|gp.garden == @@user}
        
            option = @@prompt.select("Which plant would you like to water?") do |menu|
                x = 0
                gp_array.each do |gp|
                    x+=1
                    menu.choice "#{x}. #{gp.plant.name}"
                end 
            end
            index = option.gsub(/[^\d]/,"").to_i
            index -= 1
            gp_to_water = gp_array[index]
            if gp_to_water.status == "grown"
                gp_to_water.water_plant 
                print "Awesome, your plant is fully grown! Make sure not to overwater it now."
                self.menu_2
            elsif gp_to_water.status == "dead" || gp_to_water.status == "overwatered"
                print "Oh no, you've overwatered your plant! Your plant is now" 
                gp_to_water.water_plant
                puts " #{gp_to_water.status}."
                self.menu_2 
            else
            print "Yay! You have helped your plant go from: #{gp_to_water.status} "
            gp_to_water.water_plant
            puts "to: #{gp_to_water.status}."
            self.menu_2
            end
        end
    end
    

    def menu_2
        puts ""            
        option2 = @@prompt.select("\nWhat would you like to do next?") do |menu|
            menu.choice 'Plant in my garden'
            menu.choice 'Water My Plants'
            menu.choice 'View my garden'
            menu.choice "Check My Plants' Status' "
            menu.choice 'Harvest my garden'
            menu.choice 'Rename my garden'
            menu.choice 'Return to Main Menu'
        end
        if option2 == 'Water My Plants'
            self.water_my_plants 
        elsif option2 == "Check My Plants' Status' "
           self.check_my_plants_status
        elsif option2 == 'View my garden'
            self.view_my_garden
        elsif option2 == 'Plant in my garden'
            self.plant_in_my_garden
        elsif option2 == 'Harvest my garden'
            system("clear")
            option3 = @@prompt.select(puts "Are you sure you wish to delete your garden?") do |menu|
                menu.choice "Yes"
                menu.choice "No"
            end
            if option3 == "Yes"
                system("clear")
                #Gardenplant.all.select{|gp|gp.garden==@@user}
                @@user.plants.delete_all
                @@user.save
                puts "Sorry to see your garden go!"
                self.menu_2
            elsif option3 == "No"
                self.menu_2
            end

        elsif option2 == 'Rename my garden'
            system("clear")
            puts "What would you like to rename your garden to?"
            @@user.garden_name = gets.chomp
            @@user.save
            self.menu_2    
        elsif option2 == 'Return to Main Menu'
            self.menu
        end
    end

    def check_my_plants_status
        system("clear")
        if @@user.plants.empty?
            puts "Sorry you do not have any plants yet." 
            self.menu_2
        else
            system("clear")
            puts "Your Plants' Status'"
            gp = Gardenplant.all.select{|gp|gp.garden==@@user}
            x = 0
            gp.each do |gp|
                x += 1
                puts "#{x}. #{gp.plant.name}: #{gp.status}"
            end
            self.menu_2
        end
    end

end


