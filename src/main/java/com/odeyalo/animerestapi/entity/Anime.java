package com.odeyalo.animerestapi.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.proxy.HibernateProxy;
import org.jspecify.annotations.Nullable;

import java.util.Objects;

@Entity
@Table(name = "animes")
@Getter
@Setter
@ToString
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Anime {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Nullable
    Integer id;
    @Column(name = "name", nullable = false)
    String name;
    @Column(name = "description")
    String description;

    @Override
    public final boolean equals(final Object o) {
        if ( this == o ) return true;
        if ( o == null ) return false;
        Class<?> oEffectiveClass = o instanceof HibernateProxy ? ((HibernateProxy) o).getHibernateLazyInitializer().getPersistentClass() : o.getClass();
        Class<?> thisEffectiveClass = this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass() : this.getClass();
        if ( thisEffectiveClass != oEffectiveClass ) return false;
        final Anime anime = (Anime) o;
        return getId() != null && Objects.equals(getId(), anime.getId());
    }

    @Override
    public final int hashCode() {
        return this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass().hashCode() : getClass().hashCode();
    }
}
