-- ============================================================================
-- HACARITAMA - BASELINE DDL (Flyway V1)
-- PostgreSQL 14+
-- Origen: database/schema_v2.sql con ajustes de auditoría y reglas adicionales
-- =========================================================================

-- Limpieza segura en desarrollo (no se ejecuta en prod)
-- DROP SCHEMA public CASCADE; CREATE SCHEMA public;

-- Tipos enumerados
DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'document_type_enum') THEN
        CREATE TYPE document_type_enum AS ENUM ('CC', 'TI', 'CE', 'PASAPORTE');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'employee_type_enum') THEN
        CREATE TYPE employee_type_enum AS ENUM ('DRIVER', 'ADMIN', 'OTHER');
    END IF;
END $$;

-- Función utilitaria: actualizar columna updated_at
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- State
CREATE TABLE IF NOT EXISTS state (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- City
CREATE TABLE IF NOT EXISTS city (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    state_id INTEGER NOT NULL REFERENCES state(id) ON DELETE RESTRICT,
    CONSTRAINT uq_city_name_state UNIQUE (name, state_id)
);
CREATE INDEX IF NOT EXISTS idx_city_state ON city(state_id);

-- State Trip
CREATE TABLE IF NOT EXISTS state_trip (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- State Vehicle
CREATE TABLE IF NOT EXISTS state_vehicle (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- State Passage
CREATE TABLE IF NOT EXISTS state_passage (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Vehicle
CREATE TABLE IF NOT EXISTS vehicle (
    id SERIAL PRIMARY KEY,
    plate VARCHAR(10) NOT NULL UNIQUE,
    model VARCHAR(50) NOT NULL,
    capacity INTEGER NOT NULL,
    state_vehicle_id INTEGER NOT NULL REFERENCES state_vehicle(id) ON DELETE RESTRICT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_vehicle_plate CHECK (plate ~* '^[A-Z]{3}[0-9]{3}$'),
    CONSTRAINT chk_vehicle_capacity CHECK (capacity BETWEEN 10 AND 60)
);
CREATE INDEX IF NOT EXISTS idx_vehicle_plate ON vehicle(plate);
CREATE INDEX IF NOT EXISTS idx_vehicle_state ON vehicle(state_vehicle_id);
CREATE TRIGGER trg_vehicle_updated_at
BEFORE UPDATE ON vehicle FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- Route
CREATE TABLE IF NOT EXISTS route (
    id SERIAL PRIMARY KEY,
    price DECIMAL(10,2) NOT NULL,
    origin_city_id INTEGER NOT NULL REFERENCES city(id) ON DELETE RESTRICT,
    destination_city_id INTEGER NOT NULL REFERENCES city(id) ON DELETE RESTRICT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_route_price CHECK (price > 0),
    CONSTRAINT chk_route_different_cities CHECK (origin_city_id <> destination_city_id),
    CONSTRAINT uq_route_origin_destination UNIQUE (origin_city_id, destination_city_id)
);
CREATE INDEX IF NOT EXISTS idx_route_origin ON route(origin_city_id);
CREATE INDEX IF NOT EXISTS idx_route_destination ON route(destination_city_id);
CREATE TRIGGER trg_route_updated_at
BEFORE UPDATE ON route FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- Restricción: Solo rutas Ábrego ↔ Ocaña
CREATE OR REPLACE FUNCTION validate_abrego_ocana_route()
RETURNS TRIGGER AS $$
DECLARE
    o_name TEXT; d_name TEXT;
BEGIN
    SELECT c1.name, c2.name INTO o_name, d_name
    FROM city c1, city c2
    WHERE c1.id = NEW.origin_city_id AND c2.id = NEW.destination_city_id;

    IF NOT ((o_name ILIKE 'Ábrego' AND d_name ILIKE 'Ocaña') OR (o_name ILIKE 'Ocaña' AND d_name ILIKE 'Ábrego')) THEN
        RAISE EXCEPTION 'Solo se permiten rutas entre Ábrego y Ocaña';
    END IF;
    RETURN NEW;
END; $$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_validate_abrego_ocana_route ON route;
CREATE TRIGGER trg_validate_abrego_ocana_route
BEFORE INSERT OR UPDATE ON route
FOR EACH ROW EXECUTE FUNCTION validate_abrego_ocana_route();

-- Employee base
CREATE TABLE IF NOT EXISTS employee (
    code VARCHAR(20) PRIMARY KEY,
    name_1 VARCHAR(50) NOT NULL,
    name_2 VARCHAR(50),
    last_name_1 VARCHAR(50) NOT NULL,
    last_name_2 VARCHAR(50),
    phone VARCHAR(20) NOT NULL,
    employee_type employee_type_enum NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_employee_phone CHECK (phone ~* '^\+?[0-9]{7,15}$')
);
CREATE INDEX IF NOT EXISTS idx_employee_type ON employee(employee_type);
CREATE TRIGGER trg_employee_updated_at
BEFORE UPDATE ON employee FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- Driver
CREATE TABLE IF NOT EXISTS driver (
    employee_code VARCHAR(20) PRIMARY KEY REFERENCES employee(code) ON DELETE CASCADE,
    license VARCHAR(20) NOT NULL UNIQUE,
    date_license DATE NOT NULL,
    CONSTRAINT chk_driver_license_valid CHECK (date_license > CURRENT_DATE)
);
CREATE INDEX IF NOT EXISTS idx_driver_license ON driver(license);

-- Admin
CREATE TABLE IF NOT EXISTS admin (
    employee_code VARCHAR(20) PRIMARY KEY REFERENCES employee(code) ON DELETE CASCADE,
    access VARCHAR(100) NOT NULL
);

-- Other employee
CREATE TABLE IF NOT EXISTS other_employee (
    employee_code VARCHAR(20) PRIMARY KEY REFERENCES employee(code) ON DELETE CASCADE
);

-- Passenger
CREATE TABLE IF NOT EXISTS passenger (
    document_passenger VARCHAR(20) PRIMARY KEY,
    id VARCHAR(20) NOT NULL UNIQUE,
    name_1 VARCHAR(50) NOT NULL,
    name_2 VARCHAR(50),
    last_name_1 VARCHAR(50) NOT NULL,
    last_name_2 VARCHAR(50),
    phone VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_passenger_phone CHECK (phone ~* '^\+?[0-9]{7,15}$')
);
CREATE INDEX IF NOT EXISTS idx_passenger_id ON passenger(id);
CREATE TRIGGER trg_passenger_updated_at
BEFORE UPDATE ON passenger FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- Trip (con seats_available)
CREATE TABLE IF NOT EXISTS trip (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    departure_time TIME NOT NULL,
    state_trip_id INTEGER NOT NULL REFERENCES state_trip(id) ON DELETE RESTRICT,
    route_id INTEGER NOT NULL REFERENCES route(id) ON DELETE RESTRICT,
    vehicle_plate VARCHAR(10) NOT NULL REFERENCES vehicle(plate) ON DELETE RESTRICT,
    driver_code VARCHAR(20) NOT NULL REFERENCES driver(employee_code) ON DELETE RESTRICT,
    seats_available INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_trip_vehicle_date_time UNIQUE (vehicle_plate, date, departure_time)
);
CREATE INDEX IF NOT EXISTS idx_trip_date ON trip(date);
CREATE INDEX IF NOT EXISTS idx_trip_route ON trip(route_id);
CREATE INDEX IF NOT EXISTS idx_trip_vehicle ON trip(vehicle_plate);
CREATE INDEX IF NOT EXISTS idx_trip_driver ON trip(driver_code);
CREATE INDEX IF NOT EXISTS idx_trip_state ON trip(state_trip_id);
CREATE TRIGGER trg_trip_updated_at
BEFORE UPDATE ON trip FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- Inicializar seats_available al crear viaje
CREATE OR REPLACE FUNCTION init_trip_seats_available()
RETURNS TRIGGER AS $$
DECLARE v_capacity INTEGER; BEGIN
    SELECT capacity INTO v_capacity FROM vehicle WHERE plate = NEW.vehicle_plate;
    NEW.seats_available := v_capacity;
    RETURN NEW;
END; $$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS trg_init_trip_seats_available ON trip;
CREATE TRIGGER trg_init_trip_seats_available
BEFORE INSERT ON trip FOR EACH ROW EXECUTE FUNCTION init_trip_seats_available();

-- NEW (novedades)
CREATE TABLE IF NOT EXISTS new (
    id SERIAL PRIMARY KEY,
    date_change DATE NOT NULL DEFAULT CURRENT_DATE,
    motive TEXT NOT NULL,
    vehicle_plate VARCHAR(10) NOT NULL REFERENCES vehicle(plate) ON DELETE RESTRICT,
    driver_code VARCHAR(20) NOT NULL REFERENCES driver(employee_code) ON DELETE RESTRICT,
    trip_date DATE NOT NULL
);

-- Passage
CREATE TABLE IF NOT EXISTS passage (
    line_item INTEGER NOT NULL,
    purchase_date DATE NOT NULL DEFAULT CURRENT_DATE,
    trip_id INTEGER NOT NULL REFERENCES trip(id) ON DELETE RESTRICT,
    state_passage_id INTEGER NOT NULL REFERENCES state_passage(id) ON DELETE RESTRICT,
    passenger_document VARCHAR(20) NOT NULL REFERENCES passenger(document_passenger) ON DELETE RESTRICT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (line_item, trip_id)
);
CREATE INDEX IF NOT EXISTS idx_passage_trip ON passage(trip_id);
CREATE INDEX IF NOT EXISTS idx_passage_passenger ON passage(passenger_document);
CREATE INDEX IF NOT EXISTS idx_passage_state ON passage(state_passage_id);
CREATE INDEX IF NOT EXISTS idx_passage_date ON passage(purchase_date);
CREATE TRIGGER trg_passage_updated_at
BEFORE UPDATE ON passage FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- Passage Detail
CREATE TABLE IF NOT EXISTS passage_detail (
    id_detail SERIAL PRIMARY KEY,
    seat_number INTEGER NOT NULL,
    price_paid DECIMAL(10,2) NOT NULL,
    passage_line_item INTEGER NOT NULL,
    passage_trip_id INTEGER NOT NULL,
    CONSTRAINT chk_passage_detail_seat CHECK (seat_number > 0),
    CONSTRAINT chk_passage_detail_price CHECK (price_paid > 0),
    CONSTRAINT uq_passage_detail_trip_seat UNIQUE (passage_trip_id, seat_number),
    FOREIGN KEY (passage_line_item, passage_trip_id)
        REFERENCES passage(line_item, trip_id) ON DELETE CASCADE
);
CREATE INDEX IF NOT EXISTS idx_passage_detail_passage ON passage_detail(passage_line_item, passage_trip_id);

-- VALIDACIONES Y REGLAS
-- 1) Validar capacidad y asiento existente
CREATE OR REPLACE FUNCTION validate_vehicle_capacity()
RETURNS TRIGGER AS $$
DECLARE v_capacity INTEGER; v_sold_seats INTEGER; BEGIN
    SELECT v.capacity INTO v_capacity
    FROM trip t INNER JOIN vehicle v ON t.vehicle_plate = v.plate
    WHERE t.id = NEW.passage_trip_id;

    SELECT COUNT(*) INTO v_sold_seats
    FROM passage_detail WHERE passage_trip_id = NEW.passage_trip_id;

    IF v_sold_seats >= v_capacity THEN
        RAISE EXCEPTION 'No hay asientos disponibles. Capacidad: %, Vendidos: %', v_capacity, v_sold_seats;
    END IF;
    IF NEW.seat_number > v_capacity THEN
        RAISE EXCEPTION 'El asiento % no existe. Capacidad del vehículo: %', NEW.seat_number, v_capacity;
    END IF;
    RETURN NEW;
END; $$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS trg_validate_vehicle_capacity ON passage_detail;
CREATE TRIGGER trg_validate_vehicle_capacity
BEFORE INSERT ON passage_detail FOR EACH ROW EXECUTE FUNCTION validate_vehicle_capacity();

-- 2) No vender si viaje En Curso/Finalizado/Cancelado
CREATE OR REPLACE FUNCTION validate_trip_state_for_sale()
RETURNS TRIGGER AS $$
DECLARE v_state_name VARCHAR(50); BEGIN
    SELECT st.name INTO v_state_name
    FROM trip t INNER JOIN state_trip st ON t.state_trip_id = st.id
    WHERE t.id = NEW.trip_id;
    IF v_state_name IN ('En Curso','Finalizado','Cancelado') THEN
        RAISE EXCEPTION 'No se puede vender un pasaje para un viaje %', v_state_name;
    END IF;
    RETURN NEW;
END; $$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS trg_validate_trip_state_for_sale ON passage;
CREATE TRIGGER trg_validate_trip_state_for_sale
BEFORE INSERT ON passage FOR EACH ROW EXECUTE FUNCTION validate_trip_state_for_sale();

-- 3) Actualizar seats_available al vender/anular (insert/delete de detalle)
CREATE OR REPLACE FUNCTION dec_trip_seats_available()
RETURNS TRIGGER AS $$ BEGIN
    UPDATE trip SET seats_available = seats_available - 1, updated_at = NOW()
    WHERE id = NEW.passage_trip_id; RETURN NEW; END; $$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION inc_trip_seats_available()
RETURNS TRIGGER AS $$ BEGIN
    UPDATE trip SET seats_available = seats_available + 1, updated_at = NOW()
    WHERE id = OLD.passage_trip_id; RETURN OLD; END; $$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS trg_dec_trip_seats_available ON passage_detail;
CREATE TRIGGER trg_dec_trip_seats_available
AFTER INSERT ON passage_detail FOR EACH ROW EXECUTE FUNCTION dec_trip_seats_available();
DROP TRIGGER IF EXISTS trg_inc_trip_seats_available ON passage_detail;
CREATE TRIGGER trg_inc_trip_seats_available
AFTER DELETE ON passage_detail FOR EACH ROW EXECUTE FUNCTION inc_trip_seats_available();

-- 4) Si el pasaje se anula, liberar asiento(s)
CREATE OR REPLACE FUNCTION on_passage_state_change()
RETURNS TRIGGER AS $$
DECLARE s_anulado_id INTEGER; BEGIN
    SELECT id INTO s_anulado_id FROM state_passage WHERE name ILIKE 'Anulado' LIMIT 1;
    IF NEW.state_passage_id = s_anulado_id AND OLD.state_passage_id <> s_anulado_id THEN
        -- liberar asientos del detalle
        DELETE FROM passage_detail WHERE passage_line_item = NEW.line_item AND passage_trip_id = NEW.trip_id;
    END IF;
    RETURN NEW;
