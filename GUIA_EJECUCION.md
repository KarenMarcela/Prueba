# 🚀 Guía de Ejecución del Proyecto Hacaritama

## 📋 Índice
1. [Ver Mockups](#-parte-1-ver-mockups)
2. [Ejecutar el Proyecto](#-parte-2-ejecutar-el-proyecto)
3. [Verificar Funcionamiento](#-parte-3-verificar-funcionamiento)
4. [Solución de Problemas](#-parte-4-solución-de-problemas)

---

## 🎨 PARTE 1: Ver Mockups

### Mockups Disponibles

Los mockups están documentados en formato wireframe (texto). Para visualizarlos mejor:

#### 📱 Mockups de Cliente

**1. Página de Inicio**
```
┌─────────────────────────────────────────────┐
│  [LOGO HACARITAMA]    [Iniciar Sesión]     │
├─────────────────────────────────────────────┤
│                                             │
│     🚌 VIAJA SEGURO CON HACARITAMA         │
│   Reserva tu pasaje online en 3 pasos      │
│                                             │
│  ┌───────────────────────────────────────┐ │
│  │ [Origen] [Destino] [Fecha] [Buscar]  │ │
│  └───────────────────────────────────────┘ │
│                                             │
│  📌 RUTAS POPULARES                        │
│  [Ábrego → Cúcuta] [Cúcuta → Ábrego]     │
│                                             │
└─────────────────────────────────────────────┘
```

**2. Búsqueda de Viajes**
```
┌─────────────────────────────────────────────┐
│  Ábrego → Cúcuta | 25 Ene 2025            │
├─────────────────────────────────────────────┤
│                                             │
│  🚌 06:00 AM → 08:30 AM                    │
│  Asientos disponibles: 28/40               │
│  Precio: $18.000                           │
│  [Seleccionar Asiento]                     │
│                                             │
│  🚌 09:00 AM → 11:30 AM                    │
│  Asientos disponibles: 12/30               │
│  Precio: $15.000                           │
│  [Seleccionar Asiento]                     │
│                                             │
└─────────────────────────────────────────────┘
```

**3. Selección de Asiento**
```
┌─────────────────────────────────────────────┐
│  SELECCIONA TU ASIENTO                     │
│  💺 Disponible  🔴 Ocupado  ✅ Seleccionado│
├─────────────────────────────────────────────┤
│           🚗 CONDUCTOR                      │
│  ┌─────────────────────────────────────┐   │
│  │ [1💺][2💺]  PASILLO  [3💺][4💺]     │   │
│  │ [5🔴][6💺]           [7💺][8💺]     │   │
│  │ [9💺][10💺]          [11💺][12🔴]   │   │
│  │ [13💺][14✅]         [15💺][16💺]   │   │
│  └─────────────────────────────────────┘   │
│                                             │
│  Asiento: 14 | Precio: $18.000            │
│  [Continuar con la compra →]               │
└─────────────────────────────────────────────┘
```

#### 🖥️ Mockups de Administración

**4. Dashboard Admin**
```
┌─────────────────────────────────────────────┐
│  [☰] HACARITAMA ADMIN    [👤 Admin]        │
├──────┬──────────────────────────────────────┤
│      │ DASHBOARD                            │
│ 📊   │ ┌──────┐ ┌──────┐ ┌──────┐         │
│Inicio│ │Ventas│ │Pasajes│ │Ingresos│       │
│      │ │ 45   │ │ 1,234 │ │$22.5M │       │
│ 🚌   │ └──────┘ └──────┘ └──────┘         │
│Viajes│                                      │
│      │ 📊 VENTAS DE LA SEMANA              │
│ 🚗   │ [Gráfico de barras]                 │
│Vehíc.│                                      │
│      │ 🚌 VIAJES DE HOY                    │
│ 👨‍✈️  │ • 06:00 Ábrego→Cúcuta [EN CURSO]   │
│Conduc│ • 09:00 Cúcuta→Ábrego [PROGRAMADO] │
└──────┴──────────────────────────────────────┘
```

### 📂 Ver Mockups Completos

Los mockups completos están en:
- **Archivo:** `docs/MOCKUPS.md`
- **Ubicación:** `c:\Users\USUARIO\CascadeProjects\Proyecto_Hacaritama_web\docs\MOCKUPS.md`

**Para verlos:**
```bash
# Abrir con VS Code
code docs/MOCKUPS.md

# O con notepad
notepad docs/MOCKUPS.md
```

### 🎨 Sistema de Diseño

**Colores:**
- Azul Principal: `#1E40AF`
- Naranja Secundario: `#F97316`
- Verde Éxito: `#10B981`
- Rojo Error: `#EF4444`

**Fuentes:**
- Principal: Inter
- Secundaria: Poppins

---

## 🚀 PARTE 2: Ejecutar el Proyecto

### ✅ Pre-requisitos

Antes de comenzar, verifica que tengas instalado:

```bash
# Verificar Node.js (debe ser v18+)
node --version

# Verificar Java (debe ser 17)
java -version

# Verificar Maven
mvn --version

# Verificar PostgreSQL
psql --version

# Verificar Git
git --version
```

Si falta algo, instalar desde:
- Node.js: https://nodejs.org/
- Java 17: https://adoptium.net/
- Maven: https://maven.apache.org/
- PostgreSQL: https://www.postgresql.org/

---

### 📦 PASO 1: Configurar Base de Datos

#### Opción A: Con pgAdmin (Recomendado)

1. **Abrir pgAdmin**
2. **Conectarse a PostgreSQL** (usuario: postgres)
3. **Crear base de datos:**
   - Click derecho en "Databases"
   - "Create" → "Database"
   - Nombre: `hacaritama_db`
   - Click "Save"

4. **Ejecutar script:**
   - Click derecho en `hacaritama_db`
   - "Query Tool"
   - Menú "File" → "Open"
   - Seleccionar: `database/schema_v2.sql`
   - Click "Execute" (F5)

5. **Verificar:**
   ```sql
   -- Debe mostrar 13 tablas
   SELECT table_name FROM information_schema.tables 
   WHERE table_schema = 'public' 
   ORDER BY table_name;
   ```

#### Opción B: Línea de Comandos

```bash
# 1. Crear base de datos
psql -U postgres -c "CREATE DATABASE hacaritama_db;"

# 2. Ejecutar script
psql -U postgres -d hacaritama_db -f database/schema_v2.sql

# 3. Verificar
psql -U postgres -d hacaritama_db -c "\dt"
```

---

### ⚙️ PASO 2: Configurar Backend

#### 1. Navegar al directorio backend

```bash
cd backend
```

#### 2. Configurar variables de entorno

```bash
# Copiar plantilla
copy .env.example .env
```

#### 3. Editar archivo .env

Abrir `.env` y configurar:

```properties
# IMPORTANTE: Cambiar estos valores
DB_HOST=localhost
DB_PORT=5432
DB_NAME=hacaritama_db
DB_USERNAME=postgres
DB_PASSWORD=TU_PASSWORD_AQUI    # ⚠️ CAMBIAR ESTO

# JWT (dejar como está por ahora)
JWT_SECRET=HacaritamaSecretKey2025ChangeThisInProduction
JWT_EXPIRATION=86400000
```

**⚠️ IMPORTANTE:** Reemplaza `TU_PASSWORD_AQUI` con tu contraseña de PostgreSQL.

#### 4. Instalar dependencias

```bash
# Limpiar y compilar (toma 2-3 minutos)
mvn clean install

# Si hay errores, intentar sin tests
mvn clean install -DskipTests
```

#### 5. Ejecutar backend

```bash
mvn spring-boot:run
```

**✅ Verificar:** Deberías ver en la consola:
```
Started ReservasPasajesApplication in X.XXX seconds
```

**🌐 Probar:** Abrir navegador en `http://localhost:8080/api`

---

### 🎨 PASO 3: Configurar Frontend

#### 1. Abrir NUEVA terminal

**⚠️ IMPORTANTE:** Dejar el backend corriendo y abrir una nueva terminal.

```bash
# Navegar al frontend
cd frontend
```

#### 2. Configurar variables de entorno

```bash
# Copiar plantilla
copy .env.example .env
```

El archivo `.env` debe contener:
```properties
VITE_API_URL=http://localhost:8080/api
VITE_ENV=development
```

#### 3. Instalar dependencias

```bash
# Instalar (toma 1-2 minutos)
npm install

# Si hay errores, intentar
npm install --legacy-peer-deps
```

#### 4. Ejecutar frontend

```bash
npm run dev
```

**✅ Verificar:** Deberías ver:
```
  VITE v7.x.x  ready in XXX ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: use --host to expose
```

**🌐 Probar:** Abrir navegador en `http://localhost:5173`

---

## ✅ PARTE 3: Verificar Funcionamiento

### 1. Verificar Backend

Abrir nueva terminal y ejecutar:

```bash
# Probar endpoint de rutas
curl http://localhost:8080/api/rutas

# O con PowerShell
Invoke-WebRequest -Uri http://localhost:8080/api/rutas
```

Debe retornar JSON con las rutas.

### 2. Verificar Frontend

1. Abrir navegador: `http://localhost:5173`
2. Debe cargar la página de inicio
3. Verificar que no hay errores en consola (F12)

### 3. Probar Login (Cuando esté implementado)

**Credenciales de prueba:**
- **Admin:** `admin@hacaritama.com` / `Admin123!`
- **Cliente:** `juan.perez@email.com` / `Cliente123!`

---

## 🐛 PARTE 4: Solución de Problemas

### ❌ Error: "Cannot connect to database"

**Causa:** Backend no puede conectarse a PostgreSQL

**Solución:**
1. Verificar que PostgreSQL esté corriendo:
   ```bash
   # Windows
   Get-Service postgresql*
   ```

2. Verificar password en `backend/.env`

3. Verificar que la BD existe:
   ```bash
   psql -U postgres -l
   ```

---

### ❌ Error: "Port 8080 already in use"

**Causa:** Otro proceso está usando el puerto 8080

**Solución:**
```bash
# Windows - Encontrar proceso
netstat -ano | findstr :8080

# Matar proceso (reemplazar <PID>)
taskkill /PID <PID> /F
```

---

### ❌ Error: "npm ERR! code ELIFECYCLE"

**Causa:** Problemas con node_modules

**Solución:**
```bash
cd frontend
rm -rf node_modules package-lock.json
npm install
```

---

### ❌ Error: "Java version mismatch"

**Causa:** Versión incorrecta de Java

**Solución:**
1. Verificar versión:
   ```bash
   java -version
   ```

2. Debe mostrar "17.x.x"

3. Si es diferente, instalar Java 17 y configurar JAVA_HOME

---

### ❌ Backend compila pero no inicia

**Causa:** Error en application.properties

**Solución:**
1. Verificar `backend/src/main/resources/application.properties`
2. Verificar que las variables de entorno estén bien en `.env`
3. Ver logs completos en la consola

---

### ❌ Frontend muestra página en blanco

**Causa:** Error en el código o API no disponible

**Solución:**
1. Abrir consola del navegador (F12)
2. Ver errores en la pestaña "Console"
3. Verificar que backend esté corriendo
4. Verificar VITE_API_URL en `.env`

---

## 📊 Estado Esperado

Cuando todo esté funcionando correctamente:

### Terminal 1 (Backend):
```
Started ReservasPasajesApplication in 5.234 seconds
```

### Terminal 2 (Frontend):
```
➜  Local:   http://localhost:5173/
```

### Navegador:
- `http://localhost:8080/api` → Responde (puede ser 404, es normal)
- `http://localhost:5173` → Muestra la aplicación

---

## 🎯 Próximos Pasos

Una vez que el proyecto esté corriendo:

1. **Explorar la aplicación**
   - Navegar por las páginas
   - Probar funcionalidades básicas

2. **Revisar código**
   - Backend: `backend/src/main/java/com/hacaritama/reservas/`
   - Frontend: `frontend/src/`

3. **Comenzar desarrollo**
   - Crear feature branch
   - Implementar nueva funcionalidad
   - Hacer commit y push

---

## 📚 Recursos Adicionales

- **Documentación completa:** `docs/`
- **Guía de instalación:** `docs/INSTALLATION.md`
- **Inicio rápido:** `docs/QUICK_START.md`
- **API:** `docs/API_DOCUMENTATION.md`
- **Arquitectura:** `docs/ARQUITECTURA.md`

---

## 📞 Ayuda

Si tienes problemas:
1. Revisar logs en las terminales
2. Consultar `docs/INSTALLATION.md`
3. Buscar el error en Google
4. Contactar al equipo

---

## ✅ Checklist de Verificación

- [ ] PostgreSQL instalado y corriendo
- [ ] Base de datos `hacaritama_db` creada
- [ ] Script `schema_v2.sql` ejecutado
- [ ] 13 tablas creadas en la BD
- [ ] Backend `.env` configurado
- [ ] Backend compila sin errores
- [ ] Backend corriendo en puerto 8080
- [ ] Frontend `.env` configurado
- [ ] Frontend dependencias instaladas
- [ ] Frontend corriendo en puerto 5173
- [ ] Navegador muestra la aplicación
- [ ] No hay errores en consola del navegador

---

**🎉 ¡Listo! El proyecto está corriendo.**

**Última actualización:** 25 de Enero, 2025  
**Equipo:** Keila Vacca & Karen Bayona
