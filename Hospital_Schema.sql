-- Hospital Management Database Schema 

CREATE DATABASE Hospital;
USE HOSPITAL;

-- Departments
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Doctors
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    department_id INT,
    specialization VARCHAR(100),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Patients
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
 
 last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_gender  CHECK (gender in ('Male', 'Female', 'Other'))
);

-- Rooms
CREATE TABLE Rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    type VARCHAR(50) DEFAULT 'General',
    cost_per_day DECIMAL(10,2) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    CONSTRAINT chk_type CHECK ( type in ('General' ,'Private', 'ICU', 'Semi-Private'))
);

-- Admissions (a patient admitted to a room)
CREATE TABLE Admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    room_id INT NOT NULL,
    admitted_on DATETIME NOT NULL,
    discharged_on DATETIME,
    reason TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients (patient_id),
    FOREIGN KEY (room_id) REFERENCES Rooms (room_id)
);

-- Appointments
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_datetime DATETIME NOT NULL,
    reason VARCHAR(255),
    status VARCHAR(50) DEFAULT 'Scheduled',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    CONSTRAINT chk_status CHECK (status in ('Scheduled','Completed','Cancelled','No-Show'))
);

-- Treatments / Procedures (linked to an admission)
CREATE TABLE Treatments (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    admission_id INT NOT NULL,
    doctor_id INT NOT NULL,
    description TEXT NOT NULL,
    treatment_date DATETIME NOT NULL,
    cost DECIMAL(10,2),
    FOREIGN KEY (admission_id) REFERENCES Admissions(admission_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Medications
CREATE TABLE Medications (
    medication_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    unit VARCHAR(50)
);

-- Prescriptions (issued to patient by doctor)
CREATE TABLE Prescriptions (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    issued_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Prescription details (many meds per prescription)
CREATE TABLE Prescription_Items (
    prescription_item_id INT PRIMARY KEY AUTO_INCREMENT,
    prescription_id INT NOT NULL,
    medication_id INT NOT NULL,
    dosage VARCHAR(100),
    duration VARCHAR(100),
    instructions TEXT,
    FOREIGN KEY (prescription_id) REFERENCES Prescriptions(prescription_id),
    FOREIGN KEY (medication_id) REFERENCES Medications(medication_id)
);

-- Billing / Invoices
CREATE TABLE Bills (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    admission_id INT,
    appointment_id INT,
    total_amount DECIMAL(12,2) NOT NULL,
    billing_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    paid BOOLEAN DEFAULT FALSE,
    payment_method varchar(50) DEFAULT 'Cash',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (admission_id) REFERENCES Admissions(admission_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id),
    CONSTRAINT chk_payment CHECK (payment_method in ('Cash','Card','Online','Insurance'))
);

-- Staff (optional extension)
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role VARCHAR(100),
    department_id INT,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);