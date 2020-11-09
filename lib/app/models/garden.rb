class Garden < ActiveRecord::Base
    has_many :gardenplants
    has_many :plants, through: :gardenplants

    def see_my_plants
        self.plants 
    end

    def plant_count
        self.plants.count
    end

end
