-- ============================================================
--  Civil Registry System — Complete Database Schema
--  Run: mysql -u root -p < schema.sql
-- ============================================================
CREATE DATABASE IF NOT EXISTS civil_registry;
USE civil_registry;

CREATE TABLE IF NOT EXISTS users (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(150) NOT NULL,
    email       VARCHAR(150) NOT NULL UNIQUE,
    phone       VARCHAR(10)  NOT NULL,
    password    VARCHAR(255) NOT NULL,
    role        ENUM('citizen','officer','admin') NOT NULL DEFAULT 'citizen',
    is_active   TINYINT(1) NOT NULL DEFAULT 1,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS birth_registration (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    child_name          VARCHAR(150) NOT NULL,
    gender              ENUM('Male','Female','Other') NOT NULL,
    date_of_birth       DATE NOT NULL,
    place_of_birth      VARCHAR(255) NOT NULL,
    father_name         VARCHAR(150) NOT NULL,
    mother_name         VARCHAR(150) NOT NULL,
    address             TEXT NOT NULL,
    contact_email       VARCHAR(150) DEFAULT NULL,
    contact_phone       VARCHAR(10)  DEFAULT NULL,
    doctor_name         VARCHAR(150) DEFAULT NULL,
    hospital_name       VARCHAR(200) DEFAULT NULL,
    proof_filename      VARCHAR(255) DEFAULT NULL,
    proof_original_name VARCHAR(255) DEFAULT NULL,
    user_id             INT NOT NULL,
    status              ENUM('Pending','Approved','Rejected') NOT NULL DEFAULT 'Pending',
    verification_status ENUM('Pending Verification','Verified','Failed') DEFAULT 'Pending Verification',
    verification_note   TEXT DEFAULT NULL,
    verified_by         INT DEFAULT NULL,
    verified_at         DATETIME DEFAULT NULL,
    approved_by         INT DEFAULT NULL,
    approved_at         DATETIME DEFAULT NULL,
    rejection_reason    VARCHAR(500) DEFAULT NULL,
    certificate_no      VARCHAR(40) UNIQUE DEFAULT NULL,
    submitted_at        DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at          DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)     REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (approved_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (verified_by) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS death_registration (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    deceased_name       VARCHAR(150) NOT NULL,
    gender              ENUM('Male','Female','Other') NOT NULL,
    date_of_death       DATE NOT NULL,
    place_of_death      VARCHAR(255) NOT NULL,
    cause_of_death      VARCHAR(255) NOT NULL,
    father_name         VARCHAR(150) NOT NULL,
    mother_name         VARCHAR(150) NOT NULL,
    spouse_name         VARCHAR(150) DEFAULT NULL,
    address             TEXT NOT NULL,
    informant_name      VARCHAR(150) NOT NULL,
    informant_relation  VARCHAR(100) NOT NULL,
    contact_email       VARCHAR(150) DEFAULT NULL,
    contact_phone       VARCHAR(10)  DEFAULT NULL,
    doctor_name         VARCHAR(150) DEFAULT NULL,
    hospital_name       VARCHAR(200) DEFAULT NULL,
    proof_filename      VARCHAR(255) DEFAULT NULL,
    proof_original_name VARCHAR(255) DEFAULT NULL,
    user_id             INT NOT NULL,
    status              ENUM('Pending','Approved','Rejected') NOT NULL DEFAULT 'Pending',
    verification_status ENUM('Pending Verification','Verified','Failed') DEFAULT 'Pending Verification',
    verification_note   TEXT DEFAULT NULL,
    verified_by         INT DEFAULT NULL,
    verified_at         DATETIME DEFAULT NULL,
    approved_by         INT DEFAULT NULL,
    approved_at         DATETIME DEFAULT NULL,
    rejection_reason    VARCHAR(500) DEFAULT NULL,
    certificate_no      VARCHAR(40) UNIQUE DEFAULT NULL,
    submitted_at        DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at          DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)     REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (approved_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (verified_by) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS verification_messages (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    reg_type   ENUM('birth','death') NOT NULL,
    reg_id     INT NOT NULL,
    sender_id  INT NOT NULL,
    message    TEXT NOT NULL,
    is_admin   TINYINT(1) DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS notifications (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT NOT NULL,
    phone      VARCHAR(150) NOT NULL,
    message    TEXT NOT NULL,
    sms_status ENUM('sent','failed','pending') DEFAULT 'pending',
    sent_at    DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS password_resets (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    email      VARCHAR(150) NOT NULL,
    token      VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS audit_log (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT DEFAULT NULL,
    action     VARCHAR(100) NOT NULL,
    table_name VARCHAR(60) NOT NULL,
    record_id  INT NOT NULL,
    details    TEXT DEFAULT NULL,
    ip_address VARCHAR(45) DEFAULT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);
