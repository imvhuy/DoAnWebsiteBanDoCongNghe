package com.javaweb.exception;

public class UserAlreadyExistsException extends RuntimeException {

	// Constructor
    public UserAlreadyExistsException(String message) {
        super(message);
    }

    public UserAlreadyExistsException(String message, Throwable cause) {
        super(message, cause);
    }
}
