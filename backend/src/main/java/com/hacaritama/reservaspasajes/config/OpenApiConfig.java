package com.hacaritama.reservaspasajes.config;

import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import org.springdoc.core.models.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import io.swagger.v3.oas.models.OpenAPI;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI hacaritamaOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("Hacaritama API")
                        .description("API REST para gestión de pasajes intermunicipales")
                        .version("v1.0.0")
                        .license(new License().name("MIT"))
                );
    }

    @Bean
    public GroupedOpenApi publicApi() {
        return GroupedOpenApi.builder()
                .group("public")
                .pathsToMatch("/api/**")
                .build();
    }
}
