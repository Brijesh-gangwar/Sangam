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
//       title: 'Live Location Tracker',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
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

//   Future<void> _saveNewPath(List<LatLng> path) async {
//     final double distance = _calculateDistance(path);

//     final newPath = {
//       "path": path
//           .map((point) => {"lat": point.latitude, "lng": point.longitude})
//           .toList(),
//       "timestamp": DateTime.now().toIso8601String(),
//       "distance": distance,
//     };

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _savedPaths.add(newPath);
//     List<String> savedPathsJson =
//         _savedPaths.map((path) => json.encode(path)).toList();
//     await prefs.setStringList('savedPaths', savedPathsJson);
//   }

//   double _calculateDistance(List<LatLng> path) {
//     double totalDistance = 0;
//     final Distance distanceCalculator = Distance();

//     for (int i = 0; i < path.length - 1; i++) {
//       totalDistance += distanceCalculator(path[i], path[i + 1]);
//     }
//     return totalDistance / 1000; // convert to kilometers
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
//                 await _saveNewPath(trackedPath);
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
//                 "Date: ${pathData["timestamp"]}\nDistance: ${pathData["distance"] != null ? pathData["distance"].toStringAsFixed(2) : 'N/A'} km"),
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
// }

// class LiveTrackingScreen extends StatefulWidget {
//   @override
//   _LiveTrackingScreenState createState() => _LiveTrackingScreenState();
// }

// class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
//   final List<LatLng> _trackedPath = [];
//   late StreamSubscription<Position> _positionStream;
//   final mapController = MapController();
//   LatLng? _currentLocation;

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
//         desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       _currentLocation = LatLng(position.latitude, position.longitude);
//     });
//   }

//   Future<void> _startTracking() async {
//     _positionStream = Geolocator.getPositionStream(
//       locationSettings: const LocationSettings(
//         accuracy: LocationAccuracy.best,
//         distanceFilter: 10,
//       ),
//     ).listen((Position position) {
//       final newLocation = LatLng(position.latitude, position.longitude);
//       setState(() {
//         _trackedPath.add(newLocation);
//       });
//       mapController.move(newLocation, 20);
//     });
//   }

//   Future<void> _showLocationError() async {
//     // Show a dialog to notify the user that location services are not enabled
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
//       body: FlutterMap(
//         mapController: mapController,
//         options: MapOptions(
//           initialCenter: _currentLocation ?? LatLng(37.7749, -122.4194),
//           initialZoom: 15.0,
//           maxZoom: 18.0,
//           minZoom: 5.0,
//           interactionOptions: InteractionOptions(flags: InteractiveFlag.all),
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
//             subdomains: [],
//           ),
//           if (_currentLocation != null)
//             MarkerLayer(
//               markers: [
//                 Marker(
//                   width: 80.0,
//                   height: 80.0,
//                   point: _currentLocation!,
//                   child: Icon(
//                     Icons.location_pin,
//                     color: Colors.red,
//                     size: 40,
//                   ),
//                 ),
//               ],
//             ),
//           PolylineLayer(
//             polylines: [
//               Polyline(
//                 points: _trackedPath,
//                 strokeWidth: 4.0,
//                 color: Colors.blue,
//               ),
//             ],
//           ),
//           if (_trackedPath.isNotEmpty)
//             MarkerLayer(
//               markers: [
//                 Marker(
//                   width: 40.0,
//                   height: 40.0,
//                   point: _trackedPath.first,
//                   child: Icon(
//                     Icons.flag,
//                     color: Colors.red,
//                     size: 40,
//                   ),
//                 ),
//               ],
//             ),
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
//           initialCenter:
//               path.isNotEmpty ? path.first : LatLng(37.7749, -122.4194),
//           initialZoom: 15.0,
//           maxZoom: 18.0,
//           minZoom: 5.0,
//           interactionOptions:const InteractionOptions(flags: InteractiveFlag.all),
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
//           if (path.isNotEmpty)
//             MarkerLayer(
//               markers: [
//                 Marker(
//                   width: 80.0,
//                   height: 80.0,
//                   point: path.first,
//                   child:const Icon(
//                     Icons.flag,
//                     color: Colors.green,
//                     size: 40,
//                   ),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }
