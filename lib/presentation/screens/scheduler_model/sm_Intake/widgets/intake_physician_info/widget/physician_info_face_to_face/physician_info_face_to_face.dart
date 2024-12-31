import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_info/intake_patients_info.dart';

import '../../../../../../../../app/services/api/managers/sm_module_manager/physician_info/face_to_face_manager.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';

class PhysicianFaceToFace extends StatefulWidget {
  final int patientId;
  PhysicianFaceToFace({super.key, required this.patientId});

  @override
  State<PhysicianFaceToFace> createState() => _PhysicianFaceToFaceState();
}

class _PhysicianFaceToFaceState extends State<PhysicianFaceToFace> {
  String? requiredftof;
  String? seenby;
  String? visitSchudule;

  // TextEditingController _dateController = TextEditingController();

  final TextEditingController encounterdate = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      encounterdate.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: AppPadding.p32),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: [
      //           Text(
      //             'Status Completed',
      //             style: GoogleFonts.firaSans(
      //                 fontSize: FontSize.s14,
      //                 fontWeight: FontWeightManager.bold,
      //                 color: ColorManager.greenDark),
      //           ),
      //           SizedBox(
      //             width: 15,
      //           ),
      //           ElevatedButton(
      //             onPressed: () async {
      //               await postFaceToFaceScreen(
      //                 context,
      //                 widget.patientId,
      //                 requiredftof.toString(),
      //                 encounterdate.text,//"2024-08-09",
      //                 seenby.toString(),
      //                 encounterdate.text,
      //                 visitSchudule.toString(),
      //               );
      //             },
      //             child: Text(
      //               AppString.save,
      //               style: GoogleFonts.firaSans(
      //                 fontSize: FontSize.s14,
      //                 fontWeight: FontWeightManager.bold,
      //                 color: ColorManager.white,
      //               ),
      //             ),
      //             style: ElevatedButton.styleFrom(
      //               padding: const EdgeInsets.symmetric(
      //                 horizontal: 25,
      //                 vertical: 10,
      //               ),
      //               backgroundColor: ColorManager.blueprime,
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(12),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     SizedBox(height: MediaQuery.of(context).size.height / 60),
      //     Padding(
      //       padding: const EdgeInsets.only(
      //           left: AppPadding.p29, right: AppPadding.p32),
      //       child: Container(
      //         height: AppSize.s317,
      //         decoration: BoxDecoration(
      //           color: ColorManager.white,
      //           border: Border.all(
      //             color: ColorManager.lightGrey,
      //             width: 1.0,
      //           ),
      //           borderRadius: BorderRadius.circular(12.0),
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.black.withOpacity(0.2),
      //               spreadRadius: 5,
      //               blurRadius: 7,
      //               offset: Offset(0, 4),
      //             ),
      //           ],
      //         ),
      //         child: Padding(
      //           padding: const EdgeInsets.only(
      //               left: AppPadding.p40, top: AppPadding.p52),
      //           child: Column(
      //             children: [
      //               Row(
      //                 children: [
      //                   Column(
      //                     children: [
      //                       Row(
      //                         children: [
      //                           Text(
      //                             'Is the face-to-face required',
      //                             style: GoogleFonts.firaSans(
      //                                 fontSize: FontSize.s10,
      //                                 fontWeight: FontWeightManager.regular),
      //                           )
      //                         ],
      //                       ),
      //                       Padding(
      //                         padding:
      //                             const EdgeInsets.only(left: AppPadding.p18),
      //                         child: Row(
      //                           children: [
      //                             Radio<String>(
      //                               value: 'Male',
      //                               groupValue: requiredftof,
      //                               onChanged: (value) =>
      //                                   setState(() => requiredftof = value),
      //                             ),
      //                             Text(AppString.male,
      //                                 style: GoogleFonts.firaSans(
      //                                     fontSize: FontSize.s14,
      //                                     fontWeight: FontWeightManager.regular,
      //                                     color: ColorManager.greylight)),
      //                             SizedBox(
      //                                 width:
      //                                     MediaQuery.of(context).size.width / 45),
      //                             Radio<String>(
      //                               value: 'Female',
      //                               groupValue: requiredftof,
      //                               onChanged: (value) =>
      //                                   setState(() => requiredftof = value),
      //                             ),
      //                             Text(AppString.female,
      //                                 style: GoogleFonts.firaSans(
      //                                     fontSize: FontSize.s14,
      //                                     fontWeight: FontWeightManager.regular,
      //                                     color: ColorManager.greylight)),
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   SizedBox(width: MediaQuery.of(context).size.width / 20),
      //                   Column(
      //                     children: [
      //                       Row(
      //                         children: [
      //                           Text(
      //                             'Patient was seen by the MD/ NO/ PA?',
      //                             style: GoogleFonts.firaSans(
      //                                 fontSize: FontSize.s10,
      //                                 fontWeight: FontWeightManager.regular),
      //                           )
      //                         ],
      //                       ),
      //                       Padding(
      //                         padding:
      //                             const EdgeInsets.only(left: AppPadding.p60),
      //                         child: Row(
      //                           children: [
      //                             Radio<String>(
      //                               value: 'Yes',
      //                               groupValue: seenby,
      //                               onChanged: (value) =>
      //                                   setState(() => seenby = value),
      //                             ),
      //                             Text(AppString.yes,
      //                                 style: GoogleFonts.firaSans(
      //                                     fontSize: FontSize.s14,
      //                                     fontWeight: FontWeightManager.regular,
      //                                     color: ColorManager.greylight)),
      //                             SizedBox(
      //                                 width:
      //                                     MediaQuery.of(context).size.width / 45),
      //                             Radio<String>(
      //                               value: 'No',
      //                               groupValue: seenby,
      //                               onChanged: (value) =>
      //                                   setState(() => seenby = value),
      //                             ),
      //                             Text(AppString.no,
      //                                 style: GoogleFonts.firaSans(
      //                                     fontSize: FontSize.s14,
      //                                     fontWeight: FontWeightManager.regular,
      //                                     color: ColorManager.greylight)),
      //                             SizedBox(
      //                                 width:
      //                                     MediaQuery.of(context).size.width / 45),
      //                             Radio<String>(
      //                               value: 'unknown',
      //                               groupValue: seenby,
      //                               onChanged: (value) =>
      //                                   setState(() => seenby = value),
      //                             ),
      //                             Text(AppString.unknown,
      //                                 style: GoogleFonts.firaSans(
      //                                     fontSize: FontSize.s14,
      //                                     fontWeight: FontWeightManager.regular,
      //                                     color: ColorManager.greylight)),
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //               SizedBox(height: MediaQuery.of(context).size.height / 15),
      //               Padding(
      //                 padding: const EdgeInsets.only(left: AppPadding.p24),
      //                 child: Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Container(
      //                     width: AppSize.s267,
      //                     child: SchedularTextField(
      //                         controller: encounterdate,
      //                         labelText: 'Date of face-to face encounter',
      //                         suffixIcon: Icon(
      //                           Icons.calendar_month_outlined,
      //                           size: 18,
      //                         )),
      //                   ),
      //                 ),
      //
      //                 // Row(
      //                 //   mainAxisAlignment: MainAxisAlignment.start,
      //                 //   children: [
      //                 //     Container(
      //                 //       height: 30,
      //                 //       width: 267,
      //                 //       child: TextFormField(
      //                 //         controller: _dateController,
      //                 //         decoration: InputDecoration(
      //                 //           labelText: 'Date of face-to face encounter',
      //                 //           labelStyle: GoogleFonts.firaSans(
      //                 //             fontSize: FontSize.s10,
      //                 //             fontWeight: FontWeightManager.regular,
      //                 //             color: ColorManager.lightgreyheading
      //                 //           ),
      //                 //           suffixIcon: IconButton(
      //                 //             icon: Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime),
      //                 //             onPressed: () => _selectDate(context),
      //                 //           ),
      //                 //           border: OutlineInputBorder(
      //                 //             borderRadius: BorderRadius.circular(8.0),
      //                 //             borderSide: BorderSide(
      //                 //               color: ColorManager.containerBorderGrey,
      //                 //               width: 1.0,
      //                 //             ),
      //                 //           ),
      //                 //           enabledBorder: OutlineInputBorder(
      //                 //             borderRadius: BorderRadius.circular(8.0),
      //                 //             borderSide: BorderSide(
      //                 //               color: ColorManager.containerBorderGrey,
      //                 //               width: 1.0,
      //                 //             ),
      //                 //           ),
      //                 //           focusedBorder: OutlineInputBorder(
      //                 //             borderRadius: BorderRadius.circular(8.0),
      //                 //             borderSide: BorderSide(
      //                 //               color: ColorManager.containerBorderGrey,
      //                 //               width: 1.0,
      //                 //             ),
      //                 //           ),
      //                 //         ),
      //                 //       ),
      //                 //     ),
      //                 //   ],
      //                 // ),
      //               ),
      //               SizedBox(height: MediaQuery.of(context).size.height / 15),
      //               Column(
      //                 children: [
      //                   Padding(
      //                     padding: const EdgeInsets.only(left: AppPadding.p28),
      //                     child: Row(
      //                       children: [
      //                         Text(
      //                           'Does the patient have a visit scheduled in the next 30 days?',
      //                           style: GoogleFonts.firaSans(
      //                               fontSize: FontSize.s10,
      //                               fontWeight: FontWeightManager.regular),
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.only(left: AppPadding.p24),
      //                     child: Row(
      //                       children: [
      //                         Radio<String>(
      //                           value: 'Yes',
      //                           groupValue: visitSchudule,
      //                           onChanged: (value) =>
      //                               setState(() => visitSchudule = value),
      //                         ),
      //                         Text(AppString.yes,
      //                             style: GoogleFonts.firaSans(
      //                                 fontSize: FontSize.s14,
      //                                 fontWeight: FontWeightManager.regular,
      //                                 color: ColorManager.greylight)),
      //                         SizedBox(
      //                             width: MediaQuery.of(context).size.width / 45),
      //                         Radio<String>(
      //                           value: 'No',
      //                           groupValue: visitSchudule,
      //                           onChanged: (value) =>
      //                               setState(() => visitSchudule = value),
      //                         ),
      //                         Text(AppString.no,
      //                             style: GoogleFonts.firaSans(
      //                                 fontSize: FontSize.s14,
      //                                 fontWeight: FontWeightManager.regular,
      //                                 color: ColorManager.greylight)),
      //                         SizedBox(
      //                             width: MediaQuery.of(context).size.width / 45),
      //                         Radio<String>(
      //                           value: 'Unknown',
      //                           groupValue: visitSchudule,
      //                           onChanged: (value) =>
      //                               setState(() => visitSchudule = value),
      //                         ),
      //                         Text(AppString.unknown,
      //                             style: GoogleFonts.firaSans(
      //                                 fontSize: FontSize.s14,
      //                                 fontWeight: FontWeightManager.regular,
      //                                 color: ColorManager.greylight)),
      //                         SizedBox(
      //                             width: MediaQuery.of(context).size.width / 45),
      //                         Radio<String>(
      //                           value: 'N/A',
      //                           groupValue: visitSchudule,
      //                           onChanged: (value) =>
      //                               setState(() => visitSchudule = value),
      //                         ),
      //                         Text('N/A',
      //                             style: GoogleFonts.firaSans(
      //                                 fontSize: FontSize.s14,
      //                                 fontWeight: FontWeightManager.regular,
      //                                 color: ColorManager.greylight)),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
