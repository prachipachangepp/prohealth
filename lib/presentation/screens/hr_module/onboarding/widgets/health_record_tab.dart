// import 'package:flutter/material.dart';
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
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: AppPadding.p80, vertical: AppPadding.p40),
//       child: Material(
//         elevation: 5,
//         borderRadius: BorderRadius.all(Radius.circular(12)),
//         color: Colors.white,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               children: [
//                 SizedBox(height: MediaQuery.of(context).size.height / 7),
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 81.0),
//                       child: buildHealthRecordContainer(
//                         'Physical Exam',
//                         '2023-08-17',
//                         Icons.description_outlined,
//                         Color(0xff008000),
//                       ),
//                     ),
//                     SizedBox(width: MediaQuery.of(context).size.width / 30),
//                     buildHealthRecordContainer(
//                       'TB',
//                       '2023-08-17',
//                       Icons.description_outlined,
//                       Color(0xff008000),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 60),
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 81.0,),
//                       child: buildHealthRecordContainer(
//                         'MMR Vaccine',
//                         '2023-08-17',
//                         Icons.description_outlined,
//                         Color(0xff008000),
//                       ),
//                     ),
//                     SizedBox(width: MediaQuery.of(context).size.width / 30),
//                     buildHealthRecordContainer(
//                       'Covid Vaccine',
//                       '2023-08-17',
//                       Icons.description_outlined,
//                       Color(0xff008000),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             //////////////////////////////////////////right side boxes/////////////////////////////////////////////////////////////////////////////
//             Padding(
//               padding: const EdgeInsets.only(right: 81.0),
//               child: Column(
//                 children: [
//                   SizedBox(height: MediaQuery.of(context).size.height / 7),
//                   Row(
//                     children: [
//                       buildHealthRecordContainer(
//                         'Physical Exam',
//                         '2023-08-17',
//                         Icons.description_outlined,
//                         Color(0xff686464),
//                       ),
//                       SizedBox(width: MediaQuery.of(context).size.width / 30),
//                       buildHealthRecordContainer(
//                         'TB',
//                         '2023-08-17',
//                         Icons.description_outlined,
//                         Color(0xff686464),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: MediaQuery.of(context).size.height / 60),
//                   Row(
//                     children: [
//                       buildHealthRecordContainer(
//                         'MMR Vaccine',
//                         '2023-08-17',
//                         Icons.description_outlined,
//                         Color(0xff686464),
//                       ),
//                       SizedBox(width: MediaQuery.of(context).size.width / 30),
//                       buildHealthRecordContainer(
//                         'Covid Vaccine',
//                         '2023-08-17',
//                         Icons.description_outlined,
//                         Color(0xff686464),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/health_record_tab_constant.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/value_manager.dart';

class HealthRecordTab extends StatelessWidget {
  const HealthRecordTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p80,),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/50),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            buildHealthRecordContainer(
                              'Physical Exam',
                              '2023-08-17',
                              Icons.description_outlined,
                              Color(0xff008000),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width / 30),
                            buildHealthRecordContainer(
                              'TB',
                              '2023-08-17',
                              Icons.description_outlined,
                              Color(0xff008000),
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 60),
                        Row(
                          children: [
                            buildHealthRecordContainer(
                              'MMR Vaccine',
                              '2023-08-17',
                              Icons.description_outlined,
                              Color(0xff008000),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width / 30),
                            buildHealthRecordContainer(
                              'Covid Vaccine',
                              '2023-08-17',
                              Icons.description_outlined,
                              Color(0xff008000),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/50),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            buildHealthRecordContainer(
                              'Physical Exam',
                              '2023-08-17',
                              Icons.description_outlined,
                              Color(0xff686464),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width / 30),
                            buildHealthRecordContainer(
                              'TB',
                              '2023-08-17',
                              Icons.description_outlined,
                              Color(0xff686464),
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 60),
                        Row(
                          children: [
                            buildHealthRecordContainer(
                              'MMR Vaccine',
                              '2023-08-17',
                              Icons.description_outlined,
                              Color(0xff686464),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width / 30),
                            buildHealthRecordContainer(
                              'Covid Vaccine',
                              '2023-08-17',
                              Icons.description_outlined,
                              Color(0xff686464),
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
        SizedBox(height: MediaQuery.of(context).size.height/100),
        Padding(
          padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/20),
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
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width/90),
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
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}