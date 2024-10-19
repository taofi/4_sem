import java.io.*;
import java.net.*;

public class ServerThread extends Thread {
    private PrintStream os; // передача
    private BufferedReader is; // прием
    private InetAddress addr; // адрес клиент

    public ServerThread(Socket s) throws IOException{
        os = new PrintStream(s.getOutputStream());
        is = new BufferedReader(new InputStreamReader(s.getInputStream()));
        addr = s.getInetAddress();
    }

    public void run(){
        try{
            String command;
            while ((command = is.readLine()) != null) {
                if (command.startsWith("SET")) {
                    if(NetServerThread.isGameStarted())
                    {
                        sendMessage("Число уже установлено!!");
                        continue;
                    }
                    int number = Integer.parseInt(command.split(" ")[1]);
                    NetServerThread.setSecretNumber(number);
                } else if (command.startsWith("GUESS")) {
                    if(!NetServerThread.isGameStarted())
                    {
                        sendMessage("Число еще не задано!!");
                        continue;
                    }
                    int guess;
                    try {
                        guess = Integer.parseInt((command.split(" ")[1]));
                    } catch (NumberFormatException e) {
                        sendMessage("Введите число");
                        continue;
                    }
                    boolean correct = NetServerThread.guessNumber(guess, this);
                    if (correct) {
                        sendMessage("Вы угадали число!");
                    } else {
                        sendMessage("Попробуйте снова.");
                    }
                }
            }
        }catch(IOException e){
            System.err.println("Disconnect");
        }finally {
            disconnect();
        }
    }
    public void sendMessage(String message) {
        os.println(message);
    }
    public void disconnect(){
        try{
            if(os != null){
                os.close();
            }
            if(is != null){
                is.close();
            }
            System.out.println(addr.getHostName() + " disconnecting");
        }catch (IOException e){
            e.printStackTrace();
        } finally {
            this.interrupt();
        }
    }

}
