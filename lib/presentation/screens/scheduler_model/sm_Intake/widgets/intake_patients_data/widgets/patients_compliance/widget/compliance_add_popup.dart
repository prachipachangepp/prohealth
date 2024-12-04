import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/sm_module_manager/lab_report/lab_report_manager.dart';
import 'package:prohealth/app/services/api/managers/sm_module_manager/patient_data/patient_data_compliance.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/sm_data/patient_data/patient_data_compliance.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';

import '../../../../../../../../../app/resources/color.dart';
import '../../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../em_module/widgets/button_constant.dart';
import '../../patients_plan_care/intake_patients_plan_care.dart';

class ComplianceAddPopUp extends StatefulWidget {
  final TextEditingController idDocController;
  final TextEditingController nameDocController;
  final TextEditingController calenderController;
  final VoidCallback onPressed;
  final Widget? child;
  final String title;
  final Widget? radioButton;
  final Widget? child2;
  final bool? loadingDuration;
  final Widget? uploadField;
  final int? patientId;
   dynamic filePath;
   String? fileName;

  ComplianceAddPopUp({
    super.key,
    this.fileName,
     this.patientId,
    required this.idDocController,
    required this.nameDocController,
    required this.calenderController,
    required this.onPressed,
     this.uploadField,
    required this.title,
    this.radioButton,
    this.child2,
    this.child,
    this.loadingDuration, this.filePath,
  });

  @override
  State<ComplianceAddPopUp> createState() => _ComplianceAddPopUpState();
}

