import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final String text;
  final IconData iconData;

  const ResponsiveContainer(this.text, this.iconData);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.all(Radius.circular(24)),
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width / 7,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 70,
          vertical: MediaQuery.of(context).size.height / 90,
        ),
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Color(0xff000000).withOpacity(0.3),
          //     blurRadius: 22,
          //     offset: Offset(0, 0),
          //   ),
          // ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 20,
              color: Color(0xff686464),
            ),
            SizedBox(height: 10),
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff686464),
                  fontSize: 14,
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
