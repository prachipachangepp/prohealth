import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/header_content_const.dart';

import '../../../../../../../../../app/resources/color.dart';
import '../../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../../app/services/api/managers/establishment_manager/new_org_doc/new_org_doc.dart';
import '../../../../../../manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../../../../widgets/button_constant.dart';
import '../../../../../../widgets/text_form_field_const.dart';

///Add new popup
class AddNewOrgDocButton extends StatefulWidget {
  final double? height;
  final String docTypeText;

  final int docTypeId;
  final int subDocTypeId;
  final String subDocTypeText;

  final String title;

  final String? selectedSubDocType;
  AddNewOrgDocButton({
    super.key,
    required this.title,
    this.height,
    this.selectedSubDocType,
    required this.docTypeText,
    required this.docTypeId,
    required this.subDocTypeId,
    required this.subDocTypeText,
  });

  @override
  State<AddNewOrgDocButton> createState() => _AddOrgDocButtonState();
}

class _AddOrgDocButtonState extends State<AddNewOrgDocButton> {
  bool _isFormValid = true;
  String selectedExpiryType = "";
  TextEditingController idDocController = TextEditingController();
  TextEditingController nameDocController = TextEditingController();

  // Error messages for each text field
  String? _idDocError;
  String? _nameDocError;

  TextEditingController daysController = TextEditingController(text: "1");

