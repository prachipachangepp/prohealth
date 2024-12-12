import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../../../../../app/resources/theme_manager.dart';

class PatientDetailsCalender extends StatefulWidget {
  final VoidCallback onBack;
  const PatientDetailsCalender({super.key, required this.onBack});

  @override
  State<PatientDetailsCalender> createState() => _PatientDetailsCalenderState();
}

class _PatientDetailsCalenderState extends State<PatientDetailsCalender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 100),
        child: Column(
          children: [
            Row(
              children: [
                TextButton.icon(
                  onPressed: widget.onBack,
                  label: Text(
                    'Back',
                    style: GoogleFonts.firaSans(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.textBlack),
                  ),
                  icon: Icon(Icons.keyboard_arrow_left_rounded, color: ColorManager.textBlack),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) { return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1,
                    vertical: 5,),
                  child:  Container(
                    height: AppSize.s88,
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p40),
                    margin: EdgeInsets.symmetric(horizontal: AppMargin.m2),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              CircleAvatar(
                                child:
                                Image.asset('images/1.png'),
                              ),
                              SizedBox(width: AppSize.s7),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Corea",
                                    textAlign: TextAlign.center,
                                    style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                      fontWeight: FontWeight.w400,
                                      color: ColorManager.textBlack,),
                                  ),
                                  Text(
                                    "Anaxiety",
                                    textAlign: TextAlign.center,
                                    style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                      fontWeight: FontWeight.w600,
                                      color: ColorManager.mediumgrey,),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Image.asset(
                                "images/sm/location.png",
                                height: 25,width: 26,fit: BoxFit.fill,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                "Tufts International Center, 20 Sawyer Ave,\nMedford MA 02155 ",
                                textAlign: TextAlign.start,
                                style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorManager.textBlack,),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Icon(Icons.access_time_rounded,color: ColorManager.bluelight,),
                              SizedBox(width: 10,),
                              Text("08:05 AM TO 09:00 AM",style:DocumentTypeDataStyle.customTextStyle(context),)
                            ],
                          ),
                        ),

                        Expanded(
                          child: Row(
                            children: [
                             // Text("POC :",style: DocumentTypeDataStyle.customTextStyle(context),),
                             //  Padding(
                             //    padding: const EdgeInsets.all(8.0),
                             //    child: Container(
                             //      color: Color(0xFF527FB9),
                             //      width: 19,
                             //      height: 19,
                             //      child: Center(
                             //        child: Text("ST",style: TextStyle(
                             //          // fontWeight: FontWeight.w600,
                             //          // fontSize: FontSize.s13,
                             //          color: ColorManager.white,
                             //          decoration: TextDecoration.none,
                             //        ),),
                             //      ),
                             //    ),
                             //  ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Color(0xFFFEBD4D),
                                  width: 19,
                                  height: 19,
                                  child: Center(
                                    child: Text("OT",style: TextStyle(
                                      // fontWeight: FontWeight.w600,
                                      //     fontSize: FontSize.s13,
                                      color: ColorManager.white,
                                      decoration: TextDecoration.none,
                                    ),),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              CircleAvatar(
                                child:
                                Image.asset('images/1.png'),
                              ),
                              SizedBox(width: AppSize.s7),
                              Text(
                                'Jeh Tiwari',
                                style:DocumentTypeDataStyle.customTextStyle(context),
                              ),
                            ],
                          ),
                        ),
                        Image.asset("images/sm/contact_schedular.png",
                          height: 50,width: 60,fit: BoxFit.fill,),

                      ],
                    ),
                  ),
                ); },

              ),
            ),
          ],
        ),
      ),
    );
  }
}
