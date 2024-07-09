import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';


class OnBoardingCongratulation extends StatefulWidget {
  const OnBoardingCongratulation({super.key});

  @override
  State<OnBoardingCongratulation> createState() =>
      _OnBoardingCongratulationState();
}

class _OnBoardingCongratulationState extends State<OnBoardingCongratulation> {
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => OfferLetterScreen()),
                  // );
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
                  Image.asset(
                    'images/faceman.png',
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
