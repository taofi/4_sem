package by.belstu.it.varovich.basejava;

import static java.lang.Math.log;
import static java.lang.Math.*;
import java.util.Random;

/**
* JavaTest class for lab2
* @author kirill varovich
* @version 1
*/
public class JavaTest {
    static int sint;
    final int wer;

    public final int ops;
    /**
     * @value 0
     * @see WrapperString
     */
    public static final int uip = 0;

    public JavaTest() {
        wer = 0;
        ops = 0;
    }
    /**
     * Точка входа в программу.
     * @param args Аргументы командной строки.
     * @throws Exception ArrayIndexOutOfBoundsException NullPointerException
     * @return отсутвует (тип void)
     */
    public static void main(String[] args) {

        char word = 'd';
        int integer = 1;
        short shortInteger = 2;
        byte byteVar = 3;
        long longVar = 123456;
        boolean boolFalse = false;
        boolean boolTrue = true;
        String stringFirst = "somestr";
        System.out.println(stringFirst);
        String si = stringFirst + integer;
        System.out.println(si);
        si= stringFirst + word;
        System.out.println(si);
        si = stringFirst + 3.56443;
        System.out.println(si);
        //byteVar = byteVar + integer;
        //integer = 3.123 + integer;
        long ll = integer + 2147483647L;
        System.out.println(ll);
        System.out.println(sint);
        boolean bip = boolFalse &&  boolTrue;
        System.out.println(bip);
        boolean bip1 = boolFalse ^  boolTrue;
        System.out.println(bip1);
        //boolean bip2 = boolTrue + boolFalse;
        long number1 = 9223372036854775807L;
        long number2 = 0x7fff_ffff_fffL;
        char ch = 'a';
        char ch1 = '\u0061';
        char ch2 = 97;
        char sum = (char) (ch + ch1 + ch2);
        System.out.println(sum);

        System.out.println();
        System.out.println(3.45 % 2.4);
        System.out.println(1.0/0.0);
        System.out.println(0.0/0.0);
        System.out.println(log(-345));
        float flat = Float.intBitsToFloat(0x7F800000);
        System.out.println(flat);
        flat = Float.intBitsToFloat(0xFF800000);
        System.out.println(flat);
        System.out.println(Math.PI);
        System.out.println(Math.E);
        System.out.println(Math.round(Math.PI));
        System.out.println(Math.round(Math.E));
        System.out.println(Math.min(PI,E));
        Random rand = new Random();
        double randnum = rand.nextDouble();
        System.out.println(randnum);

        System.out.println();
        Boolean bol = true;
        Character char1 = 'l';
        Integer int1 = 5;
        Byte bute1 = (byte)5;
        Short shotr1 = (short)20;
        Long long1 = 90L;
        Double double1 = 6.31;

        System.out.println(bol && true);
        System.out.println(!bol);
        System.out.println(char1 + 10);
        System.out.println(int1 * 5);
        System.out.println(~int1);
        System.out.println(Long.MIN_VALUE);
        System.out.println(Double.MIN_VALUE);
        System.out.println(Long.MAX_VALUE);
        System.out.println(Double.MAX_VALUE);

        int a = int1; //распаковка
        Integer b = a; //упаковка
        System.out.println(b);

        System.out.println();
        int num = Integer.parseInt("123");
        System.out.println(num);
        System.out.println(Integer.toHexString(255));
        System.out.println(Integer.compare(3,5));
        String text = Integer.toString(123);
        System.out.println(text);
        System.out.println(Integer.bitCount(5));

        System.out.println();
        String s34 = "2345";
        int numValueOf = Integer.valueOf(s34);
        int numParseInt = Integer.parseInt(s34);
        byte[] bytes = s34.getBytes(); // Строка в массив байтов
        String fromBytes = new String(bytes); // Массив байтов обратно в строку
        System.out.println(fromBytes);

        boolean boolValueOf = Boolean.valueOf("true"); // Возвращает true
        boolean boolParseBoolean = Boolean.parseBoolean("false"); // Возвращает false

        System.out.println(boolValueOf);
        System.out.println(boolParseBoolean);

        System.out.println();
        String str1 = "test";
        String str2 = "test";
        //str2 = null;
        System.out.println(str1 == str2);//возвращает true, если обе переменные ссылаются на один объект.
        System.out.println(str1.equals(str2));// возвращает true, если строки идентичны по содержанию.
        System.out.println(str1.compareTo(str2));// возвращает 0, если строки равны.
        str2 = null;
        System.out.println(str1 == str2);
        System.out.println(str1.equals(str2));
       // System.out.println(str1.compareTo(str2));

        String example = "hello,world,split,test";
        String[] parts = example.split(","); // Разбиение строки по ","

        System.out.println();
        System.out.println(example.contains("world"));// Проверка на содержание подстроки "world"
        System.out.println(example.hashCode()); // Получение хеш-кода строки
        System.out.println(example.indexOf("world")); // Получение индекса начала подстроки "world"
        System.out.println(example.length());//Длина
        System.out.println(example.replace("world", "java")); // Замена "world" на "java"
        char[][] c1; //предпочтительный
        char[] c2[];
        char c3[][];
        c1 = new char[3][];
        for (int i = 0; i < c1.length; i++) {
            c1[i] = new char[i + 1]; // Каждая последующая строка содержит на один элемент больше, чем предыдущая
        }
        for (int i = 0; i < c1.length; i++) {
            System.out.println("c1[" + i + "].length: " + c1[i].length);
        }
        for(String part : parts)
            System.out.print(part + ' ');
       // System.out.println(parts[20]); ArrayIndexOutOfBoundsException


        WrapperString anonymousWrapper = new WrapperString("hello world") {
            // Переопределение метода replace
            @Override
            public void replace(char oldChar, char newChar) {
                super.replace(oldChar, newChar);
                System.out.println("Override");
            }

            // Дополнительный метод delete
            public void delete(char delChar) {
                super.replace(delChar, ' ');
            }
        };


    }
}