package redis.ex5;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.TreeMap;
import java.util.Calendar;
import java.util.List;
import java.util.Scanner;
import java.util.Map;

import redis.clients.jedis.Jedis;

public class Chat {
	public static void main(String[] args) {
		Jedis jedis = new Jedis();
		jedis.flushDB();
		Scanner sc = new Scanner(System.in);
		String user = "";
		String pattern = "dd/MM/yyyy HH:mm:ss";
		DateFormat df = new SimpleDateFormat(pattern);
		while (true) {
			if (user.equals("")) {
				System.out.print("Utilizador: ");
				user = sc.nextLine();
				jedis.sadd("users", user);
			} else {
				System.out.print("1. Adicionar Contacto\n2. Remover Contacto\n3. Listar Contactos\n4. Enviar Mensagem\n5. Ver Mensagens\n6. Log out\n7. Sair\n\nOpção: ");
				String opt = sc.nextLine();
				switch (opt) {
					case "1":
						System.out.print("Adicionar Contacto\n\nNovo Contacto: ");
						String newContact = sc.nextLine();
						jedis.zadd(user+"_contacts", 0, newContact);
						break;
					case "2":
						System.out.print("Remover Contacto\n\nContacto a remover: ");
						String contactToRemove = sc.nextLine();
						jedis.zrem(user + "_contacts", contactToRemove);
						break;
					case "3":
						System.out.println("Listar Contactos\n");
						jedis.zrange(user + "_contacts", 0, -1).forEach(System.out::println);
						System.out.println();
						break;
					case "4":
						System.out.print("Enviar Mensagem\n\nDestinatário: ");
						String dest = sc.nextLine();
						System.out.print("Mensagem: ");
						String msg = sc.nextLine();
						String date = df.format(Calendar.getInstance().getTime());
						jedis.lpush(dest + "_msgs", user + "::" + date + "::" + msg);
						jedis.lpush(user + "_msgs", user + "::" + date + "::" + msg);
						break;
					case "5":
						System.out.print("Ver Mensagens\n\nContacto: ");
						String contact = sc.nextLine();
						List<String> lst1 = jedis.lrange(contact + "_msgs", 0, -1);
						List<String> lst2 = jedis.lrange(user + "_msgs", 0, -1);
						TreeMap<String, Map<String, String>> msgs = new TreeMap<>();
						for (String s : lst1) {
							String[] arr = s.split("::");
							if (arr[0].equals(user)) {
								String a = "";
								for (int i = 2; i < arr.length; i++)
									a += arr[i];
								msgs.put(arr[1], Map.of(arr[0], a));
							}
						}
						for (String s : lst2) {
							String[] arr = s.split("::");
							if (arr[0].equals(contact)) {
								String a = "";
								for (int i = 2; i < arr.length; i++)
									a += arr[i];
								msgs.put(arr[1], Map.of(arr[0], a));
							}
						}
						msgs.forEach((k, v) -> {
							v.forEach((k1, v1) -> {
								System.out.println(k1 + " (" + k + "): " + v1);
							});
						});
						System.out.println();
						break;
					case "6":
						System.out.println("Log out\n");
						user = "";
						break;
					case "7":
						sc.close();
						jedis.close();
						System.exit(0);
					default:
						System.out.println("Opção Inválida!");
				}
			}
		}
		
	}
}
