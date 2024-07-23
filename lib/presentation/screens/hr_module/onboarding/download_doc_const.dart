// import 'package:url_launcher/url_launcher.dart';
//
// Future<void> _downloadFile(String url) async {
//   final Uri uri = Uri.parse(url);
//   if (await canLaunchUrl(uri)) {
//     await launchUrl(uri);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
// // lib/url_launcher_utils.dart

import 'package:url_launcher/url_launcher.dart';

Future<void> downloadFile(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}
