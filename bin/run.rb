require_relative '../config/environment'

cli = CLI.new
cli.load_plants
cli.greet
cli.menu


#puts Plant.all
# if cli.greet 
#     cli.menu
# end




# puts "The CLI goes here!"