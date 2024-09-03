import 'dart:ui';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/offer_letter_manager.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/offer_letter_html_data/offer_letter_html.dart';
import 'package:prohealth/presentation/screens/hr_module/register/register_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/multi_step_form.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/offer_letter_description_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/verify_user_popup.dart';
import '../../../manage/widgets/bottom_row.dart';
import '../../../manage/widgets/top_row.dart';

class OnBoardingWelcome extends StatelessWidget {

  static const String routeName = "/onBordingWelcome";
  const OnBoardingWelcome({Key? key, }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TokenManager.setAccessToken(token: "svsodasihdsbd", username: "ABC", companyId: 1);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TopRowConstant(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              border: const Border(
                bottom: BorderSide(color: Colors.grey, width: 2.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 5),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            constraints: const BoxConstraints(maxWidth: 1202, maxHeight: 500),
            padding: const EdgeInsets.all(24),
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
                        height: MediaQuery.of(context).size.height / 1.7,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
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
                          color: const Color(0xff686464),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Please go through each section and fill valid information',
                        style: GoogleFonts.firaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff686464),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: 140,
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return VerifyUserpopup();
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff50B5E5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Start',
                            style: GoogleFonts.firaSans(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
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
      bottomNavigationBar: const BottomBarRow(),
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
          borderSide: const BorderSide(color: Color(0xffB1B1B1)),
        ),
        filled: true,
        fillColor: Colors.white,
        labelStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    );
  }
}

class OnBoardingCongratulation extends StatelessWidget {
  final int employeeId;
  const OnBoardingCongratulation({super.key, required this.employeeId,  });
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
        width: 800.0,
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
                  padding: const EdgeInsets.only(top: 20.0),
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
                    color: const Color(0xFF686464),
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
                        color: const Color(0xFF686464),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Please fill the information and provide necessary documents for the upcoming sections',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                        color: const Color(0xFF686464),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async{
                    OfferLetterData offerLetterData = await GetOfferLetter(context, employeeId, 1 );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MultiStepForm(employeeID: employeeId,)),
                    // );
                    if(offerLetterData.statusCode == 409){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MultiStepForm(employeeID: employeeId,)),
                      );
                    }else if(offerLetterData.statusCode == 200 || offerLetterData.statusCode == 201){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                 OfferLetterDescriptionScreen(employeeId: employeeId)));
                    }else{
                      print("Something went wrong!");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF50B5E5),
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
              ],
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
                        color: const Color(0xFF686464),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '(4088) 555-1234',
                      style: GoogleFonts.firaSans(
                        color: const Color(0xFF50B5E5),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xFF50B5E5),
                      ),
                    ),
                    Text(
                      'or email:',
                      style: GoogleFonts.firaSans(
                        color: const Color(0xFF686464),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xFF686464),
                      ),
                    ),
                    Text(
                      'support@symmetry.com',
                      style: GoogleFonts.firaSans(
                        color: const Color(0xFF50B5E5),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xFF50B5E5),
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
