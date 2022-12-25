package redis.ex4;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.Tuple;

import java.util.Scanner;
import java.io.IOException;
import java.io.File;
import java.util.Set;

public class AutocompleteB {
	public static void main(String[] args) throws IOException{
		Jedis jedis = new Jedis();
		Scanner sc = new Scanner(new File("src/main/java/redis/ex4/nomes-pt-2021.csv"));
		jedis.flushAll();
		while (sc.hasNextLine()) {
			String[] line = sc.nextLine().split(";");
			jedis.zadd("namesPT", Integer.parseInt(line[1]), line[0]);
		}
		sc.close();
		Scanner in = new Scanner(System.in); 
		String input = "";
		while (true) {
			System.out.print("Search for ('Enter' for quit): ");
			input = in.nextLine().toLowerCase();
			if(input=="")
				break;
			Set<Tuple> set = jedis.zrevrangeWithScores("namesPT", 0, -1);
			for(Tuple t : set) {
				if(t.getElement().toLowerCase().startsWith(input.toLowerCase()))
					System.out.println(t.getElement());
			}
		}
		in.close();
		jedis.close();
	}
}
