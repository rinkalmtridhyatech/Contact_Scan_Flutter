import 'package:url_launcher/url_launcher.dart';

class CallsAndMessagesService {
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> sendSMS(String number) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: number,
    );
    await launchUrl(launchUri);
  }

  Future<void> sendEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    String url = params.toString();
    if (await canLaunchUrl(Uri.parse(url
    ))) {
      await launchUrl(Uri.parse(url
      ));
    } else {
      print('Could not launch $url');
    }
  }
}
