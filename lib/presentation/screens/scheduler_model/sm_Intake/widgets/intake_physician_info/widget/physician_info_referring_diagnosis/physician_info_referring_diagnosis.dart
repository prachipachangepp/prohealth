import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_info/intake_patients_info.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../app/resources/font_manager.dart';


class ReferringDiagnososScreen extends StatefulWidget {
  const ReferringDiagnososScreen({super.key});

  @override
  State<ReferringDiagnososScreen> createState() => _ReferringDiagnososScreenState();
}

class _ReferringDiagnososScreenState extends State<ReferringDiagnososScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 29.0, right: 32.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorManager.containerBorderGrey
                ),
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height/1,
              child: Padding(
                padding: EdgeInsets.only(left: 39.0, right: 40, top: 35.0),
                child: Column(
                  children: [
                    Container(
                      height: 88,
                      child: TextFormField(
                        maxLines: 3,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'Diagnosis Summary',
                          labelStyle: GoogleFonts.firaSans(
                              fontSize: FontSize.s10,
                              fontWeight: FontWeightManager.regular,
                              color: ColorManager.greylight
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: ColorManager.containerBorderGrey,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: ColorManager.containerBorderGrey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: ColorManager.containerBorderGrey,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),


                    SizedBox(height: MediaQuery.of(context).size.height/25),
                    Column(
                      children: [
                        Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: ColorManager.fmediumgrey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 80.0),
                                    child: Text(
                                      'Title',
                                      style: AllHRTableHeading.customTextStyle(context),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      'Description',
                                      style: AllHRTableHeading.customTextStyle(context),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'ICD Code',
                                    style: AllHRTableHeading.customTextStyle(context),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      'Date',
                                      style: AllHRTableHeading.customTextStyle(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        SizedBox(height: MediaQuery.of(context).size.height/40),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: Text(
                                  'Primary Diagnosis',
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeightManager.regular
                              ),
                              ),
                            ),


                            SizedBox(width: MediaQuery.of(context).size.width/10),
                            Flexible(
                              child: Container(
                                height: 25,
                                width: MediaQuery.of(context).size.width/7,
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: ColorManager.containerBorderGrey,
                                        width: 1.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: ColorManager.containerBorderGrey,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: ColorManager.containerBorderGrey,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),



                            SizedBox(width: MediaQuery.of(context).size.width/15),
                            Flexible(
                              child: Container(
                                height: 25,
                                width: MediaQuery.of(context).size.width/6,
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: ColorManager.containerBorderGrey,
                                        width: 1.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: ColorManager.containerBorderGrey,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: ColorManager.containerBorderGrey,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


///////

