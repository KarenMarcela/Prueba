# Solución Rápida - Problemas Comunes

## ✅ Problema 1: Estilos no cargan (SOLUCIONADO)

El archivo `postcss.config.js` ya está configurado correctamente para Tailwind v4.

**Solución:** Reinicia el servidor de desarrollo del frontend:
```bash
cd frontend
# Detener con Ctrl+C si está corriendo
npm run dev
```

## ❌ Problema 2: Backend no conecta (ERR_CONNECTION_REFUSED en 8080)

### Causa
El backend de Spring Boot no está ejecutándose porque no puede conectarse a PostgreSQL.

### Solución Paso a Paso

#### 1. Verificar si PostgreSQL está instalado

Abre una terminal y ejecuta:
```bash
psql --version
```

Si no está instalado, descárgalo de: https://www.postgresql.org/download/windows/

#### 2. Iniciar PostgreSQL

**Opción A - Desde Servicios de Windows:**
1. Presiona `Win + R`
2. Escribe `services.msc` y presiona Enter
3. Busca el servicio "postgresql-x64-XX" (donde XX es la versión)
4. Click derecho → Iniciar

**Opción B - Desde PowerShell (como Administrador):**
```powershell
# Listar servicios de PostgreSQL
Get-Service | Where-Object {$_.DisplayName -like '*postgres*'}

# Iniciar el servicio (reemplaza con el nombre correcto)
Start-Service postgresql-x64-14
```

#### 3. Crear la base de datos

```bash
# Conectar a PostgreSQL (te pedirá la contraseña)
psql -U postgres

# Dentro de psql, ejecutar:
CREATE DATABASE hacaritama_db;

# Verificar que se creó
\l

# Salir
\q
```

#### 4. Ejecutar los scripts SQL

```bash
# Desde la raíz del proyecto
cd C:\Users\USUARIO\CascadeProjects\Proyecto_Hacaritama_web

# Ejecutar el esquema (te pedirá la contraseña de postgres)
psql -U postgres -d hacaritama_db -f database\schema_v2.sql

# Agregar contraseñas a los administradores
psql -U postgres -d hacaritama_db -f database\add_passwords.sql
```

#### 5. Configurar la contraseña en application.properties

Edita el archivo:
```
backend\src\main\resources\application.properties
```

Cambia la línea de password por tu contraseña de PostgreSQL:
```properties
spring.datasource.password=TU_CONTRASEÑA_AQUI
```

#### 6. Iniciar el backend

```bash
cd backend
.\mvnw spring-boot:run
```

Espera a ver el mensaje:
```
Started ReservasPasajesApplication in X.XXX seconds
```

#### 7. Verificar que funciona

Abre un navegador y ve a:
```
http://localhost:8080/api/trips
```

Deberías ver un JSON con datos de viajes.

## 🎯 Credenciales de Prueba

Una vez que todo esté funcionando:

- **Código:** ADM001
- **Contraseña:** admin123

## 📝 Orden de Ejecución

1. ✅ Iniciar PostgreSQL
2. ✅ Crear base de datos y ejecutar scripts SQL
3. ✅ Iniciar backend (puerto 8080)
4. ✅ Iniciar frontend (puerto 5173)
5. ✅ Abrir navegador en http://localhost:5173

## 🆘 Si PostgreSQL no está instalado

### Instalación Rápida de PostgreSQL en Windows:

1. Descargar: https://www.postgresql.org/download/windows/
2. Ejecutar el instalador
3. Durante la instalación:
   - Puerto: 5432 (por defecto)
   - Contraseña: Elige una y recuérdala
   - Locale: Spanish, Colombia
4. Instalar pgAdmin 4 (incluido)
5. Después de instalar, seguir los pasos del punto 3 en adelante

## 🔍 Verificar que todo funciona

### Backend funcionando:
```bash
curl http://localhost:8080/api/trips
```

### Frontend funcionando:
Abre http://localhost:5173 en el navegador

### Base de datos funcionando:
```bash
psql -U postgres -d hacaritama_db -c "SELECT COUNT(*) FROM employee;"
```

Debería mostrar: `count: 7`
