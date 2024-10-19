package by.vorovich.third.main;

import by.vorovich.third.car_park.CarPark;
import by.vorovich.third.car.Car;
import by.vorovich.third.car.PassengerCar;
import by.vorovich.third.car.Truck;
import by.vorovich.third.car_park_manager.CarParkManager;
import by.vorovich.third.exception.InvalidInputsException;
import by.vorovich.third.parsers.XMLHandler;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.log4j.xml.DOMConfigurator;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.validation.Validator;
import javax.xml.XMLConstants;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringWriter;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Optional;
import java.util.stream.Stream;

public class Main {
    static {
        new DOMConfigurator().doConfigure("log/log4j.xml",
                LogManager.getLoggerRepository());
    }
    private static final Logger LOG = Logger.getLogger(Main.class);

    public static void main(String[] args) throws InvalidInputsException,
            ParserConfigurationException, SAXException, IOException {
        LOG.info("Starting program_____________________________");

        CarParkManager manager = new CarParkManager();

        try {
            CarPark firstCarPark = new CarPark();
            firstCarPark.add(new Truck(100, 200, 6, "BWM", Truck.TruckBodyType.ALL_METAL, 2000));
            firstCarPark.add(new Truck(120, 100, 2, "AUDI", Truck.TruckBodyType.ISOTHERMAL, 20000));
            firstCarPark.add(new Truck(200, 220, 7, "LADA", Truck.TruckBodyType.REFRIGERATORS, 1000));
            firstCarPark.add(new PassengerCar(50, 300, 1, "BMW", PassengerCar.PassengerBodyType.COUPE, 3000));
            firstCarPark.add(new PassengerCar(70, 270, 4, "MAZDA", PassengerCar.PassengerBodyType.CROSSOVER, 5000));
            firstCarPark.add(new PassengerCar(80, 120, 3, "RENAULT", PassengerCar.PassengerBodyType.HATCHBACK, 100));
            firstCarPark.add(new PassengerCar(60, 210, 2, "TOYOTA", PassengerCar.PassengerBodyType.FASTBACK, 10000));


            CarPark secondCarPark;
            secondCarPark = manager.generateCarPark(3, 4);

            System.out.println("Sum of costs:" + manager.sumCarPark(firstCarPark));
            manager.sortByFuelConsumption(secondCarPark);
            System.out.println(secondCarPark);
            System.out.println(manager.findCarsByMaxSpeedRange(secondCarPark, 80, 140));
            System.out.println("Count of passenger cars:" + manager.getPassengerCarCount(secondCarPark));
            System.out.println("Count of trucks:" + manager.getTruckCount(secondCarPark));

        }
        catch (Exception ex) {
            LOG.error(ex.getMessage());
            System.out.println(ex.getMessage());
        }

        try {
            SchemaFactory factory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
            Schema schema = factory.newSchema(new File("D:/4_sem/TPI/TPVI_lab_03/files/xsdCars.xsd"));
            Validator validator = schema.newValidator();
            validator.validate(new StreamSource(new File("D:/4_sem/TPI/TPVI_lab_03/files/xmlCars.xml")));
            System.out.println("XML is valid against the XSD.");
        } catch (SAXException e) {
            System.out.println("XML is NOT valid reason:" + e);
        } catch (IOException e) {
            e.printStackTrace();
        }

        try {
            SAXParserFactory factory = SAXParserFactory.newInstance();
            SAXParser parser = factory.newSAXParser();

            XMLHandler handler = new XMLHandler();
            parser.parse(new File("D:/4_sem/TPI/TPVI_lab_03/files/xmlCars.xml"), handler);

            System.out.println("\nXML parsed cars:");

            CarPark carPark = new CarPark(handler.getCars());
            carPark.sortCost();
            System.out.println("\ncost sort:");
            System.out.println(carPark);
            System.out.println("\nspeed sort:");
            carPark.sortSpeed();
            System.out.println(carPark);

            System.out.println("\nJSON serialization:");
            PassengerCar passengerCar = new PassengerCar(50, 300, 1, "BMW", PassengerCar.PassengerBodyType.COUPE, 3000);
            Truck truck = new Truck(100, 200, 6, "BWM", Truck.TruckBodyType.ALL_METAL, 2000);

            ObjectMapper mapper = new ObjectMapper();
            StringWriter writer = new StringWriter();

            mapper.writeValue(writer, passengerCar);
            System.out.println(writer);
            try (FileWriter fileWriter = new FileWriter("D:/4_sem/TPI/TPVI_lab_03/files/car.json")) {
                fileWriter.write(writer.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
            writer.getBuffer().setLength(0);
            mapper.writeValue(writer, carPark);
            System.out.println(writer);
            try (FileWriter fileWriter = new FileWriter("D:/4_sem/TPI/TPVI_lab_03/files/carPark.json")) {
                fileWriter.write(writer.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
            writer.getBuffer().setLength(0);
            mapper.writeValue(writer, truck);
            System.out.println(writer);
            try (FileWriter fileWriter = new FileWriter("D:/4_sem/TPI/TPVI_lab_03/files/truck.json")) {
                fileWriter.write(writer.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
            System.out.println("\nJSON deserialization:");
            PassengerCar parsedCar = mapper.readValue(new File("D:/4_sem/TPI/TPVI_lab_03/files/car.json"), PassengerCar.class);
            System.out.println(parsedCar);
            Truck parsedTruck = mapper.readValue(new File("D:/4_sem/TPI/TPVI_lab_03/files/truck.json"), Truck.class);
            System.out.println(parsedTruck);
        }
        catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

        try {
            CarPark carPark = manager.generateCarPark(8, 12);
            long costLess = carPark.getCarArrayList().stream()
                    .filter(car -> car.getCost() < 10000)
                    .count();
            System.out.println(costLess);
            Optional<Car> firstCar = carPark.getCarArrayList().stream()
                    .findFirst();
        }
        catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

        LOG.info("program completed");
    }
}