END; $$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS trg_on_passage_state_change ON passage;
CREATE TRIGGER trg_on_passage_state_change
AFTER UPDATE ON passage FOR EACH ROW EXECUTE FUNCTION on_passage_state_change();

-- SEED BÁSICO
INSERT INTO state (name) VALUES ('Norte de Santander') ON CONFLICT DO NOTHING;

-- Ciudades base
INSERT INTO city (name, state_id)
SELECT 'Ábrego', s.id FROM state s WHERE s.name='Norte de Santander'
ON CONFLICT DO NOTHING;
INSERT INTO city (name, state_id)
SELECT 'Ocaña', s.id FROM state s WHERE s.name='Norte de Santander'
ON CONFLICT DO NOTHING;

-- Estados de viaje
INSERT INTO state_trip (name) VALUES ('Programado') ON CONFLICT DO NOTHING;
INSERT INTO state_trip (name) VALUES ('En Curso') ON CONFLICT DO NOTHING;
INSERT INTO state_trip (name) VALUES ('Finalizado') ON CONFLICT DO NOTHING;
INSERT INTO state_trip (name) VALUES ('Cancelado') ON CONFLICT DO NOTHING;

-- Estados de vehículo (activo/inactivo compatibles)
INSERT INTO state_vehicle (name) VALUES ('Disponible') ON CONFLICT DO NOTHING;
INSERT INTO state_vehicle (name) VALUES ('En Servicio') ON CONFLICT DO NOTHING;
INSERT INTO state_vehicle (name) VALUES ('Mantenimiento') ON CONFLICT DO NOTHING;
INSERT INTO state_vehicle (name) VALUES ('Inactivo') ON CONFLICT DO NOTHING;

-- Estados de pasaje (Pagado/Cancelado/Usado mapeados)
INSERT INTO state_passage (name) VALUES ('Activo') ON CONFLICT DO NOTHING;
INSERT INTO state_passage (name) VALUES ('Anulado') ON CONFLICT DO NOTHING;
INSERT INTO state_passage (name) VALUES ('Usado') ON CONFLICT DO NOTHING;

-- FIN V1
