import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;

public class UDPSender {
    public static void main(String[] args) throws Exception {
        int port = 5000;
        byte[] receiveData = new byte[1024];

        try (DatagramSocket serverSocket = new DatagramSocket(port)) {
            System.out.println("Запущен на порту " + port);

            while (true) {
                DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
                serverSocket.receive(receivePacket);
                String sentence = new String(receivePacket.getData(), 0, receivePacket.getLength());
                System.out.println("Получено: " + sentence);

                // Если нужно ответить клиенту, можно использовать receivePacket.getAddress() и receivePacket.getPort()
            }
        }
    }
}