import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'constant.dart';
import 'home.dart';
class Report extends StatefulWidget {


  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String platformResponse;
  final _firestore=FirebaseFirestore.instance;

  static String locat=" ";
  final MailOptions mailOptions = MailOptions(
    body: locat,
    subject: 'Potholes Nearby ',
    recipients: ['niharar25@gmail.com'],
    isHTML: true,
    /* bccRecipients: ['other@example.com'],
    ccRecipients: ['third@example.com'],
    attachments: [ 'path/to/image.png', ],*/
  );


  void getd() async{
   await _firestore.collection("location").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        //print(result.data());
        setState(() {
          locat=result.data().toString();
        });

        print(locat);
      });
    });
   sendmail();
   /*Future.delayed(const Duration(seconds: 5), () {

// Here you can write your code



   });*/


  }

  void sendmail()async{

    /*print(locat);
    print(locat);
    print(locat);*/
    final MailerResponse response = await FlutterMailer.send(mailOptions);
    switch (response) {
      case MailerResponse.saved: /// ios only
      ///
        setState(() {
          platformResponse = 'mail was saved to draft';
        });

        break;
      case MailerResponse.sent: /// ios only
        setState(() {
          platformResponse = 'mail was sent';
        });
        break;
      case MailerResponse.cancelled: /// ios only
        setState(() {
          platformResponse = 'mail was cancelled';
        });
        break;
      case MailerResponse.android:
        setState(() {
          platformResponse = 'intent was successful';
        });
        break;
      default:
        setState((){platformResponse = 'unknown';});

        break;
    }


    Alert(
      context: context,
      type: AlertType.info,
      title: "STATUS",
      desc: platformResponse,
      buttons: [
        DialogButton(
          child: Text(
            "DONE",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
          color:kPrimaryColor
        )
      ],
    ).show();
  }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getd();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold());
  }
}


