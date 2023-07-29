import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final LatLng companyLatLng = LatLng(
    35.805728,
    127.1201237,
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
    strokeWidth: 1,
  );

  static final Marker marker = Marker(
    markerId: MarkerId('marker'),
    position: companyLatLng,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: Column(
        children: [
          _CustomGoogleMap(
            initialPosition: initialPosition,
            circle: circle,
            marker: marker,
          ),
          _ChoolCheckButton(),
        ],
      ),
    );
  }

  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return '위치 권한을 허가해주세요';
    }
    LocationPermission checkPermission = await Geolocator.checkPermission();
    if (checkPermission == LocationPermission.denied) {
      checkPermission = await Geolocator.requestPermission();
    }
    if (checkPermission == LocationPermission.denied) {
      return '위치 권한을 허가해주세요';
    }
    if (checkPermission == LocationPermission.deniedForever) {
      return '설정에서 위치 권한을 허가해주세요';
    }
    return '위치 권한이 허가되었습니다';
  }

  AppBar renderAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        '오늘도 출근',
        style: TextStyle(
            color: Colors.blue, fontSize: 35, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;
  final Circle circle;
  final Marker marker;

  const _CustomGoogleMap(
      {required this.initialPosition,
      required this.circle,
      required this.marker,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GoogleMap(
        initialCameraPosition: initialPosition,
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        circles: Set.from([circle]),
        markers: Set.from([marker]),
      ),
    );
  }
}

class _ChoolCheckButton extends StatelessWidget {
  const _ChoolCheckButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.timelapse,
              color: Colors.blue,
              size: 60,
            )),
        const SizedBox(
          height: 40,
        ),
        const Text(
          'Chool Check',
          style: TextStyle(
              color: Colors.blue, fontSize: 40, fontWeight: FontWeight.w700),
        )
      ],
    ));
  }
}
