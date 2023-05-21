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
      CameraPosition(target: company, zoom: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GoogleMap(
              initialCameraPosition: initialPosition,
              mapType: MapType.normal,
            ),
          ),
          Expanded(
              child: Center(
            child: Text(
              'ChoolCheck',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          )),
        ],
      ),
    );
  }

 Future<String> checkPermission()async{
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if(!isLocationEnabled){

    }

    return '활성화 되었습니다';
  }

  AppBar renderAppBar(){
    return AppBar(
      backgroundColor: Colors.white,
      title: Text('오늘도 출근', style: TextStyle(color: Colors.blue, fontSize: 30),),
    );
  }
}
