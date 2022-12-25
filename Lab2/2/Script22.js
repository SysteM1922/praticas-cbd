// NMEC: 103600

// 1. Liste todos os documentos da coleção.
db.restaurants.find()
// 3772

// 2. Apresente os campos restaurant_id, nome, localidade e gastronomia para todos os documentos da coleção
db.restaurants.find({}, {"restaurant_id":1, "nome":1, "localidade":1, "gastronomia":1})

// 3. Apresente os campos restaurant_id, nome, localidade e código postal (zipcode), mas exclua o campo _id de todos os documentos da coleção.
db.restaurants.find({}, {_id:0, restaurant_id: 1, nome: 1, localidade: 1, zip:1})

// 4. Indique o total de restaurantes localizados no Bronx.
db.restaurants.find({localidade: "Bronx"}).count()

// 5. Apresente os primeiros 15 restaurantes localizados no Bronx, ordenados por ordem crescente de nome.
db.restaurants.find({localidade: "Bronx"}).sort({"nome":1}).limit(15)

// 6. Liste todos os restaurantes que tenham pelo menos um score superior a 85.
db.restaurants.find({"grades.score": {$gt : 85}})

// 7. Encontre os restaurantes que obtiveram uma ou mais pontuações (score) entre [80 e 100].
db.restaurants.find({"grades":{ $elemMatch: {"score" : {$gte:80, $lte:100}}}})

// 8. Indique os restaurantes com latitude inferior a -95,7.
db.restaurants.find({"address.coord.1": {$lt:-95.27}})

// 9. Indique os restaurantes que não têm gastronomia "American", tiveram uma (ou mais) pontuação superior a 70 e estão numa latitude inferior a -65.
db.restaurants.find({$and:[{"gastronomia":{$ne:"American"}}, {"grades.score":{$gt:70}}, {"address.coord.1":{$lt:-65}}]})

// 10. Liste o restaurant_id, o nome, a localidade e gastronomia dos restaurantes cujo nome começam por "Wil".
db.restaurants.find({"nome":{$regex: "Will*"}},{"restaurant_id":1, "nome":1, "gastronomia":1})

// 11. Liste o nome, a localidade e a gastronomia dos restaurantes que pertencem ao Bronx e cuja gastronomia é do tipo "American" ou "Chinese".
db.restaurants.find({$and:[{"localidade":"Bronx"}, {$or:[{"gastronomia":"American"}, {"gastronomia":"Chinese"}]}]}, {"nome":1, "localidade":1, "gastronomia":1})

// 12. Liste o restaurant_id, o nome, a localidade e a gastronomia dos restaurantes localizados em "Staten Island", "Queens", ou "Brooklyn".
db.restaurants.find({$or:[{"localidade":"Staten Island"}, {"localidade":"Queens"},{"localidade":"Brooklyn"}]},{"restaurant_id":1, "nome":1, "localidade":1, "gastronomia":1})

// 13. Liste o nome, a localidade, o score e gastronomia dos restaurantes que alcançaram sempre pontuações inferiores ou igual a 3.
db.restaurants.find({"grades.score":{$not:{$gt:3}}},{"nome":1, "localidade":1, "grades.score":1, "gastronomia":1})

// 14. Liste o nome e as avaliações dos restaurantes que obtiveram uma avaliação com um grade "A", um score 10 na data "2014-08-11T00:00:00Z" (ISODATE).
db.restaurants.find({$and:[{"grades.grade":"A"}, {"grades.score":10}, {"grades.date":ISODate("2014-08-11T00:00:00Z")}]},{"nome":1, "grades":1})

// 15. Liste o restaurant_id, o nome e os score dos restaurantes nos quais a segunda avaliação foi grade "A" e ocorreu em ISODATE "2014-08-11T00:00:00Z"
db.restaurants.find({"grades.1.grade":"A", "grades.1.date":ISODate("2014-08-11T00:00:00Z")},{"restaurant_id":1, "nome":1, "grades.score":1})

// 16. Liste o restaurant_id, o nome, o endereço (address) e as coordenadas geográficas (coord) dos restaurantes onde o 2º elemento da matriz de coordenadas tem um valor superior a 42 e inferior ou igual a 52.
db.restaurants.find({"address.coord.1": {$gt: 42, $lte: 52}},{"restaurant_id":1, "address.rua":1, "address.coord":1})

