import 'package:flutter/material.dart';

class BottomBarRow extends StatelessWidget {
  const BottomBarRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 120),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#2031ABC01BA',
                style: TextStyle(
                    fontFamily: 'FiraSans',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              Row(
                children: [
                  Text(
                    'Washington DC',
                    style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '198.168.1.231',
                    style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    'images/powered_logo.png',
                    height: 23,
                    width: 30,
                  ),
                  Text(
                    'Powered by',
                    style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // Padding(
    //   padding: EdgeInsets.symmetric(
    //       horizontal: MediaQuery.of(context).size.width / 120),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Text(
    //         '#2031ABC01BA',
    //         style: TextStyle(
    //             fontFamily: 'FiraSans',
    //             fontSize: 12,
    //             fontWeight: FontWeight.w400,
    //             color: Colors.black),
    //       ),
    //       Row(
    //         children: [
    //           Text(
    //             'Washington DC',
    //             style: TextStyle(
    //                 fontFamily: 'FiraSans',
    //                 fontSize: 12,
    //                 fontWeight: FontWeight.w700,
    //                 color: Colors.black),
    //           ),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           Text(
    //             '198.168.1.231',
    //             style: TextStyle(
    //                 fontFamily: 'FiraSans',
    //                 fontSize: 12,
    //                 fontWeight: FontWeight.w400,
    //                 color: Colors.black),
    //           ),
    //         ],
    //       ),
    //       Column(
    //         children: [
    //           Image.asset(
    //             'images/powered_logo.png',
    //             height: 23,
    //             width: 30,
    //           ),
    //           Text(
    //             'Powered by',
    //             style: TextStyle(
    //                 fontFamily: 'FiraSans',
    //                 fontSize: 12,
    //                 fontWeight: FontWeight.w400,
    //                 color: Colors.black),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