class _ComplianceAddPopUpState extends State<ComplianceAddPopUp> {
  final StreamController<List<PDComplianceModal>>
  _compliancePatientDataController =
  StreamController<List<PDComplianceModal>>();
  String _fileName = 'Upload';
  int docTypeId = 0;
  String? documentTypeName;
  dynamic filePath;
  String selectedDocType = "Select Document";
  String fileName ='';
  bool fileAbove20Mb = false;
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    final fileSize = result?.files.first.size; // File size in bytes
    final isAbove20MB = fileSize! > (20 * 1024 * 1024);
    if (result != null) {
      setState(() {
        filePath = result.files.first.bytes;
        fileName = result.files.first.name;
        fileAbove20Mb = !isAbove20MB;
        print('File path ${filePath}');
        print('File name ${fileName}');
      });
    }
  }
  String? selectedExpiryType;
  bool _isLoading =false;
  String? _nameDocError;
  String? _selectDocError;
  String? _selectExpTypeError ;
  String? _uploadDocError;
  void _validateFields() {
    setState(() {
      _nameDocError = widget.nameDocController.text.isEmpty ? 'Please Enter Document Name' : null;
      _selectDocError = selectedDocType == "Select Document" ? 'Please Select Document' : null;
      _selectExpTypeError = selectedExpiryType == null ? 'Please select expiry type': null;
      _uploadDocError = fileName == '' ? 'Please upload document':null;
    });
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: ColorManager.white,
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFB1B1B1), width: 1),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                  12,
                ),
                topLeft: Radius.circular(
                  12,
                ),
              ),
              color: ColorManager.blueprime,
            ),
            height: AppSize.s40,
            width: 408,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    widget.title,
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManager.white,
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: ColorManager.white,
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ],
      ),
      content: Container(
        height: 470,
        width: AppSize.s350,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppString.type_of_the_document,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                FutureBuilder<List<PatientDataComplianceDoc>>(
                  future:
                  getpatientDataComplianceDoc(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Container(
                        width: 350,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(10),
                        ),
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          AppString.dataNotFound,
                          style: CustomTextStylesCommon
                              .commonStyle(
                            fontWeight:
                            FontWeightManager.medium,
                            fontSize: FontSize.s14,
                            color: ColorManager.mediumgrey,
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      List<DropdownMenuItem<String>>
                      dropDownMenuItems = snapshot.data!
                          .map((doc) =>
                          DropdownMenuItem<String>(
                            value: doc.docType,
                            child: Text(doc.docType!),
                          ))
                          .toList();
                      docTypeId = snapshot.data![0].docTypeId!;
                      documentTypeName = snapshot.data![0].docType!;
                      return CICCDropdown(
                        initialValue: selectedDocType ??
                            dropDownMenuItems[0].value,
                        onChange: (val) {
                          setState(() {
                            selectedDocType = val;
                            for (var doc in snapshot.data!) {
                              if (doc.docType == val) {
                                docTypeId = doc.docTypeId!;
                                documentTypeName = doc.docType;
                              }
                            }
                            getComplianceByPatientId(
                                context,
                                1
                            ).then((data) {
                              _compliancePatientDataController
                                  .add(data);
                            }).catchError((error) {
                              // Handle error
                            });
                          });
                        },
                        items: dropDownMenuItems,
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                if (_selectDocError != null)
                  Text(
                    _selectDocError!,
                    style: CommonErrorMsg.customTextStyle(context),
                  ),
                SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Text(
                //       AppString.name_of_the_document,
                //       style: GoogleFonts.firaSans(
                //         fontSize: FontSize.s14,
                //         fontWeight: FontWeightManager.bold,
                //         color: ColorManager.textPrimaryColor,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 5),
                ///name of doc
                // Container(
                //   height: AppSize.s30,
                //   child: TextFormField(
                //     cursorColor: Colors.black,
                //     cursorHeight: 18,
                //     controller: widget.nameDocController,
                //     style: GoogleFonts.firaSans(
                //       fontSize: AppSize.s12,
                //       fontWeight: FontWeightManager.regular,
                //       color: ColorManager.greylight,
                //     ),
                //     textAlignVertical: TextAlignVertical.center,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: ColorManager.containerBorderGrey,
                //           width: 1.0,
                //         ),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: ColorManager.containerBorderGrey,
                //           width: 1.0,
                //         ),
                //       ),
                //       contentPadding:
                //           EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                //     ),
                //   ),
                // ),
                SMTextFConst(
                  controller: widget.nameDocController,
                  keyboardType: TextInputType.text,
                  text:  AppString.name_of_the_document,
                ),
                if (_nameDocError != null)
                  Text(
                    _nameDocError!,
                    style: CommonErrorMsg.customTextStyle(context),
                  ),
                SizedBox(height: 10),

                StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) setState) {
                    return Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Expiry Type",
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s14,
                                fontWeight: FontWeight.w700,
                                color: ColorManager.mediumgrey,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            CustomRadioListTile(
                              value: "Not Applicable",
                              groupValue: selectedExpiryType,
                              onChanged: (value) {
                                setState(() {
                                  selectedExpiryType = value;
                                });
                              },
                              title: "Not Applicable",
                            ),
                            CustomRadioListTile(
                              value: 'Scheduled',
                              groupValue: selectedExpiryType,
                              onChanged: (value) {
                                setState(() {
                                  selectedExpiryType = value;
                                });
                              },
                              title: 'Scheduled',
                            ),
                            CustomRadioListTile(
                              value: 'Issuer Expiry',
                              groupValue: selectedExpiryType,
                              onChanged: (value) {
                                setState(() {
                                  selectedExpiryType = value;
                                });
                              },
                              title: 'Issuer Expiry',
                            ),
                            if (_selectExpTypeError != null)
                              Text(
                                _selectExpTypeError!,
                                style: CommonErrorMsg.customTextStyle(context),
                              ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Visibility(
                          visible: selectedExpiryType ==
                              "Scheduled" ||
                              selectedExpiryType == "Issuer Expiry",
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Expiry Date",
                                style: GoogleFonts.firaSans(
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeight.w700,
                                  color: ColorManager.mediumgrey,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              FormField<String>(
                                builder:
                                    (FormFieldState<String> field) {
                                  return SizedBox(
                                    width: 354,
                                    height: 30,
                                    child: TextFormField(
                                      controller: widget.calenderController,
                                      cursorColor: ColorManager.black,
                                      style: GoogleFonts.firaSans(
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeight.w700,
                                        color:
                                        ColorManager.mediumgrey,
                                        //decoration: TextDecoration.none,
                                      ),
                                      decoration: InputDecoration(
                                        enabledBorder:
                                        OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorManager
                                                  .fmediumgrey,
                                              width: 1),
                                          borderRadius:
                                          BorderRadius.circular(
                                              8),
                                        ),
                                        focusedBorder:
                                        OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorManager
                                                  .fmediumgrey,
                                              width: 1),
                                          borderRadius:
                                          BorderRadius.circular(
                                              8),
                                        ),
                                        hintText: 'yyyy-MM-dd',
                                        hintStyle:
                                        GoogleFonts.firaSans(
                                          fontSize: FontSize.s14,
                                          fontWeight: FontWeight.w700,
                                          color:
                                          ColorManager.mediumgrey,
                                          //decoration: TextDecoration.none,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              8),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: ColorManager
                                                  .fmediumgrey),
                                        ),
                                        contentPadding:
                                        EdgeInsets.symmetric(
                                            horizontal: 16),
                                        suffixIcon: Icon(
                                            Icons
                                                .calendar_month_outlined,
                                            color: ColorManager
                                                .blueprime),
                                        errorText: field.errorText,
                                      ),
                                      onTap: () async {
                                        DateTime? pickedDate =
                                        await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(3101),
                                        );
                                        if (pickedDate != null) {
                                          widget.calenderController.text =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty) {
                                          return 'please select birth date';
                                        }
                                        return null;
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 10),
                widget.child2 ?? Offstage(),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppString.upload_document,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                /// upload  doc
        Container(
          height: AppSize.s30,
          width: AppSize.s360,
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorManager.containerBorderGrey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      fileName,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.regular,
                        color: ColorManager.greylight,
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.all(4),
                      onPressed:  _pickFile,
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
                if (_uploadDocError != null)
                  Text(
                    _uploadDocError!,
                    style: CommonErrorMsg.customTextStyle(context),
                  ),

              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: Center(
                child: widget.loadingDuration == true
                    ? SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: ColorManager.blueprime,
                        ),
                      )
                    : CustomElevatedButton(
                        width: AppSize.s105,
                        height: AppSize.s30,
                        text: AppStringEM.save,
                        onPressed: () async {
                          print('File path on pressed ${filePath}');
                          _validateFields();
                          if(_uploadDocError == null && _selectDocError == null &&
                              _selectDocError == null && _selectExpTypeError == null){
                            if(fileAbove20Mb){
                              setState(() {
                                _isLoading = true;
                              });
                              String expiryTypeToSend =
                              selectedExpiryType == "Not Applicable"
                                  ? "--"
                                  : widget.calenderController.text;
                              try {
                                ApiData response =  await addLabReport(
                                  context: context,
                                  patientId: widget.patientId!,
                                  docTypeId: docTypeId,
                                  docType: widget.nameDocController.text,
                                  name: widget.nameDocController.text,
                                  docUrl: "url",
                                  createdAt: DateTime.now().toIso8601String() + "Z",
                                  expDate: widget.calenderController.text.isEmpty ? null : "${widget.calenderController.text}T00:00:00Z",
                                );
                                if(response.statusCode == 200 ||response.statusCode == 201 ){
                                  await uploadDocumentsLabReport(
                                      context: context,
                                      documentFile: filePath,
                                      labReportId: response.labReportId!);
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AddSuccessPopup(
                                        message: 'Record Added Successfully',
                                      );
                                    },
                                  );
                                }
                                print("DocName${widget.nameDocController.text}");
                                //GetLabReport(context, 1);
                                //Navigator.pop(context);
                                setState(() {
                                  selectedExpiryType = '';
                                  fileName ='';
                                  widget.calenderController.clear();
                                  //docIdController.clear();
                                  widget.nameDocController.clear();
                                });
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            }else{
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AddErrorPopup(
                                    message: 'File is too large!',
                                  );
                                },
                              );
                            }

                          }

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

/// new
class AddClinicianPopup extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget? child;
  final String title;
  final String buttonTitle;
  final bool? loadingDuration;

  AddClinicianPopup({
    super.key,
    required this.onPressed,
    required this.title,
    this.child,
    this.loadingDuration,
    required this.buttonTitle,
  });

  @override
  State<AddClinicianPopup> createState() => _AddClinicianPopupState();
}

class _AddClinicianPopupState extends State<AddClinicianPopup> {
  List<Map<String, String>> weeks = [];

  void addWeek() {
    setState(() {
      weeks.add({'week': 'Week ${weeks.length + 1}', 'visits': ''});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFB1B1B1), width: 1),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
              ),
              color: Color(0xff50B5E5),
            ),
            height: 40,
            width: 408,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    widget.title,
                    style: GoogleFonts.firaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ],
      ),
      content: Container(
        height: 200,
        width: 250,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select Type of Clinician",
              style: GoogleFonts.firaSans(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            widget.child ?? SizedBox(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: widget.loadingDuration == true
                    ? SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: Color(0xFF50B5E5),
                  ),
                )
                    : ElevatedButton(
                  onPressed: widget.onPressed,
                  child: Text(widget.buttonTitle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
