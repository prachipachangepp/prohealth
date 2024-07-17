// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/health_record_tab_constant.dart';
//
// import '../../../../../../app/resources/color.dart';
// import '../../../../../../app/resources/value_manager.dart';
//
// class HealthRecordTab extends StatelessWidget {
//   const HealthRecordTab({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: AppPadding.p80,),
//           child: Material(
//             elevation: 5,
//             borderRadius: BorderRadius.all(Radius.circular(12)),
//             color: Colors.white,
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 14),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/50),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Row(
//                           children: [
//                             buildHealthRecordContainer(
//                               'Physical Exam',
//                               '2023-08-17',
//                               Icons.description_outlined,
//                               Color(0xff008000),
//                             ),
//                             SizedBox(width: MediaQuery.of(context).size.width / 30),
//                             buildHealthRecordContainer(
//                               'TB',
//                               '2023-08-17',
//                               Icons.description_outlined,
//                               Color(0xff008000),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: MediaQuery.of(context).size.height / 60),
//                         Row(
//                           children: [
//                             buildHealthRecordContainer(
//                               'MMR Vaccine',
//                               '2023-08-17',
//                               Icons.description_outlined,
//                               Color(0xff008000),
//                             ),
//                             SizedBox(width: MediaQuery.of(context).size.width / 30),
//                             buildHealthRecordContainer(
//                               'Covid Vaccine',
//                               '2023-08-17',
//                               Icons.description_outlined,
//                               Color(0xff008000),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   Padding(
//                     padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/50),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Row(
//                           children: [
//                             buildHealthRecordContainer(
//                               'Physical Exam',
//                               '2023-08-17',
//                               Icons.description_outlined,
//                               Color(0xff686464),
//                             ),
//                             SizedBox(width: MediaQuery.of(context).size.width / 30),
//                             buildHealthRecordContainer(
//                               'TB',
//                               '2023-08-17',
//                               Icons.description_outlined,
//                               Color(0xff686464),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: MediaQuery.of(context).size.height / 60),
//                         Row(
//                           children: [
//                             buildHealthRecordContainer(
//                               'MMR Vaccine',
//                               '2023-08-17',
//                               Icons.description_outlined,
//                               Color(0xff686464),
//                             ),
//                             SizedBox(width: MediaQuery.of(context).size.width / 30),
//                             buildHealthRecordContainer(
//                               'Covid Vaccine',
//                               '2023-08-17',
//                               Icons.description_outlined,
//                               Color(0xff686464),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: MediaQuery.of(context).size.height/100),
//         Padding(
//           padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Color(0xff1696C8),
//                   side: BorderSide(color: Color(0xff1696C8)),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text(
//                   'Reject',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w700
//                   ),
//                 ),
//               ),
//               SizedBox(width: MediaQuery.of(context).size.width/90),
//               ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xff1696C8),
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text(
//                   'Approve',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w700
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
//////
////

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/health_record_tab_constant.dart';

import '../../../../../../app/resources/value_manager.dart';

class HealthRecordTab extends StatefulWidget {
  const HealthRecordTab({Key? key}) : super(key: key);

  @override
  _HealthRecordTabState createState() => _HealthRecordTabState();
}

class _HealthRecordTabState extends State<HealthRecordTab> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  bool isChecked6 = false;
  bool isChecked7 = false;
  bool isChecked8 = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0), // Adjust as necessary
          child: Material(
            elevation: 5,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
            child: Padding(
              padding:
              EdgeInsets.symmetric(vertical: 20.0), // Adjust as necessary
              child: Row(
mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked1,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked1 = value!;
                              });
                            },
                          ),
                          HealthRecordConst(
                            "Physical Exam",
                            "2023-08-17",
                            Icons.description_outlined,
                            Color(0xff008000),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked2,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked2 = value!;
                              });
                            },
                          ),
                          HealthRecordConst(
                            "Physical Exam",
                            "2023-08-17",
                            Icons.description_outlined,
                            Color(0xff008000),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked3,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked3 = value!;
                              });
                            },
                          ),
                          HealthRecordConst(
                            "Physical Exam",
                            "2023-08-17",
                            Icons.description_outlined,
                            Color(0xff008000),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
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
                          HealthRecordConst(
                            "Physical Exam",
                            "2023-08-17",
                            Icons.description_outlined,
                            Color(0xff008000),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/7,),

                  Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked5,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked5 = value!;
                              });
                            },
                          ),
                          HealthRecordConst(
                            "Physical Exam",
                            "2023-08-17",
                            Icons.description_outlined,
                            Color(0xffC6C6C6),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked6,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked6 = value!;
                              });
                            },
                          ),
                          HealthRecordConst(
                            "Physical Exam",
                            "2023-08-17",
                            Icons.description_outlined,
                            Color(0xffC6C6C6),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked7,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked7 = value!;
                              });
                            },
                          ),
                          HealthRecordConst(
                            "Physical Exam",
                            "2023-08-17",
                            Icons.description_outlined,
                            Color(0xffC6C6C6),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked8,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked8 = value!;
                              });
                            },
                          ),
                          HealthRecordConst(
                            "Physical Exam",
                            "2023-08-17",
                            Icons.description_outlined,
                            Color(0xffC6C6C6),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Row(
                  //   children: [
                  //     Checkbox(
                  //       value: isChecked2,
                  //       onChanged: (bool? value) {
                  //         setState(() {
                  //           isChecked2 = value!;
                  //         });
                  //       },
                  //     ),
                  //     HealthRecordConst(
                  //       "Physical Exam",
                  //       "2023-08-17",
                  //       Icons.description_outlined,
                  //       Color(0xff50B5E5),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Checkbox(
                  //       value: isChecked2,
                  //       onChanged: (bool? value) {
                  //         setState(() {
                  //           isChecked2 = value!;
                  //         });
                  //       },
                  //     ),
                  //     HealthRecordConst(
                  //       "Physical Exam",
                  //       "2023-08-17",
                  //       Icons.description_outlined,
                  //       Color(0xff50B5E5),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Checkbox(
                  //       value: isChecked2,
                  //       onChanged: (bool? value) {
                  //         setState(() {
                  //           isChecked2 = value!;
                  //         });
                  //       },
                  //     ),
                  //     HealthRecordConst(
                  //       "Physical Exam",
                  //       "2023-08-17",
                  //       Icons.description_outlined,
                  //       Color(0xff50B5E5),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Checkbox(
                  //       value: isChecked2,
                  //       onChanged: (bool? value) {
                  //         setState(() {
                  //           isChecked2 = value!;
                  //         });
                  //       },
                  //     ),
                  //     HealthRecordConst(
                  //       "Physical Exam",
                  //       "2023-08-17",
                  //       Icons.description_outlined,
                  //       Color(0xff50B5E5),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: 20.0), // Adjust as necessary
        Padding(
          padding: EdgeInsets.only(right: 30.0), // Adjust as necessary
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
              SizedBox(width: 30),
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
        )
      ],
    );
  }


  Widget HealthRecordConst(String title, String Date, IconData icon,
      Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffC6C6C6)),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
            child: Container(
              height: 44.0,
              width: 44.0,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffC6C6C6)),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Icon(icon, color: iconColor),
            ),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.firaSans(
                  color: Colors.black,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                Date,
                style: GoogleFonts.firaSans(
                  color: Colors.black,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}