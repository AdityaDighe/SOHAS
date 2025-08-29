package com.demo.health.exception;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class GlobalExceptionHandler {

	// Exception Handler for Doctor Not Found and responding with message and status
	@ExceptionHandler(UserNotFoundException.class)
	public ResponseEntity<Map<String, Object>> handleDoctorNotFound(UserNotFoundException ex) {
		Map<String, Object> errorBody = new HashMap<>();
		errorBody.put("status", "error");
		errorBody.put("message", ex.getMessage());
		return new ResponseEntity<>(errorBody, HttpStatus.NOT_FOUND);
	}

	// Exception handling for bean validation and showing at frontEnd the validation
	// errors
	@ExceptionHandler(MethodArgumentNotValidException.class)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> handleValidationExceptions(MethodArgumentNotValidException ex) {
		Map<String, Object> errors = new HashMap<>();

		// collect field-specific errors
		ex.getBindingResult().getFieldErrors()
				.forEach(error -> errors.put(error.getField(), error.getDefaultMessage()));

		// wrap in response
		Map<String, Object> response = new HashMap<>();
		response.put("status", "error");
		response.put("errors", errors);

		return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
	}
	
	@ExceptionHandler(DuplicateEmailException.class)
    @ResponseBody
    public ResponseEntity<Map<String, String>> handleDuplicateEmail(DuplicateEmailException ex) {
        return ResponseEntity.badRequest().body(Map.of("email", ex.getMessage()));
    }
	
	@ExceptionHandler(TimeException.class)
	@ResponseBody
	public ResponseEntity<Map<String, String>> handleTimeException(TimeException ex) {
	    return ResponseEntity.badRequest().body(Map.of("endTime", ex.getMessage()));
	}
	
	@ExceptionHandler(Exception.class)
	public String handleGlobalException(Exception ex, Model model) {
		model.addAttribute("errorMessage", "Something went wrong! Please try again later.");
		model.addAttribute("details", ex.getMessage()); // optional: remove in production
		return "error"; // this will forward to /WEB-INF/views/error.jsp
	}
}
