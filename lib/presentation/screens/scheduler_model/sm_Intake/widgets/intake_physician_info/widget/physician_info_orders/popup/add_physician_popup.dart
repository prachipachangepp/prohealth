import 'package:flutter/material.dart';

import '../../../../../../../../../app/resources/color.dart';
import '../../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../em_module/widgets/dialogue_template.dart';
import '../../../../../../../em_module/widgets/header_content_const.dart';
import '../../../../../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';

class PopupAddPhysician extends StatefulWidget {
  const PopupAddPhysician({super.key});

  @override
  State<PopupAddPhysician> createState() => _PopupAddPhysicianState();
}

class _PopupAddPhysicianState extends State<PopupAddPhysician> {


  TextEditingController Selectphy = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: 400,
      height: 300,
      title: 'Add Physician',
      body: [
        SchedularTextField(
          width: 300,
            controller: Selectphy,
            labelText: "Select"),

        // HeaderContentConst(
        //   heading: AppString.upload_document,
        //   content: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       InkWell(
        //         onTap: _pickFile,
        //         child: Container(
        //           height: AppSize.s30,
        //           width: AppSize.s354,
        //           padding: EdgeInsets.only(left: AppPadding.p15),
        //           decoration: BoxDecoration(
        //             border: Border.all(
        //               color: ColorManager.containerBorderGrey,
        //               width: 1,
        //             ),
        //             borderRadius: BorderRadius.circular(4),
        //           ),
        //           child: StatefulBuilder(
        //             builder: (BuildContext context,
        //                 void Function(void Function()) setState) {
        //               return Padding(
        //                 padding: const EdgeInsets.all(0),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Expanded(
        //                       child: Text(
        //                         fileName,
        //                         style: DocumentTypeDataStyle.customTextStyle(
        //                             context),
        //                       ),
        //                     ),
        //                     IconButton(
        //                       padding: EdgeInsets.all(4),
        //                       onPressed: _pickFile,
        //                       icon: Icon(
        //                         Icons.file_upload_outlined,
        //                         color: ColorManager.black,
        //                         size: 17,
        //                       ),
        //                       splashColor: Colors.transparent,
        //                       highlightColor: Colors.transparent,
        //                       hoverColor: Colors.transparent,
        //                     ),
        //                   ],
        //                 ),
        //               );
        //             },
        //           ),
        //         ),
        //       ),
        //       SizedBox(height: 2),
        //       if (isFormSubmitted && filePath == null)
        //         Text(
        //           'Please select document',
        //           style: TextStyle(fontSize: 10, color: ColorManager.red),
        //         ),
        //     ],
        //   ),
        // ),

      ],
      bottomButtons:    CustomButton(
      width: 117,
      height: 30,
      onPressed: (){},

      child: Text(
        "Submit",
        style:  BlueButtonTextConst.customTextStyle(context),
      ),

    ), );
  }
}
