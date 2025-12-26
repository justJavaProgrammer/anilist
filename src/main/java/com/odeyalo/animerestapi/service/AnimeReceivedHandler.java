package com.odeyalo.animerestapi.service;

import com.google.cloud.pubsub.v1.Subscriber;
import com.google.cloud.spring.pubsub.core.PubSubTemplate;
import com.google.cloud.spring.pubsub.support.BasicAcknowledgeablePubsubMessage;
import com.odeyalo.animerestapi.entity.Anime;
import com.odeyalo.animerestapi.repository.AnimeRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;
import tools.jackson.databind.json.JsonMapper;

import java.util.function.Consumer;

@Component
public final class AnimeReceivedHandler implements ApplicationRunner {

    private final AnimeRepository animeRepository;
    private final PubSubTemplate gcpPubSubTemplate;
    private final JsonMapper objectMapper;
    private final Logger logger = LoggerFactory.getLogger(AnimeReceivedHandler.class);

    public AnimeReceivedHandler(final AnimeRepository animeRepository,
                                final PubSubTemplate gcpPubSubTemplate,
                                final JsonMapper objectMapper) {
        this.animeRepository = animeRepository;
        this.gcpPubSubTemplate = gcpPubSubTemplate;
        this.objectMapper = objectMapper;
    }

    @Override
    public void run(final ApplicationArguments args) throws Exception {

        final String subscriptionName = "created";

        Subscriber subscriber =
                gcpPubSubTemplate.subscribe(
                        subscriptionName,
                        consumerImpl()
                );
    }

    private Consumer<BasicAcknowledgeablePubsubMessage> consumerImpl() {
        return message -> {

            final Payload payload = objectMapper.readValue(
                    message.getPubsubMessage().getData().toByteArray(),
                    Payload.class
            );

            animeRepository.save(
                    new Anime(payload.name, payload.description)
            );
            message.ack();

        };
    }

    public record Payload(
            String name,
            String description
    ) {
    }
}
