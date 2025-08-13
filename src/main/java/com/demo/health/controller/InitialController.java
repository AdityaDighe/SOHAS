package com.demo.health.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class InitialController {
	@RequestMapping("/")
	public String start() {
		return "signup";
	}
}