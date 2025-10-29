package com.hacaritama.reservaspasajes.domain;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "passenger")
public class Passenger {

    @Id
    @Column(name = "document_passenger", length = 20)
    private String documentPassenger;

    @Column(name = "id", nullable = false, unique = true, length = 20)
    private String identification;

    @Column(name = "name_1", nullable = false, length = 50)
    private String name1;

    @Column(name = "name_2", length = 50)
    private String name2;

    @Column(name = "last_name_1", nullable = false, length = 50)
    private String lastName1;

    @Column(name = "last_name_2", length = 50)
    private String lastName2;

    @Column(name = "phone", nullable = false, length = 20)
    private String phone;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    public void prePersist() {
        createdAt = LocalDateTime.now();
        updatedAt = createdAt;
    }

    @PreUpdate
    public void preUpdate() {
        updatedAt = LocalDateTime.now();
    }

    public String getDocumentPassenger() { return documentPassenger; }
    public void setDocumentPassenger(String documentPassenger) { this.documentPassenger = documentPassenger; }

    public String getIdentification() { return identification; }
    public void setIdentification(String identification) { this.identification = identification; }

    public String getName1() { return name1; }
    public void setName1(String name1) { this.name1 = name1; }

    public String getName2() { return name2; }
    public void setName2(String name2) { this.name2 = name2; }

    public String getLastName1() { return lastName1; }
    public void setLastName1(String lastName1) { this.lastName1 = lastName1; }

    public String getLastName2() { return lastName2; }
    public void setLastName2(String lastName2) { this.lastName2 = lastName2; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
