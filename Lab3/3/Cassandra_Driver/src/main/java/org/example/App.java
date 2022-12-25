package org.example;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Session;

public class App
{
    private static Session session;

    public static void main( String[] args )
    {
        connect("127.0.0.1", 9042);

        System.out.println("a)\n");
        System.out.println("INSERTS");
        App.exec("INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (uuid(), 'username_test', 'TEst Name', 'test@gmail.com', '2022-06-12 15:00:00')");
        App.exec("SELECT * FROM videos.users").all().forEach(System.out::println);
        String user_uuid = App.exec("SELECT id FROM videos.users WHERE username = 'username_test' ALLOW FILTERING").one().getUUID("id").toString();
        App.exec("INSERT INTO videos.videos(id, user_id, title, description, tags, upload_date) VALUES (uuid(), "+ user_uuid +", 'Video_test', 'Description_test', {'test_tag1', 'test_tag2'}, '2022-06-12 15:00:00')");
        String video_uuid = App.exec("SELECT id FROM videos.videos WHERE title = 'Video_test' ALLOW FILTERING").one().getUUID("id").toString();
        App.exec("INSERT INTO videos.ratings(id, video_id, rating) VALUES (uuid(), "+ video_uuid +", 5)");
        String rating_uuid = App.exec("SELECT id FROM videos.ratings WHERE video_id = "+ video_uuid +"").one().getUUID("id").toString();
        App.exec("SELECT * FROM videos.ratings WHERE ID = " + rating_uuid).all().forEach(System.out::println);

        System.out.println("UPDATES");
        App.exec("UPDATE videos.users SET name = 'Antonio Silva' WHERE id = " + user_uuid);
        App.exec("SELECT * FROM videos.users WHERE id = "+ user_uuid).all().forEach(System.out::println);
        App.exec("UPDATE videos.videos SET title = 'Tutorial CBD' WHERE user_id = "+user_uuid+" AND id = " + video_uuid + " AND upload_date = '2022-06-12 15:00:00'");
        App.exec("SELECT * FROM videos.videos WHERE id = "+ video_uuid + " ALLOW FILTERING").all().forEach(System.out::println);

        System.out.println("DELETES");
        App.exec("DELETE FROM videos.ratings WHERE rating = 5 AND id = " + rating_uuid);
        App.exec("SELECT * FROM videos.ratings WHERE id = "+ rating_uuid).all().forEach(System.out::println);

        System.out.println("\nb)\n");

        System.out.println("Query 3");
        App.exec("SELECT * FROM videos.videos WHERE tags CONTAINS 'Aveiro' ALLOW FILTERING;").all().forEach(System.out::println);
        System.out.println("\nQuery 4");
        App.exec("SELECT * FROM videos.events WHERE user_id = 46901da4-4eed-4256-9f93-653a0892f069 AND video_id = 172a2dae-3cce-4243-b7d2-f48dd117d14d LIMIT 5;").all().forEach(System.out::println);
        System.out.println("\nQuery 6");
        App.exec("SELECT * FROM videos.videos LIMIT 10;").all().forEach(System.out::println);
        System.out.println("\nQuery 7");
        App.exec("SELECT * FROM videos.followers WHERE video_id = 4614e178-f4b7-4cbb-8ee5-75795a9f41c9 ALLOW FILTERING;").all().forEach(System.out::println);

        close();
        System.exit(0);
    }

    public static void connect(String node, Integer port) {
        Cluster cluster = Cluster.builder()
                .addContactPoint(node)
                .withPort(port)
                .build();
        session = cluster.connect();
        System.out.println("Connected to cluster: " + cluster.getClusterName());
    }

    public static void close() {
        session.close();
        System.out.println("Connection closed");
    }

    public static ResultSet exec(String string) {
        try {
            return session.execute(string);
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }
}
