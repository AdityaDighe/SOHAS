
# 🏥 SOHAS - Secure Online Health Appointment System  

SOHAS is a **Spring MVC + Hibernate + JWT** based web application designed to manage **Doctor–Patient Appointments** securely.  
It provides **role-based access** (Doctor / Patient), **JWT authentication**, **BCrypt password encryption**, and **OTP-based password reset**.  

---

## 🚀 Features  

- 🔐 **Authentication & Security**  
  - Login / Logout with JWT  
  - Role-based access (Doctor / Patient)  
  - BCrypt password encryption  
  - OTP-based password reset  

- 👨‍⚕️ **Doctor Module**  
  - Doctor registration with validations  
  - Manage doctor profile  
  - View patient appointments  
  - Set availability (start & end time)  

- 🧑‍🤝‍🧑 **Patient Module**  
  - Patient registration with validations  
  - Manage patient profile  
  - Search available doctors (by location, date, time)  
  - Book & manage appointments  

- 📅 **Appointment Management**  
  - Book, update, cancel, complete appointments  
  - View doctor’s and patient’s appointments  
  - Status management (`PENDING`, `COMPLETED`, `CANCELLED`)  

---

## 🛠️ Tech Stack  

- **Backend**: Spring MVC, Hibernate, Java 17  
- **Security**: JWT Authentication, BCrypt  
- **Database**: MySQL (or any relational DB)  
- **Build Tool**: Maven  
- **Frontend**: JSP, JSTL, Bootstrap  
- **Server**: Apache Tomcat  

---

## 📂 Project Structure  

```
SOHAS/
├── src/main/java/com/demo/health
│   ├── controller/         # REST Controllers
│   ├── service/            # Business logic
│   ├── dao/                # Data access layer
│   ├── entity/             # Hibernate entities
│   ├── dto/                # DTOs for request/response
│   ├── security/           # JWT + CustomUserDetails
│   ├── filter/             # JWT Authentication Filter
│   ├── util/               # Helpers (JwtUtil, OtpUtil)
│   └── exception/          # Custom Exceptions
│
└── src/main/webapp/WEB-INF/views
    ├── doctor-dashboard.jsp
    ├── patient.jsp
    ├── appointments.jsp
    ├── login.jsp
    ├── signup.jsp
    └── error.jsp
```

---

## 🔑 API Endpoints  

### Authentication (`/api`)  

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| POST | `/api/login` | Login for Patient/Doctor, returns JWT | No |
| POST | `/api/logout` | Logout user by invalidating JWT | Yes |
| POST | `/api/request-otp` | Request OTP for password reset | No |
| POST | `/api/reset-password` | Reset password using OTP | No |

---

### Doctor (`/doctors`)  

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| GET | `/doctors/{id}` | Get doctor details by ID | Yes |
| POST | `/doctors/signup` | Register a new doctor | No |
| PUT | `/doctors/{id}` | Update doctor profile | Yes |
| DELETE | `/doctors/{id}` | Delete doctor profile | Yes |
| GET | `/doctors/appointment/{id}` | View doctor’s appointments | Yes |

---

### Patient (`/patients`)  

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| POST | `/patients/signup` | Register a new patient | No |
| GET | `/patients/{id}` | Get patient details by ID | Yes |
| PUT | `/patients/{id}` | Update patient profile | Yes |
| DELETE | `/patients/{id}` | Delete patient profile | Yes |
| GET | `/patients/doctors?location=&time=&date=` | Find available doctors | Yes |
| GET | `/patients/appointment/{id}` | View patient’s appointments | Yes |

---

### Appointment (`/appointment`)  

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| POST | `/appointment` | Book a new appointment | Yes |
| GET | `/appointment` | Get all appointments | Yes |
| PUT | `/appointment/{id}` | Update appointment status | Yes |

---

## 🧪 Postman Testing  

## 1. Patient Signup
```http
POST http://localhost:8080/SOHAS/patients/signup
Content-Type: application/json

{
  "patientName": "David Johnson",
  "age": 22,
  "city": "Mumbai",
  "email": "david@mail.com",
  "password": "David@7897"
}
```

## 2. Doctor Signup
```http
POST http://localhost:8080/SOHAS/doctors/signup
Content-Type: application/json

{
  "doctorName": "Dr. Sarah Khan",
  "speciality": "Cardiologist",
  "phoneNumber": "9876543210",
  "city": "Mumbai",
  "hospitalName": "Apollo Hospital",
  "email": "sarah.khan@gmail.com",
  "password": "Doctor@123",
  "startTime": "09:00",
  "endTime": "17:00"
}
```

