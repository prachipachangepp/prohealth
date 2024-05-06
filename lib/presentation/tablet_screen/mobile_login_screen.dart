import 'package:flutter/material.dart';

class MobileLogIn extends StatelessWidget {
  const MobileLogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.green,
              height: 40,
              width: 80,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.orange,
              height: 40,
              width: 80,
            ),
          )
        ],
      ),
    ));
  }
}
