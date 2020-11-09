class Plant < ActiveRecord::Base
    has_many :gardenplants 
    has_many :gardens, through: :gardenplants 
end