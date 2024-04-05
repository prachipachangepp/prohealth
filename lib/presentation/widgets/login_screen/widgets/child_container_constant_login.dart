import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final String text;
  final ImageProvider imageProvider;

  const ResponsiveContainer(this.text, this.imageProvider);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.all(Radius.circular(24)),
      child: Container(
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width / 7.7,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 70,
          vertical: MediaQuery.of(context).size.height / 90,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: imageProvider,
              width: 30,
              height: 30,
            ),
            SizedBox(height: 10),
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff686464),
                  fontSize: 12,
                  fontFamily: 'FiraSans',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
