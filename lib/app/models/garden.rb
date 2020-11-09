class Garden < ActiveRecord::Base
    has_many :gardenplants
    has_many :plants, through: :gardenplants
end
