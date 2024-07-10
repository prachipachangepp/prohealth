import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TopRowConstant extends StatelessWidget {
  const TopRowConstant({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 120),
          child: Row(
            children: [
              Image.asset(
                'images/powered_logo.png',
                //  height: 27,
                width: MediaQuery.of(context).size.width/40,
              ),
              SizedBox(width: MediaQuery.of(context).size.width/120),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'symmetry',
                          style: GoogleFonts.firaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff686464),
                          ),
                        ),
                        TextSpan(
                          text: '.',
                          style: GoogleFonts.firaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff686464),
                          ),
                        ),
                        TextSpan(
                          text: 'care',
                          style: GoogleFonts.firaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff686464),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width/1.6),
              Row(
                children: [
                  SvgPicture.asset('images/face_man.svg')
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width/160,),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.firaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff50B5E5),
                      decoration: TextDecoration.underline,
                    ),
                    children: [
                      TextSpan(
                        text: '(4088) ',
                      ),
                      TextSpan(
                        text: '555',
                      ),
                      TextSpan(
                        text: '-',
                      ),
                      TextSpan(
                        text: '1234',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width/30),
              Expanded(
                child: Image.asset('images/logo.png'),
              )
            ],
          ),
        )
    );
  }
}