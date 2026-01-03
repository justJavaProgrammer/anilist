package com.odeyalo.animerestapi.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public final class GlobalExceptionHandler {

    @ExceptionHandler(AnimeNotFoundException.class)
    public ResponseEntity<?> handleException(AnimeNotFoundException ex){
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body("Anime with this id does not exist");
    }
}
