import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';

class DefineFormList extends StatelessWidget {
  final String formName;
  final VoidCallback? onSigned;
  final VoidCallback onView;
  final bool isSigned;

  const DefineFormList({
    Key? key,
    required this.formName,
    this.onSigned,
    required this.onView,
    required this.isSigned,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          formName,
          style: const TextStyle(fontSize: 16),
        ),
        Row(
          children: [
            // Conditional rendering: If signed, show a check mark
            isSigned ? ElevatedButton(
                onPressed: onView, // Always show the View button
                child: const Text('View')
            )
                : SizedBox(width: 50,),
            const SizedBox(width: 10),
            isSigned
                ? const Icon(
              Icons.check,
              color: Colors.green,
              size: 24,
            )
                : ElevatedButton(
              onPressed: onSigned, // Button only shown if not signed
              child: const Text('Sign'),
            ),


          ],
        ),
      ],
    );
  }
}
///
// class DefineFormList extends StatefulWidget {
//   final String formName;
//   final VoidCallback onSigned;
//   final VoidCallback onView;
//   const DefineFormList({super.key, required this.formName, required this.onSigned, required this.onView});
//
//   @override
//   State<DefineFormList> createState() => _DefineFormListState();
// }
//
// class _DefineFormListState extends State<DefineFormList> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           widget.formName,
//           style: DefineWorkWeekStyle.customTextStyle(context),
//         ),
//         Row(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: const Color(0xff1696C8)),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: IconButtonWidget(
//                 width: AppSize.s90,
//                 iconData1: Icons.remove_red_eye_outlined,
//                 buttonText: AppStringHr.viewDoc,
//                 onPressed: widget.onView,
//               ),
//             ),
//             SizedBox(width:AppSize.s20),
//             Container(
//               width: 100,
//               height: 30,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: ElevatedButton(
//                 onPressed: widget.onSigned,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:Color(0xff50B5E5) ,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//                 child: Text(
//                     "Sign",
//                     style:BlueButtonTextConst.customTextStyle(context)
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
