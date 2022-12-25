package org.example;

import org.neo4j.driver.AuthTokens;
import org.neo4j.driver.Driver;
import org.neo4j.driver.GraphDatabase;
import org.neo4j.driver.Session;

import java.io.*;
import java.nio.file.Files;
import java.util.Scanner;

public class Formula1Driver {
    public static void main(String[] args) throws  Exception {

        String address = "bolt://localhost:7687";
        String user = "neo4j";
        String password = "lab44";
        Driver driver = GraphDatabase.driver(address, AuthTokens.basic(user, password));
        Session session = driver.session();
        PrintWriter pw = new PrintWriter(new File("CBD_L44c_output.txt"));
        pw.println("// O dataset utilizado tem apenas 92 nós e 562 relações. Não encontrei datasets que cumprissem\n" +
                "// com o requisito de ter mais de 500 nós pois os datasets que encontrei que satisfaziam essa condição\n" +
                "// ou não tinham o número de relações diferentes mínimo ou essas relações eram muito pobres/com pouco\n" +
                "// interesse para o trabalho.\n");

        insertData(session);

        pw.println("#1 Indique o nome do piloto que mais venceu corridas e quantas venceu\n");
        String query  = "MATCH (d:Driver)-[f:FINISHED]->(:GrandPrix)" +
                "WHERE f.position = \"1\"" +
                "RETURN d.name, COUNT(f)" +
                "ORDER BY COUNT(f)" +
                "DESC LIMIT 1";
        pw.println(query + "\n");
        session.run(query).list().forEach(record -> pw.println(record));

        pw.println("\n#2 Indique o motor usado por cada Construtor\n");
        query = "MATCH (c:Constructor)-[:HAS]->(e:Engine)" +
                "RETURN c.name, e.name";
        pw.println(query + "\n");
        session.run(query).list().forEach(record -> pw.println(record));

        pw.println("\n#3 Indique todos os pilotos que nunca pertenceram à \"Red Bull-Renault\"\n");
        query = "MATCH (d:Driver) " +
                "WHERE NOT (d)-[:BELONGED_TO]->(:Constructor {name: \"Red Bull-Renault\"}) AND NOT (d)-[:BELONGS_TO]->(:Constructor {name: \"Red Bull-Renault\"})" +
                "RETURN d.name";
        pw.println(query + "\n");
        session.run(query).list().forEach(record -> pw.println(record));

        pw.println("\n#4 Verifique se algum piloto venceu uma corrida no seu país de origem\n");
        query = "MATCH (d:Driver)-[:COUNTRY_ORIGIN]->(c:Country)<-[:COUNTRY_ORIGIN]-(g:GrandPrix)<-[f:FINISHED]-(d)\n" +
                "WHERE f.position = \"1\"\n" +
                "RETURN d.name, c.name";
        pw.println(query + "\n");
        session.run(query).list().forEach(record -> pw.println(record));

        pw.println("\n#5 Devolva a tabela de pontos da competição de pilotos\n");
        query = "MATCH (d:Driver)-[f:FINISHED]->(g:GrandPrix)\n" +
                "WITH d, g, toInteger(f.points) AS points\n" +
                "RETURN d.name, SUM(points)\n" +
                "ORDER BY SUM(points) DESC";
        pw.println(query + "\n");
        session.run(query).list().forEach(record -> pw.println(record));

        pw.println("\n#6 Devolva a tabela de pontos da competição de construtores\n");
        query = "MATCH (c:Constructor)<-[:BELONGS_TO]-(d:Driver)-[f:FINISHED]->(g:GrandPrix)\n" +
                "WITH c, toInteger(f.points) AS points\n" +
                "RETURN c.name, SUM(points)\n" +
                "ORDER BY SUM(points) DESC";
        pw.println(query + "\n");
        session.run(query).list().forEach(record -> pw.println(record));

        pw.println("\n#7 Devolva as corridas vencidas por \"Fernado Alonso\"\n");
        query = "MATCH (d:Driver {name: \"Fernando Alonso\"})-[f:FINISHED]->(g:GrandPrix)\n" +
                "WHERE f.position = \"1\"\n" +
                "RETURN g.city";
        pw.println(query + "\n");
        session.run(query).list().forEach(record -> pw.println(record));

        pw.println("\n#8 Devolva as corridas em que \"Esteban Gutiérrez\" não terminou (\"RET\")\n");
        query = "MATCH(d:Driver{name: \"Esteban Gutiérrez\"})-[:FINISHED{position:\"RET\"}]->(g:GrandPrix)" +
                "RETURN g.city";
        pw.println(query + "\n");
        session.run(query).list().forEach(record -> pw.println(record));

        pw.println("\n#9 Devolva o país com mais pilotos no campeonato\n");
        query = "MATCH (d:Driver)-[:COUNTRY_ORIGIN]->(c:Country)\n" +
                "RETURN c.name, COUNT(d)\n" +
                "ORDER BY COUNT(d) DESC LIMIT 1";
        pw.println(query + "\n");
        session.run(query).list().forEach(record -> pw.println(record));

        pw.println("\n#10 Devolva o piloto há mais tempo na equipa onde atua e esse tempo em anos\n");
        query = "MATCH (d:Driver)-[b:BELONGS_TO]->(c:Constructor)\n" +
                "WITH d, c, b.since AS start\n" +
                "RETURN d.name, c.name, 2013 - toInteger(start) + 1 AS time\n" +
                "ORDER BY time DESC LIMIT 1";
        pw.println(query + "\n");
        session.run(query).list().forEach(record -> pw.println(record));

        session.close();
        driver.close();
        pw.close();
    }

    public static void insertData(Session session) {
        session.run("MATCH (a) -[r] -> () DELETE a, r");
        session.run("MATCH (a) DELETE a");
        try {
            Scanner sc = new Scanner(new File("load.txt"));
            String query = "";
            while (sc.hasNextLine())
                query += sc.nextLine()+"\n";
            session.run(query);
            sc.close();
        } catch (FileNotFoundException e) {
            System.out.println("File not found");
        }
    }
}
