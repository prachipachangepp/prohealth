import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/header_content_const.dart';

import '../../../../../../../../../app/resources/color.dart';
import '../../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../../app/services/api/managers/establishment_manager/new_org_doc/new_org_doc.dart';
import '../../../../../../../../widgets/error_popups/failed_popup.dart';
import '../../../../../../../../widgets/error_popups/four_not_four_popup.dart';
import '../../../../../../manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../../../../widgets/button_constant.dart';
import '../../../../../../widgets/text_form_field_const.dart';
import '../../../../whitelabelling/success_popup.dart';

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

  String? _idDocError;
  String? _nameDocError;
  String? _expiryTypeError;

  TextEditingController daysController = TextEditingController(text: "1");

  String? _validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      _isFormValid = false;
      return "Please Enter $fieldName";
    }
    return null;
  }

  void _validateForm() {
    setState(() {
      _isFormValid = true;
      _idDocError =
          _validateTextField(idDocController.text, 'ID of the Document');
      _nameDocError =
          _validateTextField(nameDocController.text, 'Name of the Document');
      if (selectedExpiryType.isEmpty) {
        _expiryTypeError = "Please select an expiry type";
        _isFormValid = false;
      } else {
        _expiryTypeError = null;
      }
    });
  }

  String? selectedYear = AppConfig.year;
  bool loading = false;

  @override
  void initState() {
    super.initState();

    if (widget.subDocTypeId == AppConfig.subDocId10MISC) {
      setState(() {
        selectedExpiryType = AppConfig.scheduled;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s420,
      height: widget.subDocTypeId == AppConfig.subDocId10MISC
          ? widget.height ?? AppSize.s530
      : widget.docTypeId == AppConfig.policiesAndProcedure
       ? widget.height ??AppSize.s540
      :widget.height ??AppSize.s610,
      body: [
       Padding(
         padding: const EdgeInsets.symmetric(
          // vertical: AppPadding.p1,
           horizontal: AppPadding.p10,
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             /// ID of the Document
             SMTextfieldAsteric(
               controller: idDocController,
               keyboardType: TextInputType.text,
               text: AppString.id_of_the_document,
             ),
             if (_idDocError != null) // Display error if any
               Text(
                 _idDocError!,
                 style:CommonErrorMsg.customTextStyle(context),
               ),
             /// Name of the Document
             SMTextfieldAsteric(
               controller: nameDocController,
               keyboardType: TextInputType.text,
               text: AppString.name_of_the_document,
             ),
             if (_nameDocError != null) // Display error if any
               Text(
                 _nameDocError!,
                 style:CommonErrorMsg.customTextStyle(context),
               ),

             /// Type of the Document
             HeaderContentConst(
              // isAsterisk: true,
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
                       style: DocumentTypeDataStyle.customTextStyle(context),
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
               //isAsterisk: true,
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
                       style: DocumentTypeDataStyle.customTextStyle(context),
                     ),
                   ],
                 ),
               ),
             ),
             /// Radio Button Section
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 2),
               child: Row(
                 children: [
                   HeaderContentConst(
                     isAsterisk: true,
                     heading: AppString.expiry_type,
                     content: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         widget.subDocTypeId == AppConfig.subDocId10MISC
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
                         widget.subDocTypeId == AppConfig.subDocId10MISC
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
                         if (_expiryTypeError != null)
                           Text(
                             _expiryTypeError!,
                             style: CommonErrorMsg.customTextStyle(context),
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
                           SizedBox(height: 20,),
                           Row(
                             children: [
                               Container(
                                 height: 30,
                                 width: 50,
                                 //color: ColorManager.red,
                                 child: TextFormField(
                                   textAlign: TextAlign.center,
                                   controller:
                                   daysController, // Use the controller initialized with "1"
                                   cursorColor: ColorManager.black,
                                   cursorWidth: 1,
                                   style: DocumentTypeDataStyle.customTextStyle(context),
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
                                         style: DocumentTypeDataStyle.customTextStyle(context),
                                       ),
                                     ),
                                     DropdownMenuItem(
                                       value: AppConfig.month,
                                       child: Text(
                                         AppConfig.month,
                                         style:DocumentTypeDataStyle.customTextStyle(context),
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
                                     hintStyle: DocumentTypeDataStyle.customTextStyle(context),
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
         ),
       )
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
                 var response =  await addNewOrgDocumentPost(
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
                    if(response.statusCode == 200 || response.statusCode == 201) {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddSuccessPopup(
                            message: 'Added Successfully',
                          );
                        },
                      );
                    }
                else if(response.statusCode == 400 || response.statusCode == 404){
                   Navigator.pop(context);
                   showDialog(
                     context: context,
                     builder: (BuildContext context) => const FourNotFourPopup(),
                   );
                 }
                 else {
                   Navigator.pop(context);
                   showDialog(
                     context: context,
                     builder: (BuildContext context) => FailedPopup(text: response.message),
                   );
                 }
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
class OrgDocNewEditPopup extends StatefulWidget {
  final double? height;
  final String docTypeText;
  final int docTypeId;
  final int subDocTypeId;
  final String subDocTypeText;
  final String title;
  final String? selectedSubDocType;
  final int orgDocumentSetupid;
  final String docName;
  final String? expiryType;
  final int? threshhold;
  final String? expiryDate;
  final String expiryReminder;
  final String idOfDoc;
  const OrgDocNewEditPopup({
    super.key,
    required this.title,
    this.height,
    this.selectedSubDocType,
    required this.docTypeText,
    required this.docTypeId,
    required this.subDocTypeId,
    required this.subDocTypeText, required this.orgDocumentSetupid, required this.docName, this.expiryType, this.threshhold, this.expiryDate, required this.expiryReminder, required this.idOfDoc,
  });

  @override
  State<OrgDocNewEditPopup> createState() => _OrgDocNewEditPopupState();
}

class _OrgDocNewEditPopupState extends State<OrgDocNewEditPopup> {
  bool _isFormValid = true;
  String selectedExpiryType = "";
  TextEditingController idDocController = TextEditingController();
  TextEditingController nameDocController = TextEditingController();

  // Error messages for each text field
  String? _nameDocError;

  TextEditingController daysController = TextEditingController(text: "1");

  String? _validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      _isFormValid = false;
      return "Please Enter $fieldName";
    }
    return null;
  }

  void _validateForm() {
    setState(() {
      _isFormValid = true;
     _nameDocError =
          _validateTextField(nameDocController.text, 'Name of the Document');
    });
  }

  String? selectedYear = AppConfig.year;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    nameDocController.text = widget.docName;
    if (widget.expiryType == AppConfig.scheduled) {
      selectedExpiryType = AppConfig.scheduled;
    }
    else if (widget.expiryType == AppConfig.notApplicable) {
      selectedExpiryType = AppConfig.notApplicable;
    }
    else if (widget.expiryType == AppConfig.issuer) {
      selectedExpiryType = AppConfig.issuer;
    }

    if (selectedExpiryType == AppConfig.scheduled && widget.threshhold != null) {
      int threshold = widget.threshhold!;

      if (threshold >= 365) {
        daysController.text = (threshold ~/ 365).toString(); // Set years
        selectedYear = AppConfig.year;
      } else {
        daysController.text = (threshold ~/ 30).toString(); // Set months
        selectedYear = AppConfig.month;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s420,
      height: widget.height ?? AppSize.s440,
      body: [
        /// ID of the Document
        HeaderContentConst(
          heading: AppString.id_of_the_document,
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
                  widget.idOfDoc,
                  style: DocumentTypeDataStyle.customTextStyle(context),
                ),
              ],
            ),
          ),
        ),

        /// Name of the Document
        SMTextfieldAsteric(
          controller: nameDocController,
          keyboardType: TextInputType.text,
          text: AppString.name_of_the_document,
        ),
        if (_nameDocError != null) // Display error if any
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 15),
                child: Text(
                  _nameDocError!,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: FontSize.s10,
                  ),
                ),
              ),
            ],
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
                  style:  DocumentTypeDataStyle.customTextStyle(context),
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
                  style:  DocumentTypeDataStyle.customTextStyle(context),
                ),
              ],
            ),
          ),
        ),

        /// Radio Button Section
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 12),
        //   child: Row(
        //     children: [
        //       HeaderContentConst(
        //         heading: AppString.expiry_type,
        //         content: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             widget.subDocTypeId == AppConfig.subDocId10MISC
        //                 ? Offstage()
        //                 : CustomRadioListTile(
        //               value: AppConfig.notApplicable,
        //               groupValue: selectedExpiryType,
        //               onChanged: (value) {
        //                 setState(() {
        //                   selectedExpiryType = value!;
        //                 });
        //               },
        //               title: AppConfig.notApplicable,
        //             ),
        //             CustomRadioListTile(
        //               value: AppConfig.scheduled,
        //               groupValue: selectedExpiryType,
        //               onChanged: (value) {
        //                 setState(() {
        //                   selectedExpiryType = value!;
        //                 });
        //               },
        //               title: AppConfig.scheduled,
        //             ),
        //             widget.subDocTypeId == AppConfig.subDocId10MISC
        //                 ? Offstage()
        //                 : CustomRadioListTile(
        //               value: AppConfig.issuer,
        //               groupValue: selectedExpiryType,
        //               onChanged: (value) {
        //                 setState(() {
        //                   selectedExpiryType = value!;
        //                 });
        //               },
        //               title: AppConfig.issuer,
        //             ),
        //           ],
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(
        //           left: AppPadding.p20,
        //           right: AppPadding.p20,
        //         ),
        //         child: Visibility(
        //           visible: selectedExpiryType == AppConfig.scheduled,
        //           child: Column(
        //             children: [
        //               SizedBox(
        //                 height: 20,
        //               ),
        //               Row(
        //                 children: [
        //                   Container(
        //                     height: 30,
        //                     width: 50,
        //                     //color: ColorManager.red,
        //                     child: TextFormField(
        //                       controller:
        //                       daysController,
        //                       cursorColor: ColorManager.black,
        //                       cursorWidth: 1,
        //                       style: GoogleFonts.firaSans(
        //                         fontSize: FontSize.s10,
        //                         fontWeight: FontWeight.w500,
        //                         color: ColorManager.mediumgrey,
        //                       ),
        //                       decoration: InputDecoration(
        //                         enabledBorder: OutlineInputBorder(
        //                           borderSide: BorderSide(
        //                               color: ColorManager.fmediumgrey,
        //                               width: 2),
        //                           borderRadius: BorderRadius.circular(8),
        //                         ),
        //                         focusedBorder: OutlineInputBorder(
        //                           borderSide: BorderSide(
        //                               color: ColorManager.fmediumgrey,
        //                               width: 2),
        //                           borderRadius: BorderRadius.circular(8),
        //                         ),
        //                         contentPadding:
        //                         EdgeInsets.symmetric(horizontal: 10),
        //                       ),
        //                       keyboardType: TextInputType.number,
        //                       inputFormatters: [
        //                         FilteringTextInputFormatter
        //                             .digitsOnly, // This ensures only digits are accepted
        //                       ],
        //                     ),
        //                   ),
        //                   SizedBox(width: 10),
        //                   Container(
        //                     height: 30,
        //                     width: 80,
        //                     padding: EdgeInsets.symmetric(horizontal: 5),
        //                     decoration: BoxDecoration(
        //                       border:
        //                       Border.all(color: ColorManager.fmediumgrey),
        //                       borderRadius: BorderRadius.circular(8),
        //                     ),
        //                     child: DropdownButtonFormField<String>(
        //                       value:
        //                       selectedYear, // Initial value (you should define this variable)
        //                       items: [
        //                         DropdownMenuItem(
        //                           value: AppConfig.year,
        //                           child: Text(
        //                             AppConfig.year,
        //                             style: GoogleFonts.firaSans(
        //                               fontSize: FontSize.s10,
        //                               fontWeight: FontWeight.w500,
        //                               color: ColorManager.mediumgrey,
        //                             ),
        //                           ),
        //                         ),
        //                         DropdownMenuItem(
        //                           value: AppConfig.month,
        //                           child: Text(
        //                             AppConfig.month,
        //                             style: GoogleFonts.firaSans(
        //                               fontSize: FontSize.s10,
        //                               fontWeight: FontWeight.w500,
        //                               color: ColorManager.mediumgrey,
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                       onChanged: (value) {
        //                         setState(() {
        //                           selectedYear = value;
        //                         });
        //                       },
        //                       decoration: InputDecoration(
        //                         enabledBorder: InputBorder.none,
        //                         focusedBorder: InputBorder.none,
        //                         hintText: AppConfig.year,
        //                         hintStyle: GoogleFonts.firaSans(
        //                           fontSize: FontSize.s10,
        //                           fontWeight: FontWeight.w500,
        //                           color: ColorManager.mediumgrey,
        //                         ),
        //                         contentPadding: EdgeInsets.only(bottom: 20),
        //                       ),
        //                       icon: Icon(
        //                         Icons.arrow_drop_down,
        //                         color: ColorManager.black,
        //                         size: 16,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),


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
        text: AppStringEM.save,
        onPressed: () async {
          _validateForm(); // Validate the form on button press
          if (_isFormValid) {
            setState(() {
              loading = true;
            });

            int threshold = 0;
            String? expiryDateToSend = "";
            if (selectedExpiryType == AppConfig.scheduled && daysController.text.isNotEmpty) {
              int enteredValue = int.parse(daysController.text);
              if (selectedYear == AppConfig.year) {
                threshold = enteredValue * 365;
              } else if (selectedYear == AppConfig.month) {
                threshold = enteredValue * 30;
              }
              expiryDateToSend = daysController.text;
            } else if (selectedExpiryType == AppConfig.notApplicable || selectedExpiryType == AppConfig.issuer) {
              threshold = 0;
              expiryDateToSend = null;
            }
            try {
              ///docname
              String finalDocName = nameDocController.text.isNotEmpty
                  ? nameDocController.text
                  : widget.docName;

            var response =  await updateNewOrgDocumentPatch(
                context: context,
                orgDocumentSetupid: widget.orgDocumentSetupid,
                docTypeID: widget.docTypeId,
                docSubTypeID: widget.subDocTypeId,
                docName: finalDocName,//name == docNameController.text ? name.toString() : docNameController.text,
                expiryType: selectedExpiryType == selectedExpiryType.toString() ? selectedExpiryType.toString() : widget.expiryType!,
                threshold: threshold,
                expiryDate: null,//widget.expiryDate,
                expiryReminder:  selectedExpiryType == selectedExpiryType.toString() ? selectedExpiryType.toString() : widget.expiryType!,
                idOfDoc: widget.idOfDoc,
              );
              if(response.statusCode == 200 || response.statusCode == 201) {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddSuccessPopup(
                      message: 'Edited Successfully',
                    );
                  },
                );
              }
              else if(response.statusCode == 400 || response.statusCode == 404){
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const FourNotFourPopup(),
                );
              }
              else {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) => FailedPopup(text: response.message),
                );
              }
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