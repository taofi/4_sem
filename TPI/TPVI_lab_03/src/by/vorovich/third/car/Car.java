package by.vorovich.third.car;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.apache.log4j.Logger;
@JsonAutoDetect
public abstract class Car implements RunInterface, Comparable<Car> {
    public int compareTo(Car o)
    {
        return this.cost - o.cost;
    }
    private static final Logger LOG =
            Logger.getLogger(Car.class);
    @JsonProperty("enginePower")
    private int enginePower;
    @JsonProperty("maxSpeed")
    private int maxSpeed;
    @JsonProperty("fuelConsumption")
    private int fuelConsumption;
    @JsonProperty("company")
    private String company;
    @JsonProperty("cost")
    private int cost;
    @JsonIgnore
    private Engine engine;

    public Car() {
        this.engine = new Engine(100);
    }

    public void setEngine(Engine engine) {
        this.engine = engine;
    }


    public Engine getEngine() {
        return engine;
    }
    public static class Engine {
        public int getPower() {
            return power;
        }
        @JsonProperty("power")
        private final int power;

        @Override
        public String toString() {
            return "power=" + power;
        }
        private Engine (int power) {
            this.power = power;
        }
    }
    public Car(int enginePower, int maxSpeed, int fuelConsumption, String company, int cost) {
        this.enginePower = enginePower;
        this.maxSpeed = maxSpeed;
        this.fuelConsumption = fuelConsumption;
        this.company = company;
        this.cost = cost;
        this.engine = new Engine(100);
    }

    public int getMaxSpeed() {
        return maxSpeed;
    }

    public int getFuelConsumption() {
        return fuelConsumption;
    }


    public int getCost() {
        return cost;
    }


    @Override
    public String toString() {
        return "Car{" +
                "enginePower=" + enginePower +
                ", maxSpeed=" + maxSpeed +
                ", fuelConsumption=" + fuelConsumption +
                ", company='" + company + '\'' +
                ", cost=" + cost +
                ", engine{" + engine +
                "}}";
    }
}
