package com.hacaritama.reservaspasajes.repository;

import com.hacaritama.reservaspasajes.model.City;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CityRepository extends JpaRepository<City, Long> {
    List<City> findByStateId(Long stateId);
}
