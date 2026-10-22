MySQL Database Security Lab
Project Description

This project demonstrates audit logging, hierarchical categories, versioned schema changes, and least-privilege database security using MySQL.

Features
Audit logging: Triggers record student inserts, updates, and deletes as JSON.
Category tree: A recursive CTE retrieves parent-child category relationships.
Schema migrations: A migration history table records database schema versions.
Database security: Read and write roles receive different permissions.
Requirements
MySQL 8.0 or later
MySQL Workbench
How to Run
Open MySQL Workbench and connect to your database.
Create or select the security_lab database.
Execute the SQL files in order.
Inspect the audit records, category tree, migration history, and role grants.
Files
01_audit_logging.sql
02_category_tree.sql
03_migrations.sql
04_security_roles.sql
screenshots/
Reflection

The most challenging part of this lab was configuring the audit triggers correctly. I learned how triggers record database changes automatically. I also learned how recursive CTEs represent hierarchical data. MySQL Workbench safe update mode taught me to use primary keys in update conditions. The migration section helped me understand how to track schema changes. The security section showed me why users should receive only the permissions they need. With more time, I would integrate Flyway to automate migrations and add stronger audit log protection.