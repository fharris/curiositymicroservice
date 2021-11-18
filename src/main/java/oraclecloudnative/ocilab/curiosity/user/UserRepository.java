package oraclecloudnative.ocilab.curiosity.user;

import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends CrudRepository<User, Long> {
    Optional<User> findByUserName(final String userName);
    
    List<User> findAllByIdIn(final List<Long> ids);
}
