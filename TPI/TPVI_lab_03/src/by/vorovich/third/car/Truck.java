package by.vorovich.third.car;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonAutoDetect
public class Truck extends Car {
    @Override
    public void RunEngine() {
        System.out.println("Start truck engine...");
    }

    public enum TruckBodyType {
        TILT,
        ALL_METAL,
        ISOTHERMAL,
        REFRIGERATORS
    }

    public Truck() {
        super();
    }

    @JsonProperty("bodyType")
    private TruckBodyType bodyType;
    public TruckBodyType getBodyType() {
        return bodyType;
    }
    public void setBodyType(TruckBodyType bodyType) {
        this.bodyType = bodyType;
    }
    public Truck(int enginePower, int maxSpeed, int fuelConsumption, String company, TruckBodyType bodyType, int cost) {
        super(enginePower, maxSpeed, fuelConsumption, company, cost);
        this.bodyType = bodyType;
    }
}
