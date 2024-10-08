import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:prohealth/presentation/screens/hr_module/manage/widgets/bottom_row.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/offer_letter_description_screen.dart';

import '../../../manage/widgets/top_row.dart';

class OnBoardingThankYou extends StatelessWidget {
  const OnBoardingThankYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(kToolbarHeight),
      //   child: TopRowConstant(),
      // ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                width: 1202,
                height: 626,
                child: Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'images/doctor.svg',
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height / 1.3,
                        ),
                        SizedBox(width: 24),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/logo.png',
                                  // width: MediaQuery.of(context).size.width / 3,
                                  // height: MediaQuery.of(context).size.height / 1.3,
                                ),
                                SizedBox(height: 25),
                                Center(
                                  child: Text(
                                    'Thank You',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff686464),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24),
                                Center(
                                  child: Text(
                                    'You have submitted all the needed\n     Information and Documents',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF686464)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 20), // Add some spacing if needed
              // Row(
              //   children: [
              //     BottomBarRow()
              //   ],
              // ) // Add your BottomRow widget here
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBarRow(),
    );
  }
}
