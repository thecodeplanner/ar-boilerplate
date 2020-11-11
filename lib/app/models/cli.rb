require "tty-prompt"
require "pry"
require 'pastel'

class CLI
    @@user = nil
    @@prompt = TTY::Prompt.new
    @@artii = Artii::Base.new :font => 'slant'
    
    # @@artii = Artii::Base.new 
    # a = Artii::Base.new 
    #     puts a.asciify('HackJack!').red.bold

    def welcome 
        system('clear')
        puts @@artii.asciify("Let's Play Zen Garden!")
        #sleep(1.0)
        self.greet
    end

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
        plants = Plant.all
        x = 1
        plant_selection = @@prompt.select("What would you like to plant today? We have tons of plants to choose from!") do |menu|
            plants.all.each do |plant|
            menu.choice "#{x}.#{plant.name}"
            x +=1
            end
        end
        #binding.pry

        plant_selection.tr!("0-9", "")
        plant_selection.tr!(".", "")
        #plant_selection.tr!(" ", "")
        ups = plant_selection.to_s
        #binding.pry
        plant = Plant.all.find_by(name: ups)
        @@user.plant_plant_in_garden(plant)
        self.menu_2
    end

    def view_my_garden
        system("clear")
        puts "Welcome to #{@@user.garden_name}!"
        if @@user.plants.empty?
            puts "Sorry you do not have any plants yet." 
            self.menu_2
        else
        puts ""
        puts "Wow, look at that garden! Here are all of your plants:"
        puts " " 
        x = 1
        gp = @@user.gardenplants.all ## whyy???
        gp.each do |gp|
            if x % 24 != 0
                #print " #{x}. #{gp.plant.name} "
                print " #{gp.plant.name} "
            else 
                #puts "#{x}. #{gp.plant.name}"
                puts " #{gp.plant.name}"
            end
            
            #puts "#{x}. #{gp.plant.name}"
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
            gp_array = @@user.gardenplants.all
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
            menu.choice 'Plant all plants'
            menu.choice 'Water All Plants'
            menu.choice 'Water My Plants'
            menu.choice 'View my garden'
            menu.choice "Check My Plants' Status' "
            menu.choice 'Harvest my garden'
            menu.choice 'Rename my garden'
            menu.choice 'Return to Main Menu'
            
        end
        if option2 == 'Water My Plants'
            self.water_my_plants 
        elsif option2 == 'Water All Plants'
            self.water_all_plants
        elsif option2 == "Check My Plants' Status' "
           self.check_my_plants_status
        elsif option2 == 'View my garden'
            self.view_my_garden
        elsif option2 == 'Plant in my garden'
            self.plant_in_my_garden
        elsif option2 == 'Plant all plants'
            self.plant_all_plants
        elsif option2 == 'Harvest my garden'
            system("clear")
            option3 = @@prompt.select(puts "Are you sure you wish to clear your garden?") do |menu|
                menu.choice "Yes"
                menu.choice "No"
            end
            if option3 == "Yes"
                system("clear")
                #Gardenplant.all.select{|gp|gp.garden==@@user}
                # @@user.plants.delete_all
                # @@user.save
                @@user.gardenplants.all.destroy_all
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
            # gp = Gardenplant.all.select{|gp|gp.garden==@@user}
            # gp.each do |gp|
            x = 0
            @@user.gardenplants.all.each do |gp|
                x += 1
                puts "#{x}. #{gp.plant.name}: #{gp.status}"
            end
            self.menu_2
        end
    end

    def plant_all_plants
        Plant.all.each do |p| 
        @@user.plant_plant_in_garden(p)
        end
        self.menu_2
    end

    def water_all_plants
        system("clear")
        if @@user.plants.empty?
            puts "Sorry you do not have any plants yet." 
            self.menu_2
        else
            @@user.gardenplants.all.each do |gp|
                gp.water_plant
            end
        end
        self.menu_2
    end


end


