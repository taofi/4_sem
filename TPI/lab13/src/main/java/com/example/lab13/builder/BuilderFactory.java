package com.example.lab13.builder;

public class BuilderFactory {
    private static final String USER = "user";
    private static final String UNIVER = "univer";
    private static final String MESSAGE= "Unknown Builder name!";
    public static Builder create(String builderName) {
        switch (builderName) {
            case USER: {
                return new UserBuilder();
            }
            case UNIVER: {
                return new UniverBuilder();
            }
            default:
                throw new IllegalArgumentException(MESSAGE);
        }
    }
}