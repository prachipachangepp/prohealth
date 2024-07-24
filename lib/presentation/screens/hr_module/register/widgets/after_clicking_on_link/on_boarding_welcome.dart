import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/offer_letter_description_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/verify_user_popup.dart';
import '../../../manage/widgets/bottom_row.dart';
import '../../../manage/widgets/top_row.dart';

class OnBoardingWelcome extends StatelessWidget {
  const OnBoardingWelcome({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TopRowConstant(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 2.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 5),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            constraints: BoxConstraints(maxWidth: 1202, maxHeight: 500),
            padding: EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'images/doctors.png',
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 2,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 24),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to Prohealth Onboarding Wizard',
                        style: GoogleFonts.firaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff686464),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Please go through each section and fill valid information',
                        style: GoogleFonts.firaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464),
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EnterEmailAndOTPDialog();
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff50B5E5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Start',
                          style: GoogleFonts.firaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBarRow(),
    );
  }
}

//
// Container(
// color: Colors.pink,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// children: [
// Image.asset(
// 'images/doctors.png',
// width: MediaQuery.of(context).size.width / 3,
// height: MediaQuery.of(context).size.height / 2,
// ),
// SizedBox(width: 24),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// 'Welcome to Prohealth Onboarding Wizard',
// style: GoogleFonts.firaSans(
// fontSize: 30,
// fontWeight: FontWeight.w600,
// color: Color(0xff686464),
// ),
// ),
// SizedBox(height: 16),
// Center(
// child: Text(
// 'Please go through each section and fill valid information',
// style: GoogleFonts.firaSans(
// fontSize: 14,
// fontWeight: FontWeight.w400,
// color: Color(0xff686464),
// ),
// ),
// ),
// SizedBox(height: 24),
// Center(
// child: ElevatedButton(
// onPressed: () {
// showDialog(
// context: context,
// builder: (BuildContext context) {
// return VerifyUserPopup();
// },
// );
// },
// style: ElevatedButton.styleFrom(
// backgroundColor: Color(0xff50B5E5),
// padding: const EdgeInsets.symmetric(
// horizontal: 32, vertical: 16),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// ),
// child: Text(
// 'Start',
// style: GoogleFonts.firaSans(
// fontSize: 20,
// fontWeight: FontWeight.w700,
// color: Colors.white),
// ),
// ),
// ),
// ],
// ),
// ],
// ),
// ],
// ),
// ),

// class OnBoardingWelcome extends StatelessWidget {
//   const OnBoardingWelcome({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(kToolbarHeight),
//         child: TopRowConstant(),
//       ),
//       body: Column(
//         children: [
//           Row(
//             children: [
//               Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                     border: Border(
//                       bottom: BorderSide(color: Colors.grey, width: 2.0),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2), // shadow color
//                         offset: Offset(0, 5), // horizontal and vertical offset
//                         blurRadius: 5,
//                         spreadRadius: 1,
//                       ),
//                     ],
//                   ),
//                   width: 1202,
//                   height: 500,
//                   child: Padding(
//                     padding: EdgeInsets.all(24),
//                     child: Container(
//                       color: Colors.pink,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Image.asset(
//                                 'images/doctors.png',
//                                 width: MediaQuery.of(context).size.width / 3,
//                                 height: MediaQuery.of(context).size.height / 2,
//                               ),
//                               SizedBox(width: 24),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Welcome to Prohealth Onboarding Wizard',
//                                     style: GoogleFonts.firaSans(
//                                       fontSize: 30,
//                                       fontWeight: FontWeight.w600,
//                                       color: Color(0xff686464),
//                                     ),
//                                   ),
//                                   SizedBox(height: 16),
//                                   Center(
//                                     child: Text(
//                                       'Please go through each section and fill valid information',
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff686464),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(height: 24),
//                                   Center(
//                                     child: ElevatedButton(
//                                       onPressed: () {
//                                         showDialog(
//                                           context: context,
//                                           builder: (BuildContext context) {
//                                             return VerifyUserPopup();
//                                           },
//                                         );
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Color(0xff50B5E5),
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 32, vertical: 16),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(8),
//                                         ),
//                                       ),
//                                       child: Text(
//                                         'Start',
//                                         style: GoogleFonts.firaSans(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w700,
//                                             color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
// //                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // SizedBox(height: MediaQuery.of(context).size.height / 80),
//           const Row(
//             children: [
//               Flexible(child: BottomBarRow()),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

////////////////////////////////////////VerifyUserPopup////////////////////////

class VerifyUserPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      // shape: RoundedRectangleBorder(
      // ),
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          //color: Colors.white, //background colour pf screen
        ),
        width: 500,
        height: 450,
        child: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xff50B5E5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        Icon(Icons.person_outline,
                            color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          AppString.verify_user,
                          style: GoogleFonts.firaSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  CustomTextField(
                    labelWidget: Row(
                      children: [
                        Icon(Icons.security, color: Color(0xFF50B5E5)),
                        SizedBox(width: 8),
                        Text(
                          AppString.security_code,  style: TextStyle(fontSize: 14),

                        ),
                      ],
                    ),
                    labelText: AppString.security_code,
                    icon: Icons.security,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    labelWidget: Row(
                      children: [
                        Icon(Icons.phone, color: Color(0xFF50B5E5)),
                        SizedBox(width: 8),
                        Text(AppString.phone_number, style: TextStyle(fontSize: 14),),
                      ],
                    ),
                    labelText: AppString.phone_number,
                    icon: Icons.phone,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    labelWidget: Row(
                      children: [
                        Icon(Icons.email, color: Color(0xFF50B5E5)),
                        SizedBox(width: 8),
                        Text(AppString.email, style: TextStyle(fontSize: 14),),
                      ],
                    ),
                    labelText: AppString.email,
                    icon: Icons.email,
                  ),
                  SizedBox(height: 35),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: OnBoardingCongratulation(),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff50B5E5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: GoogleFonts.firaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final Widget? labelWidget;
  final IconData icon;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.icon,
    this.labelWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        label: labelWidget,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xffB1B1B1)),
        ),
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    );
  }
}

//
// class VerifyUserPopup extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.white,
//       titlePadding: EdgeInsets.zero,
//       title: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12.0),
//           color: Colors.white,
//         ),
//         width: 500,
//         height: 450,
//         child: Column(
//           children: [
//             Container(
//               height: 60,
//               decoration: BoxDecoration(
//                 color: Color(0xff50B5E5),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(13),
//                   topRight: Radius.circular(13),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: 16),
//                     child: Row(
//                       children: [
//                         Image.asset('images/verify_user.png', width: 20, height: 20),
//                         SizedBox(width: 8),
//                         Text(
//                           AppString.verify_user,
//                           style: GoogleFonts.firaSans(
//                             fontSize: 24,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     icon: Image.asset('images/cancle_button.png', width: 20, height: 20),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(24),
//               child: Column(
//                 children: [
//                   CustomTextField(
//                     labelWidget: Row(
//                       children: [
//                         Image.asset('images/security_code.png'),
//                         // SizedBox(width: 8),
//                         Text(AppString.security_code),
//                       ],
//                     ),
//                     labelText: AppString.security_code,
//                     iconPath: 'images/security_code.png',
//                   ),
//                   SizedBox(height: 16),
//                   CustomTextField(
//                     labelWidget: Row(
//                       children: [
//                         Image.asset('images/phone_number.png', width: 0, height: 0),
//                         SizedBox(width: 8),
//                         Text(AppString.phone_number),
//                       ],
//                     ),
//                     labelText: AppString.phone_number,
//                     iconPath: 'images/phone_number.png',
//                   ),
//                   SizedBox(height: 16),
//                   CustomTextField(
//                     labelWidget: Row(
//                       children: [
//                         Image.asset('images/email.png', width: 20, height: 20),
//                         SizedBox(width: 8),
//                         Text(AppString.email),
//                       ],
//                     ),
//                     labelText: AppString.email,
//                     iconPath: 'images/email.png',
//                   ),
//                   SizedBox(height: 24),
//                   ElevatedButton(
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return Dialog(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             child: OnBoardingCongratulation(),
//                           );
//                         },
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xff50B5E5),
//                       padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       'Continue',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CustomTextField extends StatelessWidget {
//   final String labelText;
//   final Widget? labelWidget;
//   final String iconPath;
//
//   const CustomTextField({
//     Key? key,
//     required this.labelText,
//     this.labelWidget,
//     required this.iconPath,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//         label: labelWidget,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Color(0xffB1B1B1)),
//         ),
//         filled: true,
//         fillColor: Colors.white,
//         labelStyle: TextStyle(color: Colors.grey),
//         contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//         prefixIcon: Padding(
//           padding: EdgeInsets.all(12.0),
//           child: Image.asset(iconPath, width: 20, height: 20),
//         ),
//       ),
//     );
//   }
// }

////////////////////////////////////congratulation/////////////////////////////////////
class OnBoardingCongratulation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 1.0,
        ),
      ),
      child: Container(
        width: 900.0,
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Image.asset(
                    'images/single_doctor.png',
                    height: 277.0,
                    width: 372.0,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Congratulations!',
                  style: GoogleFonts.firaSans(
                    color: Color(0xFF686464),
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'You are a part of ProHealth family',
                      style: GoogleFonts.firaSans(
                        color: Color(0xFF686464),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Please fill the information and provide necessary documents for the upcoming sections',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                        color: Color(0xFF686464),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OfferLetterDescriptionScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF50B5E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: GoogleFonts.firaSans(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 5.0,
                  runSpacing: 5.0,
                  children: [
                    SvgPicture.asset(
                      'images/face_man.svg',
                      height: 24.0,
                      width: 24.0,
                    ),
                    Text(
                      'For any assistance please call:',
                      style: GoogleFonts.firaSans(
                        color: Color(0xFF686464),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '(4088) 555-1234',
                      style: GoogleFonts.firaSans(
                        color: Color(0xFF50B5E5),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF50B5E5),
                      ),
                    ),
                    Text(
                      'or email:',
                      style: GoogleFonts.firaSans(
                        color: Color(0xFF686464),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF686464),
                      ),
                    ),
                    Text(
                      'support@symmetry.com',
                      style: GoogleFonts.firaSans(
                        color: Color(0xFF50B5E5),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF50B5E5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
