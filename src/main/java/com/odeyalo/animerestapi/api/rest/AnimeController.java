package com.odeyalo.animerestapi.api.rest;

import com.odeyalo.animerestapi.entity.Anime;
import com.odeyalo.animerestapi.exception.AnimeNotFoundException;
import com.odeyalo.animerestapi.repository.AnimeRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/animes")
public class AnimeController {

    private final AnimeRepository animeRepository;

    public AnimeController(final AnimeRepository animeRepository) {
        this.animeRepository = animeRepository;
    }

    @GetMapping
    public List<Anime> getAnime() {
        return animeRepository.findAll();
    }

    @GetMapping("/{id}")
    public Anime getAnime(@PathVariable Integer id) {
        return animeRepository.findById(id)
                .orElseThrow(AnimeNotFoundException::new);
    }
}
