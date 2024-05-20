import 'dart:ui';

import 'package:flutter/material.dart';

class UpdatePassMobileScreen extends StatelessWidget {
  const UpdatePassMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 4,
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/mobile_images/mobile_login.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height / 30,
                  vertical: MediaQuery.of(context).size.width / 8,
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 5),
                  ),
                ),
              ),
            )));
  }
}
