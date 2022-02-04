package oraclecloudnative.ocilab.curiosity.curiosity.serviceclients;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.oracle.bmc.ConfigFileReader;
import com.oracle.bmc.auth.ConfigFileAuthenticationDetailsProvider;
import com.oracle.bmc.streaming.StreamClient;
import com.oracle.bmc.streaming.model.PutMessagesDetailsEntry;
import com.oracle.bmc.streaming.model.PutMessagesDetails;
import com.oracle.bmc.streaming.requests.PutMessagesRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;


import lombok.extern.slf4j.Slf4j;
import oraclecloudnative.ocilab.curiosity.curiosity.QueryPage;
import oraclecloudnative.ocilab.curiosity.curiosity.SentQueryPageEvent;

/*
*
*Publish QueryPage objects to OCIStreaming QueryPage Stream 
*
*/
@Slf4j
@Service
public class ChampionshipServicePublisher {


    //these should be passed in the future through application.properties
    private String streamEndpoint;
    private String UTF16;
    private String streamId ;



    
    public ChampionshipServicePublisher(@Value("${oci.config.stream.endpoint}") final String ociConfigStreamEndpoint, 
                                        @Value("${oci.config.stream.id}") final String ociConfigStreamId) {
        
        this.UTF16 = "UTF-8";
        this.streamEndpoint = ociConfigStreamEndpoint;
        this.streamId = ociConfigStreamId;

    }


    private StreamClient prepareOCICall() {


        /*
        *
        * Use this to authenticate through Instance Principals inside OCI
        *
        */
        //InstancePrincipalsAuthenticationDetailsProvider provider = InstancePrincipalsAuthenticationDetailsProvider.builder().build(); 
        //IdentityClient identityClient = new IdentityClient(provider);
         /*
        *
        *
        */

        
        log.info("Using DEFAULT profile from the default OCI configuration file ($HOME/.oci/config)");
        try {
            var configFile = ConfigFileReader.parseDefault();
            var ociAuthProvider = new ConfigFileAuthenticationDetailsProvider(configFile);
            log.info("Preparing OCI API clients (for Streaming)");	
            return StreamClient.builder().endpoint(streamEndpoint).build(ociAuthProvider);
        } catch (IOException e) {
            log.error("Error preparing OCI Call");		
            e.printStackTrace();
        }
           
        return null;
     }

     private SentQueryPageEvent buildEvent(final QueryPage queryPage){
                return new SentQueryPageEvent(queryPage.getId(), 
                                      queryPage.getUser().getId(), 
                                      queryPage.getUser().getUserName(), 
                                      queryPage.getOriginalQuery(),
                                      queryPage.getQuery());

     }

     public void publishMessageToStream(QueryPage queryPage) //challengeSolved
            throws UnsupportedEncodingException {

                SentQueryPageEvent event = buildEvent(queryPage);

                StreamClient streamClient = this.prepareOCICall();

                ObjectMapper objectMapper = new ObjectMapper();
                   
                  String queryPageAsString = "init_value";
                  try {
                      queryPageAsString = objectMapper.writeValueAsString(event);
                  } catch (JsonProcessingException e) {
                       log.error("Error trying to transform object QueryPage into String with objectMapper");
                        e.printStackTrace();
                  }


        // Prepare PutMessagesDetails
        var messages = new ArrayList<PutMessagesDetailsEntry>();
						for (int i = 0; i < 1; i++) { //use the loop to publish multiple messages
							messages.add(
									PutMessagesDetailsEntry.builder()
											.key(String.format("messageKey-%s",  queryPage.getId()).getBytes(UTF16))
											//.value(String.format("messageValue-%s", i).getBytes(UTF16))
											.value(String.format(queryPageAsString).getBytes(UTF16))
											.build());
						}

        var putMessagesDetails = PutMessagesDetails.builder().messages(messages).build();
        
        // Put message to the stream
        // https://docs.oracle.com/en-us/iaas/api/#/en/streaming/20180418/Message/PutMessages
        var putMessagesRequest = PutMessagesRequest.builder()
                                    .streamId(streamId)
                                    .putMessagesDetails(putMessagesDetails)
                                    .build();
        var putMessagesResponse = streamClient.putMessages(putMessagesRequest);
        var putMessagesResponseCode = putMessagesResponse.get__httpStatusCode__();
        if(putMessagesResponseCode!=200) {
            log.error("PutObject failed - HTTP {}", putMessagesResponseCode);
            System.exit(1);
        }
        log.info("Successfully published the message to the stream");
    }


    
}
