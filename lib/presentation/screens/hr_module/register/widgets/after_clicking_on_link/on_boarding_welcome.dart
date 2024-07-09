//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// void main() {
//   runApp(MaterialApp(
//     home: OnBoardingWelcome(),
//     debugShowCheckedModeBanner: false,
//   ));
// }
//
// class OnBoardingWelcome extends StatelessWidget {
//   const OnBoardingWelcome({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SizedBox(
//           width: 1202,
//           height: 626, // card height and width
//           child: Card(
//             margin: EdgeInsets.all(16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(24),
//               child: Column(
//                 children: [
//                   SvgPicture.asset(
//                     'assets/images/doctors.svg',
//                     width: 300, // adjust width and height if needed
//                     height: 300,
//                   ),
//                   SizedBox(height: 24),
//                   Text(
//                     'Welcome to Prohealth Onboarding Wizard',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Please go through each section and fill valid information',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 24),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Add your onPressed code here!
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       'Start',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(8),
//         child: Text(
//           'Washington DC • 196.168.1.231',
//           style: TextStyle(color: Colors.grey, fontSize: 12),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/top_row.dart';

import 'offer_letter_description_screen.dart';

void main() {
  runApp(MaterialApp(
    home: OnBoardingWelcome(),
    debugShowCheckedModeBanner: false,
  ));
}

class OnBoardingWelcome extends StatelessWidget {
  const OnBoardingWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          width: 1202,
          height: 626, // card height and width
          child: Card(
            color: Colors.white,
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Image.asset(
                  //       'images/symmetry_care_logo.png', // Replace with the actual logo asset
                  //       height: 50,
                  //     ),
                  //     Row(
                  //       children: [
                  //         Icon(Icons.phone, color: Colors.blue),
                  //         SizedBox(width: 8),
                  //         Text('(4088) 555-1234', style: TextStyle(color: Colors.blue)),
                  //         SizedBox(width: 16),
                  //         Image.asset(
                  //           'images/prohealth_logo.png', // Replace with the actual logo asset
                  //           height: 50,
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 24),
                  Row(
                    children: [
                      Image.asset(
                        'images/doctors.png',
                        width: MediaQuery.of(context).size.width/3, // adjust width and height if needed
                        height: MediaQuery.of(context).size.height/1.3,
                      ),
                      SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome to Prohealth Onboarding Wizard',
                              style: GoogleFonts.firaSans(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff686464)
                              ),
                            ),
                            SizedBox(height: 16),
                            Center(
                              child: Text(
                                'Please go through each section and fill valid information',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff686464),
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => OfferLetterDescriptionScreen()));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff50B5E5),
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Start',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Spacer(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       '#2031ABC01BA',
                  //       style: TextStyle(color: Colors.grey, fontSize: 12),
                  //     ),
                  //     Text(
                  //       'Washington DC • 196.168.1.231',
                  //       style: TextStyle(color: Colors.grey, fontSize: 12),
                  //     ),
                  //     Image.asset(
                  //       'images/powered_by_logo.png',
                  //       height: 20,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

