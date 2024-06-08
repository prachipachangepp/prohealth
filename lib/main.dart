import 'package:flutter/material.dart';
import 'package:prohealth/app/services/token/token_manager.dart';

import 'app/app.dart';

Future<void> main() async {
  bool token = await checkToken();
  runApp(
      App(
    signedIn: token,
  )
  );
}

Future<bool> checkToken() async {
  String token = await TokenManager.getAccessToken();
  if (token.isEmpty) {
    return false;
  } else {
    return true;
  }
}
