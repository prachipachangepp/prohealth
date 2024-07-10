// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/add_employee_popup_const.dart';
// import '../../../../../../../../app/resources/theme_manager.dart';
// import '../../../manage/widgets/icon_button_constant.dart';
// import '../../../manage/widgets/row_container_widget_const.dart';
//
// class QualificationEmploymentConstant extends StatefulWidget {
//   @override
//   State<QualificationEmploymentConstant> createState() =>
//       _BankingTabContainerConstantState();
// }
//
// class _BankingTabContainerConstantState
//     extends State<QualificationEmploymentConstant> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: MediaQuery.of(context).size.width / 80,
//         vertical: MediaQuery.of(context).size.height / 100,
//       ),
//       child: TwoContainersRow(
//         child1: EmploymentDetailsSection(employmentNumber: 'Employment #1'),
//         child2: EmploymentDetailsSection(employmentNumber: 'Employment #2'),
//       ),
//     );
//   }
// }
//
// class EmploymentDetailsSection extends StatelessWidget {
//   final String employmentNumber;
//
//   const EmploymentDetailsSection({required this.employmentNumber});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           employmentNumber,
//           style: TextStyle(
//             fontFamily: 'FiraSans',
//             fontSize: 13,
//             color: Color(0xFF333333),
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InfoText('Final Position Title', ThemeManager.customTextStyle(context)),
//                 InfoText('Start Date', ThemeManager.customTextStyle(context)),
//                 InfoText('End Date', ThemeManager.customTextStyle(context)),
//                 InfoText('Employer', ThemeManager.customTextStyle(context)),
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InfoData('123-45-6789', ThemeManagerDark.customTextStyle(context)),
//                 InfoData('ST', ThemeManagerDark.customTextStyle(context)),
//                 InfoData('1234567890', ThemeManagerDark.customTextStyle(context)),
//                 InfoData('abc@gmail.com', ThemeManagerDark.customTextStyle(context)),
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InfoText('Reason of Leaving', ThemeManager.customTextStyle(context)),
//                 InfoText('Last Supervisor’s Name', ThemeManager.customTextStyle(context)),
//                 InfoText('Supervisor’s Phone No.', ThemeManager.customTextStyle(context)),
//                 InfoText('City', ThemeManager.customTextStyle(context)),
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InfoData('1234687654', ThemeManagerDark.customTextStyle(context)),
//                 InfoData('TPN', ThemeManagerDark.customTextStyle(context)),
//                 InfoData('Hamburg', ThemeManagerDark.customTextStyle(context)),
//                 InfoData('02', ThemeManagerDark.customTextStyle(context)),
//               ],
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             ActionButtons(),
//           ],
//         )
//       ],
//     );
//   }
// }
//
// class InfoText extends StatelessWidget {
//   final String text;
//   final TextStyle style;
//
//   const InfoText(this.text, this.style);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(text, style: style),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
//
// class InfoData extends StatelessWidget {
//   final String text;
//   final TextStyle style;
//
//   const InfoData(this.text, this.style);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(text, style: style),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
//
// class ActionButtons extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         CustomElevatedButton(
//           icon: Icons.remove_red_eye,
//           label: 'Void Check',
//           onPressed: () {
//
//           },
//         ),
//         SizedBox(width: 8.0),
//         CustomElevatedButton(
//           icon: Icons.print_outlined,
//           label: 'Print',
//           iconPosition: IconPosition.right,
//           onPressed: () {
//
//           },
//         ),
//         SizedBox(width: 8.0),
//         CustomElevatedButton(
//           icon: Icons.sim_card_download_outlined,
//           label: 'Download',
//           iconPosition: IconPosition.right,
//           onPressed: () {
//
//           },
//         ),
//       ],
//     );
//   }
// }
//
// class CustomElevatedButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final IconPosition iconPosition;
//   final VoidCallback onPressed;
//
//   const CustomElevatedButton({
//     required this.icon,
//     required this.label,
//     required this.onPressed,
//     this.iconPosition = IconPosition.left,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {},
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Color(0xff1696C8),
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       child: Text(
//         'Approve',
//         style: GoogleFonts.firaSans(
//             fontSize: 10.0,
//             fontWeight: FontWeight.w700
//         ),
//       ),
//     );
//   }
// }
//
// enum IconPosition { left, right }



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/add_employee_popup_const.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../manage/widgets/icon_button_constant.dart';
import '../../../manage/widgets/row_container_widget_const.dart';

class QualificationEmploymentConstant extends StatefulWidget {
  @override
  State<QualificationEmploymentConstant> createState() =>
      _BankingTabContainerConstantState();
}

class _BankingTabContainerConstantState
    extends State<QualificationEmploymentConstant> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 80,
        vertical: MediaQuery.of(context).size.height / 100,
      ),
      child: TwoContainersRow(
        child1: EmploymentDetailsSection(employmentNumber: 'Employment #1'),
        child2: EmploymentDetailsSection(employmentNumber: 'Employment #2'),
      ),
    );
  }
}

class EmploymentDetailsSection extends StatelessWidget {
  final String employmentNumber;

  const EmploymentDetailsSection({required this.employmentNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          employmentNumber,
          style: TextStyle(
            fontFamily: 'FiraSans',
            fontSize: 13,
            color: Color(0xFF333333),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoText('Final Position Title', ThemeManager.customTextStyle(context)),
                InfoText('Start Date', ThemeManager.customTextStyle(context)),
                InfoText('End Date', ThemeManager.customTextStyle(context)),
                InfoText('Employer', ThemeManager.customTextStyle(context)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoDataEmployment('123-45-6789', ThemeManagerDark.customTextStyle(context)),
                InfoDataEmployment('ST', ThemeManagerDark.customTextStyle(context)),
                InfoDataEmployment('1234567890', ThemeManagerDark.customTextStyle(context)),
                InfoDataEmployment('abc@gmail.com', ThemeManagerDark.customTextStyle(context)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoText('Reason of Leaving', ThemeManager.customTextStyle(context)),
                InfoText('Last Supervisor’s Name', ThemeManager.customTextStyle(context)),
                InfoText('Supervisor’s Phone No.', ThemeManager.customTextStyle(context)),
                InfoText('City', ThemeManager.customTextStyle(context)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoDataEmployment('1234687654', ThemeManagerDark.customTextStyle(context)),
                InfoDataEmployment('TPN', ThemeManagerDark.customTextStyle(context)),
                InfoDataEmployment('Hamburg', ThemeManagerDark.customTextStyle(context)),
                InfoDataEmployment('02', ThemeManagerDark.customTextStyle(context)),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ActionButtons(),
          ],
        )
      ],
    );
  }
}

class InfoText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const InfoText(this.text, this.style);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text, style: style),
        const SizedBox(height: 10),
      ],
    );
  }
}

class InfoDataEmployment extends StatelessWidget {
  final String text;
  final TextStyle style;

  const InfoDataEmployment(this.text, this.style);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text, style: style),
        const SizedBox(height: 10),
      ],
    );
  }
}

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
        SizedBox(width: MediaQuery.of(context).size.width/75),
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
    );
  }
}
