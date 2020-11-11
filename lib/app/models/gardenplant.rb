class Gardenplant < ActiveRecord::Base
    belongs_to :garden 
    belongs_to :plant

    def water_plant
        if self.status == "seedling"
            self.status = "sprouting"
        elsif self.status == "sprouting"
            self.status = "grown"
        elsif self.status == "grown"
            self.status = "overwatered"
        elsif self.status == "overwatered"
            self.status = "dead"
        end
        self.save
    end

    # def status_of_plant
    #     self.status
    # end
end