## 3. Login (Doctor/Patient)
```http
POST http://localhost:8080/SOHAS/api/login
Content-Type: application/json

{
  "email": "david@mail.com",
  "password": "David@7897"
}
```

## 4. Update Patient Profile
```http
PUT http://localhost:8080/SOHAS/patients/{id}
Content-Type: application/json
Authorization: Bearer {jwtToken}

{
  "patientName": "David Johnson",
  "age": 23,
  "city": "Mumbai",
  "email": "david@gmail.com",
  "password": "David@7897"
}
```

## 5. Update Doctor Profile
```http
PUT http://localhost:8080/SOHAS/doctors/{id}
Content-Type: application/json
Authorization: Bearer {jwtToken}

{
  "doctorName": "Dr. Sarah Khan",
  "speciality": "Cardiologist",
  "phoneNumber": "9876543210",
  "city": "Pune",
  "hospitalName": "Apollo Hospital",
  "email": "sarah.khan@gmail.com",
  "password": "Doctor@123",
  "startTime": "09:00",
  "endTime": "17:00"
}
```

## 6. Send OTP for Forgot Password
```http
POST http://localhost:8080/SOHAS/api/request-otp
Content-Type: application/json

{
  "email": "user@example.com"
}
```

## 7. Reset Password with OTP
```http
POST http://localhost:8080/SOHAS/api/reset-password
Content-Type: application/json

{
  "email": "user@example.com",
  "otp": "123456",
  "newPassword": "NewPassword@123"
}
```

## 8. Find Available Doctors
```http
GET http://localhost:8080/SOHAS/patients/doctors?date=2025-08-21&time=10:00:00&location=Mumbai
Content-Type: application/json
Authorization: Bearer {jwtToken}
```

## 9. Book Appointment
```http
POST http://localhost:8080/SOHAS/appointment
Content-Type: application/json
Authorization: Bearer {jwtToken}

{
  "date": "2025-09-15",
  "time": "10:30",
  "patient": {
    "patientId": 101
  },
  "doctor": {
    "doctorId": 202
  }
}
```

## 10. Get Patient Appointments
```http
GET http://localhost:8080/SOHAS/patients/appointment/{id}
Content-Type: application/json
Authorization: Bearer {jwtToken}
```

## 11. Get Doctor Appointments
```http
GET http://localhost:8080/SOHAS/doctors/appointment/{id}
Content-Type: application/json
Authorization: Bearer {jwtToken}
```

## 12. Logout
```http
POST http://localhost:8080/SOHAS/api/logout
Content-Type: application/json
Authorization: Bearer {jwtToken}
```

## 13. Complete Appointment
```http
PUT http://localhost:8080/SOHAS/appointment/{id}
Content-Type: application/json
Authorization: Bearer {jwtToken}

{
  "status": "COMPLETED"
}
```

## 14. Cancel Appointment
```http
PUT http://localhost:8080/SOHAS/appointment/{id}
Content-Type: application/json
Authorization: Bearer {jwtToken}

{
  "status": "CANCELLED"
}
```

---

## Postman Testing Format

### 1. Patient Signup
**Method:** POST  
**URL:** http://localhost:8080/SOHAS/patients/signup  
**Content-Type:** application/json  
**Request-Body:**
```json
{
  "patientName": "David Johnson",
  "age": 22,
  "city": "Mumbai",
  "email": "david@mail.com",
  "password": "David@7897"
}
```

### 2. Doctor Signup
**Method:** POST  
**URL:** http://localhost:8080/SOHAS/doctors/signup  
**Content-Type:** application/json  
**Request-Body:**
```json
{
  "doctorName": "Dr. Sarah Khan",
  "speciality": "Cardiologist",
  "phoneNumber": "9876543210",
  "city": "Mumbai",
  "hospitalName": "Apollo Hospital",
  "email": "sarah.khan@gmail.com",
  "password": "Doctor@123",
  "startTime": "09:00",
  "endTime": "17:00"
}
```

### 3. Login (Doctor/Patient)
**Method:** POST  
**URL:** http://localhost:8080/SOHAS/api/login  
**Content-Type:** application/json  
**Request-Body:**
```json
{
  "email": "david@mail.com",
  "password": "David@7897"
}
```

### 4. Update Patient Profile
**Method:** PUT  
**URL:** http://localhost:8080/SOHAS/patients/{id}  
**Content-Type:** application/json  
**Headers:**  
Authorization: Bearer {jwtToken}  
**Request-Body:**
```json
{
  "patientName": "David Johnson",
  "age": 23,
  "city": "Mumbai",
  "email": "david@gmail.com",
  "password": "David@7897"
}
```

