import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/header_content_const.dart';

import '../../../../../app/constants/app_config.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/establishment_manager/newpopup_manager.dart';
import '../../../../../data/api_data/api_data.dart';
import '../../../../../data/api_data/establishment_data/ci_manage_button/newpopup_data.dart';
import '../../widgets/button_constant.dart';
import 'ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';

class UploadDocumentAddPopup extends StatefulWidget {
  final String title;
  bool? loadingDuration;
  final String officeId;
  final int docTypeMetaIdCC;
  final List<TypeofDocpopup> dataList;
  final int selectedSubDocId;
  final double? height;
  final Widget? uploadField;
  dynamic filePath;
  String? fileName;
  // final Visibility? child3;
  UploadDocumentAddPopup({
    required this.title,
    this.loadingDuration,
    this.height,
    this.uploadField,
    required this.officeId,
    required this.docTypeMetaIdCC,
    required this.selectedSubDocId,
    required this.dataList,
    // this.child3
  });

  @override
  State<UploadDocumentAddPopup> createState() => _UploadDocumentAddPopupState();
}

class _UploadDocumentAddPopupState extends State<UploadDocumentAddPopup> {
  int docTypeId = 0;
  String documentTypeName = "";
  dynamic filePath;
  String? selectedDocType;
  String fileName = '';
  String _url = "";
  bool showExpiryDateField = false;
  TextEditingController expiryDateController = TextEditingController();

  bool load = false;
  DateTime? datePicked;
  List<DropdownMenuItem<String>> dropDownMenuItems = [];
  @override
  void initState() {
    dropDownMenuItems = widget.dataList
        .map((doc) => DropdownMenuItem<String>(
              value: doc.docname,
              child: Text(doc.docname),
            ))
        .toList();

    super.initState();
    _url = "";
    showExpiryDateField; // Reset _url when the popup is initialized
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        filePath = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s420,
      height: widget.height == null ? AppSize.s360 : widget.height!,
      body: [
        HeaderContentConst(
          heading: AppString.type_of_the_document,
          content: CICCDropdown(
            initialValue: "Select",
            onChange: (val) {
              setState(() {
                // Always reset the expiry field visibility to false initially
                showExpiryDateField = false;

                // Loop through the documents and check the selected value
                for (var doc in widget.dataList) {
                  if (doc.docname == val) {
                    docTypeId = doc.orgDocumentSetupid!;
                    documentTypeName = doc.docname;

                    // Show expiry date field only if expirytype is "issuer expiry"
                    if (doc.expirytype == AppConfig.issuer) {
                      showExpiryDateField = true;
                    }
                  }
                }
              });
            },
            items: dropDownMenuItems,
          ),
        ),
        Visibility(
          visible: showExpiryDateField,

          /// Conditionally display expiry date field
          child: HeaderContentConst(
            heading: AppString.expiry_date,
            content: FormField<String>(
              builder: (FormFieldState<String> field) {
                return SizedBox(
                  width: 354,
                  height: 30,
                  child: TextFormField(
                    controller: expiryDateController,
                    cursorColor: ColorManager.black,
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.mediumgrey,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorManager.fmediumgrey, width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorManager.fmediumgrey, width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: 'MM-DD-YYYY',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeight.w500,
                        color: ColorManager.mediumgrey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                            width: 1, color: ColorManager.fmediumgrey),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      suffixIcon: Icon(Icons.calendar_month_outlined,
                          color: ColorManager.blueprime),
                      errorText: field.errorText,
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1901),
                        lastDate: DateTime(3101),
                      );
                      if (pickedDate != null) {
                        datePicked = pickedDate;
                        expiryDateController.text =
                            DateFormat('MM-dd-yyyy').format(pickedDate);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please select date';
                      }
                      return null;
                    },
                  ),
                );
              },
            ),
          ),
        ),

        /// upload  doc
        HeaderContentConst(
          heading: AppString.upload_document,
          content: Container(
            height: AppSize.s30,
            width: AppSize.s354,
            padding: EdgeInsets.only(left: AppPadding.p15),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorManager.containerBorderGrey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
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
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.mediumgrey,
                          ),
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
        )
      ],
      bottomButtons: load
          ? SizedBox(
              height: AppSize.s25,
              width: AppSize.s25,
              child: CircularProgressIndicator(
                color: ColorManager.blueprime,
              ),
            )
          : CustomElevatedButton(
              width: AppSize.s105,
              height: AppSize.s30,
              text: AppStringEM.add, //submit
              onPressed: () async {
                setState(() {
                  load = true;
                });
                try {
                  String? expiryDate;
                  if (expiryDateController.text.isEmpty) {
                    expiryDate = null;
                  } else {
                    expiryDate = datePicked!.toIso8601String() + "Z";
                  }
                  ApiData response = await addOrgDocPPPost(
                    context: context,
                    orgDocumentSetupid: docTypeId,
                    idOfDocument: documentTypeName,
                    expiryDate: expiryDate,
                    docCreated: DateTime.now().toIso8601String() + "Z",
                    url: "url",
                    officeId: widget.officeId,
                  );
                  expiryDateController.clear();
                  if (response.statusCode == 200 ||
                      response.statusCode == 201) {
                    await uploadDocumentsoffice(
                        context: context,
                        documentFile: filePath,
                        orgOfficeDocumentId: response.orgOfficeDocumentId!);
                    setState(() {
                      load = false;
                    });
                  }
                } finally {
                  setState(() {
                    Navigator.pop(context);
                    load = false;
                  });
                }
              },
            ),
      title: widget.title,
    );
  }
}
