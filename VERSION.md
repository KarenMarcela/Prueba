# Control de Versiones - Sistema Hacaritama

## 📌 Versión Actual: 0.1.0

**Fecha de Release:** 25 de Enero, 2025  
**Estado:** En Desarrollo  
**Branch:** develop

---

## 🎯 Estrategia de Versionado

Este proyecto utiliza **Semantic Versioning 2.0.0** (SemVer):

```
MAJOR.MINOR.PATCH

Ejemplo: 1.2.3
```

### Incremento de Versiones

- **MAJOR (X.0.0):** Cambios incompatibles en la API
- **MINOR (0.X.0):** Nueva funcionalidad compatible con versiones anteriores
- **PATCH (0.0.X):** Corrección de bugs compatible con versiones anteriores

---

## 📅 Roadmap de Versiones

### v0.1.0 - Sprint 0 (Actual) ✅
**Fecha:** Enero 2025  
**Objetivo:** Configuración inicial del proyecto

- [x] Estructura de carpetas
- [x] Configuración de Git Flow
- [x] Setup de frontend (React + Vite)
- [x] Setup de backend (Spring Boot)
- [x] Conexión a PostgreSQL
- [x] Documentación base

---

### v0.2.0 - Sprint 1 🔄
**Fecha Estimada:** Febrero 2025  
**Objetivo:** Base de datos y modelos

**Backend:**
- [ ] Scripts DDL de base de datos
- [ ] Entidades JPA (Pasajero, Ruta, Vehículo, Conductor, Viaje, Venta, Pasaje)
- [ ] Repositorios Spring Data
- [ ] Configuración de Flyway/Liquibase para migraciones

**Frontend:**
- [ ] Diseño de mockups en Figma
- [ ] Componentes base (Button, Input, Card, Modal)
- [ ] Sistema de diseño (colores, tipografía, espaciado)

**DevOps:**
- [ ] Scripts de inicialización de BD
- [ ] Docker Compose para desarrollo local

---

### v0.3.0 - Sprint 2
**Fecha Estimada:** Febrero 2025  
**Objetivo:** Autenticación y autorización

**Backend:**
- [ ] Implementación de Spring Security
- [ ] Generación y validación de JWT
- [ ] Endpoints de autenticación (login, register, refresh)
- [ ] Control de roles (CLIENTE, SECRETARIA, ADMIN)

**Frontend:**
- [ ] Páginas de Login y Registro
- [ ] Context API para manejo de autenticación
- [ ] Protected Routes
- [ ] Interceptor de Axios para JWT

---

### v0.4.0 - Sprint 3
**Fecha Estimada:** Marzo 2025  
**Objetivo:** Gestión de pasajeros

**Backend:**
- [ ] CRUD completo de pasajeros
- [ ] Validaciones de negocio
- [ ] Búsqueda y filtrado

**Frontend:**
- [ ] Listado de pasajeros
- [ ] Formulario de registro/edición
- [ ] Búsqueda y paginación

---

### v0.5.0 - Sprint 4
**Fecha Estimada:** Marzo 2025  
**Objetivo:** Gestión de rutas y vehículos

**Backend:**
- [ ] CRUD de rutas
- [ ] CRUD de vehículos
- [ ] Validación de capacidad de asientos

**Frontend:**
- [ ] Gestión de rutas (admin)
- [ ] Gestión de vehículos (admin)
- [ ] Visualización de flota

---

### v0.6.0 - Sprint 5
**Fecha Estimada:** Abril 2025  
**Objetivo:** Gestión de conductores y programación de viajes

**Backend:**
- [ ] CRUD de conductores
- [ ] CRUD de viajes
- [ ] Asignación de conductor y vehículo a viaje
- [ ] Validación de disponibilidad

**Frontend:**
- [ ] Gestión de conductores
- [ ] Programación de viajes
- [ ] Calendario de viajes

---

### v0.7.0 - Sprint 6
**Fecha Estimada:** Abril 2025  
**Objetivo:** Búsqueda y visualización de viajes

**Backend:**
- [ ] Endpoint de búsqueda de viajes (origen, destino, fecha)
- [ ] Endpoint de disponibilidad de asientos
- [ ] Lógica de asientos ocupados/disponibles

**Frontend:**
- [ ] Buscador de viajes
- [ ] Listado de resultados
- [ ] Visualización de asientos (mapa visual)

---

### v0.8.0 - Sprint 7-8
**Fecha Estimada:** Mayo 2025  
**Objetivo:** Sistema de reserva y venta de pasajes

**Backend:**
- [ ] Endpoint de creación de venta
- [ ] Endpoint de creación de pasaje
- [ ] Validación de asiento único por viaje
- [ ] Trigger de actualización de asientos disponibles
- [ ] Endpoint de anulación de pasaje

**Frontend:**
- [ ] Flujo de compra (selección de asiento → datos → pago)
- [ ] Componente de selección visual de asientos
- [ ] Confirmación de compra
- [ ] Visualización de pasaje

---

### v0.9.0 - Sprint 9
**Fecha Estimada:** Mayo 2025  
**Objetivo:** Integraciones externas

**Backend:**
- [ ] Integración con pasarela de pagos (MercadoPago/PayU)
- [ ] Servicio de envío de emails (SMTP)
- [ ] Generación de PDF de pasajes (iText/JasperReports)

**Frontend:**
- [ ] Integración de formulario de pago
- [ ] Confirmación de pago
- [ ] Descarga de pasaje en PDF

---

### v1.0.0 - Sprint 10-11 🎯
**Fecha Estimada:** Junio 2025  
**Objetivo:** Release de producción

**Backend:**
- [ ] Sistema de reportes (ventas, ocupación, ingresos)
- [ ] Optimización de consultas
- [ ] Documentación de API (Swagger/OpenAPI)

**Frontend:**
- [ ] Dashboard de administrador
- [ ] Reportes visuales (gráficos)
- [ ] Optimización de rendimiento
- [ ] PWA (Progressive Web App)

**DevOps:**
- [ ] Deploy en producción (Render/Railway + Vercel)
- [ ] Configuración de CI/CD
- [ ] Monitoreo y logs

**Testing:**
- [ ] Tests unitarios (>80% cobertura)
- [ ] Tests de integración
- [ ] Tests E2E
- [ ] UAT (User Acceptance Testing)

---

## 🏷️ Convención de Tags en Git

```bash
# Formato de tags
v0.1.0          # Release estable
v0.1.0-alpha    # Pre-release (desarrollo)
v0.1.0-beta     # Beta testing
v0.1.0-rc.1     # Release candidate

# Crear tag
git tag -a v0.1.0 -m "Release v0.1.0: Configuración inicial"
git push origin v0.1.0

# Listar tags
git tag -l
```

---

## 📊 Historial de Versiones

| Versión | Fecha | Descripción | Branch |
|---------|-------|-------------|--------|
| 0.1.0 | 2025-01-25 | Configuración inicial del proyecto | develop |

---

## 🔄 Workflow de Release

1. **Desarrollo en `feature/` branches**
2. **Merge a `develop`** cuando la feature está completa
3. **Testing en `develop`**
4. **Crear `release/vX.Y.Z` branch** desde develop
5. **Testing final y bug fixes** en release branch
6. **Merge a `main`** y crear tag
7. **Merge back a `develop`**

---

## 📝 Notas

- Cada sprint dura **2 semanas**
- Las versiones MINOR (0.X.0) corresponden a sprints completados
- Las versiones PATCH (0.0.X) son hotfixes
- La versión 1.0.0 será el release de producción
