## 🏠 Dalal – AI‑Powered Real Estate App

**Dalal** is an end‑to‑end real estate app that connects property owners directly with buyers and renters through a modern mobile application, an admin dashboard, a REST API, and an AI price prediction service.

The system digitizes the real estate journey (listing, discovery, communication, and pricing) with a focus on transparency, local‑market suitability, and practical AI integration.

---

## 📌 Overview

- **Mobile app (Flutter)** for end users (Android / iOS)
- **Admin dashboard** for operations and content moderation
- **RESTful PHP API** as the backend layer
- **AI microservice (FastAPI + XGBoost)** for price prediction
- **MySQL database** 
This repository was built as a **full‑stack graduation project (2026)** and is structured as a production‑ready, extensible codebase.

---

## 🚀 Core Features

### 👤 User Experience

- User registration, login, and secure authentication
- Guest mode: browse properties without creating an account
- Advanced property search and filtering (by city, area, type, price, etc.)
- Add properties to favorites and manage personal lists
- In‑app flows to contact property owners directly
- Reporting system for inappropriate or suspicious listings

### 🏢 Property Management

- Create, edit, and delete property listings
- Upload photos and specify location / property metadata
- Admin review workflow before publishing (Pending / Approved / Rejected)
- Featured packages and promotions for property owners

### 🤖 AI Price Prediction

- Separate AI microservice (FastAPI) with a `/predict` endpoint
- Uses trained **XGBoost** models for **sale** and **rent** prices
- Input features include city, area, property type, size, rooms, baths, floors
- Supports detailed, human‑readable explanations based on area category
- Clean integration inside the Flutter app with a dedicated **"Predict price with AI"** flow

### 🔐 Security & System Design

- Role‑based access control between admin and normal users
- Token‑based authentication on the API layer
- Protected user data handling and validation
- Clean, layered architecture on mobile (Data / Domain / Presentation)

---

## 🧱 System Architecture

```
Flutter Mobile App
        │
        ▼
  PHP REST API (api-app)
        │
        ▼
     MySQL Database
        │
        └────► AI Price Service (FastAPI + XGBoost)
```

The components are decoupled so each can be developed, deployed, and scaled independently.

---

## 📁 Repository Structure

- **`mobile-app/`** – Flutter application
  - Uses `flutter_bloc`, `go_router`, `hive`, `cached_network_image`, `image_picker`, and more
  - Follows Clean Architecture with `core` + `features`
  - Includes an AI feature module under `lib/features/ai_price_prediction/`

- **`backend-api-and-admin-dashboard/`**
  - **`admin/`** – HTML/CSS/JS admin dashboard for:
    - Managing users, properties, reports, delete‑account requests, packages, banners, etc.
  - **`api-app/api/`** – PHP REST API organized by domain:
    - `user/` – registration, login, OTP, password reset, delete‑account request
    - `user_profile/` – profile update, phone change, password change
    - `ad/` – create/update/delete ad, likes, favorites, reports
    - `banner/`, `media/`, `notification/`, `package/`, `static/`, `search_and_filter/`


- **`ai-price-model/`**
  - **`algorithm-and-training/main.py`** – FastAPI app exposing `/predict`
  - **`algorithm-and-training/requirements.txt`** – Python dependencies
  - **`algorithm-and-training/api startup.txt`** – quick command to start Uvicorn
  - **`dataset-and-model/`** – training data, notebooks, and serialized models (`*.pkl`)

- **`database/ghassan_dalal_app.sql`** – additional DB dump for the application

- **`postman-tests/Dalal-API.postman_collection.json`**
  - Postman collection to explore and test the API

- **`screenshots/`**
  - UI screenshots for the app and dashboard

---

## ⚙️ Installation & Setup

### 1️⃣ Mobile App (Flutter)

**Prerequisites**

- Flutter SDK (compatible with `sdk: ^3.7.0` in `pubspec.yaml`)
- Android Studio or VS Code with Flutter/Dart extensions
- Android device/emulator or iOS simulator

**Run**

```bash
cd mobile-app
flutter pub get
flutter run
```

The app boots with `MaterialApp.router`, `go_router` for navigation, and `flutter_bloc` + `Hive` for state management and local storage.

---

### 2️⃣ Backend API & Admin Dashboard (PHP + MySQL)

**Prerequisites**

- PHP 8+
- MySQL
- Web server (XAMPP, WAMP, Laragon, etc.)

**Database Setup**

1. Create a new MySQL database (e.g. `dalal_db`).
2. Import one of:
   - `backend-api-and-admin-dashboard/dalal_db.sql`
   - or `database/ghassan_dalal_app.sql`
3. Apply any documented migrations (example for delete‑account flow):

   ```sql
   ALTER TABLE `users`
   MODIFY COLUMN `status` enum('active','blocked','pending_deletion') NOT NULL DEFAULT 'active';
   ```

**Server Setup**