### 5. Update Doctor Profile
**Method:** PUT  
**URL:** http://localhost:8080/SOHAS/doctors/{id}  
**Content-Type:** application/json  
**Headers:**  
Authorization: Bearer {jwtToken}  
**Request-Body:**
```json
{
  "doctorName": "Dr. Sarah Khan",
  "speciality": "Cardiologist",
  "phoneNumber": "9876543210",
  "city": "Pune",
  "hospitalName": "Apollo Hospital",
  "email": "sarah.khan@gmail.com",
  "password": "Doctor@123",
  "startTime": "09:00",
  "endTime": "17:00"
}
```

### 6. Send OTP for Forgot Password
**Method:** POST  
**URL:** http://localhost:8080/SOHAS/api/request-otp  
**Content-Type:** application/json  
**Request-Body:**
```json
{
  "email": "user@example.com"
}
```

### 7. Reset Password with OTP
**Method:** POST  
**URL:** http://localhost:8080/SOHAS/api/reset-password  
**Content-Type:** application/json  
**Request-Body:**
```json
{
  "email": "user@example.com",
  "otp": "123456",
  "newPassword": "NewPassword@123"
}
```

### 8. Find Available Doctors
**Method:** GET  
**URL:** http://localhost:8080/SOHAS/patients/doctors  
**Content-Type:** application/json  
**Headers:**  
Authorization: Bearer {jwtToken}  
**Request-Params:**
```
date: 2025-08-21
time: 10:00:00
location: Mumbai
```

### 9. Book Appointment
**Method:** POST  
**URL:** http://localhost:8080/SOHAS/appointment  
**Content-Type:** application/json  
**Headers:**  
Authorization: Bearer {jwtToken}  
**Request-Body:**
```json
{
  "date": "2025-09-15",
  "time": "10:30",
  "patient": {
    "patientId": 101
  },
  "doctor": {
    "doctorId": 202
  }
}
```

### 10. Get Patient Appointments
**Method:** GET  
**URL:** http://localhost:8080/SOHAS/patients/appointment/{id}  
**Content-Type:** application/json  
**Headers:**  
Authorization: Bearer {jwtToken}

### 11. Get Doctor Appointments
**Method:** GET  
**URL:** http://localhost:8080/SOHAS/doctors/appointment/{id}  
**Content-Type:** application/json  
**Headers:**  
Authorization: Bearer {jwtToken}

### 12. Logout
**Method:** POST  
**URL:** http://localhost:8080/SOHAS/api/logout  
**Content-Type:** application/json  
**Headers:**  
Authorization: Bearer {jwtToken}

### 13. Complete Appointment
**Method:** PUT  
**URL:** http://localhost:8080/SOHAS/appointment/{id}  
**Content-Type:** application/json  
**Headers:**  
Authorization: Bearer {jwtToken}  
**Request-Body:**
```json
{
  "status": "COMPLETED"
}
```

### 14. Cancel Appointment
**Method:** PUT  
**URL:** http://localhost:8080/SOHAS/appointment/{id}  
**Content-Type:** application/json  
**Headers:**  
Authorization: Bearer {jwtToken}  
**Request-Body:**
```json
{
  "status": "CANCELLED"
}
```

---

## Notes:
- Replace `{id}` with actual patient/doctor/appointment ID
- Replace `{jwtToken}` with the actual JWT token received from login
- All endpoints require proper authentication headers where specified
- Date format: YYYY-MM-DD
- Time format: HH:MM or HH:MM:SS






---

## 🔒 Security Flow  

1. User **registers** (Patient / Doctor)  
2. On login, server **validates credentials** & generates JWT  
3. JWT is sent in **Authorization: Bearer {token}** for all secured endpoints  
4. `JwtAuthenticationFilter` validates token on each request  
5. Users can only access data relevant to their **role (Patient/Doctor)**  

---

## ⚙️ Setup Instructions  

1. Clone repository  
   ```bash
   git clone https://github.com/yourusername/SOHAS.git
   cd SOHAS
   ```
2. Configure **PostgreSQL database** in dispatcher servlet.xml  
3. Right click -> Run on Server
4. Deploy on **Apache Tomcat** (`target/SOHAS.war`)  
5. Access in browser:  
   ```
   http://localhost:8080/SOHAS
   ```

---

## 📌 Future Enhancements  

- Add **admin role** for monitoring doctors & patients  
- Integrate **payment gateway** for paid consultations  
- Add **video consultation module**  
- Generate **doctor availability calendar**  