  String? _validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      _isFormValid = false;
      return "Please Enter $fieldName";
    }
    // if (value.isEmpty) {
    //   _isFormValid = false;
    //   return "$fieldName must start with a capital letter";
    // }
    return null;
  }

  void _validateForm() {
    setState(() {
      _isFormValid = true;
      _idDocError =
          _validateTextField(idDocController.text, 'ID of the Document');
      _nameDocError =
          _validateTextField(nameDocController.text, 'Name of the Document');
    });
  }

  String? selectedYear;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s420,
      height: widget.height ?? AppSize.s560,
      body: [
        /// ID of the Document
        SMTextFConst(
          controller: idDocController,
          keyboardType: TextInputType.text,
          text: AppString.id_of_the_document,
        ),
        if (_idDocError != null)
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              _idDocError!,
              style: TextStyle(
                color: Colors.red,
                fontSize: FontSize.s12,
              ),
            ),
          ),

        /// Name of the Document
        FirstSMTextFConst(
          controller: nameDocController,
          keyboardType: TextInputType.text,
          text: AppString.name_of_the_document,
        ),
        if (_nameDocError != null) // Display error if any
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              _nameDocError!,
              style: TextStyle(
                color: Colors.red,
                fontSize: FontSize.s12,
              ),
            ),
          ),

        /// Type of the Document
        HeaderContentConst(
          heading: AppString.type_of_the_document,
          content: Container(
            width: 354,
            height: 30,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ColorManager.fmediumgrey, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.docTypeText,
                  style: CustomTextStylesCommon.commonStyle(
                    fontWeight: FontWeightManager.medium,
                    fontSize: FontSize.s12,
                    color: ColorManager.mediumgrey,
                  ),
                ),
              ],
            ),
          ),
        ),

        /// Sub Type of the Document
        widget.docTypeId == AppConfig.policiesAndProcedure
            ? SizedBox(
                height: 1,
              )
            : HeaderContentConst(
                heading: AppString.sub_type_of_the_document,
                content: Container(
                  height: 30,
                  width: 354,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: ColorManager.fmediumgrey, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.subDocTypeText,
                        style: CustomTextStylesCommon.commonStyle(
                          fontWeight: FontWeightManager.medium,
                          fontSize: FontSize.s12,
                          color: ColorManager.mediumgrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

        /// Radio Button Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              HeaderContentConst(
                heading: AppString.expiry_type,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.subDocTypeId == AppConfig.misc
                        ? Offstage()
                        : CustomRadioListTile(
                            value: AppConfig.notApplicable,
                            groupValue: selectedExpiryType,
                            onChanged: (value) {
                              setState(() {
                                selectedExpiryType = value!;
                              });
                            },
                            title: AppConfig.notApplicable,
                          ),
                    CustomRadioListTile(
                      value: AppConfig.scheduled,
                      groupValue: selectedExpiryType,
                      onChanged: (value) {
                        setState(() {
                          selectedExpiryType = value!;
                        });
                      },
                      title: AppConfig.scheduled,
                    ),
                    widget.subDocTypeId == AppConfig.misc
                        ? Offstage()
                        : CustomRadioListTile(
                            value: AppConfig.issuer,
                            groupValue: selectedExpiryType,
                            onChanged: (value) {
                              setState(() {
                                selectedExpiryType = value!;
                              });
                            },
                            title: AppConfig.issuer,
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p20,
                  right: AppPadding.p20,
                ),
                child: Visibility(
                  visible: selectedExpiryType == AppConfig.scheduled,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 50,
                            //color: ColorManager.red,
                            child: TextFormField(
                              controller:
                                  daysController, // Use the controller initialized with "1"
                              cursorColor: ColorManager.black,
                              cursorWidth: 1,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.mediumgrey,
                              ),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorManager.fmediumgrey,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorManager.fmediumgrey,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .digitsOnly, // This ensures only digits are accepted
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            height: 30,
                            width: 80,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: ColorManager.fmediumgrey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonFormField<String>(
                              value:
                                  selectedYear, // Initial value (you should define this variable)
                              items: [
                                DropdownMenuItem(
                                  value: AppConfig.year,
                                  child: Text(
                                    AppConfig.year,
                                    style: GoogleFonts.firaSans(
                                      fontSize: FontSize.s10,
                                      fontWeight: FontWeightManager.medium,
                                      color: ColorManager.mediumgrey,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: AppConfig.month,
                                  child: Text(
                                    AppConfig.month,
                                    style: GoogleFonts.firaSans(
                                      fontSize: FontSize.s10,
                                      fontWeight: FontWeightManager.medium,
                                      color: ColorManager.mediumgrey,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedYear =
                                      value; // Update the selected option (Year/Month)
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: AppConfig.year,
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: FontSize.s10,
                                  fontWeight: FontWeightManager.medium,
                                  color: ColorManager.mediumgrey,
                                ),
                                contentPadding: EdgeInsets.only(bottom: 20),
                              ),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: ColorManager.black,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      bottomButtons: loading == true
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
              text: AppStringEM.add,
              onPressed: () async {
                _validateForm(); // Validate the form on button press
                if (_isFormValid) {
                  setState(() {
                    loading = true;
                  });

                  int threshold = 0;
                  if (selectedExpiryType == AppConfig.scheduled &&
                      daysController.text.isNotEmpty) {
                    int enteredValue = int.parse(daysController.text);
                    if (selectedYear == AppConfig.year) {
                      threshold = enteredValue * 365;
                    } else if (selectedYear == AppConfig.month) {
                      threshold = enteredValue * 30;
                    }
                  }
                  try {
                    await addNewOrgDocumentPost(
                        context: context,
                        docName: nameDocController.text,
                        docTypeID: widget.docTypeId,
                        docSubTypeID: widget.subDocTypeId,
                        threshold: threshold,
                        expiryType: selectedExpiryType.toString(),
                        expiryDate: null, //expiryTypeToSend,
                        expiryReminder: selectedExpiryType.toString(),
                        idOfDoc: idDocController.text);
                    // await getNewOrgDocument(context);
                    Navigator.pop(context);
                  } finally {
                    setState(() {
                      loading = false;
                    });
                  }
                }
              },
            ),
      title: widget.title,
    );
  }
}

///edit popup
class CCScreenEditNewPopup extends StatefulWidget {
  final String? idOfDoc;
  final TextEditingController idOfDocController;
  final TextEditingController nameDocController;
  final TextEditingController? calenderController;
  final VoidCallback? onSavePressed;
  final Widget child;
  final Widget? child1;
  final Widget? child2;
  final Widget? child3;
  final double? height;
  final Widget? radioButton;
  bool? loadingDuration;
  final String title;

  CCScreenEditNewPopup({
    super.key,
    required this.idOfDocController,
    required this.nameDocController,
    this.onSavePressed,
    required this.child,
    this.child1,
    this.child2,
    this.child3,
    this.idOfDoc,
    this.radioButton,
    this.calenderController,
    this.loadingDuration,
    required this.title,
    this.height,
  });

  @override
  State<CCScreenEditNewPopup> createState() => _CCScreenEditPopupState();
}

class _CCScreenEditPopupState extends State<CCScreenEditNewPopup> {
  String? _expiryType;
  final DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s420,
        height: widget.height == null ? AppSize.s550 : widget.height,
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
              height: AppSize.s35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Text(
                      widget.title,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s13,
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
                    icon: Icon(
                      Icons.close,
                      color: ColorManager.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p18,
                horizontal: AppPadding.p18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    enable: false,
                    // readOnly: true,
                    controller: widget.idOfDocController,
                    keyboardType: TextInputType.text,
                    text: AppString.id_of_the_document,
                  ),
                  SizedBox(height: AppSize.s12),
                  SMTextFConst(
                    controller: widget.nameDocController,
                    keyboardType: TextInputType.text,
                    text: AppString.name_of_the_document,
                  ),
                  SizedBox(height: AppSize.s12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.type_of_the_document,
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.mediumgrey,
                          //decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: AppSize.s5),
                      widget.child!,
                    ],
                  ),
                  SizedBox(height: AppSize.s10),
                  if (widget.child1 != null) ...[
                    Text(
                      AppString.sub_type_of_the_document,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.mediumgrey,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: AppSize.s5),
                  ],
                  widget.child1 ?? Offstage(),
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),

            ///radio
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
              child: Row(
                children: [
                  widget.radioButton!,
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppPadding.p20,
                      right: AppPadding.p20,
                    ),
                    child: widget.child3,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s10),

            Padding(
              padding: const EdgeInsets.only(
                left: AppPadding.p20,
                right: AppPadding.p20,
              ),
              child: widget.child2,
            ),
            SizedBox(height: AppSize.s20),

            ///button
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p10),
              child: Center(
                child: widget.loadingDuration == true
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
                        onPressed: () {
                          widget.onSavePressed!();
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
