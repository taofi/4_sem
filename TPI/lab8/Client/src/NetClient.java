import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.InetAddress;
import java.net.Socket;
import java.nio.Buffer;
import java.util.Scanner;

public class NetClient {
    public static void main(String[] args) {
        Socket socket = null;
        BufferedReader br= null;
        try{
            socket = new Socket(InetAddress.getLocalHost(), 7071);
            PrintStream ps = new PrintStream(socket.getOutputStream());
            br = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            Scanner scanner = new Scanner(System.in);
            System.out.println("Вы хотите установить число? (y/n)");
            String response = scanner.nextLine();
            if ("y".equalsIgnoreCase(response)) {
                String command;
                System.out.println("Введите число для угадывания:");
                while (!(command = scanner.nextLine()).equals("end") ){
                    int number;
                    try {
                        number = Integer.parseInt(command);
                    } catch (NumberFormatException e) {
                        System.out.println("Введите число");
                        continue;
                    }
                    ps.println("SET " + number);
                    System.out.println("Введите число для угадывания:");
                }
            } else {
                String command;
                System.out.println("Введите вашу догадку:");
                while (!(command = scanner.nextLine()).equals("end") ) {
                    int number;
                    try {
                        number = Integer.parseInt(command);
                    } catch (NumberFormatException e) {
                        System.out.println("Введите число");
                        continue;
                    }
                    ps.println("GUESS " + number);
                    System.out.println(br.readLine());
                    System.out.println("Введите вашу догадку:");
                }
            }
        } catch (IOException e) {
            System.err.println(e);
        }
    }
}