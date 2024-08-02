import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/value_manager.dart';

class ReferralSubmitPopup extends StatefulWidget {
  const ReferralSubmitPopup({super.key});

  @override
  State<ReferralSubmitPopup> createState() => _ReferralSubmitPopupState();
}

class _ReferralSubmitPopupState extends State<ReferralSubmitPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 500,
        height: 150,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 27.0),
              child: Text(
                'Are you sure you want to submit this intake information for John Scott ?',
                style: GoogleFonts.firaSans(
                    fontSize: AppSize.s12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff686464)
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 20.0,bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text('No',
                        style: GoogleFonts.firaSans(
                          fontWeight: FontWeight.w700,
                            fontSize: AppSize.s12,
                            color: Color(0xff686464))),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    height: 26,
                    width: 103,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        child: Text(
                          'Yes',
                          style: GoogleFonts.firaSans(
                            fontWeight: FontWeight.w700,
                            fontSize: AppSize.s12,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff50B5E5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          // Handle 'Yes' action
                          Navigator.of(context).pop();
                        },
                      ),
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
