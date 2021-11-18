package oraclecloudnative.ocilab.curiosity.curiosity.serviceclients;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import lombok.extern.slf4j.Slf4j;
import oraclecloudnative.ocilab.curiosity.curiosity.QueryPage;
import oraclecloudnative.ocilab.curiosity.curiosity.SentQueryPageDTO;

@Slf4j
@Service
public class ChampionshipServiceClient {

    private final RestTemplate restTemplate;
    private final String championshipHostUrl;

    public ChampionshipServiceClient(final RestTemplateBuilder builder,
                                     @Value("${service.championship.host}") final String championshipHostUrl) {
        restTemplate = builder.build();
        this.championshipHostUrl = championshipHostUrl;
    }

    public boolean sendAttempt(final QueryPage queryPage) {
        try {
            SentQueryPageDTO dto = new SentQueryPageDTO(queryPage.getId(), 
            queryPage.getUser().getId(), queryPage.getOriginalQuery(),
             queryPage.getQuery(), queryPage.getUser().getUserName());

            ResponseEntity<String> r = restTemplate.postForEntity(
                    championshipHostUrl + "/championship", dto,
                    String.class);
            log.info("Championship service response: {}", r.getStatusCode());
            return r.getStatusCode().is2xxSuccessful();
        } catch (Exception e) {
            log.error("There was a problem sending the query page.", e);
            return false;
        }
    }
    
}
