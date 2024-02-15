package oraclecloudnative.ocilab.curiosity.curiosity.serviceclients;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class KafkaProducerMyService {

    @Autowired
    private KafkaTemplate<String, String> kafkaTemplate;

    private ObjectMapper objectMapper = new ObjectMapper();

    public void sendMessage(String message) {
        kafkaTemplate.send("myTopicCuriosity2", message);
    }

    public void sendMessage2(Object object) {
        try {
            String message = objectMapper.writeValueAsString(object);
            kafkaTemplate.send("myTopicCuriosity2", message);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
    }
}
// Path: src/main/java/cloudnative/kafka/producer/ProducerApplication.java