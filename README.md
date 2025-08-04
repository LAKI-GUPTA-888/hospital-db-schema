# 🏥 Hospital Management Database Schema

## 📌 Overview
This project is a **Hospital Management System** database schema designed using **MySQL**.  
It models real-world hospital operations such as managing patients, doctors, departments, appointments, admissions, treatments, prescriptions, medications, and billing.

The database is normalized to **Third Normal Form (3NF)** to ensure minimal redundancy and maintain referential integrity.

---

## Entities & Relationships

### **Entities**
- **Departments** – Manages hospital specializations (e.g., Cardiology, Orthopedics).
- **Doctors** – Medical professionals associated with departments.
- **Patients** – People receiving hospital services.
- **Rooms** – Hospital rooms for admissions.
- **Admissions** – Patient stays in rooms.
- **Appointments** – Scheduled consultations with doctors.
- **Treatments** – Medical procedures performed.
- **Medications** – Drugs used for treatment.
- **Prescriptions** – Issued by doctors to patients.
- **Prescription Items** – Medications with dosage & duration.
- **Bills** – Payment records for services.
- **Staff** – Non-doctor hospital staff.

---

### **Key Relationships**
- **One-to-Many**:
  - Department → Doctors
  - Doctor → Appointments
  - Patient → Appointments
  - Admission → Treatments
- **Many-to-Many** (via link tables):
  - Prescriptions ↔ Medications (through Prescription_Items)
- **One-to-One**:
  - Admission → Room (during that stay)

---

## Schema Features
- **Primary Keys (PK)**: All main entities use surrogate keys with `AUTO_INCREMENT`.
- **Foreign Keys (FK)**: Enforce referential integrity.
- **Constraints**:
  - `NOT NULL` for mandatory fields.
  - `UNIQUE` for fields like emails and room numbers.
  - `ENUM` for fixed values (gender, room type, status).
- **Default Values**: `CURRENT_TIMESTAMP` for creation dates, default room availability, etc.

---

## Tools Used
- **MySQL Workbench** – For schema design & ER diagram creation.
- **Draw.io / dbdiagram.io** – For visual ER diagram export (optional).
- **GitHub** – For version control and submission.

---

## ER Diagram
![ER Diagram](ER_Diagram.png)

