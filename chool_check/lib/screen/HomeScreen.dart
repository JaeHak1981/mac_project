import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool checkDone = false;
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
              return const Center(
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
                              ? checkDoneCircle
                              : isWithinRange
                                  ? withinCircle
                                  : notWithinCircle,
                          marker: marker,
                          onMapCreated: onMapCreated,
                        ),
                        _ChoolCheckButton(
                          isWithinRange: isWithinRange,
                          onPressed: onChoolCheckButton,
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

  onChoolCheckButton() async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('출근하기'),
            content: Text('출근하시겠습니까?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Cance')),
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
      return '설정에서 위치 서비스를 허가해주세요';
    }
    return '위치 서비스가 허가되었습니다';
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  AppBar renderAppBar() {
    return AppBar(
      title: const Text('오늘도 출근',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700)),
      centerTitle: true,
      backgroundColor: Colors.white,
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
            icon: const Icon(
              Icons.my_location,
              color: Colors.blue,
            ))
      ],
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;
  final Circle circle;

  final Marker marker;
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
        Icon(
          Icons.timelapse,
          color: checkDone
              ? Colors.green
              : isWithinRange
                  ? Colors.blue
                  : Colors.red,
          size: 40,
        ),
        const SizedBox(
          height: 30,
        ),
        if (!checkDone && isWithinRange)
          TextButton(
              onPressed: onPressed,
              child: const Text(
                'Chool Check',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ))
      ],
    ));
  }
}
