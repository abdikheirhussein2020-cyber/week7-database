
USE security_lab;

-- Create roles.
CREATE ROLE IF NOT EXISTS app_read;
CREATE ROLE IF NOT EXISTS app_write;

-- Read-only role.
GRANT SELECT ON security_lab.students TO app_read;
GRANT SELECT ON security_lab.categories TO app_read;
GRANT SELECT ON security_lab.products TO app_read;

-- Write role: can modify business data.
GRANT SELECT, INSERT, UPDATE, DELETE
ON security_lab.students TO app_write;

GRANT SELECT, INSERT, UPDATE, DELETE
ON security_lab.categories TO app_write;

GRANT SELECT, INSERT, UPDATE, DELETE
ON security_lab.products TO app_write;

-- Create a lab user with a unique password.
CREATE USER IF NOT EXISTS 'api'@'localhost'
IDENTIFIED BY 'Replace_With_Your_Own_Strong_Password_2026!';

GRANT app_write TO 'api'@'localhost';

SET DEFAULT ROLE app_write TO 'api'@'localhost';

-- Verify permissions.
SHOW GRANTS FOR app_read;
SHOW GRANTS FOR app_write;
SHOW GRANTS FOR 'api'@'localhost';
