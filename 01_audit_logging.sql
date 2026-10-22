
USE security_lab;

CREATE TABLE IF NOT EXISTS students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS audit_log (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tbl VARCHAR(64),
    op VARCHAR(10),
    old_row JSON,
    new_row JSON,
    changed_by VARCHAR(288) DEFAULT (CURRENT_USER()),
    at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER trg_students_insert
AFTER INSERT ON students
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (tbl, op, old_row, new_row)
    VALUES (
        'students', 'INSERT', NULL,
        JSON_OBJECT('id', NEW.id, 'name', NEW.name)
    );
END$$

CREATE TRIGGER trg_students_update
AFTER UPDATE ON students
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (tbl, op, old_row, new_row)
    VALUES (
        'students', 'UPDATE',
        JSON_OBJECT('id', OLD.id, 'name', OLD.name),
        JSON_OBJECT('id', NEW.id, 'name', NEW.name)
    );
END$$

CREATE TRIGGER trg_students_delete
AFTER DELETE ON students
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (tbl, op, old_row, new_row)
    VALUES (
        'students', 'DELETE',
        JSON_OBJECT('id', OLD.id, 'name', OLD.name), NULL
    );
END$$

DELIMITER ;

-- Test the audit triggers
INSERT INTO students (name) VALUES ('Kofi');

UPDATE students
SET name = 'Kofi M.'
WHERE id = 1;

SELECT * FROM audit_log;
