import 'package:file_picker/file_picker.dart';
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

class Add_Prescription extends StatefulWidget {
  const Add_Prescription ({super.key});

  @override
  State<Add_Prescription> createState() => _Add_PrescriptionState();
}

class _Add_PrescriptionState extends State<Add_Prescription> {

  bool fileAbove20Mb = false;
  dynamic filePath;
  String fileName = '';
  TextEditingController treatmentfor = TextEditingController();

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    final fileSize = result?.files.first.size; // File size in bytes
    final isAbove20MB = fileSize! > (20 * 1024 * 1024); // 20MB in bytes
    if (result != null) {
      setState(() {
        filePath = result.files.first.bytes;
        fileName = result.files.first.name;
        fileAbove20Mb = !isAbove20MB;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: 400,
      height: 320,
      title: 'Add Prescription',
      body: [
        SchedularTextField(
            width: AppSize.s354,
            controller: treatmentfor,
            labelText: "Treatment for"),

SizedBox(height: 10,),
        HeaderContentConst(
          heading: "Upload Prescription",
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: _pickFile,
                child: Container(
                  height: AppSize.s30,
                  width: AppSize.s354,
                  padding: EdgeInsets.only(left: AppPadding.p15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorManager.containerBorderGrey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                fileName,
                                style: DocumentTypeDataStyle.customTextStyle(
                                    context),
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.all(4),
                              onPressed: _pickFile,
                              icon: Icon(
                                Icons.file_upload_outlined,
                                color: ColorManager.black,
                                size: 17,
                              ),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
             // SizedBox(height: 2),
              // if (isFormSubmitted && filePath == null)
              //   Text(
              //     'Please select document',
              //     style: TextStyle(fontSize: 10, color: ColorManager.red),
              //   ),
            ],
          ),
        ),

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
