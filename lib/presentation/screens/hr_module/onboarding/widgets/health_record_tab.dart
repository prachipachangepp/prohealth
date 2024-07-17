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
  final Map<String, bool> leftCheckboxStates = {
    'Physical Exam': false,
    'TB': false,
    'MMR Vaccine': false,
    'Covid Vaccine': false,
  };

  final Map<String, bool> rightCheckboxStates = {
    'Physical Exam': false,
    'TB': false,
    'MMR Vaccine': false,
    'Covid Vaccine': false,
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Material(
              elevation: 5,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _buildHealthRecordColumn(context, const Color(0xff008000), leftCheckboxStates),
                    ),
                    Expanded(
                      child: _buildHealthRecordColumn(context, const Color(0xff686464), rightCheckboxStates),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Wrap(
              alignment: WrapAlignment.end,
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildButton('Reject', Colors.white, const Color(0xff1696C8), true),
                _buildButton('Approve', const Color(0xff1696C8), Colors.white, false),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHealthRecordColumn(BuildContext context, Color color, Map<String, bool> checkboxStates) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHealthRecordRow(context, 'Physical Exam', 'TB', color, checkboxStates),
            SizedBox(height: size.height * 0.02),
            _buildHealthRecordRow(context, 'MMR Vaccine', 'Covid Vaccine', color, checkboxStates),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthRecordRow(BuildContext context, String title1, String title2, Color color, Map<String, bool> checkboxStates) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        _buildHealthRecordWithCheckbox(title1, '2023-08-17', Icons.description_outlined, color, checkboxStates),
        SizedBox(width: size.width * 0.02),
        _buildHealthRecordWithCheckbox(title2, '2023-08-17', Icons.description_outlined, color, checkboxStates),
      ],
    );
  }

  Widget _buildHealthRecordWithCheckbox(String title, String date, IconData icon, Color color, Map<String, bool> checkboxStates) {
    return Row(
      children: [
        Checkbox(
          value: checkboxStates[title],
          onChanged: (bool? value) {
            setState(() {
              checkboxStates[title] = value!;
            });
          },
        ),
        buildHealthRecordContainer(title, date, icon, color),
      ],
    );
  }

  Widget _buildButton(String text, Color bgColor, Color textColor, bool hasBorder) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        side: hasBorder ? BorderSide(color: textColor) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: GoogleFonts.firaSans(
            fontSize: 10.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}