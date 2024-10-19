package by.vorovich.third.Comparator;
import java.util.Comparator;
import by.vorovich.third.car.Car;


public class ComparatorSpeed implements Comparator<Car> {
    @Override
    public int compare(Car car1, Car car2) {
        return Integer.compare(car1.getMaxSpeed(), car2.getMaxSpeed());
    }
}

