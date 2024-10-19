package by.vorovich.third.car_park;

import by.vorovich.third.car.Car;
import by.vorovich.third.Comparator.ComparatorSpeed;
import by.vorovich.third.exception.NullCarException;
import com.fasterxml.jackson.annotation.JsonAutoDetect;
import org.apache.log4j.Logger;

import java.util.Collections;
import java.util.ArrayList;
@JsonAutoDetect
public class CarPark {
    private static final Logger LOG =
            Logger.getLogger(CarPark.class);

    private ArrayList<Car> carArrayList = new ArrayList<Car>();

    public void sortCost()
    {
        Collections.sort(carArrayList);
    }

    public  void sortSpeed()
    {
        Collections.sort(carArrayList, new ComparatorSpeed());
    }
    public CarPark() { }

    public CarPark(ArrayList<Car> carArrayList) {
        this.carArrayList = carArrayList;
    }

    public ArrayList<Car> getCarArrayList() {
        return carArrayList;
    }

    public void setCarArrayList(ArrayList<Car> carArrayList) {
        this.carArrayList = carArrayList;
    }

    public boolean add(Car item) throws NullCarException {
        if (item == null) {
            throw new NullCarException("Car must have value");
        }
        LOG.info("car added");
        return carArrayList.add(item);
    }

    public boolean remove(Car item) throws NullCarException {
        if (item == null) {
            throw new NullCarException("Car must have value");
        }
        LOG.info("car removed");
        return carArrayList.remove(item);
    }

    @Override
    public String toString() {
        StringBuilder result = new StringBuilder();
        for(Car car: carArrayList) {
            result.append(car.toString()).append("\n");
        }
        return result.toString();
    }
}
