// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'dart:async';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Enhanced Location Tracker',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Map<String, dynamic>> _savedPaths = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedPaths();
//   }

//   Future<void> _loadSavedPaths() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? savedPathsJson = prefs.getStringList('savedPaths');
//     if (savedPathsJson != null) {
//       setState(() {
//         _savedPaths = savedPathsJson
//             .map((pathJson) => json.decode(pathJson))
//             .toList()
//             .cast<Map<String, dynamic>>();
//       });
//     }
//   }

//   Future<void> _saveNewPath(List<LatLng> path, double distance) async {
//     final newPath = {
//       "path": path.map((point) => {"lat": point.latitude, "lng": point.longitude}).toList(),
//       "timestamp": DateTime.now().toIso8601String(),
//       "distance": distance,
//     };

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _savedPaths.add(newPath);
//     List<String> savedPathsJson =
//         _savedPaths.map((path) => json.encode(path)).toList();
//     await prefs.setStringList('savedPaths', savedPathsJson);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Saved Paths"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add_location_alt),
//             onPressed: () async {
//               List<LatLng> trackedPath = await Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => LiveTrackingScreen()),
//               );
//               if (trackedPath.isNotEmpty) {
//                 double distance = _calculateDistance(trackedPath);
//                 await _saveNewPath(trackedPath, distance);
//                 _loadSavedPaths();
//               }
//             },
//           )
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: _savedPaths.length,
//         itemBuilder: (context, index) {
//           final pathData = _savedPaths[index];
//           return ListTile(
//             title: Text("Path ${index + 1}"),
//             subtitle: Text(
//               "Date: ${pathData["timestamp"]}\nDistance: ${pathData["distance"] != null ? pathData["distance"].toStringAsFixed(2) : 'N/A'} km",
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => MapDisplayScreen(
//                     path: (pathData["path"] as List)
//                         .map((point) => LatLng(point["lat"], point["lng"]))
//                         .toList(),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   double _calculateDistance(List<LatLng> path) {
//     final Distance distance = Distance();
//     double totalDistance = 0;
//     for (int i = 0; i < path.length - 1; i++) {
//       totalDistance += distance(path[i], path[i + 1]);
//     }
//     return totalDistance / 1000; // in kilometers
//   }
// }

// class LiveTrackingScreen extends StatefulWidget {
//   @override
//   _LiveTrackingScreenState createState() => _LiveTrackingScreenState();
// }

// class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
//   final List<LatLng> _trackedPath = [];
//   late StreamSubscription<Position> _positionStream;
//   final MapController _mapController = MapController();
//   LatLng? _currentLocation;
//   LatLng _mapCenter = LatLng(37.7749, -122.4194); // Default center
//   double _currentZoom = 15.0;

//   @override
//   void initState() {
//     super.initState();
//     _enableLocationService();
//   }

//   @override
//   void dispose() {
//     _positionStream.cancel();
//     super.dispose();
//   }

//   Future<void> _enableLocationService() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await _showLocationError();
//       return;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         await _showLocationError();
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       await _showLocationError();
//       return;
//     }

//     _getCurrentLocation();
//     _startTracking();
//   }

//   Future<void> _getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.bestForNavigation); // Increased accuracy
//     setState(() {
//       _currentLocation = LatLng(position.latitude, position.longitude);
//       _mapCenter = _currentLocation!;
//     });
//   }

//   Future<void> _startTracking() async {
//     _positionStream = Geolocator.getPositionStream(
//       locationSettings: const LocationSettings(
//         accuracy: LocationAccuracy.bestForNavigation,
//         distanceFilter: 5,
//       ),
//     ).listen((Position position) {
//       final newLocation = LatLng(position.latitude, position.longitude);
//       setState(() {
//         _trackedPath.add(newLocation);
//         _mapCenter = newLocation;
//       });
//       _mapController.move(newLocation, _currentZoom);
//     });
//   }

//   Future<void> _showLocationError() async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Location Services Disabled"),
//           content: Text("Please enable location services to use this feature."),
//           actions: [
//             TextButton(
//               child: Text("OK"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _zoomIn() {
//     setState(() {
//       _currentZoom += 1;
//     });
//     _mapController.move(_mapCenter, _currentZoom);
//   }

//   void _zoomOut() {
//     setState(() {
//       _currentZoom -= 1;
//     });
//     _mapController.move(_mapCenter, _currentZoom);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Live Tracking"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.stop),
//             onPressed: () {
//               Navigator.pop(context, _trackedPath);
//             },
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           FlutterMap(
//             mapController: _mapController,
//             options: MapOptions(
//               initialCenter: _mapCenter,
//               initialZoom: _currentZoom,
//               maxZoom: 18.0,
//               minZoom: 5.0,
//               interactionOptions:
//                   InteractionOptions(flags: InteractiveFlag.all),
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
//                 subdomains: [],
//               ),
//               if (_currentLocation != null)
//                 MarkerLayer(
//                   markers: [
//                     Marker(
//                       width: 80.0,
//                       height: 80.0,
//                       point: _currentLocation!,
//                       child: Icon(Icons.location_pin, color: Colors.red, size: 40),
//                     ),
//                   ],
//                 ),
//               if (_trackedPath.isNotEmpty)
//                 MarkerLayer(
//                   markers: [
//                     Marker(
//                       width: 80.0,
//                       height: 80.0,
//                       point: _trackedPath.first, // Mark the first location as starting point
//                       child: Icon(Icons.flag, color: Colors.green, size: 40),
//                     ),
//                   ],
//                 ),
//               PolylineLayer(
//                 polylines: [
//                   Polyline(
//                     points: _trackedPath,
//                     strokeWidth: 4.0,
//                     color: Colors.blue,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Positioned(
//             bottom: 20,
//             right: 20,
//             child: Column(
//               children: [
//                 FloatingActionButton(
//                   onPressed: _zoomIn,
//                   child: Icon(Icons.zoom_in),
//                 ),
//                 SizedBox(height: 10),
//                 FloatingActionButton(
//                   onPressed: _zoomOut,
//                   child: Icon(Icons.zoom_out),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MapDisplayScreen extends StatelessWidget {
//   final List<LatLng> path;

//   MapDisplayScreen({required this.path});

//   @override
//   Widget build(BuildContext context) {
//     final mapController = MapController();
//     return Scaffold(
//       appBar: AppBar(title: Text("Path on Map")),
//       body: FlutterMap(
//         mapController: mapController,
//         options: MapOptions(
//           initialCenter: path.isNotEmpty ? path.first : LatLng(37.7749, -122.4194),
//           initialZoom: 15.0,
//           maxZoom: 18.0,
//           minZoom: 5.0,
//           interactionOptions:
//                   InteractionOptions(flags: InteractiveFlag.all),
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
//             subdomains: [],
//           ),
//           PolylineLayer(
//             polylines: [
//               Polyline(
//                 points: path,
//                 strokeWidth: 4.0,
//                 color: Colors.red,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
