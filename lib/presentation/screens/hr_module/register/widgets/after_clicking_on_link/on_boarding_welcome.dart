import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/offer_letter_description_screen.dart';
import '../../../manage/widgets/bottom_row.dart';
import '../../../manage/widgets/top_row.dart';

class OnBoardingWelcome extends StatelessWidget {
  const OnBoardingWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TopRowConstant(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // shadow color
                      offset: Offset(0, 5), // horizontal and vertical offset
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                width: 1202,
                height: 626,
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'images/doctors.png',
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 1.3,
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
                                      color: Color(0xff686464),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Center(
                                    child: Text(
                                      'Please go through each section and fill valid information',
                                      style: GoogleFonts.firaSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff686464),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return VerifyUserPopup();
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff50B5E5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 32, vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 80),
              Row(
                children: [BottomBarRow()],
              )
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////VerifyUserPopup////////////////////////

class VerifyUserPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      // shape: RoundedRectangleBorder(
      // ),
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.white, //background colour pf screen
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
                            color: Colors.white, size: 28),
                        SizedBox(width: 8),
                        Text(
                          AppString.verify_user,
                          style: GoogleFonts.firaSans(
                            fontSize: 24,
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
                        Text(AppString.security_code),
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
                        Text(AppString.phone_number),
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
                        Text(AppString.email),
                      ],
                    ),
                    labelText: AppString.email,
                    icon: Icons.email,
                  ),
                  SizedBox(height: 24),
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
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
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
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0), // Adjust padding as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'images/single_doctor.png',
                height: 277.0,
                width: 372.0,
              ),
              SizedBox(height: 20.0),
              Text(
                'Congratulations!',
                style: GoogleFonts.firaSans(
                    color: Color(0xFF686464),
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20.0),
              Text(
                'You are a part of ProHealth family',
                style: GoogleFonts.firaSans(
                    color: Color(0xFF686464),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20.0),
              Text(
                'Please fill the information and provide necessary documents for the upcoming sections',
                textAlign: TextAlign.center,
                style: GoogleFonts.firaSans(
                    color: Color(0xFF686464),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
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
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Wrap(
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
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '(4088) 555-1234',
                    style: GoogleFonts.firaSans(
                        color: Color(0xFF50B5E5),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'or email:',
                    style: GoogleFonts.firaSans(
                        color: Color(0xFF686464),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'support@symmetry.com',
                    style: GoogleFonts.firaSans(
                        color: Color(0xFF50B5E5),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
