package oraclecloudnative.ocilab.curiosity.curiosity;

import lombok.Value;

@Value
public class SentQueryPageEvent {
    Long queryPageid;
    Long userId;
    String userName;
    String originalQuery;
    String query;
}
