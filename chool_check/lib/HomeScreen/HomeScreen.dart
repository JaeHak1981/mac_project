import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final LatLng companyLng = LatLng(37.5233273, 126.921252);
  static final CameraPosition initialPosition =
      CameraPosition(target: companyLng, zoom: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialPosition,
      ),
    );
  }
}
