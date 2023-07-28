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
    127.1201237,
  );
  static final CameraPosition initialPosition = CameraPosition(
    target: companyLatLng,
    zoom: 15,
  );

  static const double okDistance = 100;
  static final Circle circle = Circle(
    circleId: CircleId('circle'),
    radius: okDistance,
    center: companyLatLng,
    fillColor: Colors.blue.withOpacity(0.5),
    strokeColor: Colors.red,
    strokeWidth: 1,
  );

  static final Marker marker = Marker(
    markerId: MarkerId('marker'),
    position: companyLatLng,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBart(),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GoogleMap(
              initialCameraPosition: initialPosition,
              mapType: MapType.normal,
              myLocationEnabled: true,
              markers: Set.from([marker]),
              circles: Set.from([circle]),
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.timelapse,
                    size: 60,
                    color: Colors.blue,
                  )),
              SizedBox(
                height: 30,
              ),
              Text(
                'Chool Check',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ))
        ],
      ),
    );
  }

  AppBar renderAppBart() {
    return AppBar(
      title: const Text(
        '오늘도 출근',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
