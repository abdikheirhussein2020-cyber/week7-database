
USE security_lab;

-- Create a table to track schema migration versions.
CREATE TABLE IF NOT EXISTS schema_migrations (
    version INT PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Migration V1: Add SKU to products.
CREATE TABLE IF NOT EXISTS products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- Apply V1 only if it has not already been recorded.
SET @v1_exists = (
    SELECT COUNT(*) FROM schema_migrations WHERE version = 1
);

SET @sql_v1 = IF(
    @v1_exists = 0,
    'ALTER TABLE products ADD COLUMN sku VARCHAR(50) NULL',
    'SELECT ''Migration V1 already recorded'' AS message'
);

PREPARE migration_v1 FROM @sql_v1;
EXECUTE migration_v1;
DEALLOCATE PREPARE migration_v1;

INSERT IGNORE INTO schema_migrations (version, description)
VALUES (1, 'Add SKU column to products');

-- Migration V2: Add creation timestamp.
SET @v2_exists = (
    SELECT COUNT(*) FROM schema_migrations WHERE version = 2
);

SET @sql_v2 = IF(
    @v2_exists = 0,
    'ALTER TABLE products ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP',
    'SELECT ''Migration V2 already recorded'' AS message'
);

PREPARE migration_v2 FROM @sql_v2;
EXECUTE migration_v2;
DEALLOCATE PREPARE migration_v2;

INSERT IGNORE INTO schema_migrations (version, description)
VALUES (2, 'Add creation timestamp to products');

-- Verify applied migrations.
SELECT * FROM schema_migrations ORDER BY version;
DESCRIBE products;
