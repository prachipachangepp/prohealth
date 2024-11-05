import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/font_manager.dart';

class DefineFormList extends StatelessWidget {
  final String formName;
  final VoidCallback? onSigned;
  final VoidCallback onView;
  final bool isSigned;
  final bool isHandbook;
  final bool isReturnCompany;
  final VoidCallback? handBookView;

  const DefineFormList({
    Key? key,
    required this.formName,
    this.onSigned,
    required this.onView,
    required this.isSigned,
    required this.isHandbook,
    this.handBookView, required this.isReturnCompany,
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
    isReturnCompany
        ? Padding(
      padding: const EdgeInsets.only(right: 40.0),
      child: Text('NA',style: TextStyle(
          fontSize: FontSize.s12,
          fontWeight: FontWeight.w700,
          color: ColorManager.mediumgrey)),
    )
        :  isHandbook
        ? Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: InkWell(
            onTap: onView,
            child: Container(
                height: 30,
                width: 90,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff1696C8)),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.only(bottom: 5,left: 15,right: 10),
                child:
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('View',style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: FontSize.s12,
                          color: Color(0xff1696C8),
                        ),),
                        SizedBox(width: 10,),
                        Center(
                          child: const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Color(0xff1696C8),
                            size: 20,
                          ),
                        ),]),
                )),
          ),
        )
        : Row(
          children: [
            // Conditional rendering: If signed, show a check mark
            isSigned ?
            InkWell(
              onTap: onView,
              child: Container(
                height: 30,
                width: 90,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff1696C8)),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.only(bottom: 5,left: 10,right: 10),
                child:
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Row(
                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('View',style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: FontSize.s12,
                      color: Color(0xff1696C8),
                    ),),
                    SizedBox(width: 10,),
                    Center(
                      child: const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Color(0xff1696C8),
                        size: 20,
                      ),
                    ),]),
              )),
            )
                : SizedBox(width: 50,),
            const SizedBox(width: 10),
            isSigned
                ? Container(
              width: 90,
                  child: Center(
                    child: const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 24,
                                ),
                  ),
                )
                : Container(
              width: 90,
                  child: ElevatedButton(
                                onPressed: onSigned, // Button only shown if not signed
                                child: const Text('Sign'),
                              ),
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
