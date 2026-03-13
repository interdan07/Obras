# Guía de Instalación - Módulo de Bancos

## Requisitos Previos
- Microsoft Office 2010 o superior
- Access habilitado para ejecutar macros y módulos VB
- Permisos de lectura/escritura en la carpeta del proyecto

## Pasos de Instalación

### 1. Descarga del Proyecto
```bash
git clone https://github.com/interdan07/obras.git
cd obras
```

### 2. Crear la Base de Datos

#### Opción A: Usando el archivo .accdb proporcionado
1. Ve a la carpeta `BaseDatos/`
2. Abre `ObrasBancos.accdb` con Microsoft Access
3. La base de datos ya contiene todas las tablas configuradas

#### Opción B: Crear las tablas manualmente
1. Abre Microsoft Access
2. Crea una nueva base de datos
3. Accede a la pestaña "Herramientas de Base de Datos"
4. Abre el "Editor de Consultas"
5. Copia y ejecuta el contenido de `BaseDatos/CrearTablas.sql`

### 3. Importar Módulos VB

1. Abre la base de datos en Access
2. Ve a la pestaña "Base de Datos" → "Objetos" → "Módulos"
3. Haz clic derecho → "Importar Módulos"
4. Selecciona los archivos .bas de la carpeta `Modulos/`:
   - `mdbCuentas.bas`
   - `mdbTransacciones.bas`
   - `mdbReportes.bas`

### 4. Crear Formularios

1. En Access, ve a "Crear" → "Diseño de Formulario"
2. Importa los formularios desde la carpeta `Formularios/` o
3. Crea manualmente los formularios según la documentación

### 5. Configurar Reportes

1. Ve a "Crear" → "Diseño de Informe"
2. Importa los reportes desde la carpeta `Reportes/`
3. Configura las fuentes de datos según sea necesario

## Configuración Inicial

### Crear Primer Banco
1. Abre el formulario `frmBancos`
2. Ingresa el nombre del banco
3. Guarda los cambios

### Crear Primera Cuenta
1. Abre el formulario `frmCuentas`
2. Selecciona el banco
3. Ingresa el número de cuenta
4. Define el saldo inicial
5. Guarda los cambios

## Pruebas Básicas

1. **Crear una Cuenta**
   ```vb
   Call AgregarCuenta("123456789", "Banco Ejemplo", "Corriente", 1000)
   ```

2. **Registrar un Depósito**
   ```vb
   Call RegistrarDeposito(1, 500, "Depósito inicial")
   ```

3. **Registrar un Retiro**
   ```vb
   Call RegistrarRetiro(1, 200, "Retiro en cajero automático")
   ```

## Solución de Problemas

### Error: "No se puede ejecutar el macro"
- Habilita macros en Access: Archivo → Opciones → Centro de Confianza

### Error: "Tabla no encontrada"
- Verifica que todas las tablas hayan sido creadas correctamente

### Error de conexión a base de datos
- Cierra todos los archivos abiertos
- Reinicia Access
- Verifica los permisos de archivo

## Documentación Adicional

Para más información, consulta:
- [GUIA_USUARIO.md](./GUIA_USUARIO.md) - Manual de uso del sistema
- [DICCIONARIO_DATOS.md](./DICCIONARIO_DATOS.md) - Descripción de tablas y campos