package Ex1;

import java.util.ArrayList;
import java.util.concurrent.Semaphore;

public class Client extends Thread {
    private int id;
    private boolean isComplete = false;
    private ArrayList<Operator> operators;
    public Client(int id, ArrayList<Operator> operators) {
        this.id = id;
        this.operators = operators;
    }

    @Override
    public void run() {
        System.out.println("Клиент " + id + " звонит в колл-центр!");

        try {
            while(!isComplete) {
                if (!operators.isEmpty()) {
                    Operator operator = operators.getFirst();
                    operators.removeFirst();

                    System.out.println("Клиент " + id + " дозвонился до оператора " + operator.GetID());
                    Thread.sleep(2500);

                    System.out.println("Клиент " + id + " завершил разговор.");
                    isComplete = true;

                    System.out.println("Оператор " + id + " освободился.");
                    operators.add(operator);
                }
                else {
                    System.out.println("Клиент " + id + " не смог попасть к свободному оператору. Он перезвонит через 3 секунды.");
                    Thread.sleep(3000);
                }
            }
        }
        catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }
}