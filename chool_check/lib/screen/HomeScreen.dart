import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? mapController;
  bool checkDone = false;

  static final LatLng companyLatLng = const LatLng(
    35.805720,
    127.1201237,
  );
  static final CameraPosition initialPosition = CameraPosition(
    target: companyLatLng,
    zoom: 15,
  );

  static final double okDistance = 100;

  static final Circle withinCircle = Circle(
    circleId: const CircleId('withinCircle'),
    center: companyLatLng,
    radius: okDistance,
    fillColor: Colors.blue.withOpacity(0.5),
    strokeColor: Colors.red,
    strokeWidth: 1,
  );
  static final Circle notWithinCircle = Circle(
    circleId: const CircleId('notWithinCircle'),
    center: companyLatLng,
    radius: okDistance,
    fillColor: Colors.red.withOpacity(0.5),
    strokeColor: Colors.red,
    strokeWidth: 1,
  );
  static final Circle checkDoneCircle = Circle(
    circleId: const CircleId('checkDoneCircle'),
    center: companyLatLng,
    radius: okDistance,
    fillColor: Colors.green.withOpacity(0.5),
    strokeColor: Colors.red,
    strokeWidth: 1,
  );

  static final Marker marker = Marker(
    markerId: const MarkerId('marker'),
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data == '위치 서비스가 허가되었습니다') {
              return StreamBuilder<Position>(
                  stream: Geolocator.getPositionStream(),
                  builder: (context, snapshot) {
                    final start = snapshot.data!;
                    final end = companyLatLng;
                    bool isWithinRange = false;

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
                            circle:checkDone ? checkDoneCircle :
                                isWithinRange ? withinCircle : notWithinCircle,
                            marker: marker,
                            onMapCreated: onMapCreated),
                        _ChoolCheckButton(
                          isWithinRange: isWithinRange,
                          onPressed: onChoolCheckPressed, checkDone: checkDone,
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
            title: const Text('Go to work'),
            content: const Text('Do you go to work'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Approval')),
            ],
          );
        });

    if (result) {
      checkDone = true;
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
      return '설정에서 위치 서비스를 허가해주세요';
    }

    return '위치 서비스가 허가되었습니다';
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  AppBar renderAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Go to work',
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
      ),
      actions: [
        IconButton(
            onPressed: () async {
              if (mapController == null) {
                return;
              }
              final location = await Geolocator.getCurrentPosition();

              mapController!.animateCamera(CameraUpdate.newLatLng(LatLng(
                location.latitude,
                location.longitude,
              )));
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
  final Marker marker;
  final Circle circle;
  final MapCreatedCallback onMapCreated;

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
        Icon(
          Icons.timelapse,
          color:checkDone ? Colors.green : isWithinRange ? Colors.blue : Colors.red,
          size: 40,
        ),
        const SizedBox(
          height: 30,
        ),
        if (!checkDone &&  isWithinRange)
          TextButton(
              onPressed: onPressed,
              child: const Text(
                'Go to work',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ))
      ],
    ));
  }
}
