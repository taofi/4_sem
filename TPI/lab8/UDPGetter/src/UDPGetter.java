import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.util.Scanner;

public class UDPGetter {
    public static void main(String[] args) throws Exception {
        int port = 5000;
        InetAddress IPAddress = InetAddress.getByName("localhost");
        Scanner scanner = new Scanner(System.in);
        System.out.println("Введите строку:");
        String input;
        try (DatagramSocket clientSocket = new DatagramSocket()) {
            while (!(input = scanner.nextLine()).equals("end")) {
                try{
                    byte[] inputDataBytes = input.getBytes();
                    DatagramPacket sendPacket = new DatagramPacket(inputDataBytes, inputDataBytes.length, IPAddress, port);
                    clientSocket.send(sendPacket);
                    System.out.println("Сообщение отправлено на сервер");
                }catch (IOException e){
                    System.err.println(e);
                }
            }
        }
    }
}