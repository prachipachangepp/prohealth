import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/header_content_const.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/services/api/managers/establishment_manager/newpopup_manager.dart';

class VCScreenPopupEditConst extends StatefulWidget {
  final String title;
  bool? loadingDuration;
  final String officeId;
  final int orgDocId;
  final String docName;
  final String url;
  final String selectedExpiryType;
  final int orgDocumentSetupid;
  final String? expiryDate;

  final int docTypeMetaIdCC;
  final int selectedSubDocId;

  final double? height;
  final Widget? uploadField;
  VCScreenPopupEditConst({
    super.key,
    required this.title,
    this.height,
    this.loadingDuration,
    this.uploadField,
    required this.officeId,
    required this.docTypeMetaIdCC,
    required this.selectedSubDocId,
    required this.orgDocId,
    required this.orgDocumentSetupid,
    required this.docName,
    required this.selectedExpiryType,
    required this.expiryDate,
    required this.url,
  });

  @override
  State<VCScreenPopupEditConst> createState() => _VCScreenPopupEditConstState();
}

class _VCScreenPopupEditConstState extends State<VCScreenPopupEditConst> {
  int docTypeId = 0;
  String? documentTypeName;
  dynamic filePath;
  String? selectedDocType;
  String fileName = '';
  bool fileIsPicked = false;
  DateTime? datePicked;
  bool loading = false;
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        fileIsPicked = true;
        filePath = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  bool _isLoading = false;
  bool showExpiryDateField = false;
  TextEditingController expiryDateController = TextEditingController();

  @override
  void initState() {
    if (widget.selectedExpiryType == AppConfig.issuer) {
      DateTime dateTime =
          DateTime.parse(widget.expiryDate ?? DateTime.now().toString());
      showExpiryDateField = true;
      datePicked = dateTime;
      expiryDateController = TextEditingController(
          text: DateFormat('MM-dd-yyyy').format(dateTime!));
    }
    fileName = widget.docName;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s420,
      height: widget.height == null ? AppSize.s390 : widget.height!,
      body: [
        HeaderContentConst(
          heading: AppString.type_of_the_document,
          content: Container(
            width: 354,
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: ColorManager.fmediumgrey, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.docName,
                  style: ConstTextFieldRegister.customTextStyle(context),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
        ),

        /// upload  doc
        HeaderContentConst(
            heading: AppString.upload_document,
            content: InkWell(
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
                              style: TextStyle(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeight.w500,
                                color: ColorManager.greylight,
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
            )),
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
                    style: ConstTextFieldRegister.customTextStyle(context),
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
                      hintStyle: ConstTextFieldRegister.customTextStyle(context),
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
                        initialDate: datePicked,
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
      ],
      bottomButtons: loading
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
              text: AppStringEM.save, //submit
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                try {
                  String? expiryDate;
                  expiryDate = widget.selectedExpiryType == AppConfig.issuer
                      ? datePicked!.toIso8601String() + "Z"
                      : null;
                  var response = await updateOrgDoc(
                    context: context,
                    orgDocId: widget.orgDocId,
                    orgDocumentSetupid: widget.orgDocumentSetupid,
                    idOfDocument: widget.docName,
                    expiryDate: expiryDate,
                    docCreatedat: DateTime.now().toIso8601String() + "Z",
                    url: widget.url,
                    officeid: widget.officeId,
                  );

                  if (response.statusCode == 200 ||
                      response.statusCode == 201) {
                    if (fileIsPicked) {
                      await uploadDocumentsoffice(
                          context: context,
                          documentFile: filePath,
                          orgOfficeDocumentId: response.orgOfficeDocumentId!);
                    }
                    setState(() {
                      loading = false;
                    });
                  }
                } finally {
                  setState(() {
                    loading = false;
                  });
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CountySuccessPopup(
                        message: 'Save Successfully',
                      );
                    },
                  );
                }
              },
            ),
      title: widget.title,
    );
  }
}
