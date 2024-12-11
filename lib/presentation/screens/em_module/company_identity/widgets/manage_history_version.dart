import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../data/api_data/establishment_data/ci_manage_button/newpopup_data.dart';
import '../../widgets/button_constant.dart';
///policies old implemented
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
        height: AppSize.s210,
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
                      style:PopupBlueBarText.customTextStyle(context),
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
                    style: DefineWorkWeekStyle.customTextStyle(context),
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
                          "Modified on:  ${historyItem['doc_modified_at'] != null
                              ? "${DateFormat('yyyy-MM-dd').format(DateTime.parse(historyItem['doc_modified_at']))} at ${DateFormat('HH:mm').format(DateTime.parse(historyItem['doc_modified_at']))}"
                              : 'N/A'}",
                          style: ConstTextFieldRegister.customTextStyle(context),
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

