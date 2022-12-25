package redis.ex4;

import redis.clients.jedis.Jedis;
import java.util.Scanner;
import java.io.File;
import java.io.IOException;

public class AutocompleteA {
	public static void main(String[] args) throws IOException {
		Jedis jedis = new Jedis();
		Scanner sc = new Scanner(new File("src/main/java/redis/ex4/names.txt"));
		jedis.flushDB();
		while (sc.hasNextLine()) {
			jedis.zadd("names", 0, sc.nextLine());
		}
		sc.close();
		Scanner in = new Scanner(System.in); 
		String input = "";
		while (true) {
			System.out.print("Search for ('Enter' for quit): ");
			input = in.nextLine().toLowerCase();
			if(input=="")
				break;
			jedis.zrangeByLex("names", "["+input, "["+input+(char)0xFF).forEach(System.out::println);
		}
		in.close();
		jedis.close();
	}
}
