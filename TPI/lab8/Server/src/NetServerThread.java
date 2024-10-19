import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

public class NetServerThread {
    private static int secretNumber = -1; // Если число не установлено, будет -1

    public static boolean isGameStarted() {
        return gameStarted;
    }

    private static boolean gameStarted = false;
    private static final List<ServerThread> clients = Collections.synchronizedList(new ArrayList<>());

    public static void main(String[] args) {
        try {
            ServerSocket server = new ServerSocket(7071);
            System.out.println("initialized");
            while (true){
                Socket socket = server.accept();
                System.out.println(socket.getInetAddress().getHostName() + " connected");

                ServerThread thread = new ServerThread(socket);
                thread.start();
            }
        }catch (IOException e ){
            System.err.println(e);
        }
    }
    // Метод для установки числа
    public static synchronized void setSecretNumber(int number) {
        secretNumber = number;
        gameStarted = true;
        broadcastMessage("Игра началась! Попробуйте угадать число.");
    }

    // Проверка угадано ли число
    public static synchronized boolean guessNumber(int guess, ServerThread guesser) {
        if (guess == secretNumber) {
            broadcastMessage("Число угадано клиентом " + guesser.getName());
            gameStarted = false;
            return true;
        }
        return false;
    }

    public static void broadcastMessage(String message) {
        synchronized (clients) {
            for (ServerThread client : clients) {
                System.out.println(client.getName() + " " + message);
                client.sendMessage(message);
            }
        }
    }

    public static void endGame(String winnerMessage) {
        broadcastMessage(winnerMessage);
        for (ServerThread client : clients) {
            client.disconnect();
        }
    }

}