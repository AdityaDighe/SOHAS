package com.demo.health.exception;

public class DuplicateEmailException extends RuntimeException{
	public DuplicateEmailException(String message) {
		super(message);
	}
}

