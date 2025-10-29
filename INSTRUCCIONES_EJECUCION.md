# Instrucciones de Ejecución - Sistema Hacaritama

## Requisitos Previos

- PostgreSQL 14+
- Java 17+
- Maven 3.8+
- Node.js 18+
- npm o yarn

## Configuración de la Base de Datos

### 1. Crear la base de datos

```bash
# Conectar a PostgreSQL
psql -U postgres

# Crear la base de datos
CREATE DATABASE hacaritama_db;

# Salir
\q
```

### 2. Ejecutar los scripts SQL

```bash
# Ejecutar el esquema principal
psql -U postgres -d hacaritama_db -f database/schema_v2.sql

# Agregar contraseñas a los administradores
psql -U postgres -d hacaritama_db -f database/add_passwords.sql
```

## Backend (Spring Boot)

### 1. Configurar credenciales de base de datos

Editar `backend/src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/hacaritama_db
spring.datasource.username=postgres
spring.datasource.password=TU_CONTRASEÑA
```

### 2. Compilar y ejecutar

```bash
cd backend

# Compilar
mvnw clean install

# Ejecutar
mvnw spring-boot:run
```

El backend estará disponible en: `http://localhost:8080`

## Frontend (React + Vite)

### 1. Instalar dependencias

```bash
cd frontend
npm install
```

### 2. Ejecutar en modo desarrollo

```bash
npm run dev
```

El frontend estará disponible en: `http://localhost:5173`

## Credenciales de Prueba

### Administradores

- **Usuario 1:**
  - Código: `ADM001`
  - Contraseña: `admin123`
  - Nombre: Karen Marcela Bayona Moreno

- **Usuario 2:**
  - Código: `ADM002`
  - Contraseña: `admin123`
  - Nombre: Keila Nathaly Vacca Bacca

## Funcionalidades Implementadas

### ✅ Login
- Autenticación de administradores
- Validación de credenciales
- Gestión de sesión con localStorage
- Diseño con paleta de colores de Hacaritama

### ✅ Dashboard (Página Principal)
- Vista general del sistema
- Navegación a módulos principales
- Lista de viajes disponibles
- Información de asientos disponibles

### ✅ Gestión de Pasajeros
- Registrar nuevos pasajeros
- Listar todos los pasajeros
- Editar información de pasajeros
- Eliminar pasajeros
- Validación de formularios
- Conexión completa con la base de datos

## Paleta de Colores Utilizada

Basada en los logos de COOTRANS Hacaritama:

- **Verde Oscuro**: `#1B5E20` (primary-dark)
- **Verde Medio**: `#4CAF50` (primary)
- **Verde Claro**: `#8BC34A` (primary-light)
- **Amarillo/Dorado**: `#F9A825` (secondary)
- **Naranja**: `#FFA726` (secondary-light)

## Estructura del Proyecto

```
Proyecto_Hacaritama_web/
├── backend/
│   ├── src/main/java/com/hacaritama/reservaspasajes/
│   │   ├── config/          # Configuración de seguridad
│   │   ├── controller/      # Controladores REST
│   │   ├── dto/             # Objetos de transferencia de datos
│   │   ├── model/           # Entidades JPA
│   │   ├── repository/      # Repositorios JPA
│   │   └── service/         # Lógica de negocio
│   └── src/main/resources/
│       └── application.properties
├── frontend/
│   ├── src/
│   │   ├── components/      # Componentes reutilizables
│   │   ├── context/         # Context API (Auth)
│   │   ├── pages/           # Páginas principales
│   │   ├── services/        # API services
│   │   └── App.jsx          # Componente principal
│   └── tailwind.config.js   # Configuración de Tailwind
└── database/
    ├── schema_v2.sql        # Esquema de base de datos
    └── add_passwords.sql    # Script de contraseñas
```

## Endpoints API

### Autenticación
- `POST /api/auth/login` - Iniciar sesión

### Pasajeros
- `GET /api/passengers` - Listar todos los pasajeros
- `GET /api/passengers/{id}` - Obtener pasajero por ID
- `POST /api/passengers` - Crear nuevo pasajero
- `PUT /api/passengers/{id}` - Actualizar pasajero
- `DELETE /api/passengers/{id}` - Eliminar pasajero

### Viajes
- `GET /api/trips` - Listar todos los viajes
- `GET /api/trips/available` - Listar viajes disponibles

## Solución de Problemas

### Error de conexión a la base de datos
- Verificar que PostgreSQL esté ejecutándose
- Verificar credenciales en `application.properties`
- Verificar que la base de datos `hacaritama_db` exista

### Error CORS en el frontend
- Verificar que el backend esté ejecutándose en el puerto 8080
- La configuración CORS ya está habilitada en `SecurityConfig.java`

### Error al compilar el backend
- Verificar versión de Java: `java -version` (debe ser 17+)
- Limpiar y recompilar: `mvnw clean install`

### Error al ejecutar el frontend
- Eliminar `node_modules` y reinstalar: `rm -rf node_modules && npm install`
- Verificar versión de Node: `node -v` (debe ser 18+)
