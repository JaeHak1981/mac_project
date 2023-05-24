import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final LatLng company = LatLng(35.805566, 127.120111);
  static final CameraPosition initialPosition =
      CameraPosition(target: company, zoom: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == '활성화 되었습니다') {
          return Column(
            children: [
              _CustomGoogleMap(initialPosition: initialPosition),
              _ChoolCheckButton(),
            ],
          );
        }

        return Center(
          child: snapshot.data,
        );
      }),
    );
  }

  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      return '위치 서비스르 활성화해 주세요';
    }

    LocationPermission checkPermission = await Geolocator.checkPermission();
    if (checkPermission == LocationPermission.denied) {
      checkPermission = await Geolocator.requestPermission();
      if (checkPermission == LocationPermission.denied) {
        return '위치 서비스를 활성화 해주세요';
      }
    }
    if (checkPermission == LocationPermission.deniedForever) {
      return '설정에서 위치 서비스를 활성화해 주세요';
    }

    return '활성화 되었습니다';
  }

  AppBar renderAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        'Chool Check !!',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;

  const _CustomGoogleMap({required this.initialPosition, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GoogleMap(
        initialCameraPosition: initialPosition,
      ),
    );
  }
}

class _ChoolCheckButton extends StatelessWidget {
  const _ChoolCheckButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: Text('Chool Check'),
    ));
  }
}
