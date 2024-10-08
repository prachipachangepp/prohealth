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
import '../../../../../../../../data/api_data/api_data.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../../../widgets/constant_widgets/button_constant.dart';

class ReferringDiagnososScreen extends StatefulWidget {
  final int patientId;
  ReferringDiagnososScreen({super.key, required this.patientId});

  @override
  State<ReferringDiagnososScreen> createState() =>
      _ReferringDiagnososScreenState();
}

class _ReferringDiagnososScreenState extends State<ReferringDiagnososScreen> {
  TextEditingController DSummarycont = TextEditingController();
  TextEditingController paidhelp = TextEditingController();
  TextEditingController comments = TextEditingController();
  TextEditingController encounterdate = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController icdCodeController = TextEditingController();
  TextEditingController pdDateController = TextEditingController();
  TextEditingController allergiesController = TextEditingController();
  TextEditingController startEffectiveDate = TextEditingController();
  TextEditingController dummyCtrl = TextEditingController();

  String? codestatusB;
  String? codestatusA;

  List<GlobalKey<_ReferringTextfieldState>> referenceFormKeys = [];
  List<GlobalKey<_allergiesState>> allergiesFormKeys = [];
  @override
  void initState() {
    super.initState();
    addReferenseForm();
    addallergiesForm();
  }

  void addReferenseForm() {
    setState(() {
      referenceFormKeys.add(GlobalKey<_ReferringTextfieldState>());
    });
  }

  void addallergiesForm() {
    setState(() {
      allergiesFormKeys.add(GlobalKey<_allergiesState>());
    });
  }

  void removeReferenseForm(GlobalKey<_ReferringTextfieldState> key) {
    setState(() {
      referenceFormKeys.remove(key);
    });
  }

