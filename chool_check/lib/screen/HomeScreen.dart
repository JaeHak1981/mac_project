import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final LatLng companyLatLng = LatLng(
    35.805720,
    127.120237,
  );
  static final CameraPosition initialPosition = CameraPosition(
    target: companyLatLng,
    zoom: 15,
  );

  static final double okDistance = 100;
  static final Circle circle = Circle(
      circleId: CircleId('circle'),
      center: companyLatLng,
      radius: okDistance,
      fillColor: Colors.blue.withOpacity(0.5),
      strokeColor: Colors.red,
      strokeWidth: 1);

  static final Marker marker = Marker(
    markerId: MarkerId('marker'),
    position: companyLatLng,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        mapType: MapType.normal,

        myLocationEnabled: true,
        markers: Set.from([marker]),
        circles: Set.from([circle]),
      ),
    );
  }
}
