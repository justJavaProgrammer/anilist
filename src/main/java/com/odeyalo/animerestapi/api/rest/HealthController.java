package com.odeyalo.animerestapi.api.rest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public final class HealthController {

    @GetMapping("/greetings")
    public String greeting(@RequestParam(value = "name", required = false, defaultValue = "World") final String name) {
        return "Hello " + name;
    }

    @GetMapping("/health")
    public String health() {
        return "OK";
    }
}