  void removeallergiesForm(GlobalKey<_allergiesState> key) {
    setState(() {
      allergiesFormKeys.remove(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ///button save api done
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      ApiData response = await postRDoneScreen(
                        context,
                        widget.patientId,
                        codestatusA.toString(),
                        codestatusB.toString(),
                        paidhelp.text,
                        comments.text,
                        DSummarycont.text,
                      );

                      for (var key in referenceFormKeys) {
                        final st = key.currentState;
                        await postRDTWOScreen(
                          context,
                          widget.patientId,
                          response.rDignosisId!,
                    //  " title",
                       "Secondary Diagnosis", // titleController.text,
                          st!.prdescription.text,
                          st!.prcode.text,
                          st!.prdate.text,
                        );
                      }

                      for (var key in allergiesFormKeys) {
                        final st = key.currentState;
                        await postRDThreeScreen(
                          context,
                          widget.patientId,
                          response.rDignosisId!,
                          st!.allergiesController.text,
                          st!.startEffectiveDate.text,
                        );
                      }

                      // Optionally show a success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('All API calls were successful!')),
                      );
                    } catch (error) {
                      // Handle the error appropriately
                      print('Error during API calls: $error');

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('An error occurred: $error')),
                      );
                    }
                  },
                  // onPressed: () async {
                  //   await postRDoneScreen(
                  //       context,
                  //       1,
                  //       codestatusA.toString(),
                  //       codestatusB.toString(),
                  //       paidhelp.text,
                  //       comments.text,
                  //       DSummarycont.text);
                  //final List<Map<String, dynamic>> dataForPostRDTWOScreen = [
                  //                       {
                  //                         'param1': 1,
                  //                     'param2': 1,
                  //                     'param3': 'Primary Diagnosis',
                  //                     'param4': descriptionController.text,
                  //                     'param5': icdCodeController.text,
                  //                     'param6': pdDateController.text,
                  //                   },
                  //                     ];
                  //                       for (var data in dataForPostRDTWOScreen) {
                  //                         await postRDTWOScreen(
                  //                           context,
                  //                           data['param1'],
                  //                           data['param2'],
                  //                           data['param3'],
                  //                           data['param4'],
                  //                           data['param5'],
                  //                           data['param6'],
                  //                         );
                  //                       }
                  //   await postRDTWOScreen(
                  //       context,
                  //       1,
                  //       1,
                  //       "Primary Diagnosis", // titleController.text,
                  //       descriptionController.text,
                  //       icdCodeController.text,
                  //       pdDateController.text);
                  //
                  //
                  //   await postRDThreeScreen(
                  //     context,
                  //     1,
                  //     3,
                  //     allergiesController.text,
                  //     startEffectiveDate.text
                  //   );
                  //
                  //
                  // },
                  child: Text(
                    AppString.save,
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s14,
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
              //height: MediaQuery.of(context).size.height / 0.9,
              child: Padding(
                padding: EdgeInsets.only(left: 39.0, right: 40, top: 35.0),
                child: Column(
                  children: [
                    ///Diagnosis Summary textfield
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
                        ///heading
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
                                    style: TableHeading.customTextStyle(
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
                                    style: TableHeading.customTextStyle(
                                        context),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'ICD Code',
                                  style: TableHeading.customTextStyle(
                                      context),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Text(
                                    AppString.date,
                                    style: TableHeading.customTextStyle(
                                        context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 40),

                        ///Primary text field
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
                                            controller: descriptionController,
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
                                              controller: icdCodeController,
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
                                              controller: pdDateController,
                                              labelText: '',
                                              suffixIcon: Icon(
                                                Icons.calendar_month_outlined,
                                                color: ColorManager.blueprime,
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

                        ///Secondary textfield
                        Column(
                          children:
                              referenceFormKeys.asMap().entries.map((entry) {
                            int index = entry.key;
                            GlobalKey<_ReferringTextfieldState> key =
                                entry.value;
                            return ReferringTextfield(
                              key: key,
                              index: index + 1,
                              onRemove: () => removeReferenseForm(key),
                              // employeeID: widget.employeeID,
                            );
                          }).toList(),
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height / 15),

                        ///Last Inpatient Stay Information and  Add button
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 38.0),
                              child: Text(
                                'Last Inpatient Stay Information',
                                style: TextStyle(
                                    fontSize: FontSize.s14,
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
                                  onPressed: addReferenseForm,
                                  // onPressed: () {}
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height / 20),

                        /// Allergies and Start Effective Date Heading
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
                                    style: TableHeading.customTextStyle(
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
                                    style: TableHeading.customTextStyle(
                                        context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height / 80),

                        /// Allergies and Start Effective Date TextField
                        ///

                        Column(
                          children:
                              allergiesFormKeys.asMap().entries.map((entry) {
                            int index = entry.key;
                            GlobalKey<_allergiesState> key = entry.value;
                            return allergies(
                              key: key,
                              index: index + 1,
                              onRemove: () => removeallergiesForm(key),
                            );
                          }).toList(),
                        ),

                        // Row(
                        //   children: [
                        //     Flexible(
                        //       child: Padding(
                        //         padding: const EdgeInsets.only(left: 50.0),
                        //         child: Container(
                        //           height: AppSize.s25,
                        //           width:
                        //               MediaQuery.of(context).size.width / 2.5,
                        //           child: TextFormField(
                        //             controller: allergiesController,
                        //             cursorColor: ColorManager.black,
                        //             decoration: InputDecoration(
                        //               border: OutlineInputBorder(
                        //                 borderRadius:
                        //                     BorderRadius.circular(8.0),
                        //                 borderSide: BorderSide(
                        //                   color:
                        //                       ColorManager.containerBorderGrey,
                        //                   width: 1.0,
                        //                 ),
                        //               ),
                        //               enabledBorder: OutlineInputBorder(
                        //                 borderRadius:
                        //                     BorderRadius.circular(8.0),
                        //                 borderSide: BorderSide(
                        //                   color:
                        //                       ColorManager.containerBorderGrey,
                        //                   width: 1.0,
                        //                 ),
                        //               ),
                        //               focusedBorder: OutlineInputBorder(
                        //                 borderRadius:
                        //                     BorderRadius.circular(8.0),
                        //                 borderSide: BorderSide(
                        //                   color:
                        //                       ColorManager.containerBorderGrey,
                        //                   width: 1.0,
                        //                 ),
                        //               ),
                        //             ),
                        //             style: GoogleFonts.firaSans(
                        //               fontSize: FontSize.s12,
                        //               fontWeight: FontWeightManager.regular,
                        //               color: ColorManager.black,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //         width: MediaQuery.of(context).size.width / 5),
                        //     Container(
                        //       width: AppSize.s267,
                        //       child: SchedularTextField(
                        //           controller: startEffectiveDate,
                        //           labelText: '',
                        //           suffixIcon: Icon(
                        //             Icons.calendar_month_outlined,color: ColorManager.blueprime,
                        //             size: 18,
                        //           )),
                        //     ),
                        //   ],
                        // ),

                        // Row(
                        //   children: [
                        //     Flexible(
                        //       child: Padding(
                        //         padding: const EdgeInsets.only(left: 50.0),
                        //         child: Container(
                        //           height: AppSize.s25,
                        //           width:
                        //               MediaQuery.of(context).size.width / 2.5,
                        //           child: TextFormField(
                        //             cursorColor: ColorManager.black,
                        //             decoration: InputDecoration(
                        //               border: OutlineInputBorder(
                        //                 borderRadius:
                        //                     BorderRadius.circular(8.0),
                        //                 borderSide: BorderSide(
                        //                   color:
                        //                       ColorManager.containerBorderGrey,
                        //                   width: 1.0,
                        //                 ),
                        //               ),
                        //               enabledBorder: OutlineInputBorder(
                        //                 borderRadius:
                        //                     BorderRadius.circular(8.0),
                        //                 borderSide: BorderSide(
                        //                   color:
                        //                       ColorManager.containerBorderGrey,
                        //                   width: 1.0,
                        //                 ),
                        //               ),
                        //               focusedBorder: OutlineInputBorder(
                        //                 borderRadius:
                        //                     BorderRadius.circular(8.0),
                        //                 borderSide: BorderSide(
                        //                   color:
                        //                       ColorManager.containerBorderGrey,
                        //                   width: 1.0,
                        //                 ),
                        //               ),
                        //             ),
                        //             style: GoogleFonts.firaSans(
                        //               fontSize: FontSize.s12,
                        //               fontWeight: FontWeightManager.regular,
                        //               color: ColorManager.black,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //         width: MediaQuery.of(context).size.width / 5),
                        //     Container(
                        //       width: AppSize.s267,
                        //       child: SchedularTextField(
                        //           labelText: '',
                        //           suffixIcon: Icon(
                        //             Icons.calendar_month_outlined,color: ColorManager.blueprime,
                        //             size: 18,
                        //           )),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),

                    ///code status
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
                                          fontSize: FontSize.s14,
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
                                          fontSize: FontSize.s14,
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
                                          fontSize: FontSize.s14,
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
                                          fontSize: FontSize.s14,
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
                                          fontSize: FontSize.s14,
                                          fontWeight: FontWeightManager.regular,
                                          color: ColorManager.greylight)),
                                ],
                              ),
                            ),
                          ],
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
                              onPressed: addallergiesForm,
                              // onPressed: () {}
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),

                    /// helpline & comment
                    Row(
                      children: [
                        Flexible(
                          child: SchedularTextField(
                              controller: paidhelp, labelText: 'Paid Help'),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 40),
                        ////////
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
                            style: GoogleFonts.firaSans(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.regular,
                              color: ColorManager.black,
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

class ReferringTextfield extends StatefulWidget {
  final VoidCallback onRemove;
  final int index;
  ReferringTextfield({super.key, required this.onRemove, required this.index});

  @override
  _ReferringTextfieldState createState() => _ReferringTextfieldState();
}

class _ReferringTextfieldState extends State<ReferringTextfield> {
  TextEditingController prdescription = TextEditingController();
  TextEditingController prcode = TextEditingController();
  TextEditingController prdate = TextEditingController();
  //final TextEditingController secondaryDiagnosisController = TextEditingController(text: 'Secondary Diagnosis');


  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text(

                      'Secondary Diagnosis',
                      style: GoogleFonts.firaSans(
                          fontSize: FontSize.s10,
                          fontWeight: FontWeightManager.regular),
                    ),
                  ),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 10),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 7,
                        child: SchedularTextField(
                          controller: prdescription,
                          labelText: 'pr 1',
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 15),
                      Container(
                          width: MediaQuery.of(context).size.width / 7,
                          child: SchedularTextField(
                            controller: prcode,
                            labelText: 'pr 2',
                          )),
                      SizedBox(width: MediaQuery.of(context).size.width / 15),
                      Container(
                        width: MediaQuery.of(context).size.width / 7,
                        child: SchedularTextField(
                            controller: prdate,
                            labelText: '',
                            suffixIcon: Icon(
                              Icons.calendar_month_outlined,
                              color: ColorManager.blueprime,
                              size: 18,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 20),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class allergies extends StatefulWidget {
  final VoidCallback onRemove;
  final int index;
  const allergies({super.key, required this.onRemove, required this.index});

  @override
  _allergiesState createState() => _allergiesState();
}

class _allergiesState extends State<allergies> {
  TextEditingController allergiesController = TextEditingController();
  TextEditingController startEffectiveDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Container(
                  height: AppSize.s25,
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: allergiesController,
                    cursorColor: ColorManager.black,
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
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.regular,
                      color: ColorManager.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width / 5),
            Container(
              width: AppSize.s267,
              child: SchedularTextField(
                  controller: startEffectiveDate,
                  labelText: '',
                  suffixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: ColorManager.blueprime,
                    size: 18,
                  )),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 80),
      ],
    );
  }
}

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
///
// SizedBox(
//   height: 10,
// ),
// Row(
//   children: [
//     Container(
//       width: MediaQuery.of(context).size.width / 7,
//       child: SchedularTextField(
//         controller: srdescription,
//         labelText: 'sr 1',
//       ),
//     ),
//     SizedBox(width: MediaQuery.of(context).size.width / 15),
//     Container(
//         width: MediaQuery.of(context).size.width / 7,
//         child: SchedularTextField(
//           controller: srcode,
//           labelText: 'sr 2',
//         )),
//     SizedBox(width: MediaQuery.of(context).size.width / 15),
//     Container(
//       width: MediaQuery.of(context).size.width / 7,
//       child: SchedularTextField(
//           controller: srdate,
//           labelText: '',
//           suffixIcon: Icon(
//             Icons.calendar_month_outlined,color: ColorManager.blueprime,
//             size: 18,
//           )),
//     ),
//   ],
// ),
// SizedBox(
//   height: 10,
// ),
// Row(
//   children: [
//     Container(
//       width: MediaQuery.of(context).size.width / 7,
//       child: SchedularTextField(
//         controller: trdescription,
//         labelText: 'tr 1',
//       ),
//     ),
//     SizedBox(width: MediaQuery.of(context).size.width / 15),
//     Container(
//         width: MediaQuery.of(context).size.width / 7,
//         child: SchedularTextField(
//           controller: trcode,
//           labelText: 'tr 2',
//         )),
//     SizedBox(width: MediaQuery.of(context).size.width / 15),
//     Container(
//       width: MediaQuery.of(context).size.width / 7,
//       child: SchedularTextField(
//           controller: trdate,
//           labelText: '',
//           suffixIcon: Icon(
//             Icons.calendar_month_outlined,color: ColorManager.blueprime,
//             size: 18,
//           )),
//     ),
//   ],
// ),
///
// IconButton(
//   icon: Icon(Icons.remove_circle, color: Colors.red,size:12),
//   onPressed: widget.onRemove,
// ),
///
// IconButton(
//   icon: Icon(Icons.remove_circle, color: Colors.red,size:12),
//   onPressed: widget.onRemove,
// ),
///
// TextEditingController srdescription = TextEditingController();
// TextEditingController srcode = TextEditingController();
// TextEditingController srdate = TextEditingController();
// TextEditingController trdescription = TextEditingController();
// TextEditingController trcode = TextEditingController();
// TextEditingController trdate = TextEditingController();
///
// Container(
//   // color: Colors.blue,
//   child: Column(
//     children: [
//       Row(
//         children: [
//           Column(
//             children: [
//               Padding(
//                 padding:
//                     const EdgeInsets.only(left: 40.0),
//                 child: Text(
//                   'Secondary Diagnosis',
//                   style: GoogleFonts.firaSans(
//                       fontSize: FontSize.s10,
//                       fontWeight:
//                           FontWeightManager.regular),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//               width: MediaQuery.of(context).size.width /
//                   10),
//           Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context)
//                             .size
//                             .width /
//                         7,
//                     child: SchedularTextField(
//                       labelText: 'pr 1',
//                     ),
//                   ),
//                   SizedBox(
//                       width: MediaQuery.of(context)
//                               .size
//                               .width /
//                           15),
//                   Container(
//                       width: MediaQuery.of(context)
//                               .size
//                               .width /
//                           7,
//                       child: SchedularTextField(
//                         labelText: 'pr 2',
//                       )),
//                   SizedBox(
//                       width: MediaQuery.of(context)
//                               .size
//                               .width /
//                           15),
//                   Container(
//                     width: MediaQuery.of(context)
//                             .size
//                             .width /
//                         7,
//                     child: SchedularTextField(
//                         labelText: '',
//                         suffixIcon: Icon(
//                           Icons.calendar_month_outlined,
//                           size: 18,
//                         )),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context)
//                             .size
//                             .width /
//                         7,
//                     child: SchedularTextField(
//                       labelText: 'sr 1',
//                     ),
//                   ),
//                   SizedBox(
//                       width: MediaQuery.of(context)
//                               .size
//                               .width /
//                           15),
//                   Container(
//                       width: MediaQuery.of(context)
//                               .size
//                               .width /
//                           7,
//                       child: SchedularTextField(
//                         labelText: 'sr 2',
//                       )),
//                   SizedBox(
//                       width: MediaQuery.of(context)
//                               .size
//                               .width /
//                           15),
//                   Container(
//                     width: MediaQuery.of(context)
//                             .size
//                             .width /
//                         7,
//                     child: SchedularTextField(
//                         labelText: '',
//                         suffixIcon: Icon(
//                           Icons.calendar_month_outlined,
//                           size: 18,
//                         )),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context)
//                             .size
//                             .width /
//                         7,
//                     child: SchedularTextField(
//                       labelText: 'tr 1',
//                     ),
//                   ),
//                   SizedBox(
//                       width: MediaQuery.of(context)
//                               .size
//                               .width /
//                           15),
//                   Container(
//                       width: MediaQuery.of(context)
//                               .size
//                               .width /
//                           7,
//                       child: SchedularTextField(
//                         labelText: 'tr 2',
//                       )),
//                   SizedBox(
//                       width: MediaQuery.of(context)
//                               .size
//                               .width /
//                           15),
//                   Container(
//                     width: MediaQuery.of(context)
//                             .size
//                             .width /
//                         7,
//                     child: SchedularTextField(
//                         labelText: '',
//                         suffixIcon: Icon(
//                           Icons.calendar_month_outlined,
//                           size: 18,
//                         )),
//                   ),
//                 ],
//               ),
//             ],
//           )
//         ],
//       ),
//     ],
//   ),
// ),

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






////////////
//
// Container(
// height: AppSize.s350,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(16),
// border: Border.all(
// width: 2,
// color: ColorManager.black.withOpacity(0.2),
// ),
// boxShadow: [
// BoxShadow(
// color: ColorManager.black.withOpacity(0.15),
// offset: const Offset(0, 4),
// blurRadius: 4,
// spreadRadius: 0,
// ),
// ],
// color: ColorManager.white,
// ),
// child: Stack(
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Expanded(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// SMTextFConst(
// controller: nameController,
// keyboardType: TextInputType.text,
// text: AppStringEM.officename,
// ),
// const SizedBox(height: AppSize.s10),
// SMTextFConstPhone(
// controller: secNumberController,
// keyboardType: TextInputType.number,
// text: AppStringEM.secNum,
// ),
// const SizedBox(height: AppSize.s10),
// SMTextFConst(
// focusNode: _focusNode,
// controller: addressController,
// keyboardType: TextInputType.text,
// text: AppStringEM.address,
// ),
// // The suggestions container will be overlaid here
// // (Only shown if there are suggestions)
// ],
// ),
// ),
// const SizedBox(
// width:
// 16), // Add spacing between columns if needed
// Expanded(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// SMTextFConstPhone(
// controller: primNumController,
// keyboardType: TextInputType.number,
// text: AppStringEM.primNum,
// ),
// const SizedBox(height: AppSize.s10),
// SMTextFConstPhone(
// controller: altNumController,
// keyboardType: TextInputType.number,
// text: AppStringEM.alternatephone,
// ),
// const SizedBox(height: AppSize.s10),
// SMTextFConst(
// controller: emailController,
// keyboardType: TextInputType.text,
// text: AppStringEM.primarymail,
// ),
// ],
// ),
// ),
// ],
// ),
// ValueListenableBuilder<List<String>>(
// valueListenable: _suggestionsNotifier,
// builder: (context, suggestions, child) {
// if (suggestions.isEmpty) return SizedBox.shrink();
// return Positioned(
// top: 150, // Adjust this value as needed
// left: 16,
// right: 16,
// child: Container(
// height: 100,
// width: 300,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(8),
// boxShadow: [
// BoxShadow(
// color: Colors.black26,
// blurRadius: 4,
// offset: Offset(0, 2),
// ),
// ],
// ),
// child: ListView.builder(
// scrollDirection: Axis.vertical,
// itemCount: suggestions.length,
// itemBuilder: (context, index) {
// return ListTile(
// title: Text(
// suggestions[index],
// style: GoogleFonts.firaSans(
// fontSize: FontSize.s12,
// fontWeight: FontWeight.w700,
// color: ColorManager.mediumgrey,
// decoration: TextDecoration.none,
// ),
// ),
// onTap: () {
// addressController.text =
// suggestions[index];
// _focusNode.unfocus();
// _suggestionsNotifier.value = [];
// },
// );
// },
// ),
// ),
// );
// },
// ),
// ],
// ),
// ),