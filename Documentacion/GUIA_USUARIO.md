# Guía de Usuario - Módulo de Bancos

## Introducción

El Módulo de Bancos es una herramienta integral para gestionar cuentas bancarias, realizar transacciones y generar reportes financieros. Esta guía te ayudará a utilizar todas las funcionalidades del sistema.

## Tabla de Contenidos
1. [Interfaz Principal](#interfaz-principal)
2. [Gestión de Cuentas](#gestión-de-cuentas)
3. [Transacciones Bancarias](#transacciones-bancarias)
4. [Generación de Reportes](#generación-de-reportes)
5. [Preguntas Frecuentes](#preguntas-frecuentes)

---

## Interfaz Principal

Al abrir el módulo, verás la pantalla principal con los siguientes elementos:

- **Menú Principal**: Acceso a todas las funcionalidades
- **Panel de Cuentas**: Lista de cuentas bancarias activas
- **Panel de Transacciones**: Historial de transacciones recientes
- **Botones de Acción**: Crear, editar, eliminar

---

## Gestión de Cuentas

### Crear una Nueva Cuenta

1. Haz clic en el botón **"+ Agregar Cuenta"**
2. Se abrirá el formulario `frmAgregarCuenta`
3. Completa los siguientes campos:
   - **Número de Cuenta**: Identificador único (ej: 123456789)
   - **Nombre del Banco**: Selecciona de la lista o ingresa uno nuevo
   - **Tipo de Cuenta**: Corriente, Ahorro, etc.
   - **Saldo Inicial**: Cantidad de dinero inicial

4. Haz clic en **"Guardar"**

### Editar una Cuenta

1. Selecciona una cuenta de la lista
2. Haz clic en **"Editar"**
3. Modifica los campos necesarios
4. Haz clic en **"Guardar"**

### Desactivar una Cuenta

1. Selecciona una cuenta de la lista
2. Haz clic en **"Desactivar"**
3. Confirma la acción

**Nota**: Las cuentas no se eliminan, solo se desactivan para mantener el historial.

### Consultar Saldo

1. Abre el formulario **"Consultar Saldo"**
2. Selecciona una cuenta de la lista
3. El saldo actual se mostrará automáticamente

---

## Transacciones Bancarias

### Realizar un Depósito

1. Haz clic en **"Nueva Transacción"**
2. Selecciona **"Depósito"** como tipo
3. Selecciona la cuenta a depositar
4. Ingresa el monto
5. Añade una descripción (opcional)
6. Haz clic en **"Confirmar"**

### Realizar un Retiro

1. Haz clic en **"Nueva Transacción"**
2. Selecciona **"Retiro"** como tipo
3. Selecciona la cuenta
4. Ingresa el monto (no puede exceder el saldo disponible)
5. Añade una descripción (opcional)
6. Haz clic en **"Confirmar"**

### Realizar una Transferencia

1. Haz clic en **"Nueva Transacción"**
2. Selecciona **"Transferencia"** como tipo
3. Selecciona la cuenta de origen
4. Selecciona la cuenta de destino
5. Ingresa el monto
6. Haz clic en **"Confirmar"**

### Ver Historial de Transacciones

1. Abre el formulario **"Historial de Transacciones"**
2. Selecciona una cuenta
3. Define un rango de fechas (opcional)
4. Haz clic en **"Filtrar"**
5. Se mostrarán todas las transacciones realizadas

---

## Generación de Reportes

### Estado de Cuenta

1. Ve a **"Reportes"** → **"Estado de Cuenta"**
2. Selecciona la cuenta
3. Define el período (inicio y fin)
4. Haz clic en **"Generar"**
5. Opcionalmente, exporta a PDF o Excel

### Movimientos por Cuenta

1. Ve a **"Reportes"** → **"Movimientos"**
2. Selecciona la cuenta
3. Define el rango de fechas
4. Haz clic en **"Generar"**

### Resumen de Transacciones

1. Ve a **"Reportes"** → **"Resumen"**
2. Selecciona el tipo de transacción (Deposito, Retiro, Transferencia)
3. Define el período
4. Haz clic en **"Generar"**

### Exportar Reportes

Todos los reportes pueden exportarse en los siguientes formatos:
- **PDF**: Para visualizar e imprimir
- **Excel**: Para análisis adicional

---

## Preguntas Frecuentes

### ¿Qué ocurre si intento hacer un retiro mayor al saldo disponible?

El sistema lo impedirá y mostrará un mensaje de error indicando "Fondos insuficientes".

### ¿Puedo recuperar una transacción eliminada?

No, las transacciones no se pueden eliminar. El sistema mantiene un historial completo por razones de auditoría.

### ¿Qué información se incluye en el "Estado de Cuenta"?

El estado de cuenta incluye:
- Saldo inicial del período
- Todas las transacciones realizadas
- Saldo final del período
- Suma de depósitos y retiros

### ¿Cómo cambio de banco?

1. Abre **"Configuración"** → **"Bancos"**
2. Agrega un nuevo banco
3. Crea cuentas asociadas al nuevo banco

### ¿Hay un límite de transacciones por cuenta?

No hay límite de transacciones. El sistema está diseñado para manejar miles de transacciones sin problemas de rendimiento.

### ¿Qué significa "Cuenta Activa" vs "Inactiva"?

- **Activa**: Puede recibir transacciones
- **Inactiva**: No se muestra en listados regulares pero mantiene su historial

---

## Soporte

Para reportar problemas o solicitar ayuda:
1. Contacta al administrador del sistema
2. Proporciona detalles específicos del problema
3. Incluye capturas de pantalla si es necesario

---

**Última actualización**: 2026-03-13