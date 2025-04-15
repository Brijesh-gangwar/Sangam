import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enhanced Location Tracker',
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
                  builder: (context) => MapDisplayScreen(
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

  double _calculateDistance(List<LatLng> path) {
    const Distance distance = Distance();
    double totalDistance = 0;
    for (int i = 0; i < path.length - 1; i++) {
      totalDistance += distance(path[i], path[i + 1]);
    }
    return totalDistance / 1000; // in kilometers
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
  double _currentZoom = 15.0;

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
        distanceFilter: 5,
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

  void _zoomIn() {
    setState(() {
      _currentZoom += 1;
    });
    _mapController.move(_mapCenter, _currentZoom);
  }

  void _zoomOut() {
    setState(() {
      _currentZoom -= 1;
    });
    _mapController.move(_mapCenter, _currentZoom);
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
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _mapCenter,
              initialZoom: _currentZoom,
              maxZoom: 18.0,
              minZoom: 5.0,
              interactionOptions:
                  const InteractionOptions(flags: InteractiveFlag.all),
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const [],
              ),
              if (_currentLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _currentLocation!,
                      child:
                          const Icon(Icons.location_pin, color: Colors.red, size: 40),
                    ),
                  ],
                ),
              if (_trackedPath.isNotEmpty)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _trackedPath.first,
                      child: const Icon(Icons.flag, color: Colors.green, size: 40),
                    ),
                  ],
                ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _trackedPath,
                    strokeWidth: 4.0,
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: _zoomIn,
                  child: const Icon(Icons.zoom_in),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _zoomOut,
                  child: const Icon(Icons.zoom_out),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MapDisplayScreen extends StatelessWidget {
  final List<LatLng> path;

  const MapDisplayScreen({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    final mapController = MapController();
    return Scaffold(
      appBar: AppBar(title: const Text("Path on Map")),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter:
              path.isNotEmpty ? path.first : const LatLng(37.7749, -122.4194),
          initialZoom: 15.0,
          maxZoom: 18.0,
          minZoom: 5.0,
          interactionOptions: const InteractionOptions(flags: InteractiveFlag.all),
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
                strokeWidth: 4.0,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
