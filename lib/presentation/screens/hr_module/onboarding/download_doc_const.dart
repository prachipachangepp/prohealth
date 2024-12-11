import 'package:url_launcher/url_launcher.dart';

Future<void> downloadFile(String url) async {
  final Uri uri = Uri.parse(url);
  print('Url Response : ${uri.data}');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

/// image launcher code of ack onboarding
