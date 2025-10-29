-- V2: Add password column required by JPA Admin entity
ALTER TABLE admin
ADD COLUMN IF NOT EXISTS password VARCHAR(255);
