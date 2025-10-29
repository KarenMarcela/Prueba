# 🤝 Guía de Contribución - Sistema Hacaritama

## 📋 Tabla de Contenidos

1. [Código de Conducta](#código-de-conducta)
2. [¿Cómo Contribuir?](#cómo-contribuir)
3. [Flujo de Trabajo Git](#flujo-de-trabajo-git)
4. [Estándares de Código](#estándares-de-código)
5. [Commits](#commits)
6. [Pull Requests](#pull-requests)
7. [Testing](#testing)

---

## 📜 Código de Conducta

Este proyecto se adhiere a un código de conducta profesional y académico:

- ✅ Ser respetuoso y profesional
- ✅ Aceptar críticas constructivas
- ✅ Enfocarse en lo mejor para el proyecto
- ✅ Mostrar empatía hacia otros miembros del equipo
- ❌ No usar lenguaje ofensivo o inapropiado
- ❌ No realizar ataques personales

---

## 🚀 ¿Cómo Contribuir?

### 1. Configurar el Entorno

```bash
# Clonar el repositorio
git clone https://github.com/Keila2Vacca/Proyecto_Hacaritama_web.git
cd Proyecto_Hacaritama_web

# Instalar dependencias
cd backend && mvn clean install
cd ../frontend && npm install
```

### 2. Crear una Issue (Opcional)

Antes de trabajar en una nueva funcionalidad:
1. Verificar que no exista una issue similar
2. Crear una nueva issue describiendo la funcionalidad o bug
3. Esperar aprobación del Product Owner

### 3. Crear una Rama

```bash
# Actualizar develop
git checkout develop
git pull origin develop

# Crear rama de feature
git checkout -b feature/nombre-descriptivo

# Ejemplos:
git checkout -b feature/auth-jwt
git checkout -b feature/seleccion-asientos
git checkout -b bugfix/corregir-validacion-email
```

---

## 🔀 Flujo de Trabajo Git (Git Flow)

### Estructura de Ramas

```
main (producción)
  └── develop (integración)
       ├── feature/auth-jwt
       ├── feature/gestion-viajes
       ├── bugfix/validacion-email
       └── hotfix/error-critico
```

### Tipos de Ramas

| Tipo | Prefijo | Propósito | Base | Merge a |
|------|---------|-----------|------|---------|
| **Feature** | `feature/` | Nueva funcionalidad | `develop` | `develop` |
| **Bugfix** | `bugfix/` | Corrección de bug | `develop` | `develop` |
| **Hotfix** | `hotfix/` | Corrección urgente | `main` | `main` y `develop` |
| **Release** | `release/` | Preparar release | `develop` | `main` y `develop` |

### Comandos Comunes

```bash
# Crear feature
git checkout develop
git checkout -b feature/mi-feature

# Trabajar en la feature
git add .
git commit -m "feat: descripción del cambio"

# Actualizar con develop (si hay cambios)
git checkout develop
git pull origin develop
git checkout feature/mi-feature
git merge develop

# Subir cambios
git push origin feature/mi-feature

# Crear Pull Request en GitHub
```

---

## 💻 Estándares de Código

### Backend (Java/Spring Boot)

#### Convenciones de Nombres

```java
// Clases: PascalCase
public class PasajeroService { }

// Métodos: camelCase
public Pasajero buscarPorEmail(String email) { }

// Constantes: UPPER_SNAKE_CASE
private static final String JWT_SECRET = "secret";

// Variables: camelCase
private String nombreCompleto;
```

#### Estructura de Paquetes

```
com.hacaritama.reservas/
├── controller/     # REST Controllers
├── service/        # Lógica de negocio
├── repository/     # Acceso a datos
├── model/          # Entidades JPA
├── dto/            # Data Transfer Objects
├── mapper/         # Conversión Entity ↔ DTO
├── security/       # Configuración de seguridad
├── exception/      # Excepciones personalizadas
├── config/         # Configuraciones
└── util/           # Utilidades
```

#### Ejemplo de Controller

```java
@RestController
@RequestMapping("/api/viajes")
@RequiredArgsConstructor
public class ViajeController {
    
    private final ViajeService viajeService;
    
    @GetMapping
    public ResponseEntity<Page<ViajeDTO>> buscarViajes(
            @RequestParam String origen,
            @RequestParam String destino,
            @RequestParam @DateTimeFormat(iso = ISO.DATE) LocalDate fecha,
            Pageable pageable) {
        
        Page<ViajeDTO> viajes = viajeService.buscarViajes(origen, destino, fecha, pageable);
        return ResponseEntity.ok(viajes);
    }
}
```

#### Buenas Prácticas Java

- ✅ Usar Lombok para reducir boilerplate
- ✅ Validar datos con Bean Validation (`@Valid`, `@NotNull`, etc.)
- ✅ Manejar excepciones con `@ControllerAdvice`
- ✅ Usar DTOs para exponer datos (no entidades directamente)
- ✅ Documentar con JavaDoc métodos públicos
- ✅ Escribir tests unitarios (JUnit 5 + Mockito)

---

### Frontend (React/JavaScript)

#### Convenciones de Nombres

```javascript
// Componentes: PascalCase
function BuscarViajes() { }

// Funciones: camelCase
function buscarViajesDisponibles() { }

// Constantes: UPPER_SNAKE_CASE
const API_BASE_URL = 'http://localhost:8080/api';

// Variables: camelCase
const nombrePasajero = 'Juan';
```

#### Estructura de Carpetas

```
src/
├── components/
│   ├── common/         # Botones, Inputs, Cards
│   ├── layout/         # Header, Footer, Sidebar
│   └── features/       # Componentes específicos
├── pages/              # Páginas/Vistas
├── services/           # Llamadas a API
├── hooks/              # Custom hooks
├── context/            # Context API
├── utils/              # Funciones auxiliares
├── assets/             # Imágenes, iconos
└── styles/             # CSS global
```

#### Ejemplo de Componente

```jsx
import React, { useState, useEffect } from 'react';
import { buscarViajes } from '../services/viajeService';

function BuscarViajes() {
  const [viajes, setViajes] = useState([]);
  const [loading, setLoading] = useState(false);
  
  useEffect(() => {
    cargarViajes();
  }, []);
  
  const cargarViajes = async () => {
    setLoading(true);
    try {
      const data = await buscarViajes({ origen: 'Ábrego', destino: 'Cúcuta' });
      setViajes(data);
    } catch (error) {
      console.error('Error al cargar viajes:', error);
    } finally {
      setLoading(false);
    }
  };
  
  return (
    <div className="container">
      {loading ? <Spinner /> : <ViajesList viajes={viajes} />}
    </div>
  );
}

export default BuscarViajes;
```

#### Buenas Prácticas React

- ✅ Usar functional components con hooks
- ✅ Extraer lógica compleja a custom hooks
- ✅ Usar PropTypes o TypeScript para validación
- ✅ Memoizar componentes pesados con `React.memo`
- ✅ Usar Context API para estado global
- ✅ Escribir tests con React Testing Library

---

## 📝 Commits

### Formato de Commit (Conventional Commits)

```
<tipo>(<scope>): <descripción corta>

[cuerpo opcional]

[footer opcional]
```

### Tipos de Commit

| Tipo | Descripción | Ejemplo |
|------|-------------|---------|
| `feat` | Nueva funcionalidad | `feat(auth): agregar login con JWT` |
| `fix` | Corrección de bug | `fix(viajes): corregir validación de fecha` |
| `docs` | Documentación | `docs(readme): actualizar guía de instalación` |
| `style` | Formato de código | `style(frontend): aplicar prettier` |
| `refactor` | Refactorización | `refactor(service): simplificar lógica de búsqueda` |
| `test` | Tests | `test(pasajes): agregar tests unitarios` |
| `chore` | Tareas de mantenimiento | `chore(deps): actualizar dependencias` |

### Ejemplos de Buenos Commits

```bash
# Feature
git commit -m "feat(pasajes): implementar selección de asientos"

# Fix
git commit -m "fix(auth): corregir expiración de token JWT"

# Docs
git commit -m "docs(api): documentar endpoint de ventas"

# Refactor
git commit -m "refactor(viajes): extraer lógica a servicio separado"

# Test
git commit -m "test(conductores): agregar tests de integración"
```

### ❌ Ejemplos de Malos Commits

```bash
# Muy vago
git commit -m "fix bug"

# Sin tipo
git commit -m "agregar validación"

# Demasiado largo
git commit -m "feat: implementar toda la funcionalidad de reserva de pasajes con selección de asientos, validación de disponibilidad, integración con pasarela de pagos y generación de PDF"
```

---

## 🔍 Pull Requests

### Antes de Crear un PR

- ✅ Actualizar rama con `develop`
- ✅ Ejecutar tests: `mvn test` (backend) y `npm test` (frontend)
- ✅ Ejecutar linters: `mvn checkstyle:check` y `npm run lint`
- ✅ Verificar que el código compile sin errores
- ✅ Probar manualmente la funcionalidad

### Crear un Pull Request

1. **Título descriptivo:**
   ```
   feat(auth): Implementar autenticación JWT
   ```

2. **Descripción completa:**
   ```markdown
   ## Descripción
   Implementa sistema de autenticación con JWT para usuarios.
   
   ## Cambios
   - Agregar configuración de Spring Security
   - Crear JwtTokenProvider
   - Implementar endpoints de login y registro
   - Agregar tests unitarios
   
   ## Testing
   - [x] Tests unitarios pasando
   - [x] Tests de integración pasando
   - [x] Probado manualmente
   
   ## Screenshots
   [Adjuntar capturas si aplica]
   
   ## Relacionado
   Closes #15
   ```

3. **Asignar revisores:**
   - Asignar a al menos 1 miembro del equipo
   - Esperar aprobación antes de hacer merge

### Revisión de Código

**Como revisor:**
- ✅ Verificar que el código siga los estándares
- ✅ Probar la funcionalidad localmente
- ✅ Revisar tests
- ✅ Dejar comentarios constructivos
- ✅ Aprobar o solicitar cambios

**Como autor:**
- ✅ Responder a todos los comentarios
- ✅ Hacer cambios solicitados
- ✅ Agradecer feedback constructivo

---

## 🧪 Testing

### Backend (JUnit 5)

```java
@SpringBootTest
class PasajeroServiceTest {
    
    @Autowired
    private PasajeroService pasajeroService;
    
    @Test
    @DisplayName("Debe registrar un nuevo pasajero correctamente")
    void debeRegistrarPasajero() {
        // Arrange
        PasajeroDTO dto = new PasajeroDTO();
        dto.setEmail("test@email.com");
        dto.setNombre("Test");
        
        // Act
        Pasajero pasajero = pasajeroService.registrar(dto);
        
        // Assert
        assertNotNull(pasajero.getId());
        assertEquals("test@email.com", pasajero.getEmail());
    }
}
```

### Frontend (Jest + React Testing Library)

```javascript
import { render, screen, fireEvent } from '@testing-library/react';
import BuscarViajes from './BuscarViajes';

test('debe mostrar resultados al buscar viajes', async () => {
  render(<BuscarViajes />);
  
  const botonBuscar = screen.getByRole('button', { name: /buscar/i });
  fireEvent.click(botonBuscar);
  
  const resultados = await screen.findByText(/viajes disponibles/i);
  expect(resultados).toBeInTheDocument();
});
```

### Cobertura Mínima

- **Backend:** 80% de cobertura
- **Frontend:** 70% de cobertura

```bash
# Backend
mvn test jacoco:report

# Frontend
npm run test:coverage
```

---

## 📚 Recursos Adicionales

- [Git Flow Cheatsheet](https://danielkummer.github.io/git-flow-cheatsheet/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Spring Boot Best Practices](https://spring.io/guides)
- [React Best Practices](https://react.dev/learn)

---

## 💬 Comunicación

- **Daily Standup:** Lunes a Viernes, 9:00 AM
- **Sprint Planning:** Cada 2 semanas
- **Retrospectiva:** Al final de cada sprint
- **Canal de Slack:** #hacaritama-dev
- **Trello:** [Link al board]

---

## ❓ Preguntas

Si tienes dudas:
1. Revisar la documentación en `docs/`
2. Buscar en issues cerradas
3. Preguntar en el canal de Slack
4. Contactar al Scrum Master: Keila Vacca

---

**¡Gracias por contribuir al proyecto Hacaritama! 🚌**
