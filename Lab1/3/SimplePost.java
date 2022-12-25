package redis.ex3;

import redis.clients.jedis.Jedis;
import java.util.HashMap;

public class SimplePost {
	public static String USERS_KEY = "users"; // Key set for users' name
	public static String USERS_LIST_KEY = "usersList";
	public static String USERS_MAP_KEY = "usersMap";
	public static void main(String[] args) {
		Jedis jedis = new Jedis();
		// some users
		String[] users = { "Ana", "Pedro", "Maria", "Luis", "Maria" };
		// jedis.del(USERS_KEY); // remove if exists to avoid wrong type
		System.out.println("Set:");
		for (String user : users)
			jedis.sadd(USERS_KEY, user);
		jedis.smembers(USERS_KEY).forEach(System.out::println);

		String[] usersList = { "Rita", "Raquel", "Henrique", "António", "André", "Ricardo" };

		System.out.println("\nList:");
		jedis.del(USERS_LIST_KEY);
		for (String user: usersList)
			jedis.lpush(USERS_LIST_KEY, user);
		jedis.lrange(USERS_LIST_KEY, 0, jedis.llen(USERS_LIST_KEY)).forEach(System.out::println);

		System.out.println("\nMap:");
		
		HashMap<String, String> map = new HashMap<>() {};
		for (int i = 0; i < usersList.length; i++)
			map.put(String.valueOf(i), usersList[i]);
		jedis.hmset(USERS_MAP_KEY, map);
		for(String key: jedis.hgetAll(USERS_MAP_KEY).keySet())
			System.out.println(key + ": " + jedis.hget(USERS_MAP_KEY, key));
		jedis.close();
	}
}
