-- 1. Crear el usuario y otorgar privilegios
CREATE USER IF NOT EXISTS 'test'@'localhost' IDENTIFIED BY '123456';
GRANT ALL PRIVILEGES ON *.* TO 'test'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;

-- 2. Crear la base de datos
CREATE DATABASE IF NOT EXISTS transferencias_banca;
USE transferencias_banca;

CREATE TABLE cuentas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  numero VARCHAR(20) UNIQUE,
  moneda VARCHAR(10),
  saldo DECIMAL(10,2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE transferencias (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cuenta_origen_id INT NOT NULL,
  cuenta_destino_id INT NOT NULL,
  monto DECIMAL(10,2),
  estado VARCHAR(50),
  descripcion VARCHAR(255),
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (cuenta_origen_id) REFERENCES cuentas(id),
  FOREIGN KEY (cuenta_destino_id) REFERENCES cuentas(id)
);

-- 4. Insertar datos de prueba
-- Cuentas
INSERT INTO cuentas (numero, moneda, saldo) VALUES
('001-000001', 'PEN', 10000.00),
('001-000002', 'PEN', 5000.00),
('001-000003', 'USD', 7500.50);

-- Transferencias
INSERT INTO transferencias (cuenta_origen_id, cuenta_destino_id, monto, estado, descripcion) VALUES
(1, 2, 100.00, 'EXITOSA', 'Pago por servicios'),
(2, 1, 50.00, 'EXITOSA', 'Pago por deuda');