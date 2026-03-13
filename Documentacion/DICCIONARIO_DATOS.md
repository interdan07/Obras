# Diccionario de Datos - Módulo de Bancos

## Tabla: tblBancos

| Campo | Tipo | Descripción | Restricciones |
|-------|------|-------------|---------------|
| ID | AutoIncrement | Identificador único del banco | PK, AutoIncrement |
| NombreBanco | Text(100) | Nombre del banco | NOT NULL |
| CodigoBanco | Text(10) | Código de identificación del banco | UNIQUE |
| Contacto | Text(100) | Contacto principal del banco | Opcional |
| Telefono | Text(20) | Teléfono de contacto | Opcional |
| FechaCreacion | DateTime | Fecha de registro | Default: NOW() |

### Ejemplo de Datos:
```
ID: 1, NombreBanco: Banco Nacional, CodigoBanco: BN001, Telefono: 555-1234
```

---

## Tabla: tblCuentasBancarias

| Campo | Tipo | Descripción | Restricciones |
|-------|------|-------------|---------------|
| ID | AutoIncrement | Identificador único de la cuenta | PK, AutoIncrement |
| NumeroCuenta | Text(50) | Número de cuenta bancaria | UNIQUE, NOT NULL |
| NombreBanco | Text(100) | Nombre del banco asociado | NOT NULL |
| Saldo | Currency | Saldo actual de la cuenta | CHECK: >= 0 |
| TipoCuenta | Text(50) | Tipo de cuenta (Corriente/Ahorro) | Opcional |
| FechaCreacion | DateTime | Fecha de creación de la cuenta | Default: NOW() |
| Estado | Text(20) | Estado de la cuenta (Activa/Inactiva) | Default: 'Activa' |

### Tipos de Cuenta Válidos:
- Corriente
- Ahorro
- Tarjeta de Crédito
- Depósito a Plazo

### Ejemplo de Datos:
```
ID: 1, NumeroCuenta: 123456789, NombreBanco: Banco Nacional, 
Saldo: 5000.00, TipoCuenta: Corriente, Estado: Activa
```

---

## Tabla: tblTransacciones

| Campo | Tipo | Descripción | Restricciones |
|-------|------|-------------|---------------|
| ID | AutoIncrement | Identificador único de la transacción | PK, AutoIncrement |
| IDCuenta | Long | Referencia a la cuenta bancaria | FK, NOT NULL |
| TipoTransaccion | Text(20) | Tipo de transacción | NOT NULL |
| Monto | Currency | Monto de la transacción | CHECK: > 0 |
| Fecha | DateTime | Fecha y hora de la transacción | Default: NOW() |
| Descripcion | Text(255) | Descripción de la transacción | Opcional |
| SaldoResultante | Currency | Saldo de la cuenta después de la transacción | Opcional |

### Tipos de Transacción Válidos:
- Deposito
- Retiro
- Transferencia
- Pago
- Interés
- Comisión

### Ejemplo de Datos:
```
ID: 1, IDCuenta: 1, TipoTransaccion: Deposito, Monto: 500.00,
Fecha: 2026-03-13 10:30:45, SaldoResultante: 5500.00
```

---

## Relaciones entre Tablas

### tblTransacciones → tblCuentasBancarias
- **Relación**: Muchos a Uno (Many-to-One)
- **Campo Foráneo**: IDCuenta
- **Campo Referenciado**: tblCuentasBancarias.ID
- **Integridad Referencial**: Activa

---

## Índices para Optimización

```sql
CREATE INDEX idx_cuenta ON tblCuentasBancarias(NumeroCuenta);
CREATE INDEX idx_transaccion_cuenta ON tblTransacciones(IDCuenta);
CREATE INDEX idx_transaccion_fecha ON tblTransacciones(Fecha);
CREATE INDEX idx_transaccion_tipo ON tblTransacciones(TipoTransaccion);
```

Estos índices mejoran la velocidad de búsqueda y filtrado de datos.

---

## Restricciones y Validaciones

### tblCuentasBancarias
- El saldo no puede ser negativo
- El número de cuenta debe ser único
- El nombre del banco es obligatorio

### tblTransacciones
- El monto debe ser mayor a cero
- La transacción debe estar asociada a una cuenta válida
- La fecha se registra automáticamente

---

## Consultas Útiles

### Obtener saldo actual de una cuenta:
```sql
SELECT Saldo FROM tblCuentasBancarias WHERE ID = 1;
```

### Obtener historial de transacciones:
```sql
SELECT * FROM tblTransacciones WHERE IDCuenta = 1 ORDER BY Fecha DESC;
```

### Obtener resumen de transacciones por tipo:
```sql
SELECT TipoTransaccion, SUM(Monto) as Total 
FROM tblTransacciones 
WHERE IDCuenta = 1 
GROUP BY TipoTransaccion;
```

### Obtener cuentas activas:
```sql
SELECT * FROM tblCuentasBancarias WHERE Estado = 'Activa';
```
