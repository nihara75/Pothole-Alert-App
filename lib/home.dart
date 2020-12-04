import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import 'map.dart';

import 'camera.dart';
import 'bndbox.dart';
import 'models.dart';
import 'constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'report.dart';




class Home extends StatefulWidget {
  final List<CameraDescription> cameras;

  Home(this.cameras);
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<Home> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  loadModel() async {
    String res;
    switch (_model) {
      case yolo:
        res = await Tflite.loadModel(
          model: "assets/converted_model.tflite",
          labels: "assets/labels.txt",
        );
        break;
    }
    print("hello loaded module...");
    print(res);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(130.0),
            child: AppBar(
                backgroundColor: kPrimaryColor,
                elevation: 30,title: Center(child: Padding(
                  padding: const EdgeInsets.only(top:40.0),
                  child: Text('Pothole  Alert',style: TextStyle(color:kTextColor,fontWeight: FontWeight.bold,
                  fontFamily:'Satisfy',fontSize:30.0 ),),
                )),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                      topRight: Radius.circular(50)
                )))),
        body: _model == ""
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset("assets/loc.svg"),
                    RaisedButton(
                      child: const Text(
                        'START JOURNEY',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      onPressed: () => onSelect(yolo),
                    ),
                    RaisedButton(
                      child: const Text(
                        'MAPPING TOUR',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Gmap())),
                    ),
                    RaisedButton(
                      child: const Text(
                        '  REPORT PWD  ',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Report())),
                    )
                  ],
                ),
              )
            : Stack(
                children: [
                  Camera(
                    widget.cameras,
                    _model,
                    setRecognitions,
                  ),
                  BndBox(
                      _recognitions == null ? [] : _recognitions,
                      math.max(_imageHeight, _imageWidth),
                      math.min(_imageHeight, _imageWidth),
                      screen.height,
                      screen.width,
                      _model),
                ],
              ),
      ),
    );
  }
}
/*


 */