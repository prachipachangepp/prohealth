// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/health_record_tab_constant.dart';
//
// import '../../../../../../app/resources/value_manager.dart';
//
// class HealthRecordTab extends StatefulWidget {
//   const HealthRecordTab({Key? key}) : super(key: key);
//
//   @override
//   _HealthRecordTabState createState() => _HealthRecordTabState();
// }
//
// class _HealthRecordTabState extends State<HealthRecordTab> {
//   final Map<String, bool> leftCheckboxStates = {
//     'Physical Exam': false,
//     'TB': false,
//     'MMR Vaccine': false,
//     'Covid Vaccine': false,
//   };
//
//   final Map<String, bool> rightCheckboxStates = {
//     'Physical Exam': false,
//     'TB': false,
//     'MMR Vaccine': false,
//     'Covid Vaccine': false,
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
//             child: Material(
//               elevation: 5,
//               borderRadius: const BorderRadius.all(Radius.circular(12)),
//               color: Colors.white,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Expanded(
//                       child: _buildHealthRecordColumn(context, const Color(0xff008000), leftCheckboxStates),
//                     ),
//                     Expanded(
//                       child: _buildHealthRecordColumn(context, const Color(0xff686464), rightCheckboxStates),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: size.height * 0.02),
//           Padding(
//             padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/19),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Wrap(
//                   alignment: WrapAlignment.end,
//                   spacing: 8,
//                   runSpacing: 8,
//                   children: [
//                     _buildButton('Reject', Colors.white, const Color(0xff1696C8), true),
//                     _buildButton('Approve', const Color(0xff1696C8), Colors.white, false),
//                   ],
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHealthRecordColumn(BuildContext context, Color color, Map<String, bool> checkboxStates) {
//     final size = MediaQuery.of(context).size;
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildHealthRecordRow(context, 'Physical Exam', 'TB', color, checkboxStates),
//             SizedBox(height: size.height * 0.02),
//             _buildHealthRecordRow(context, 'MMR Vaccine', 'Covid Vaccine', color, checkboxStates),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHealthRecordRow(BuildContext context, String title1, String title2, Color color, Map<String, bool> checkboxStates) {
//     final size = MediaQuery.of(context).size;
//     return Row(
//       children: [
//         _buildHealthRecordWithCheckbox(title1, '2023-08-17', Icons.description_outlined, color, checkboxStates),
//         SizedBox(width: size.width * 0.02),
//         _buildHealthRecordWithCheckbox(title2, '2023-08-17', Icons.description_outlined, color, checkboxStates),
//       ],
//     );
//   }
//
//   Widget _buildHealthRecordWithCheckbox(String title, String date, IconData icon, Color color, Map<String, bool> checkboxStates) {
//     return Row(
//       children: [
//         Checkbox(
//           value: checkboxStates[title],
//           onChanged: (bool? value) {
//             setState(() {
//               checkboxStates[title] = value!;
//             });
//           },
//         ),
//         buildHealthRecordContainer(title, date, icon, color),
//       ],
//     );
//   }
//
//   Widget buildHealthRecordContainer(String title, String date, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         color: color.withOpacity(0.1),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: GoogleFonts.firaSans(
//               fontSize: 14.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 8.0),
//           Row(
//             children: [
//               Icon(
//                 icon,
//                 size: 20.0,
//                 color: color,
//               ),
//               SizedBox(width: 4.0),
//               Text(
//                 date,
//                 style: GoogleFonts.firaSans(
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildButton(String text, Color bgColor, Color textColor, bool hasBorder) {
//     return ElevatedButton(
//       onPressed: () {},
//       style: ElevatedButton.styleFrom(
//         backgroundColor: bgColor,
//         foregroundColor: textColor,
//         side: hasBorder ? BorderSide(color: textColor) : null,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       child: FittedBox(
//         fit: BoxFit.scaleDown,
//         child: Text(
//           text,
//           style: GoogleFonts.firaSans(
//             fontSize: 10.0,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/acknowledgement_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/health_record_tab_constant.dart';

import '../../../../../app/resources/value_manager.dart';

class HealthRecordTab extends StatefulWidget {
  const HealthRecordTab({super.key});

  @override
  State<HealthRecordTab> createState() => _HealthRecordTabState();
}

//////////////////////////////////////////////
class _HealthRecordTabState extends State<HealthRecordTab> {
  @override
  Widget build(BuildContext context) {
    return HealthRecordConstant();  // call listview buider here
  }
}
//////////////////////////////////////////////

class HealthRecordConstant extends StatefulWidget {
  const HealthRecordConstant({super.key});

  @override
  State<HealthRecordConstant> createState() => _HealthRecordConstantState();
}

class _HealthRecordConstantState extends State<HealthRecordConstant> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p80),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight / 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: screenWidth / 21),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isChecked1,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked1 = value!;
                                      });
                                    },
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width/140),
                                  Container(
                                    width: MediaQuery.of(context).size.width/10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: Color(0xffC6C6C6))
                                    ),
                                    child: HealthRecordConstantWithContainer(
                                      'Physical Exam',
                                      '2023-08-17',
                                      Icons.description_outlined,
                                      Color(0xff50B5E5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 60),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: screenWidth / 21),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isChecked2,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked2 = value!;
                                      });
                                    },
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width/140),
                                  Container(
                                    width: MediaQuery.of(context).size.width/10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: Color(0xffC6C6C6))
                                    ),
                                    child: HealthRecordConstantWithContainer(
                                      'Physical Exam',
                                      '2023-08-17',
                                      Icons.description_outlined,
                                      Color(0xff50B5E5),
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
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: screenWidth / 13), //6.6
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isChecked3,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked3 = value!;
                                      });
                                    },
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width/140),
                                  Container(
                                    width: MediaQuery.of(context).size.width/10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: Color(0xffC6C6C6))
                                    ),
                                    child: HealthRecordConstantWithContainer(
                                      'TB',
                                      '2023-08-17',
                                      Icons.description_outlined,
                                      Color(0xff50B5E5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: isChecked4,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked4 = value!;
                                    });
                                  },
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width/140),
                                Container(
                                  width: MediaQuery.of(context).size.width/10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: Color(0xffC6C6C6))
                                  ),
                                  child: HealthRecordConstantWithContainer(
                                    'TB',
                                    '2023-08-17',
                                    Icons.description_outlined,
                                    Color(0xff50B5E5),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight / 100),
        Padding(
          padding: EdgeInsets.only(right: screenWidth / 19),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xff1696C8),
                  side: BorderSide(color: Color(0xff1696C8)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Reject',
                  style: GoogleFonts.firaSans(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: screenWidth / 90),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff1696C8),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Approve',
                  style: GoogleFonts.firaSans(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
