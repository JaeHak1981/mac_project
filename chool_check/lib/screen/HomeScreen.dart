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
  static final CameraPosition initialPosition = CameraPosition(
    target: companyLatLng,
    zoom: 15,
  );

  static const double okDistance = 100;

  static final Circle withinCircle = Circle(
    circleId: CircleId('withinCircle'),
    fillColor: Colors.blue.withOpacity(0.5),
    radius: okDistance,
    center: companyLatLng,
    strokeColor: Colors.red,
    strokeWidth: 1,
  );
  static final Circle notWithinCircle = Circle(
    circleId: CircleId('notWithinCircle'),
    fillColor: Colors.red.withOpacity(0.5),
    radius: okDistance,
    center: companyLatLng,
    strokeColor: Colors.red,
    strokeWidth: 1,
  );
  static final Circle doneCircle = Circle(
    circleId: CircleId('doneCircle'),
    fillColor: Colors.green.withOpacity(0.5),
    radius: okDistance,
    center: companyLatLng,
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
                            onMapCreated: onMapCreated,
                            withinCircle: checkDone ?  doneCircle :
                                isWithinRange ? withinCircle : notWithinCircle,
                            marker: marker),
                        _AttendanceButton(
                            isWithinRange: isWithinRange,
                          attendPressed: onAttendPressed,
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

  onAttendPressed() async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('출근'),
            content: const Text('출근할래?'),
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

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  AppBar renderAppBar() {
    return AppBar(
      title: const Text(
        'Go to work',
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
      centerTitle: true,
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
              size: 30,
              color: Colors.white,
            ))
      ],
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;
  final MapCreatedCallback? onMapCreated;
  final Circle withinCircle;
  final Marker marker;

  const _CustomGoogleMap(
      {required this.initialPosition,
      required this.onMapCreated,
      required this.withinCircle,
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
        onMapCreated: onMapCreated,
        markers: Set.from([marker]),
        circles: Set.from([withinCircle]),
      ),
    );
  }
}

class _AttendanceButton extends StatelessWidget {
  final bool isWithinRange;
  final VoidCallback attendPressed;
  final bool checkDone;

  const _AttendanceButton({
    required this.attendPressed,
    required this.isWithinRange,
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
          color:checkDone ? Colors.green :
          isWithinRange ? Colors.blue : Colors.red,
          size: 60,
        ),
        const SizedBox(
          height: 20,
        ),
        if(!checkDone &&isWithinRange)
        TextButton(
            onPressed: attendPressed,
            child: const Text(
              '출근하기',
              style: TextStyle(color: Colors.blue, fontSize: 50),
            ))
      ],
    ));
  }
}
