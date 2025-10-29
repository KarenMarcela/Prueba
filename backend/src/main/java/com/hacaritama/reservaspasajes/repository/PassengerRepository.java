package com.hacaritama.reservaspasajes.repository;

import com.hacaritama.reservaspasajes.domain.Passenger;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PassengerRepository extends JpaRepository<Passenger, String> {
    Optional<Passenger> findByIdentification(String identification);
    boolean existsByIdentification(String identification);
}
