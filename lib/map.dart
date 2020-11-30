import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
LatLng p=LatLng(45.521563, -122.677433);

class Gmap extends StatefulWidget {
  @override
  _GmapState createState() => _GmapState();
}

class _GmapState extends State<Gmap>  {
  GoogleMapController mapController;
 static LatLng _center;
final _firestore=FirebaseFirestore.instance;
 /* final LatLng _center =LatLng(45.521563, -122.677433);*/
  List<Marker> markers = <Marker>[];

  void getloc() async{

  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
  setState(() {
    _center=LatLng(position.latitude,position.longitude);
  });
  }

  void addmarker(){
   /* setState(() {
      markers.clear(); // 2
    });*/
    _firestore.collection("location").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        final location=result.data();
        final lati=location['Lat'];
        final longi=location['Lon'];
        markers.add(Marker(position: LatLng(lati,longi),markerId: MarkerId(result.id)));
      });
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getloc();
    addmarker();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Navigate Potholes')),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          myLocationEnabled: true,
          markers: Set<Marker>.of(markers),

        ),
      ),
    );

  }
}
