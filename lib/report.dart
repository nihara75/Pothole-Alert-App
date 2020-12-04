import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';

class Report extends StatelessWidget {
  String platformResponse;
  final MailOptions mailOptions = MailOptions(
    body: 'a long body for the email <br> with a subset of HTML',
    subject: 'the Email Subject',
    recipients: ['example@example.com'],
    isHTML: true,
    bccRecipients: ['other@example.com'],
    ccRecipients: ['third@example.com'],
    attachments: [ 'path/to/image.png', ],
  );
void sendmail()async{
  final MailerResponse response = await FlutterMailer.send(mailOptions);
  switch (response) {
  case MailerResponse.saved: /// ios only
  platformResponse = 'mail was saved to draft';
  break;
  case MailerResponse.sent: /// ios only
  platformResponse = 'mail was sent';
  break;
  case MailerResponse.cancelled: /// ios only
  platformResponse = 'mail was cancelled';
  break;
  case MailerResponse.android:
  platformResponse = 'intent was successful';
  break;
  default:
  platformResponse = 'unknown';
  break;
  }}
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
