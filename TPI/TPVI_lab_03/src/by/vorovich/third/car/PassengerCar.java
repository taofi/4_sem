package by.vorovich.third.car;

import com.fasterxml.jackson.annotation.JsonAutoDetect;

@JsonAutoDetect
public class PassengerCar extends Car {
    @Override
    public void RunEngine() {
        System.out.println("Start passenger car engine...");
    }

    public enum PassengerBodyType {
        SEDAN,
        COUPE,
        HATCHBACK,
        FASTBACK,
        CROSSOVER
    }
    private PassengerBodyType bodyType;

    public PassengerBodyType getBodyType() {
        return bodyType;
    }

    public void setBodyType(PassengerBodyType bodyType) {
        this.bodyType = bodyType;
    }

    public PassengerCar() {

    }
    public PassengerCar(int enginePower, int maxSpeed, int fuelConsumption, String company, PassengerBodyType bodyType, int cost) {
        super(enginePower, maxSpeed, fuelConsumption, company, cost);
        this.bodyType = bodyType;
    }
}
