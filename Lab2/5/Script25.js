// Alinea c)
// 1. Liste quantos registos existem no dataset
db.weather.find().count()

// 2. Liste o registo mais recente presente
db.weather.find().sort({"ts":1}).limit(1)

// 3. Liste as coordenadas e os dados sobre o vento dos registos com ventos entre o ângulo [310, 360]
db.weather.find({ "wind.direction.angle": { $gt: 310, $lt: 360 } }, {"position.coordinates":1, "wind":1})

//4. Liste os registos não são do tipo "FM-13"
db.weather.find({"type":{$ne:"FM-13"}})

// 5. Liste as secções e o id dos registos tirados nas secções "AA1" e "AG1" em simultâneo
db.weather.find({$and:[{"sections":"AA1"}, {"sections":"AG1"}]}, {"sections":1})

// 6. Liste as secções e o id dos registos tirados nas secções "AG1", "AY1" e "MW1"
db.weather.find({$or:[{"sections":"AG1"},{"sections":"AY1"},{"sections":"MW1"}]},{"sections":1})

// Alinea d)
// 1. Conte quantos registos há por tipo de vento
db.weather.aggregate([{$group:{_id:"$wind.type", count: {$sum:1}}}])

// 2. Apresente os dados de visibilidade ordenados por qualidade de distância dos registos feitos à altitude de 9999
db.weather.aggregate([{$match:{"elevation":9999}}, {$project:{visibility:"$visibility", distance_quality:"$visibility.distance.quality"}}, {$sort:{distance_quality:1}}])

// 3. Apresente os dados dos 6 registos mais antigo divididos por secção
db.weather.aggregate([{$unwind:"$sections"}, {$sort:{"ts":1}}, {$limit:6}])

// 4. Apresente o registo com mais secções
db.weather.aggregate([{$unwind:"$sections"}, {$group:{_id:"$_id", count:{$sum:1}}}, {$sort:{count:-1}}, {$limit:1}])

// 5. Liste todos os registos com valores de ângulo de vento superiores a 350
db.weather.aggregate([{$match:{"wind.direction.angle":{$gt:350}}}, {$project:{_id:1, "wind.direction.angle":1}}])

// 6. Conte quantos registos há por secção
db.weather.aggregate([{$unwind:"$sections"}, {$group:{_id:"$sections", count:{$sum:1}}}, {$sort:{count:-1}}])
