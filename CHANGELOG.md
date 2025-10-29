# Changelog

Todos los cambios notables en el proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/lang/es/).

## [Unreleased]

### Planeado
- Sistema de autenticación JWT
- Módulo de gestión de pasajeros
- Módulo de gestión de rutas
- Módulo de gestión de vehículos
- Módulo de gestión de conductores
- Sistema de reserva de pasajes
- Selección visual de asientos
- Integración de pagos electrónicos
- Generación de pasajes en PDF
- Sistema de reportes

## [0.1.1] - 2025-01-25

### Agregado
- **Modelo de base de datos v2.0** basado en diseño conceptual del equipo
  - 13 tablas con herencia y normalización completa
  - Herencia de empleados (DRIVER, ADMIN, OTHER)
  - Normalización geográfica (STATE → CITY → ROUTE)
  - Tabla NEW para registro de novedades
  - 3 triggers automáticos para validaciones
  - 2 vistas consolidadas
- `database/schema_v2.sql` - Script DDL completo del nuevo modelo
- `database/MODELO_COMPARACION.md` - Comparación entre modelos
- `database/DIAGRAMA_MODELO.md` - Diagrama visual del modelo

### Modificado
- README.md actualizado con nuevo modelo de datos
- Documentación de arquitectura ajustada

### Notas Técnicas
- El modelo v2.0 cumple con 3FN (Tercera Forma Normal)
- Implementa patrón de herencia Table-per-Type (TPT)
- Incluye todas las entidades del diagrama conceptual original
- Mantiene compatibilidad con requisitos funcionales

## [0.1.0] - 2025-01-25

### Agregado
- Estructura inicial del proyecto
- Configuración de frontend React + Vite + Tailwind CSS
- Configuración de backend Spring Boot + PostgreSQL
- Configuración de Git Flow
- **Documentación completa:**
  - README.md profesional
  - VERSION.md con roadmap de 11 sprints
  - CONTRIBUTING.md con guías de desarrollo
  - PROJECT_SUMMARY.md con resumen ejecutivo
  - docs/ARQUITECTURA.md con arquitectura del sistema
  - docs/API_DOCUMENTATION.md con 30+ endpoints
  - docs/MOCKUPS.md con diseños UI/UX
  - docs/INSTALLATION.md con guía detallada
  - docs/QUICK_START.md para inicio rápido
- **Base de datos inicial:**
  - database/schema.sql (modelo simplificado)
  - database/seed_data.sql con datos de prueba
- Configuración de linters y formatters (ESLint, Prettier)
- Configuración de testing (Jest, JUnit)
- Variables de entorno (.env.example)

### Notas de Desarrollo
- **Sprint:** Sprint 0 - Configuración inicial
- **Equipo:** Keila Vacca (Scrum Master), Karen Bayona (Product Owner)
- **Estado:** Base del proyecto establecida
- **Versión de BD:** 1.0.0 (simplificada) y 2.0.0 (completa)
