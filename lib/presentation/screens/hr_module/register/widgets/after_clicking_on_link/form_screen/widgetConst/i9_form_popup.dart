import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/legal_documents/legal_document_manager.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../data/api_data/hr_module_data/legal_document_data/legal_oncall_doc_data.dart';
import '../../../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../../../../em_module/widgets/button_constant.dart';
import '../../../../../../em_module/widgets/dialogue_template.dart';
import '../../../../../../em_module/widgets/header_content_const.dart';
import '../../../../../../em_module/widgets/text_form_field_const.dart';
import 'form_screen_const.dart';

class INineSignPopup extends StatefulWidget {
  final int employeeId;
  final int htmlFormTemplateId;
  const INineSignPopup({super.key, required this.employeeId, required this.htmlFormTemplateId});

  @override
  State<INineSignPopup> createState() => _INineSignPopupState();
}

class _INineSignPopupState extends State<INineSignPopup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController aptNumController = TextEditingController();
  TextEditingController alienInfoController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController uscisController = TextEditingController();
  TextEditingController work1Controller = TextEditingController();
  TextEditingController work2Controller = TextEditingController();
  TextEditingController work3Controller = TextEditingController();

  bool loading = false;
  bool _isFormValid = true;
  String? citizenshipError;
  String? nameError;
  String? lastNameError;
  String? aptNumError;
  String? dateError;
  String? alienError;
  String? workError;
  DateTime? datePicked;

  String? citizentype;
  String  alienWork = "";
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
     // citizenshipError = _validateTextField(uscisController.text, 'citizenship');
      nameError = _validateTextField(nameController.text, 'name');
      lastNameError = _validateTextField(lastNameController.text, 'last name');
      aptNumError = _validateTextField(aptNumController.text, 'apt number');
      // if (citizentype == 'A lawful permanent resident' &&
      //     alienInfoController.text.isEmpty &&
      //     uscisController.text.isEmpty) {
      //   alienError = 'Please enter either Alien Registration Number or USCIS Number';
      //   _isFormValid = false;
      // } else {
      //   alienError = null;
      // }
      ///
      // if (citizentype == 'An alien authorized to work' &&
      //     work1Controller.text.isEmpty &&
      //     work2Controller.text.isEmpty &&
      //     work3Controller.text.isEmpty) {
      //   workError =
      //   'Please enter at least one of Alien Registration / USCIS Number, Form I-94 Admission Number, or Foreign Passport Number';
      //   _isFormValid = false;
      // } if(dateController.text.isEmpty){
      //   dateError = 'Fill this field';
      //   _isFormValid = false;
      // }
      // else {
      //   workError = null;
      //   dateError = null;
      // }
    });
  }
  //
  // Future<String> alienWorkDocument()async{
  //   if(citizentype == 'A citizen of the United States' && citizentype == 'A noncitizen national of the United States'){
  //     return alienWork;
  //   }
  //   else if(citizentype == 'A lawful permanent resident'){
  //     if (alienInfoController.text.isEmpty){
  //       return alienWork = uscisController.text;
  //     }
  //     else{
  //       return alienWork = alienInfoController.text;
  //     }
  //   }
  //   else{
  //     if (work1Controller.text.isEmpty){
  //       return alienWork = work2Controller.text;
  //     }
  //     else if(work2Controller.text.isEmpty){
  //       return alienWork = work3Controller.text;
  //     }
  //     else{
  //       return alienWork = work1Controller.text;
  //     }
  //     }
  //
  // }
  Future<String> alienWorkDocument() async {
    if (citizentype == 'A citizen of the United States' ||
        citizentype == 'A noncitizen national of the United States') {
      return ''; // Pass empty string for these two citizenship types.
    }
    else if (citizentype == 'A lawful permanent resident') {
      // Use either Alien Info or USCIS number
      return alienInfoController.text.isNotEmpty
          ? alienInfoController.text
          : uscisController.text;
    }
    else if (citizentype == 'An alien authorized to work') {
      // Use one of the work-related fields
      if (work1Controller.text.isNotEmpty) {
        return work1Controller.text;
      } else if (work2Controller.text.isNotEmpty) {
        return work2Controller.text;
      } else {
        return work3Controller.text;
      }
    }
    return ''; // Default empty if none match (safety fallback).
  }


  @override
  Widget build(BuildContext context) {
    return TerminationDialogueTemplate(
      width: AppSize.s400,
      height: AppSize.s610,
      title: "i-9 form",
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( AppStringLegalDocument.popupMsgHead,
                style:  LegalDocumentPopupMessage.customTextStyle(context),),
              SizedBox(height: AppSize.s25),
              SMTextFConst(
                controller: nameController,
                keyboardType: TextInputType.text,
                text: 'Middle Name',
              ),
              if (nameError != null)
                Text(
                  nameError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              SizedBox(height: AppSize.s8),
              SMTextFConst(
                controller: lastNameController,
                keyboardType: TextInputType.text,
                text: 'Other Last Name',
              ),
              if (lastNameError != null)
                Text(
                  lastNameError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              SizedBox(height: AppSize.s8),
              SMTextFConst(
                controller: aptNumController,
                keyboardType: TextInputType.text,
                text: 'ATP Number',
              ),
              if (aptNumError != null)
                Text(
                  aptNumError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              SizedBox(height: AppSize.s8),
              SizedBox(height: AppSize.s8),
              Text( 'Citizenship', style: AllPopupHeadings.customTextStyle(context),
              ),
              CustomRadioListTile(
                title: 'A citizen of the United States',
                value: 'A citizen of the United States',
                groupValue: citizentype,
                onChanged: (value) {
                  setState(() {
                    citizentype = value;
                  });
                },
              ),
              CustomRadioListTile(
                title: 'A noncitizen national of the United States',
                value: 'A noncitizen national of the United States',
                groupValue: citizentype,
                onChanged: (value) {
                  setState(() {
                    citizentype = value;
                  });
                },
              ),
              CustomRadioListTile(
                title: 'A lawful permanent resident',
                value: 'A lawful permanent resident',
                groupValue: citizentype,
                onChanged: (value) {
                  setState(() {
                    citizentype = value;
                  });
                },
              ),
              CustomRadioListTile(
                title: 'An alien authorized to work',
                value: 'An alien authorized to work',
                groupValue: citizentype,
                onChanged: (value) {
                  setState(() {
                    citizentype = value;
                  });
                },
              ),
              Visibility(
              visible: citizentype == 'A lawful permanent resident',
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SizedBox(height: AppSize.s8),
              Text(
              'Enter Alien Registration Number / USCIS Number',
              style: AllNoDataAvailable.customTextStyle(context),
              ),
              SMTextFConst(
              controller: alienInfoController,
              keyboardType: TextInputType.text,
              text: 'Alien Registration Number',
              ),
              SMTextFConst(
              controller: uscisController,
              keyboardType: TextInputType.text,
              text: 'USCIS Number',
              ),
              // if (alienError != null)
              // Text(
              // alienError!,
              // style: CommonErrorMsg.customTextStyle(context),
              //       ),
          ],
          ),),
              Visibility(
              visible: citizentype == 'An alien authorized to work',
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SizedBox(height: AppSize.s8),
                HeaderContentConst(
                  heading: "Available Date",
                  content :
                  FormField<String>(
                    builder: (FormFieldState<String> field) {
                      return SizedBox(
                        width: 354,
                        height: 30,
                        child: TextFormField(
                          controller: dateController,
                          cursorColor: ColorManager.black,
                          style: DocumentTypeDataStyle.customTextStyle(context),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorManager.fmediumgrey, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorManager.fmediumgrey, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'MM-DD-YYYY',
                            hintStyle:
                            DocumentTypeDataStyle.customTextStyle(context),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  width: 2, color: ColorManager.fmediumgrey),
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
                              dateController.text =
                                  DateFormat('MM-dd-yyyy').format(pickedDate);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a date';
                            }
                            return null;
                          },
                        ),
                      );
                    },
                  ),
                ),
              // SMTextFConst(controller: dateController,
              //     keyboardType: TextInputType.number,
              //     text: 'expiration date, if applicable',
              // showDatePicker: true,),
                // if (dateError != null)
                //   Text(
                //     dateError!,
                //     style: CommonErrorMsg.customTextStyle(context),
                //   ),
              Container(
                width: 354,
                child: Text(
                'Aliens authorized to work must provide only one of following document number.',
                style: AllNoDataAvailable.customTextStyle(context),
                ),
              ),
              SMTextFConst(
              controller: work1Controller,
              keyboardType: TextInputType.text,
              text: 'Alien Registration / USCIS Number',
              ),
              SMTextFConst(
              controller: work2Controller,
              keyboardType: TextInputType.text,
              text: 'Form I-94 Admission Number',
              ),
              SMTextFConst(
              controller: work3Controller,
              keyboardType: TextInputType.text,
              text: 'Foreign Passport Number',
              ),
              // if (workError != null)
              // Text(
              //   workError!,
              // style: CommonErrorMsg.customTextStyle(context),
              // ),
              ],
              ),),
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
        text: AppStringEM.submit,
        onPressed: () async {
          _validateForm(); // Validate the form before submission.

          String alienWork = '';
          alienWork = await alienWorkDocument(); // Await the correct value.
          print(alienWork);

          if (_isFormValid) {
            setState(() {
              loading = true;
            });

            try {
              // Call the API with correct parameters.
              INineDocument iNineDocument = await getI9Document(
                context: context,
                i9FormhtmlId: widget.htmlFormTemplateId,
                employeeId: widget.employeeId,
                middleName: nameController.text,
                otherLastName: lastNameController.text,
                aptNumber: aptNumController.text,
                alienInfo: alienWork, // Use the returned value.
                citizenship: citizentype.toString(),
                  alienDate: dateController.text
              );

              print("Middle Name: ${nameController.text}");
              print("Last Name: ${lastNameController.text}");
              print("APT Number: ${aptNumController.text}");
              print("Alien Info: $alienWork");
              print("Citizenship: $citizentype");

              if (iNineDocument.statusCode == 200 || iNineDocument.statusCode == 201) {
                Navigator.pop(context); // Close the current popup.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SignatureFormScreen(
                      documentName: iNineDocument.name,
                      onPressed: () {},
                      htmlFormData: iNineDocument.html,
                      employeeId: widget.employeeId,
                      htmlFormTemplateId: iNineDocument.iNineDocumentId,
                    ),
                  ),
                );
              }
            } catch (e) {
              print("Error: $e");
            } finally {
              setState(() {
                loading = false;
              });
            }
          }
        },
      )
      ,);
  }
}
//
// CustomElevatedButton(
// width: AppSize.s105,
// height: AppSize.s30,
// text: AppStringEM.submit,
// onPressed: () async {
// _validateForm(); // Validate the form on button press
// await alienWorkDocument();
// if (_isFormValid) {
// setState(() {
// loading = true;
// });
//
// INineDocument iNineDocument = await getI9Document(context: context, i9FormhtmlId: widget.htmlFormTemplateId, employeeId: widget.employeeId,
// middleName: nameController.text, otherLastName: lastNameController.text, aptNumber: aptNumController.text, alienInfo: alienWork,
// citizenship: citizentype.toString());
// print("${nameController.text}");
// print("${lastNameController.text}");
// print("${aptNumController.text}");
// print("${alienWork}");
// print(citizentype.toString());
// if(iNineDocument.statusCode == 200 || iNineDocument.statusCode == 201){
// Navigator.pop(context);
// Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
// documentName: iNineDocument.name,
// onPressed: () {
//
// },
// htmlFormData: iNineDocument.html,
// employeeId: widget.employeeId,//widget.employeeID,
// htmlFormTemplateId: iNineDocument.iNineDocumentId,)));
// }
//
//
// };
// //finally {
// setState(() {
// loading = false;
// // Navigator.pop(context);
// });
// // }
// }
// )