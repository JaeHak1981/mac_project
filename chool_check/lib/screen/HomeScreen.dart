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
  bool checkButton = false;

  GoogleMapController? mapController;

  static const double okDistance = 100;

  static final Marker marker = Marker(
    markerId: const MarkerId('marker'),
    position: companyLatLng,
  );

  static final Circle withinCircle = Circle(
    circleId: const CircleId('withinCircle'),
    center: companyLatLng,
    fillColor: Colors.blue.withOpacity(0.5),
    radius: okDistance,
    strokeColor: Colors.red,
    strokeWidth: 1,
  );
  static final Circle notWithinCircle = Circle(
    circleId: const CircleId('notWithinCircle'),
    center: companyLatLng,
    fillColor: Colors.red.withOpacity(0.5),
    radius: okDistance,
    strokeColor: Colors.red,
    strokeWidth: 1,
  );
  static final Circle checkDoneCircle = Circle(
    circleId: const CircleId('checkDoneCircle'),
    center: companyLatLng,
    fillColor: Colors.green.withOpacity(0.5),
    radius: okDistance,
    strokeColor: Colors.red,
    strokeWidth: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: FutureBuilder<String>(
          future: checkPermission(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == '위치 서비스가 허가되었습니다') {
              return StreamBuilder<Position>(
                  stream: Geolocator.getPositionStream(),
                  builder: (context, snapshot) {
                    bool isWithinRange = false;
                    final start = snapshot.data!;
                    final end = companyLatLng;
                    if (snapshot.hasData) {
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
                          circle: checkButton
                              ? checkDoneCircle
                              : isWithinRange
                                  ? withinCircle
                                  : notWithinCircle,
                          marker: marker,
                          onMapCreated: onMapCreated,
                        ),
                        _AttendButton(
                          onPressed: onCheckAttendButton,
                          isWithinRange: isWithinRange,
                          checkButton: checkButton,
                        ),
                      ],
                    );
                  });
            }
            return Text(snapshot.data);
          }),
    );
  }

  onCheckAttendButton() async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('출근하기'),
            content: const Text('출근하실래요?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text(
                    'Cancle',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    'Approval',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  )),
            ],
          );
        });
    if (result) {
      checkButton = true;
    }
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<String> checkPermission() async {
    final isLocationPermission = await Geolocator.isLocationServiceEnabled();
    if (!isLocationPermission) {
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
      return '설정에서 위치 서비스를 허가해주세요';
    }
    return '위치 서비스가 허가되었습니다';
  }

  AppBar renderAppBar() {
    return AppBar(
      title: const Text(
        'Go to work',
        style: TextStyle(
            color: Colors.white, fontSize: 35, fontWeight: FontWeight.w700),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              if (mapController != null) {
                mapController!
                    .animateCamera(CameraUpdate.newLatLng(companyLatLng));
              }
            },
            icon: const Icon(
              Icons.my_location,
              color: Colors.white,
              size: 40,
            ))
      ],
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;
  final Circle circle;
  final Marker marker;
  final MapCreatedCallback? onMapCreated;

  const _CustomGoogleMap(
      {required this.initialPosition,
      required this.circle,
      required this.marker,
      required this.onMapCreated,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GoogleMap(
        initialCameraPosition: initialPosition,
        mapType: MapType.normal,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        onMapCreated: onMapCreated,
        markers: Set.from([marker]),
        circles: Set.from([circle]),
      ),
    );
  }
}

class _AttendButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isWithinRange;
  final bool checkButton;

  const _AttendButton({
    required this.onPressed,
    required this.isWithinRange,
    required this.checkButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.timelapse,
          color: checkButton
              ? Colors.green
              : isWithinRange
                  ? Colors.blue
                  : Colors.red,
          size: 60,
        ),
        const SizedBox(height: 30),
        if (!checkButton &&  isWithinRange)
          TextButton(
              onPressed: onPressed,
              child: const Text(
                '출근하기',
                style: TextStyle(fontSize: 50),
              ))
      ],
    ));
  }
}
