import Ex1.Client;
import Ex1.Operator;
import Ex2.Car;

import java.util.ArrayList;
import java.util.Set;
import java.util.concurrent.Semaphore;

import static java.lang.Thread.sleep;

public class main {
    public static void main(String[] args) {

        //============= ex_1 ===============
        ArrayList<Operator> operators = new ArrayList<>();
        operators.add(new Operator(1));
        operators.add(new Operator(2));
        operators.add(new Operator(3));

        Client client = new Client(1, operators);

        for (int i = 1; i <= 5; i++) {
            new Client(i, operators).start();
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }

        //============= ex_2 ===============
        Car.setFirstParkingCount(1);
        Car.setSecondParkingCount(2);
        Semaphore semaphore = new Semaphore(1);

        for (int i = 0; i < 9; i++) {
            new Car(i, semaphore).start();
        }
    }
}