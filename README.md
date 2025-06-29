### 🚀 SANGAM – Inter-Departmental Cooperation Platform for Smart Cities  
🏆 **Grand Finalist | Smart India Hackathon (SIH) 2024 | PS ID 1724**  
🛡️ Developed for the **Ministry of Housing and Urban Affairs (MoHUA)** under the **Smart Cities Mission**


📱 Flutter Mobile App – Companion Platform for Field Officers

As part of the **SANGAM** ecosystem, the Flutter mobile application empowers on-ground officers and field staff to seamlessly interact with centralized dashboards, report in real-time, and visualize GIS data from anywhere.

This cross-platform mobile app is a lightweight, high-performance gateway into the larger SANGAM platform, enabling last-mile integration for data collection, task updates, and location tracking.


📌 Project Overview (Mobile Perspective)

The SANGAM Flutter app complements the full-stack web platform by enabling:

 ✅ Field teams to **update KPIs** and **log updates** remotely.
 ✅ Real-time **location tracking & path logging** using GPS.
 ✅ **Offline path storage** synced later to central dashboard.
 ✅ Interactive **GIS map overlays** using Leaflet and OpenStreetMap.
 ✅ **Role-based authentication** and department-specific access.


 🛠️ Tech Stack (Flutter)

| Layer             | Tech                                  |
|------------------|---------------------------------------|
| Framework         | Flutter (Cross-platform)              |
| State Management  | `setState` / `Provider` / `Riverpod` |
| Location          | `geolocator`                          |
| Mapping           | `flutter_map` + `latlong2`            |
| Local Storage     | `shared_preferences`                  |
| Backend Sync      | RESTful APIs (Node.js/Express)        |



🔍 Mobile App Features

### 📡 Live GPS Tracking
- Real-time location updates for personnel on field.
- Polyline path drawing and automatic map updates.

📦 Path Storage per Project
- Assignments tracked under multiple "Projects".
- All paths stored locally using SharedPreferences for offline usage.

🗺️ Map-Based Replay
- Navigate previously saved paths with clear visual overlays.
- Display current location on historical path navigation screen.

 🔐 Secure Sync (optional)
- JWT-based login or token-based access to the central SANGAM backend.

