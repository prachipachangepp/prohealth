import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../data/api_data/establishment_data/ci_manage_button/newpopup_data.dart';
import '../../widgets/button_constant.dart';
///policies old implemented
// class ManageHistoryPopup extends StatefulWidget {
//   final List<MCorporateComplianceModal> historyData;
//    ManageHistoryPopup({super.key, required this.historyData});
//
//   @override
//   State<ManageHistoryPopup> createState() => _ManageHistoryPopupState();
// }
//
// class _ManageHistoryPopupState extends State<ManageHistoryPopup> {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: AppSize.s350,
//         height: AppSize.s250,
//         decoration: BoxDecoration(
//           color: ColorManager.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: ColorManager.bluebottom,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8),
//                   topRight: Radius.circular(8),
//                 ),
//               ),
//               height: 35,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15.0),
//                     child: Text(
//                       "Version History",
//                       style: GoogleFonts.firaSans(
//                         fontSize: FontSize.s12,
//                         fontWeight: FontWeightManager.semiBold,
//                         color: ColorManager.white,
//                         decoration: TextDecoration.none,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(Icons.close,color: ColorManager.white,),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: AppSize.s20,),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: widget.historyData.length,
//                 itemBuilder: (context, index) {
//                   final historyItem = widget.historyData[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "ID: ${historyItem.idOfDocument}",
//                           style: GoogleFonts.firaSans(
//                             fontSize: FontSize.s12,
//                             fontWeight: FontWeightManager.medium,
//                             color: ColorManager.black,
//                             decoration: TextDecoration.none,
//                           ),
//                         ),
//                         Text(
//                           historyItem.orgDocumentSetupid.toString(),
//                           style: GoogleFonts.firaSans(
//                             fontSize: FontSize.s12,
//                             fontWeight: FontWeightManager.medium,
//                             color: ColorManager.black,
//                             decoration: TextDecoration.none,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             // Padding(
//             //   padding: const EdgeInsets.symmetric(
//             //     vertical: AppPadding.p20,
//             //     horizontal: AppPadding.p20,
//             //   ),
//             //   child: Center(
//             //     child: Row(
//             //       children: [
//             //         Text('Do you really want to delete?',
//             //           style:CustomTextStylesCommon.commonStyle(
//             //               fontWeight: FontWeightManager.semiBold,
//             //               fontSize: FontSize.s12,
//             //               color: ColorManager.mediumgrey
//             //           ),
//             //         ),
//             //       ],
//             //     ),
//             //   ),
//             // ),
//             //
//           ],
//         ),
//       ),
//     );
//   }
// }

class ManageHistoryPopup extends StatefulWidget {
  final List<dynamic> docHistory;
  ManageHistoryPopup({super.key, required this.docHistory});

  @override
  State<ManageHistoryPopup> createState() => _ManageHistoryPopupState();
}

class _ManageHistoryPopupState extends State<ManageHistoryPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s350,
        height: AppSize.s250,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Version History",
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close,color: ColorManager.white,),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s20,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p20,
                  horizontal: AppPadding.p20,
                ),
                child: widget.docHistory.isEmpty
                    ? Center(
                  child: Text(
                    'No History Available',
                    style: CustomTextStylesCommon.commonStyle(
                      fontWeight: FontWeightManager.semiBold,
                      fontSize: FontSize.s12,
                      color: ColorManager.mediumgrey,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: widget.docHistory.length,
                  itemBuilder: (context, index) {
                    var historyItem = widget.docHistory[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Version ${index + 1}: ${historyItem['doc_name'] ?? 'N/A'}",
                          style: CustomTextStylesCommon.commonStyle(
                            fontWeight: FontWeightManager.semiBold,
                            fontSize: FontSize.s12,
                            color: ColorManager.mediumgrey,
                          ),
                        ),
                        SizedBox(height: AppSize.s5),
                        Text(
                          "Created: ${historyItem['doc_created_at'] ?? 'N/A'}",
                          style: CustomTextStylesCommon.commonStyle(
                            fontWeight: FontWeightManager.regular,
                            fontSize: FontSize.s10,
                            color: ColorManager.mediumgrey,
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     vertical: AppPadding.p20,
            //     horizontal: AppPadding.p20,
            //   ),
            //   child: Center(
            //     child: Row(
            //       children: [
            //         Text('Do you really want to delete?',
            //           style:CustomTextStylesCommon.commonStyle(
            //               fontWeight: FontWeightManager.semiBold,
            //               fontSize: FontSize.s12,
            //               color: ColorManager.mediumgrey
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            //
          ],
        ),
      ),
    );
  }
}