// 17. Liste nome, gastronomia e localidade de todos os restaurantes ordenando por ordem crescente da gastronomia e, em segundo, por ordem decrescente de localidade.
db.restaurants.find({}, {"nome":1, "gastronomia":1, "localidade":1}).sort({"gastronomia":1, "localidade":-1})

// 18. Liste nome, localidade, grade e gastronomia de todos os restaurantes localizados em Brooklyn que não incluem gastronomia "American" e obtiveram uma classificação (grade) "A". Deve apresentá-los por ordem decrescente de gastronomia.
db.restaurants.find({$and:[{"localidade": "Brooklyn"}, {"gastronomia":{$ne:"American"}}, {"grades.grade": "A" }]}, {"nome":1, "localidade":1, "grades":1, "gastronomia":1}).sort({"gastronomia":-1})

// 19. Conte o total de restaurante existentes em cada localidade.
db.restaurants.aggregate([{$group:{_id: "$localidade", count: {$sum:1}}}])

// 20. Liste todos os restaurantes cuja média dos score é superior a 30.
db.restaurants.aggregate([{$project: {_id: "$restaurant_id", avg: {$avg:"$grades.score"}}}, {$match:{avg:{$gt:30}}}])

// 21. Indique os restaurantes que têm gastronomia "Portuguese", o somatório de score é superior a 50 e estão numa latitude inferior a -60.
db.restaurants.aggregate([{$project: {_id: "$restaurant_id", nome: "$nome", sum: {$sum:"$grades.score"}, lat: "$address.coord.1", gastronomia: "$gastronomia"}}, {$match:{$and:[{sum:{$gt:50}}, {gastronomia: "Portuguese"}, {lat:{$lt: -60}}]}}])

// 22. Apresente o nome e o score dos 3 restaurantes com score médio mais elevado.
db.restaurants.aggregate([{$project: {_id:"$nome", score:{$avg:"$grades.score"}}}, {$sort:{score:-1}}, {$limit:3}])

// 23. Apresente o número de gastronomias diferentes na rua "Fifth Avenue"
db.restaurants.distinct("gastronomia", {"address.rua":"Fifth Avenue"}).length

// 24. Conte quantos restaurantes existem por rua e ordene por ordem decrescente
db.restaurants.aggregate([{$group:{_id:"$address.rua", restaurantes: {$sum:1}}}, {$sort:{restaurantes:-1}}])

// 25 .. 30. Descreva 5 perguntas adicionais à base dados (alíneas 26 a 30), significativamente distintas das anteriores, e apresente igualmente a solução de pesquisa para cada questão.


// 26. Liste os restaurantes que estejam em localidades com zipcode entre 10100 e 11000, inclusive
db.restaurants.find({"address.zipcode":{$gte:"10100", $lte:"11000"}},{_id:0,"restaurant_id":1, "address":1})

// 27. Apresente o restaurante com a nota média mais alta em cada localidade
db.restaurants.aggregate([{$project: {_id: "$restaurant_id", nome: "$nome", localidade: "$localidade", avg_score: {$avg:"$grades.score"}}}, {$sort:{score:-1}}, {$group:{_id:"$localidade", restaurantes: {$first:"$$ROOT"}}}, {$project:{_id:0, restaurantes:1}}])

// 28. Apresente a localidade com mais restaurantes
db.restaurants.aggregate([{$group:{_id:"$localidade", restaurantes : {$sum:1}}}, {$sort:{restaurantes:-1}}, {$limit:1}])

// 29. Apresenta o nome, a gastronomia e os scores do melhor restaurante em Queens.
db.restaurants.aggregate([{$match:{"localidade":"Queens"}}, {$project: {_id: "$restaurant_id", nome: "$nome", gastronomia: "$gastronomia", score: {$avg:"$grades.score"}}}, {$sort:{score:-1}}, {$limit:1}])

// 30. Encontre os restaurantes que obtiveram todas as pontuações (score) fora do intervalo [80 e 100].
db.restaurants.find({"grades.score":{$not:{$gte:80,$lte:100}}})
