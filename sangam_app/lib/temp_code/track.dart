// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class LiveTrackingPage extends StatefulWidget {
//   @override
//   _LiveTrackingPageState createState() => _LiveTrackingPageState();
// }

// class _LiveTrackingPageState extends State<LiveTrackingPage> {
//   final List<LatLng> _trackedPath = [];
//   late StreamSubscription<Position> _positionStream;
//   final MapController mapController = MapController();

//   @override
//   void initState() {
//     super.initState();
//     _startTracking();
//   }

//   @override
//   void dispose() {
//     _positionStream.cancel();
//     super.dispose();
//   }

//   Future<void> _startTracking() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Location permissions are permanently denied.');
//     }

//     _positionStream = Geolocator.getPositionStream(
//       locationSettings: const LocationSettings(accuracy: LocationAccuracy.best),
//     ).listen((Position position) {
//       final newLocation = LatLng(position.latitude, position.longitude);
//       setState(() {
//         _trackedPath.add(newLocation);
//       });

//       _saveLocationToBackend(newLocation);

//       mapController.move(newLocation, 15);
//     });
//   }

//   Future<void> _saveLocationToBackend(LatLng location) async {
//     final url = Uri.parse("https://your-backend-url.com/api/save-location");
//     await http.post(url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({
//           "latitude": location.latitude,
//           "longitude": location.longitude,
//           "timestamp": DateTime.now().toIso8601String(),
//         }));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Live Tracking Path")),
//       body: FlutterMap(
//         mapController: mapController,
//         options: MapOptions(
//           initialCenter: _trackedPath.isNotEmpty
//               ? _trackedPath.last
//               : LatLng(37.7749, -122.4194), // Default center if no path yet
//         initialZoom: 15.0,
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//             subdomains: ['a', 'b', 'c'],
//           ),
//           PolylineLayer(
//             polylines: [
//               Polyline(
//                 points: _trackedPath,
//                 strokeWidth: 4.0,
//                 color: Colors.blue,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
