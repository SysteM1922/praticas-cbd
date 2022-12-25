package com.example;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import com.mongodb.client.model.Indexes;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.util.*;

public class Mongo {
	public static void main(String[] args) {
		MongoClient mongoClient = new MongoClient("localhost", 27017);
		MongoDatabase Lab2 = mongoClient.getDatabase("Lab2");
		MongoCollection<org.bson.Document> restaurants = Lab2.getCollection("restaurants");

		System.out.println("\n======= ALINEA A) =======\n");

		Document doc = new Document("_id", new ObjectId())
					.append("address", new Document().append("building", "985").append("coord", Arrays.asList(-73.9557413, 40.7720266))
							.append("rua", "2 Avenue").append("zipcode", "10075"))
					.append("localidade", "Aveiro")
					.append("gastronomia", "Portuguesa")
					.append("grades", Arrays.asList(new Document().append("date", "2022-11-08T00:00:00Z").append("grade", "A")
							.append("score", 11), new Document().append("date", "2022-11-08T00:00:00Z").append("grade", "B")
									.append("score", 17)))
					.append("nome", "Canal Madeirense")
					.append("restaurant_id", "41704620");
		inserir(restaurants, doc);
		editar(restaurants, "nome", "Canal Madeirense", "Canal Madeirense - Aveiro");
		pesquisar(restaurants, new Document("localidade", "Aveiro"));

		System.out.println("\n======= ALINEA B) =======\n");

		double start = System.nanoTime();
		pesquisar(restaurants, new Document("localidade", "Aveiro"));
		double end = System.nanoTime();
		System.out.println("Tempo de pesquisa para localidade sem índice:\n " + (end - start) + "ns");

		criarIndice(restaurants, "localidade");

		start = System.nanoTime();
		pesquisar(restaurants, new Document("localidade", "Aveiro"));
		end = System.nanoTime();
		System.out.println("Tempo de pesquisa para localidade com índice:\n " + (end - start) + "ns");

		start = System.nanoTime();
		pesquisar(restaurants, new Document("gastronomia", "Portuguesa"));
		end = System.nanoTime();
		System.out.println("Tempo de pesquisa para gastronomia sem índice:\n " + (end - start) + "ns");

		criarIndice(restaurants, "gastronomia");

		start = System.nanoTime();
		pesquisar(restaurants, new Document("gastronomia", "Portuguesa"));
		end = System.nanoTime();
		System.out.println("Tempo de pesquisa para gastronomia com índice:\n " + (end - start) + "ns");

		start = System.nanoTime();
		pesquisar(restaurants, new Document("nome", "Canal Madeirense - Aveiro"));
		end = System.nanoTime();
		System.out.println("Tempo de pesquisa para nome sem índice:\n " + (end - start) + "ns");

		criarIndiceText(restaurants, "nome");

		start = System.nanoTime();
		pesquisar(restaurants, new Document("nome", "Canal Madeirense - Aveiro"));
		end = System.nanoTime();
		System.out.println("Tempo de pesquisa para nome com índice:\n " + (end - start) + "ns");

		System.out.println("\n======= ALINEA C) =======\n");

		System.out.println("\n1. Liste todos os documentos da coleção.");
		pesquisar(restaurants, new Document());

		System.out.println("\n10. Liste o restaurant_id, o nome, a localidade e gastronomia dos restaurantes cujo nome começam por \"Wil\".");
		pesquisar(restaurants, new Document("nome", new Document("$regex", "^Wil")));

		System.out.println("\n15. 13. Liste o nome, a localidade, o score e gastronomia dos restaurantes que alcançaram sempre pontuações inferiores ou igual a 3.");
		pesquisar(restaurants, new Document("grades.score", new Document("$lte", 3)));

		System.out.println("\n26. Liste os restaurantes que estejam em localidades com zipcode entre 10100 e 11000, inclusive");
		pesquisar(restaurants, new Document("address.zipcode", new Document("$gte", "10100").append("$lte", "11000")));

		System.out.print("\n30. Encontre os restaurantes que obtiveram todas as pontuações (score) fora do intervalo [80 e 100].");
		pesquisar(restaurants, new Document("grades.score", new Document("$not", new Document("$gt", 80).append("$lt", 100))));

		System.out.println("\n======= ALINEA D) =======\n");

		System.out.println("Numero de localidades distintas: " + countLocalidades(restaurants));

		System.out.println("\nNumero de restaurantes por localidade:");
		for (Map.Entry<String, Integer> entry : countRestByLocalidade(restaurants).entrySet()) {
			System.out.println("-> " + entry.getKey() + " - " + entry.getValue());
		}

		System.out.println("\nNome de restaurantes contendo 'Park' no nome:");
		for (String nome : getRestWithNameCloserTo(restaurants, "Park")) {
			System.out.println("-> " + nome);
		}

		mongoClient.close();
	}

	public static void inserir(MongoCollection col, Document doc){
		col.insertOne(doc);
	}

	public static void editar(MongoCollection col, String param, String aValor, String nValor) {
		col.updateOne(new Document(param, aValor), new Document("$set", new Document(param, nValor)));
	}

	public static void pesquisar(MongoCollection col, Document doc) {
		for (Object document : col.find(doc))
			System.out.println(document);
	}

	public static void criarIndice(MongoCollection col, String param) {
		try{
			col.createIndex(Indexes.ascending(param));
		}catch (Exception e){
			System.out.println("Erro ao criar o índice!");
		}
	}

	public static void criarIndiceText(MongoCollection col, String param) {
		try{
			col.createIndex(Indexes.text(param));
		}catch (Exception e){
			System.out.println("Erro ao criar o índice!");
		}
	}

	public static int countLocalidades(MongoCollection col) {
		return col.distinct("localidade", String.class).into(new ArrayList<>()).size();
	}

	public static Map<String, Integer> countRestByLocalidade(MongoCollection col) {
		Map<String, Integer> map = new HashMap<>();
		for (Object document : col.find()) {
			Document doc = (Document) document;
			String localidade = doc.getString("localidade");
			if (map.containsKey(localidade)) {
				map.put(localidade, map.get(localidade) + 1);
			} else {
				map.put(localidade, 1);
			}
		}
		return map;
	}

	public static List<String> getRestWithNameCloserTo(MongoCollection col, String name) {
		List<String> list = new ArrayList<>();
		for (Object document : col.find(new Document("nome", new Document("$regex", name)))) {
			Document doc = (Document) document;
			list.add(doc.getString("nome"));
		}
		return list;
	}

}
