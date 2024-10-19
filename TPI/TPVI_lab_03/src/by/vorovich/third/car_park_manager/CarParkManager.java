package by.vorovich.third.car_park_manager;

import by.vorovich.third.car.Car;
import by.vorovich.third.car.PassengerCar;
import by.vorovich.third.car_park.CarPark;
import by.vorovich.third.car.Truck;
import by.vorovich.third.exception.InvalidInputsException;
import by.vorovich.third.exception.InvalidRangeException;
import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Random;

public class CarParkManager {
    private static final Logger LOG =
            Logger.getLogger(CarParkManager.class);

    public CarPark generateCarPark(int passengerCarCount, int truckCount) throws InvalidInputsException {
        if (passengerCarCount < 0 || truckCount < 0) {
            throw new InvalidInputsException("Car count can not be negative");
        }

        final Random random = new Random();
        final String[] company = {"BMW", "AUDI", "LADA", "MAZDA", "TOYOTA", "RENAULT"};

        ArrayList<Car> carArrayList = new ArrayList<Car>();

        final int max = 200;
        final int min = 100;
        final int diff = max - min;

        for(int i = 0; i < passengerCarCount; i++) {
            Car car = new PassengerCar(
                    random.nextInt(diff + 1) + min,
                    random.nextInt(diff + 1) + min,
                    random.nextInt(diff + 1) + min,
                    company[random.nextInt(company.length - 1)],
                    PassengerCar.PassengerBodyType.values()[random.nextInt(4)],
                    random.nextInt(1000) + 1000
                    );
            carArrayList.add(car);
        }
        for(int i = 0; i < truckCount; i++) {
            Car car = new Truck(
                    random.nextInt(diff + 1) + min,
                    random.nextInt(diff + 1) + min,
                    random.nextInt(diff + 1) + min,
                    company[random.nextInt(company.length - 1)],
                    Truck.TruckBodyType.values()[random.nextInt(3)],
                    random.nextInt(5000) + 5000
            );
            carArrayList.add(car);
        }
        LOG.info("new carpark generated");
        return new CarPark(carArrayList);
    }

    public int sumCarPark(CarPark carPark) {
        int result = 0;
        for (Car car: carPark.getCarArrayList()) {
            result += car.getCost();
        }
        return  result;
    }

    Comparator<Car> comparator = new Comparator<Car>() {
        public int compare(Car o1, Car o2) {
            if (o1.getFuelConsumption() > o2.getFuelConsumption()) {
                return 1;
            }
            else if (o1.getFuelConsumption() < o2.getFuelConsumption()) {
                return -1;
            }
            return 0;
        }
    };
    public void sortByFuelConsumption(CarPark carPark) {
        carPark.getCarArrayList().sort(comparator);
    }

    public ArrayList<Car> findCarsByMaxSpeedRange(CarPark carPark, int lower, int upper) throws InvalidRangeException {
        if (lower < 0 || upper < 0)
            throw new InvalidRangeException("Range can not be negative");
        ArrayList<Car> cars = new ArrayList<Car>();
        for (Car car: carPark.getCarArrayList()) {
            if (car.getMaxSpeed() > lower && car.getMaxSpeed() < upper) {
                cars.add(car);
            }
        }
        return cars;
    }
    public int getTruckCount(CarPark carPark) {
        int result = 0;
        for(Car car: carPark.getCarArrayList()) {
            if(car instanceof Truck) {
                result++;
            }
        }
        return result;
    }

    public int getPassengerCarCount(CarPark carPark) {
        int result = 0;
        for(Car car: carPark.getCarArrayList()) {
            if(car instanceof PassengerCar) {
                result++;
            }
        }
        return result;
    }
}
