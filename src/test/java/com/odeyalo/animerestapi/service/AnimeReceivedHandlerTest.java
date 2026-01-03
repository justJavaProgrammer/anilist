package com.odeyalo.animerestapi.service;

import org.junit.jupiter.api.Test;
import tools.jackson.databind.json.JsonMapper;

import static org.junit.jupiter.api.Assertions.*;

class AnimeReceivedHandlerTest {

    @Test
    void name() {
        final String json = """  
                {"name": "Kuroko: Basketball", "description": "Just a funny stuff about teenagers and basketball"}
                """;

        AnimeReceivedHandler.Payload payload = new JsonMapper().readValue(json, AnimeReceivedHandler.Payload.class);

        System.out.println(payload);
    }
}