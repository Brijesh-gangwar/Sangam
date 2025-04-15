import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Path Tracker with Navigation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _savedPaths = [];

  @override
  void initState() {
    super.initState();
    _loadSavedPaths();
  }

  Future<void> _loadSavedPaths() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedPathsJson = prefs.getStringList('savedPaths');
    if (savedPathsJson != null) {
      setState(() {
        _savedPaths = savedPathsJson
            .map((pathJson) => json.decode(pathJson))
            .toList()
            .cast<Map<String, dynamic>>();
      });
    }
  }

  Future<void> _saveNewPath(List<LatLng> path, double distance) async {
    final newPath = {
      "path": path
          .map((point) => {"lat": point.latitude, "lng": point.longitude})
          .toList(),
      "timestamp": DateTime.now().toIso8601String(),
      "distance": distance,
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _savedPaths.add(newPath);
    List<String> savedPathsJson =
        _savedPaths.map((path) => json.encode(path)).toList();
    await prefs.setStringList('savedPaths', savedPathsJson);
  }

  double _calculateDistance(List<LatLng> path) {
    const Distance distance = Distance();
    double totalDistance = 0;
    for (int i = 0; i < path.length - 1; i++) {
      totalDistance += distance(path[i], path[i + 1]);
    }
    return totalDistance / 1000; // in kilometers
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Paths"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_location_alt),
            onPressed: () async {
              List<LatLng> trackedPath = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LiveTrackingScreen()),
              );
              if (trackedPath.isNotEmpty) {
                double distance = _calculateDistance(trackedPath);
                await _saveNewPath(trackedPath, distance);
                _loadSavedPaths();
              }
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _savedPaths.length,
        itemBuilder: (context, index) {
          final pathData = _savedPaths[index];
          return ListTile(
            title: Text("Path ${index + 1}"),
            subtitle: Text(
              "Date: ${pathData["timestamp"]}\nDistance: ${pathData["distance"] != null ? pathData["distance"].toStringAsFixed(2) : 'N/A'} km",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PathNavigationScreen(
                    path: (pathData["path"] as List)
                        .map((point) => LatLng(point["lat"], point["lng"]))
                        .toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  _LiveTrackingScreenState createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  final List<LatLng> _trackedPath = [];
  late StreamSubscription<Position> _positionStream;
  final MapController _mapController = MapController();
  LatLng? _currentLocation;
  LatLng _mapCenter = const LatLng(37.7749, -122.4194); // Default center
  final double _currentZoom = 15.0;

  @override
  void initState() {
    super.initState();
    _enableLocationService();
  }

  @override
  void dispose() {
    _positionStream.cancel();
    super.dispose();
  }

  Future<void> _enableLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await _showLocationError();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await _showLocationError();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await _showLocationError();
      return;
    }

    _getCurrentLocation();
    _startTracking();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _mapCenter = _currentLocation!;
    });
  }

  Future<void> _startTracking() async {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,

        distanceFilter: 1,
      ),
    ).listen((Position position) {
      final newLocation = LatLng(position.latitude, position.longitude);
      setState(() {
        _trackedPath.add(newLocation);
        _mapCenter = newLocation;
      });
      _mapController.move(newLocation, _currentZoom);
    });
  }

  Future<void> _showLocationError() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Location Services Disabled"),
          content: const Text("Please enable location services to use this feature."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Tracking"),
        actions: [
          IconButton(
            icon: const Icon(Icons.stop),
            onPressed: () {
              Navigator.pop(context, _trackedPath);
            },
          ),
        ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _mapCenter,
          initialZoom: _currentZoom,
          maxZoom: 18.0,
          minZoom: 5.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const [],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: _trackedPath,
                strokeWidth: 10.0,
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PathNavigationScreen extends StatelessWidget {
  final List<LatLng> path;

  const PathNavigationScreen({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Navigate Path")),
      body: StreamBuilder<Position>(
        stream: Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation,
            distanceFilter: 1,
          ),
        ),
        builder: (context, snapshot) {
          LatLng? currentLocation;
          if (snapshot.hasData) {
            Position position = snapshot.data!;
            currentLocation = LatLng(position.latitude, position.longitude);
          }
          return FlutterMap(
            options: MapOptions(
              initialCenter: path.first,
              initialZoom: 15.0,
              maxZoom: 18.0,
              minZoom: 5.0,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const [],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: path,
                    strokeWidth: 10.0,
                    color: Colors.red,
                  ),
                ],
              ),
              if (currentLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: currentLocation,
                      width: 20,
                      height: 20,
                      child:  Container(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
