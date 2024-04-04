import 'package:flutter/material.dart';

class LoginBaseConstant extends StatelessWidget {
  final Widget child;

  LoginBaseConstant({required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
       // height: 725,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/login_screen_no_blur.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 58.0, vertical: 58),
            child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff000000).withOpacity(0.045),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(1, 4),
                    ),
                  ],
                  color: Color(0xffFFFFFF).withOpacity(0.35),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 90,
                      vertical: MediaQuery.of(context).size.height / 100),
            child: child,
          ),
        ),
      ),
      )),
    );
  }
}
