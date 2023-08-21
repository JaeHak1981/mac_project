import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool choolCheckDone = false;
  GoogleMapController? mapController;
  static final LatLng companyLatLng = LatLng(35.805720, 127.1201237);
  static final CameraPosition initialPosition =
      CameraPosition(target: companyLatLng, zoom: 15);

  static final double okDistance = 100;

  static final Circle withinCircle = Circle(
    circleId: CircleId('withinCircle'),
    center: companyLatLng,
    radius: okDistance,
    fillColor: Colors.blue.withOpacity(0.5),
    strokeColor: Colors.red,
    strokeWidth: 1,
  );
  static final Circle notWithinCircle = Circle(
    circleId: CircleId('notWithinCircle'),
    center: companyLatLng,
    radius: okDistance,
    fillColor: Colors.red.withOpacity(0.5),
    strokeColor: Colors.red,
    strokeWidth: 1,
  );
  static final Circle checkDoneCircle = Circle(
    circleId: CircleId('checkDoneCircle'),
    center: companyLatLng,
    radius: okDistance,
    fillColor: Colors.green.withOpacity(0.5),
    strokeColor: Colors.green,
    strokeWidth: 1,
  );

  static final Marker marker =
      Marker(markerId: MarkerId('marker'), position: companyLatLng);

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
                    bool withinRange = false;

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
                        withinRange = true;
                      }
                    }

                    return Column(
                      children: [
                        _GoogleMap(
                            initialPosition: initialPosition,
                            circle: choolCheckDone
                                ? checkDoneCircle
                                : withinRange
                                    ? withinCircle
                                    : notWithinCircle,
                            marker: marker,
                            onMapCreated: onMapCreated),
                        _ChoolCheckButton(
                          withinCircle: withinRange,
                          onPressed: onChoolCheckPressed,
                          choolCheckDone: choolCheckDone,
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
            title: Text('Go to work'),
            content: Text('Do you go to work'),
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
        choolCheckDone = true;
      });
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  AppBar renderAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Go to Work',
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

              mapController!.animateCamera(CameraUpdate.newLatLng(
                  LatLng(location.latitude, location.longitude)));
            },
            icon: Icon(
              Icons.my_location,
              color: Colors.white,
              size: 40,
            ))
      ],
    );
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
}

class _GoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;

  final Marker marker;
  final Circle circle;
  final MapCreatedCallback onMapCreated;

  const _GoogleMap(
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
  final bool withinCircle;
  final VoidCallback onPressed;
  final bool choolCheckDone;

  const _ChoolCheckButton({
    required this.withinCircle,
    required this.onPressed,
    required this.choolCheckDone,
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
          color: choolCheckDone
              ? Colors.green
              : withinCircle
                  ? Colors.blue
                  : Colors.red,
          size: 50,
        ),
        SizedBox(
          height: 30,
        ),
        if (!choolCheckDone && withinCircle)
          TextButton(
              onPressed: onPressed,
              child: Text(
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
