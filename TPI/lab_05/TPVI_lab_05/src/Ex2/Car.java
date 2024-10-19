package Ex2;

import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.Semaphore;

public class Car extends Thread {
    private int carId;
    private Semaphore semaphore;

    public static int getFirstParkingCount() {
        return firstParkingCount;
    }

    public static int getSecondParkingCount() {
        return secondParkingCount;
    }

    private static int firstParkingCount;
    private static int secondParkingCount;

    public static void setFirstParkingCount(int firstParkingCount) {
        Car.firstParkingCount = firstParkingCount;
    }

    public static void setSecondParkingCount(int secondParkingCount) {
        Car.secondParkingCount = secondParkingCount;
    }
    public Car(int carId, Semaphore semaphore) {
        this.carId = carId;
        this.semaphore = semaphore;
    }

    @Override
    public void run() {
        try {
            semaphore.acquire();
            while (true) {
                if (getFirstParkingCount() > 0) {
                    System.out.println("Машина " + carId + " припарковалась на первой парковке.");
                    firstParkingCount--;
                    semaphore.release();
                    sleep((long)(Math.random() * (3500 - 1000)) + 1000);
                    System.out.println("С первой парковки уехал автомобиль " + carId);
                    firstParkingCount++;
                    break;
                }
                else if (getSecondParkingCount() > 0) {
                    System.out.println("Машина " + carId + " припарковалась на второй парковке.");
                    secondParkingCount--;
                    semaphore.release();
                    sleep((long)(Math.random() * (3500 - 1000)) + 1000);
                    System.out.println("Со второй парковки уехал автомобиль " + carId);
                    secondParkingCount++;
                    break;
                }
                System.out.print("");
            }
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }
}
