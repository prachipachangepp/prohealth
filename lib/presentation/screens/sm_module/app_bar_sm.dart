import 'package:flutter/material.dart';

class AppBarSM extends StatelessWidget {
  const AppBarSM({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          ///main container
          Container(
            height: 131,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xff000000).withOpacity(0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
              color: Color(0xffFFFFFF)
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                        child: Container(
                      //color: Colors.grey,

                    )),
                    Expanded(
                      flex: 10,
                        child: Container(
                         // color: Colors.red,
                        )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                        child: Container(
                      color: Colors.grey,

                    )),
                    Expanded(
                      flex: 10,
                        child: Container(
                          color: Colors.red,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