1. Place `backend-api-and-admin-dashboard` inside your web root (e.g. `htdocs`).
2. Configure DB credentials in the PHP config/helper files under `api-app`.
3. Open the backend landing page in a browser (example):
   - `http://localhost/backend-api-and-admin-dashboard/index.html`
4. Use the **“Admin Dashboard”** button to access `admin/index.html`.

**API Testing**

- Import `postman-tests/Dalal-API.postman_collection.json` into Postman.
- Test endpoints such as `user/login.php`, `ad/create_ad.php`, `notification/get_notifications.php`, etc.

---

### 3️⃣ AI Price Prediction Service (FastAPI)

**Prerequisites**

- Python 3.9+
- Pip + virtual environment (recommended)

**Install dependencies**

```bash
cd "ai-price-model/algorithm-and-training"
pip install -r requirements.txt
```

**Run the service (local)**

```bash
uvicorn main:app --reload
```

**Run the service (for mobile device on same Wi‑Fi)**

```bash
python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Then open:

```text
http://YOUR_LAPTOP_IP:8000/docs
```

to explore the interactive FastAPI docs and test `/predict`.

**Sample request**

```json
{
  "city": "Sanaa",
  "area_name": "Al-Tahrir",
  "property_type": "apartment",
  "deal_type": "rent",
  "area_m2": 120,
  "rooms": 3,
  "baths": 2,
  "floors": 1
}
```

**Sample response**

```json
{
  "predicted_price": 150000,
  "message": "The property is located in a mid‑demand area close to services and main roads."
}
```

---

## 🔗 Flutter–AI Integration

The mobile app includes a dedicated guide at:

- `mobile-app/lib/features/ai_price_prediction/AI_CONNECTION_GUIDE.md`

Key steps:

1. Get your laptop IP using `ipconfig`.
2. Update the constant in `ai_api_service.dart`:

   ```dart
   // lib/features/ai_price_prediction/data/data_source/ai_api_service.dart
   const String laptopIp = '192.168.1.100'; // replace with your machine IP
   ```

3. Start the FastAPI server with `--host 0.0.0.0 --port 8000`.
4. Run the Flutter app and use **“Predict price with AI”** in the create‑ad flow.

---

## 🧩 Technical Highlights

- **Clean Architecture (Flutter)**:
  - Clear separation into `Data`, `Domain`, and `Presentation` layers
  - Use cases, repositories, and entities for maintainability and testability
- **State Management**:
  - `flutter_bloc` and Cubit across core features (auth, ads, AI, profile, etc.)
- **Local Storage**:
  - `Hive` boxes for logged‑in user data and cached ads (featured / all)
- **Modern UI/UX**:
  - Custom theming and typography (`Rubik` font family)
  - Full RTL and Arabic language support
  - Visual design showcased as a Behance case study: [Dalal – Real Estate Mobile App](https://www.behance.net/gallery/237325549/Dalal-Real-Estate-Mobile-App)
- **Backend Modularity**:
  - API grouped by domain (user, ads, packages, notifications…)
  - Documented flows such as delete‑account requests and admin review
- **Real‑world AI**:
  - XGBoost models trained on real estate data
  - Robust Arabic text normalization and area‑name extraction
  - Human‑friendly explanation messages for different area categories

---

## 🛠️ Tech Stack

- **Mobile**: Flutter, Dart, flutter_bloc, go_router, Hive, HTTP, cached_network_image, image_picker, intl
- **Backend API**: PHP, custom REST architecture, MySQL
- **Admin Dashboard**: HTML, CSS, JavaScript, SVG assets
- **AI Service**: FastAPI, Uvicorn, Pandas, Joblib, XGBoost, Scikit‑learn
- **Database & Modeling**: MySQL, ERD, UML (Use Case, Activity, Sequence, Class)
- **Tooling**: Postman, Jupyter Notebook, Git, GitHub

---

## 📈 Motivation & Future Work

The traditional real estate market often suffers from limited transparency, slow information flow, and high brokerage fees. **Dalal** aims to provide a digital, data‑driven alternative tailored to the local housing market, while demonstrating end‑to‑end product thinking (from UX to AI).

Potential future extensions include:

- Online and in‑app payments
- In‑app chat between buyers and sellers
- Multi‑language support (Arabic/English toggle)
- Web client version
- Smarter notifications and recommendation engine

---

## 👨‍💻 About the Project

Type: Computer Science Graduation Project – 2026.

Scope: Full-stack mobile platform with production-style backend architecture and AI-powered price prediction integration.

Focus Areas: Mobile engineering, RESTful API development, database architecture design, and applied machine learning.

This repository is publicly available for portfolio and demonstration purposes only.
It showcases full-stack development skills and real-world system architecture implementation.

---

## 📄 License & Intellectual Property

© 2026 Ghassan Al-Moqbeli. All Rights Reserved.

This project and its source code are the intellectual property of the author.

Unauthorized copying, reproduction, modification, redistribution, or re-publication of this project — in whole or in part — without explicit written permission from the author is strictly prohibited.

This repository is intended for viewing and evaluation purposes (e.g., recruiters, technical reviewers, academic assessment).
