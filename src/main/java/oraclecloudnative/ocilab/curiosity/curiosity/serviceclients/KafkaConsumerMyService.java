package oraclecloudnative.ocilab.curiosity.curiosity.serviceclients;

import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

@Service
public class KafkaConsumerMyService {

    @KafkaListener(topics = "myTopicCuriosity2", groupId = "myGroupCuriosity2")
    public void listen(String message) {
        System.out.println("Received Message: " + message);
    }


    @KafkaListener(topics = "myTopicCuriosity2", groupId = "myGroupCuriosity2")
    public void listen2(String message) {
        System.out.println("Received Message: " + message);
    }
}
