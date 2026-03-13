-- Script de creación de tablas para el módulo de bancos
-- Ejecutar en Microsoft Access

-- Tabla de Bancos
CREATE TABLE tblBancos (
    ID AUTOINCREMENT PRIMARY KEY,
    NombreBanco TEXT(100) NOT NULL,
    CodigoBanco TEXT(10) UNIQUE,
    Contacto TEXT(100),
    Telefono TEXT(20),
    FechaCreacion DATETIME DEFAULT NOW()
);

-- Tabla de Cuentas Bancarias
CREATE TABLE tblCuentasBancarias (
    ID AUTOINCREMENT PRIMARY KEY,
    NumeroCuenta TEXT(50) UNIQUE NOT NULL,
    NombreBanco TEXT(100) NOT NULL,
    Saldo CURRENCY DEFAULT 0,
    TipoCuenta TEXT(50),
    FechaCreacion DATETIME DEFAULT NOW(),
    Estado TEXT(20) DEFAULT 'Activa',
    CONSTRAINT chk_saldo CHECK (Saldo >= 0)
);

-- Tabla de Transacciones
CREATE TABLE tblTransacciones (
    ID AUTOINCREMENT PRIMARY KEY,
    IDCuenta LONG NOT NULL,
    TipoTransaccion TEXT(20) NOT NULL,
    Monto CURRENCY NOT NULL,
    Fecha DATETIME DEFAULT NOW(),
    Descripcion TEXT(255),
    SaldoResultante CURRENCY,
    FOREIGN KEY (IDCuenta) REFERENCES tblCuentasBancarias(ID),
    CONSTRAINT chk_monto CHECK (Monto > 0)
);

-- Índices para optimización
CREATE INDEX idx_cuenta ON tblCuentasBancarias(NumeroCuenta);
CREATE INDEX idx_transaccion_cuenta ON tblTransacciones(IDCuenta);
CREATE INDEX idx_transaccion_fecha ON tblTransacciones(Fecha);
CREATE INDEX idx_transaccion_tipo ON tblTransacciones(TipoTransaccion);

-- Relaciones
-- La relación entre tblTransacciones y tblCuentasBancarias se define con FOREIGN KEY arriba