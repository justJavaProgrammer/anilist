package com.odeyalo.animerestapi.entity;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Entity
@Table(name = "animes")
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Anime {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;
    @Column(name = "name", nullable = false)
    String name;
    @Column(name = "description")
    String description;
}
