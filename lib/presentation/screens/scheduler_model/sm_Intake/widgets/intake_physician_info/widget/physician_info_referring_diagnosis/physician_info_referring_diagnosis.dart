import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_info/intake_patients_info.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../app/services/api/managers/sm_module_manager/physician_info/referral_diagonsis_manager.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../../../widgets/constant_widgets/button_constant.dart';

class ReferringDiagnososScreen extends StatefulWidget {
  const ReferringDiagnososScreen({super.key});

  @override
  State<ReferringDiagnososScreen> createState() =>
      _ReferringDiagnososScreenState();
}

class _ReferringDiagnososScreenState extends State<ReferringDiagnososScreen> {


TextEditingController DSummarycont = TextEditingController();
TextEditingController paidhelp = TextEditingController();
TextEditingController comments = TextEditingController();
TextEditingController encounterdate = TextEditingController();
// TextEditingController encounterdate = TextEditingController();
// TextEditingController encounterdate = TextEditingController();
// TextEditingController encounterdate = TextEditingController();
// TextEditingController encounterdate = TextEditingController();


  String? codestatusB ;
  String? codestatusA;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                ElevatedButton(
                  onPressed: () async {

                    await postRDoneScreen(
                      context,
                      1,
                      codestatusA.toString(),
                      codestatusB.toString(),
                      paidhelp.text,
                      comments.text,
                      DSummarycont.text
                    );
                  },
                  child: Text(
                    AppString.save,
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManager.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                    backgroundColor: ColorManager.blueprime,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height / 60),
          Padding(
            padding: EdgeInsets.only(left: 29.0, right: 32.0),

            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorManager.containerBorderGrey),
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height / 0.9,
              child: Padding(
                padding: EdgeInsets.only(left: 39.0, right: 40, top: 35.0),
                child: Column(

                  children: [

                    Container(
                      height: AppSize.s88,
                      child: TextFormField(
                        controller: DSummarycont,
                        maxLines: 3,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'Diagnosis Summary',
                          labelStyle: GoogleFonts.firaSans(
                              fontSize: FontSize.s10,
                              fontWeight: FontWeightManager.regular,
                              color: ColorManager.greylight),
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
                    SizedBox(height: MediaQuery.of(context).size.height / 25),
                    Column(
                      children: [
                        Container(
                          height: AppSize.s30,
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
                                    style: AllHRTableHeading.customTextStyle(
                                        context),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    'Description',
                                    style: AllHRTableHeading.customTextStyle(
                                        context),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'ICD Code',
                                  style: AllHRTableHeading.customTextStyle(
                                      context),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Text(
                                    AppString.date,
                                    style: AllHRTableHeading.customTextStyle(
                                        context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height / 40),
                        // Row(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(left: 40.0),
                        //       child: Text(
                        //           'Primary Diagnosis',
                        //       style: GoogleFonts.firaSans(
                        //         fontSize: FontSize.s10,
                        //         fontWeight: FontWeightManager.regular
                        //       ),
                        //       ),
                        //     ),
                        //
                        //
                        //     SizedBox(width: MediaQuery.of(context).size.width/10),
                        //     Flexible(
                        //       child: Container(
                        //         height: AppSize.s25,
                        //         width: MediaQuery.of(context).size.width/7,
                        //         child: TextFormField(
                        //           cursorColor: ColorManager.black,
                        //           decoration: InputDecoration(
                        //             border: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(8.0),
                        //               borderSide: BorderSide(
                        //                 color: ColorManager.containerBorderGrey,
                        //                 width: 1.0,
                        //               ),
                        //             ),
                        //             enabledBorder: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(8.0),
                        //               borderSide: BorderSide(
                        //                 color: ColorManager.containerBorderGrey,
                        //                 width: 1.0,
                        //               ),
                        //             ),
                        //             focusedBorder: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(8.0),
                        //               borderSide: BorderSide(
                        //                 color: ColorManager.containerBorderGrey,
                        //                 width: 1.0,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //
                        //
                        //
                        //     SizedBox(width: MediaQuery.of(context).size.width/15),
                        //     Flexible(
                        //       child: Container(
                        //         height: AppSize.s25,
                        //         width: MediaQuery.of(context).size.width/6,
                        //         child: TextFormField(
                        //           cursorColor: ColorManager.black,
                        //           decoration: InputDecoration(
                        //             border: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(8.0),
                        //               borderSide: BorderSide(
                        //                 color: ColorManager.containerBorderGrey,
                        //                 width: 1.0,
                        //               ),
                        //             ),
                        //             enabledBorder: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(8.0),
                        //               borderSide: BorderSide(
                        //                 color: ColorManager.containerBorderGrey,
                        //                 width: 1.0,
                        //               ),
                        //             ),
                        //             focusedBorder: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(8.0),
                        //               borderSide: BorderSide(
                        //                 color: ColorManager.containerBorderGrey,
                        //                 width: 1.0,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //
                        //     SizedBox(width: MediaQuery.of(context).size.width/15),
                        //     Container(
                        //       width: AppSize.s267,
                        //       child: SchedularTextField(
                        //           labelText: '',
                        //           suffixIcon: Icon(
                        //             Icons.calendar_month_outlined,
                        //             size: 18,
                        //           )
                        //           ),
                        //     ),
                        //   ],
                        // ),

                        Container(
                          // color: Colors.blue,
                          child: Column(children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 40.0),
                                      child: Text(
                                        '  Primary Diagnosis   ',
                                        style: GoogleFonts.firaSans(
                                            fontSize: FontSize.s10,
                                            fontWeight:
                                                FontWeightManager.regular),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 10),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              7,
                                          child: SchedularTextField(
                                            labelText: 'pr 1',
                                          ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                15),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                7,
                                            child: SchedularTextField(
                                              labelText: 'pr 2',
                                            )),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                15),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              7,
                                          child: SchedularTextField(
                                              labelText: '',
                                              suffixIcon: Icon(
                                                Icons.calendar_month_outlined,
                                                size: 18,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ]),
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height / 20),

                        Container(
                          // color: Colors.blue,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40.0),
                                        child: Text(
                                          'Secondary Diagnosis',
                                          style: GoogleFonts.firaSans(
                                              fontSize: FontSize.s10,
                                              fontWeight:
                                                  FontWeightManager.regular),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          10),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                7,
                                            child: SchedularTextField(
                                              labelText: 'pr 1',
                                            ),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  15),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  7,
                                              child: SchedularTextField(
                                                labelText: 'pr 2',
                                              )),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  15),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                7,
                                            child: SchedularTextField(
                                                labelText: '',
                                                suffixIcon: Icon(
                                                  Icons.calendar_month_outlined,
                                                  size: 18,
                                                )),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                7,
                                            child: SchedularTextField(
                                              labelText: 'sr 1',
                                            ),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  15),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  7,
                                              child: SchedularTextField(
                                                labelText: 'sr 2',
                                              )),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  15),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                7,
                                            child: SchedularTextField(
                                                labelText: '',
                                                suffixIcon: Icon(
                                                  Icons.calendar_month_outlined,
                                                  size: 18,
                                                )),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                7,
                                            child: SchedularTextField(
                                              labelText: 'tr 1',
                                            ),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  15),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  7,
                                              child: SchedularTextField(
                                                labelText: 'tr 2',
                                              )),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  15),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                7,
                                            child: SchedularTextField(
                                                labelText: '',
                                                suffixIcon: Icon(
                                                  Icons.calendar_month_outlined,
                                                  size: 18,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        // ///////2 nd containe 3 row
                        // SizedBox(height: MediaQuery.of(context).size.height/20),
                        // Row(
                        //   children: [
                        //     Column(
                        //       children: [
                        //         Padding(
                        //           padding: const EdgeInsets.only(left: 40.0),
                        //           child: Text(
                        //             'Primary   Diagnosis',
                        //             style: GoogleFonts.firaSans(
                        //                 fontSize: FontSize.s10,
                        //                 fontWeight: FontWeightManager.regular,
                        //               color: Colors.transparent
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),

                        // SizedBox(width: MediaQuery.of(context).size.width/10),

                        // Row(
                        //   children: [
                        //     Container(
                        //       width: AppSize.s267,
                        //       child: SchedularTextField(
                        //           labelText: 'pr 1',
                        //
                        //       ),
                        //     ),
                        //     SizedBox(width: MediaQuery.of(context).size.width/15),
                        //     Container(
                        //       width: AppSize.s267,
                        //       child: SchedularTextField(
                        //         labelText: 'pr 2',
                        //       )
                        //       ),
                        //     SizedBox(width: MediaQuery.of(context).size.width/15),
                        //     Container(
                        //       width: AppSize.s267,
                        //       child: SchedularTextField(
                        //           labelText: '',
                        //           suffixIcon: Icon(
                        //             Icons.calendar_month_outlined,
                        //             size: 18,
                        //           )
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Flexible(
                        //   child: Container(
                        //     height: AppSize.s25,
                        //     width: MediaQuery.of(context).size.width/7,
                        //     child: TextFormField(
                        //
                        //       cursorColor: ColorManager.black,
                        //       decoration: InputDecoration(
                        //         border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(8.0),
                        //           borderSide: BorderSide(
                        //             color: ColorManager.containerBorderGrey,
                        //             width: 1.0,
                        //           ),
                        //         ),
                        //         enabledBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(8.0),
                        //           borderSide: BorderSide(
                        //             color: ColorManager.containerBorderGrey,
                        //             width: 1.0,
                        //           ),
                        //         ),
                        //         focusedBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(8.0),
                        //           borderSide: BorderSide(
                        //             color: ColorManager.containerBorderGrey,
                        //             width: 1.0,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        // Flexible(
                        //   child: Container(
                        //     height: AppSize.s25,
                        //     width: MediaQuery.of(context).size.width/6,
                        //     child: TextFormField(
                        //       cursorColor: ColorManager.black,
                        //       decoration: InputDecoration(
                        //         border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(8.0),
                        //           borderSide: BorderSide(
                        //             color: ColorManager.containerBorderGrey,
                        //             width: 1.0,
                        //           ),
                        //         ),
                        //         enabledBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(8.0),
                        //           borderSide: BorderSide(
                        //             color: ColorManager.containerBorderGrey,
                        //             width: 1.0,
                        //           ),
                        //         ),
                        //         focusedBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(8.0),
                        //           borderSide: BorderSide(
                        //             color: ColorManager.containerBorderGrey,
                        //             width: 1.0,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        // SizedBox(width: MediaQuery.of(context).size.width/15),
                        // Container(
                        //   width: AppSize.s267,
                        //   child: SchedularTextField(
                        //       labelText: '',
                        //       suffixIcon: Icon(
                        //         Icons.calendar_month_outlined,
                        //         size: 18,
                        //       )
                        //   ),
                        // ),
                        //   ],
                        // ),

//
// ///////////////////////////////////////
//                       SizedBox(height: MediaQuery.of(context).size.height/100),
//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 40.0),
//                               child: Text(
//                                 'Secondary Diagnosis',
//                                 style: GoogleFonts.firaSans(
//                                     fontSize: FontSize.s10,
//                                     fontWeight: FontWeightManager.regular
//                                 ),
//                               ),
//                             ),
//
//
//                             SizedBox(width: MediaQuery.of(context).size.width/10),
//                             Flexible(
//                               child: Container(
//                                 height: AppSize.s25,
//                                 width: MediaQuery.of(context).size.width/7,
//                                 child: TextFormField(
//                                   cursorColor: Colors.black,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8.0),
//                                       borderSide: BorderSide(
//                                         color: ColorManager.containerBorderGrey,
//                                         width: 1.0,
//                                       ),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8.0),
//                                       borderSide: BorderSide(
//                                         color: ColorManager.containerBorderGrey,
//                                         width: 1.0,
//                                       ),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8.0),
//                                       borderSide: BorderSide(
//                                         color: ColorManager.containerBorderGrey,
//                                         width: 1.0,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//
//
//                             SizedBox(width: MediaQuery.of(context).size.width/15),
//                             Flexible(
//                               child: Container(
//                                 height: AppSize.s25,
//                                 width: MediaQuery.of(context).size.width/6,
//                                 child: TextFormField(
//                                   cursorColor: ColorManager.black,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8.0),
//                                       borderSide: BorderSide(
//                                         color: ColorManager.containerBorderGrey,
//                                         width: 1.0,
//                                       ),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8.0),
//                                       borderSide: BorderSide(
//                                         color: ColorManager.containerBorderGrey,
//                                         width: 1.0,
//                                       ),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8.0),
//                                       borderSide: BorderSide(
//                                         color: ColorManager.containerBorderGrey,
//                                         width: 1.0,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//                             SizedBox(width: MediaQuery.of(context).size.width/15),
//                             Container(
//                               width: AppSize.s267,
//                               child: SchedularTextField(
//                                   labelText: '',
//                                   suffixIcon: Icon(
//                                     Icons.calendar_month_outlined,
//                                     size: 18,
//                                   )
//                                  ),
//                             ),
//                           ],
//                         ),
//
//
//
// /////////////////////////////////////////
//                         SizedBox(height: MediaQuery.of(context).size.height/100),
//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 40.0),
//                               child: Text(
//                                 'Primary Diagnosis',
//                                 style: GoogleFonts.firaSans(
//                                     fontSize: FontSize.s10,
//                                     fontWeight: FontWeightManager.regular,
//                                   color: Colors.transparent
//                                 ),
//                               ),
//                             ),
//
//
//                             SizedBox(width: MediaQuery.of(context).size.width/10),
//                             Flexible(
//                               child: Container(
//                                 height: AppSize.s25,
//                                 width: MediaQuery.of(context).size.width/7,
//                                 child: TextFormField(
//                                   cursorColor: ColorManager.black,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8.0),
//                                       borderSide: BorderSide(
//                                         color: ColorManager.containerBorderGrey,
//                                         width: 1.0,
//                                       ),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8.0),
//                                       borderSide: BorderSide(
//                                         color: ColorManager.containerBorderGrey,
//                                         width: 1.0,
//                                       ),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8.0),
//                                       borderSide: BorderSide(
//                                         color: ColorManager.containerBorderGrey,
//                                         width: 1.0,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//
//
//                             SizedBox(width: MediaQuery.of(context).size.width/15),
//                             Flexible(
//                               child: Container(
//                                 height: AppSize.s25,
//                                 width: MediaQuery.of(context).size.width/6,
//                                 child: TextFormField(
//                                   cursorColor: ColorManager.black,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8.0),
//                                       borderSide: BorderSide(
//                                         color: ColorManager.containerBorderGrey,
//                                         width: 1.0,
//                                       ),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8.0),
//                                       borderSide: BorderSide(
//                                         color: ColorManager.containerBorderGrey,
//                                         width: 1.0,
//                                       ),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8.0),
//                                       borderSide: BorderSide(
//                                         color: ColorManager.containerBorderGrey,
//                                         width: 1.0,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//                             SizedBox(width: MediaQuery.of(context).size.width/15),
//                             Container(
//                               width: AppSize.s267,
//                               child: SchedularTextField(
//                                   labelText: '',
//                                   suffixIcon: Icon(
//                                     Icons.calendar_month_outlined,
//                                     size: 18,
//                                   )
//                                   ),
//                             ),
//                           ],
//                         ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height / 15),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 38.0),
                              child: Text(
                                'Last Inpatient Stay Information',
                                style: TextStyle(
                                    fontSize: FontSize.s12,
                                    fontWeight: FontWeightManager.semiBold,
                                    color: ColorManager.textPrimaryColor),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 39.0),
                              child: Container(
                                height: AppSize.s32,
                                width: AppSize.s105,
                                child: SchedularIconButtonConst(
                                    text: 'Add New',
                                    icon: Icons.add,
                                    onPressed: () {}),
                              ),
                            ),
                          ],
                        ),

                        //////////////2nd container separate
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 20),
                        Container(
                          height: AppSize.s30,
                          decoration: BoxDecoration(
                            color: ColorManager.fmediumgrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 9,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 274.0),
                                  child: Text(
                                    'Allergies',
                                    style: AllHRTableHeading.customTextStyle(
                                        context),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    'Start Effective Date',
                                    style: AllHRTableHeading.customTextStyle(
                                        context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height / 80),
                        Row(
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 50.0),
                                child: Container(
                                  height: AppSize.s25,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: TextFormField(
                                    cursorColor: ColorManager.black,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color:
                                              ColorManager.containerBorderGrey,
                                          width: 1.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color:
                                              ColorManager.containerBorderGrey,
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color:
                                              ColorManager.containerBorderGrey,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 5),
                            Container(
                              width: AppSize.s267,
                              child: SchedularTextField(
                                  labelText: '',
                                  suffixIcon: Icon(
                                    Icons.calendar_month_outlined,
                                    size: 18,
                                  )),
                            ),
                          ],
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height / 80),
                        Row(
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 50.0),
                                child: Container(
                                  height: AppSize.s25,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: TextFormField(
                                    cursorColor: ColorManager.black,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color:
                                              ColorManager.containerBorderGrey,
                                          width: 1.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color:
                                              ColorManager.containerBorderGrey,
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color:
                                              ColorManager.containerBorderGrey,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 5),
                            Container(
                              width: AppSize.s267,
                              child: SchedularTextField(
                                  labelText: '',
                                  suffixIcon: Icon(
                                    Icons.calendar_month_outlined,
                                    size: 18,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Code Status',
                                  style: GoogleFonts.firaSans(
                                      fontSize: FontSize.s10,
                                      fontWeight: FontWeightManager.regular,
                                      color: ColorManager.greylight),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: AppPadding.p80),
                              child: Row(
                                children: [
                                  Radio<String>(
                                    value: 'Male',
                                    groupValue: codestatusA,
                                    onChanged: (value) =>
                                        setState(() => codestatusA = value),
                                  ),
                                  Text(AppString.male,
                                      style: GoogleFonts.firaSans(
                                          fontSize: FontSize.s12,
                                          fontWeight: FontWeightManager.regular,
                                          color: ColorManager.greylight)),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          45),
                                  Radio<String>(
                                    value: 'Female',
                                    groupValue: codestatusA,
                                    onChanged: (value) =>
                                        setState(() => codestatusA = value),
                                  ),
                                  Text(AppString.female,
                                      style: GoogleFonts.firaSans(
                                          fontSize: FontSize.s12,
                                          fontWeight: FontWeightManager.regular,
                                          color: ColorManager.greylight)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 80),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Code Status',
                                  style: GoogleFonts.firaSans(
                                      fontSize: FontSize.s10,
                                      fontWeight: FontWeightManager.regular),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: AppPadding.p180),
                              child: Row(
                                children: [
                                  Radio<String>(
                                    value: 'Alone',
                                    groupValue: codestatusB,
                                    onChanged: (value) =>
                                        setState(() => codestatusB = value),
                                  ),
                                  Text('Alone',
                                      style: GoogleFonts.firaSans(
                                          fontSize: FontSize.s12,
                                          fontWeight: FontWeightManager.regular,
                                          color: ColorManager.greylight)),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          45),
                                  Radio<String>(
                                    value: 'Spouse',
                                    groupValue: codestatusB,
                                    onChanged: (value) =>
                                        setState(() => codestatusB = value),
                                  ),
                                  Text('Spouse',
                                      style: GoogleFonts.firaSans(
                                          fontSize: FontSize.s12,
                                          fontWeight: FontWeightManager.regular,
                                          color: ColorManager.greylight)),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          45),
                                  Radio<String>(
                                    value: 'Other',
                                    groupValue: codestatusB,
                                    onChanged: (value) =>
                                        setState(() => codestatusB = value),
                                  ),
                                  Text(AppString.other,
                                      style: GoogleFonts.firaSans(
                                          fontSize: FontSize.s12,
                                          fontWeight: FontWeightManager.regular,
                                          color: ColorManager.greylight)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Row(
                      children: [
                        Flexible(
                          child: SchedularTextField(
                              controller: paidhelp,
                              labelText: 'Paid Help'),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 40),
                        Container(
                          height: AppSize.s54,
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: TextFormField(
                            controller: comments,
                            cursorColor: ColorManager.black,
                            decoration: InputDecoration(
                              labelText: AppString.comment,
                              labelStyle: GoogleFonts.firaSans(
                                  fontSize: FontSize.s10,
                                  fontWeight: FontWeightManager.regular,
                                  color: ColorManager.greylight),
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
                      ],
                    )
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
