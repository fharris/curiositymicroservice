package oraclecloudnative.ocilab.curiosity.curiosity.configuration;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfiguration implements WebMvcConfigurer{
    @Override
    public void addCorsMappings(final CorsRegistry registry) {
        registry.addMapping("/**").allowedOrigins("*").allowedHeaders("*");
       //registry.addMapping("/**").allowedOrigins("http://132.226.199.186/"); //consider admiting only origins from the LoadBalancer or Ingress Controller
    }
}
