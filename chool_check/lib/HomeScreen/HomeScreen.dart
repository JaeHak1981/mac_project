import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          _CustomGoogleMap(initialPosition: initialPosition),
          _ChoolCheckButton(),
        ],
      ),
    );
  }

  AppBar renderAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        '오늘도 출근',
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
      ),
    );
  }
}
class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;
  const _CustomGoogleMap({required this.initialPosition, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GoogleMap(
        initialCameraPosition: initialPosition,
        mapType: MapType.normal,
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
        child: Text('Chool Check!!!', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700, fontSize: 40),),
      ),
    );
  }
}
