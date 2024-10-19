import java.net.URL;
import java.net.MalformedURLException;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

public class Main {
    public static void main(String[] args) {
        URL tut = null;
        String urlName = "https://ru.legacy.reactjs.org";
        try {
            tut = new URL(urlName);
        } catch (MalformedURLException e) {
// некорректно заданы протокол, доменное имя или путь к файлу
            e.printStackTrace();
        }
        if (tut == null) {
            throw new RuntimeException();
        }
        try (BufferedReader d = new BufferedReader
                (new InputStreamReader(tut.openStream())))
        {
            String line = "";
            while ((line = d.readLine()) != null) {
                System.out.println(line);
            }
        } catch (IOException e) {
            e.printStackTrace(); }
    }
}