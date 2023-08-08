import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final LatLng companyLatLng = LatLng(35.805720, 127.1201237);
  static final CameraPosition initialPosition =
      CameraPosition(target: companyLatLng, zoom: 15);

  bool checkDone = false;

  static final double okDistance = 100;
  static final Circle withinCircle = Circle(
    circleId: CircleId('withinCircle'),
    radius: okDistance,
    center: companyLatLng,
    fillColor: Colors.blue.withOpacity(0.5),
    strokeColor: Colors.red,
    strokeWidth: 1,
  );
  static final Circle notWithinCircle = Circle(
    circleId: CircleId('notWithinCircle'),
    radius: okDistance,
    center: companyLatLng,
    fillColor: Colors.red.withOpacity(0.5),
    strokeColor: Colors.red,
    strokeWidth: 1,
  );
  static final Circle doneCircle = Circle(
    circleId: CircleId('doneCircle'),
    radius: okDistance,
    center: companyLatLng,
    fillColor: Colors.green.withOpacity(0.5),
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
      body: FutureBuilder<String>(
          future: checkPermission(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data == '위치 서비스가 허가되었습니다') {
              return StreamBuilder<Position>(
                  stream: Geolocator.getPositionStream(),
                  builder: (context, snapshot) {
                    bool isWithinRange = false;
                    if (snapshot.hasData) {
                      final start = snapshot.data!;
                      final end = companyLatLng;
                      final distance = Geolocator.distanceBetween(
                        start.latitude,
                        start.longitude,
                        end.latitude,
                        end.longitude,
                      );
                      if (distance < okDistance) {
                        isWithinRange = true;
                      }
                    }

                    return Column(
                      children: [
                        _CustomGoogleMap(
                          initialPosition: initialPosition,
                          circle: checkDone
                              ? doneCircle
                              : isWithinRange
                                  ? withinCircle
                                  : notWithinCircle,
                          marker: marker,
                        ),
                        _ChoolCheckButton(
                          isWithinRange: isWithinRange,
                          onPressed: onChoolCheckPressed,
                          checkDone: checkDone,
                        ),
                      ],
                    );
                  });
            }
            return Text(snapshot.data);
          }),
    );
  }

  void onChoolCheckPressed() async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Chool Check'),
            content: Text('출근하기?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Approval')),
            ],
          );
        });
    if (result) {
      setState(() {
        checkDone = true;
      });
    }
  }

  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return '위치 서비스를 허가해주세요';
    }
    LocationPermission checkPermission = await Geolocator.checkPermission();
    if (checkPermission == LocationPermission.denied) {
      checkPermission = await Geolocator.requestPermission();
    }
    if (checkPermission == LocationPermission.denied) {
      return '위치 서비스를 허가해주세요';
    }
    if (checkPermission == LocationPermission.deniedForever) {
      return '설정에서 위치 서비스를 허가해 주세요';
    }
    return '위치 서비스가 허가되었습니다';
  }

  AppBar renderAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        '오늘도 출근',
        style: TextStyle(
            color: Colors.blue, fontSize: 40, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;
  final Circle circle;
  final Marker marker;

  const _CustomGoogleMap({
    required this.initialPosition,
    required this.circle,
    required this.marker,
    super.key,
  });

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
  final bool isWithinRange;
  final VoidCallback onPressed;
  final bool checkDone;

  const _ChoolCheckButton({
    required this.isWithinRange,
    required this.onPressed,
    required this.checkDone,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.timelapse,
              color: checkDone
                  ? Colors.green
                  : isWithinRange
                      ? Colors.blue
                      : Colors.red,
              size: 60,
            )),
        const SizedBox(height: 30),
        if (!checkDone && isWithinRange)
          TextButton(
              onPressed: onPressed,
              child: const Text(
                'Chool Check',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 50,
                    fontWeight: FontWeight.w700),
              ))
      ],
    ));
  }
}
