import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/offer_letter_description_screen.dart';

import '../../../manage/widgets/top_row.dart';

class OnBoardingWelcome extends StatelessWidget {
  const OnBoardingWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TopRowConstant(),
      ),
      body: Center(
        child: Container(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


////////////////////////////////////////popup////////////////////////


class VerifyUserPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        width: 500,
        height: 450,
        child: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xff50B5E5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 450,
                    top: 16,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified_user, color: Colors.white),
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
                        Icon(Icons.security),
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
                        Icon(Icons.phone),
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
                        Icon(Icons.email),
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
          borderSide: BorderSide(color: Color(0xff50B5E5)),
        ),
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.grey),
        contentPadding:
        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    );
  }
}


////////////////////////////////////congratulation/////////////////////////////////////


class OnBoardingCongratulation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OfferLetterDescriptionScreen()));
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
