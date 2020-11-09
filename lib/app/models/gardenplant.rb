class Gardenplant < ActiveRecord::Base
    belongs_to :garden 
    belongs_to :plant

    def water_plant
        if self.status == nil
            self.status = "seedling"
        elsif self.status == "seedling"
            self.status = "sprouting"
        elsif self.status == "sprouting"
            self.status = "grown"
        elsif self.status == "grown"
            self.status = "grown"
            # maybe we want to add an over watered condition later??
        end
        self.save
    end

    # def status_of_plant
    #     self.status
    # end
end



