Garden.destroy_all
Plant.destroy_all
Gardenplant.destroy_all


simon = Garden.create(username: "simon", password: "123")
melissa = Garden.create(username: "melissa", password: "123")

fern = Plant.create(name: "fern")
cactus = Plant.create(name: "cactus")

gp1 = Gardenplant.create(garden: simon, plant: fern)
gp2 = Gardenplant.create(garden: melissa, plant: cactus)

