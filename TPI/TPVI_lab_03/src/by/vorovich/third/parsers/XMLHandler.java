package by.vorovich.third.parsers;

import by.vorovich.third.car.Car;
import by.vorovich.third.car.PassengerCar;
import by.vorovich.third.car.Truck;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import java.util.ArrayList;

public class XMLHandler extends DefaultHandler {
    private ArrayList<Car> cars = new ArrayList<Car>();
    public ArrayList<Car> getCars() {
        return cars;
    }
    @Override
    public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
        if (qName.equals("PassengerCar")) {
            String enginePower = attributes.getValue("enginePower");
            String maxSpeed = attributes.getValue("maxSpeed");
            String fuelConsumption = attributes.getValue("fuelConsumption");
            String company = attributes.getValue("company");
            String cost = attributes.getValue("cost");
            String stringBodyType = attributes.getValue("bodyType");
            PassengerCar.PassengerBodyType bodyType = switch (stringBodyType) {
                case "PassengerBodyType.COUPE" -> PassengerCar.PassengerBodyType.COUPE;
                case "PassengerBodyType.HATCHBACK" -> PassengerCar.PassengerBodyType.HATCHBACK;
                case "PassengerBodyType.FASTBACK" -> PassengerCar.PassengerBodyType.FASTBACK;
                case "PassengerBodyType.CROSSOVER" -> PassengerCar.PassengerBodyType.CROSSOVER;
                default -> PassengerCar.PassengerBodyType.SEDAN;
            };
            cars.add(new PassengerCar(
                    Integer.parseInt(enginePower),
                    Integer.parseInt(maxSpeed),
                    Integer.parseInt(fuelConsumption),
                    company,
                    bodyType,
                    Integer.parseInt(cost)
            ));
        }
        if (qName.equals("Truck")) {
            String enginePower = attributes.getValue("enginePower");
            String maxSpeed = attributes.getValue("maxSpeed");
            String fuelConsumption = attributes.getValue("fuelConsumption");
            String company = attributes.getValue("company");
            String cost = attributes.getValue("cost");
            String stringBodyType = attributes.getValue("bodyType");
            Truck.TruckBodyType bodyType = switch (stringBodyType) {
                case "TruckBodyType.ALL_METAL" -> Truck.TruckBodyType.ALL_METAL;
                case "TruckBodyType.ISOTHERMAL" -> Truck.TruckBodyType.ISOTHERMAL;
                case "TruckBodyType.REFRIGERATORS" -> Truck.TruckBodyType.REFRIGERATORS;
                default -> Truck.TruckBodyType.TILT;
            };
            cars.add(new Truck(
                    Integer.parseInt(enginePower),
                    Integer.parseInt(maxSpeed),
                    Integer.parseInt(fuelConsumption),
                    company,
                    bodyType,
                    Integer.parseInt(cost)
            ));
        }
    }
}
