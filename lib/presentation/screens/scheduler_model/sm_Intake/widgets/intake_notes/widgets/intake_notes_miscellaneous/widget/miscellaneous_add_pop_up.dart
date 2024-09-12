import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/data/api_data/sm_data/Intake_deta/notes_data/intake_misc_note_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';

import '../../../../../../../../../app/resources/color.dart';
import '../../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../../app/services/api/managers/sm_module_manager/notes_manager/notes_misc_manager.dart';
import '../../../../../../../../../app/services/api/managers/sm_module_manager/patient_data/patient_data_compliance.dart';
import '../../../../../../../../../data/api_data/api_data.dart';
import '../../../../../../../../../data/api_data/sm_data/patient_data/patient_data_compliance.dart';
import '../../../../../../../em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import '../../../../../../../em_module/widgets/button_constant.dart';
import '../../../../../../../hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import '../../../../../../widgets/constant_widgets/schedular_success_popup.dart';

class MiscellaneousAddPopUp extends StatefulWidget {
  final TextEditingController idDocController;
  final TextEditingController nameDocController;
  final TextEditingController calenderController;
  final VoidCallback onPressed;
  final Widget? child;
  final String title;
  final Widget? radioButton;
  final int? patientId;
  final Widget? child2;
  final bool? loadingDuration;
  dynamic filePath;
  String? fileName;
  MiscellaneousAddPopUp(
      {super.key,
      required this.idDocController,
      required this.nameDocController,
      required this.calenderController,
      required this.onPressed,
      this.child,
      required this.title,
      this.radioButton,
      this.child2,
        this.fileName,
        this.filePath,
      this.loadingDuration, this.patientId});

  @override
  State<MiscellaneousAddPopUp> createState() => _MiscellaneousAddPopUpState();
}

class _MiscellaneousAddPopUpState extends State<MiscellaneousAddPopUp> {
  String _fileName = 'Upload';
  String? selectedDocType;
  int docTypeId = 0;
  String? documentTypeName;
  dynamic filePath;
  // String? selectedDocType;
  String fileName ='';
  final StreamController<List<PDComplianceModal>>
  noteMiscController =
  StreamController<List<PDComplianceModal>>();
  // dynamic filePath;
  // String? selectedDocType;
  // String fileName ='';
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        filePath = result.files.first.bytes;
        fileName = result.files.first.name;
        print('File path ${filePath}');
        print('File name ${fileName}');
      });
    }
  }
  bool _isLoading =false;
  String? selectedExpiryType;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: ColorManager.white,
      titlePadding: EdgeInsets.zero,
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: ColorManager.blueprime,
        ),
        height: AppSize.s47,
        width: AppSize.s408,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
      content: Container(
        height: AppSize.s475,
        width: AppSize.s350,
        color: ColorManager.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSize.s10),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppString.type_of_the_document,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.s10),
                // FutureBuilder<List<MiscNotesDocTypeModal>>(
                //   future:
                //   getMisNotesDoc(context),
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState ==
                //         ConnectionState.waiting) {
                //       return Container(
                //         width: 350,
                //         height: 30,
                //         decoration: BoxDecoration(
                //           borderRadius:
                //           BorderRadius.circular(10),
                //         ),
                //       );
                //     }
                //     if (snapshot.data!.isEmpty) {
                //       return Center(
                //         child: Text(
                //           AppString.dataNotFound,
                //           style: CustomTextStylesCommon
                //               .commonStyle(
                //             fontWeight:
                //             FontWeightManager.medium,
                //             fontSize: FontSize.s12,
                //             color: ColorManager.mediumgrey,
                //           ),
                //         ),
                //       );
                //     }
                //     if (snapshot.hasData) {
                //       List<DropdownMenuItem<String>>
                //       dropDownMenuItems = snapshot.data!
                //           .map((doc) =>
                //           DropdownMenuItem<String>(
                //             value: doc.documentType,
                //             child: Text(doc.documentType!),
                //           ))
                //           .toList();
                //       docTypeId = snapshot.data![0].docTypeId!;
                //       documentTypeName = snapshot.data![0].documentType!;
                //       return CICCDropdown(
                //         initialValue: selectedDocType ??
                //             dropDownMenuItems[0].value,
                //         onChange: (val) {
                //           setState(() {
                //             selectedDocType = val;
                //             for (var doc in snapshot.data!) {
                //               if (doc.documentType == val) {
                //                 docTypeId = doc.doctTypeId!;
                //                 // documentTypeName = doc.doctTypeId;
                //               }
                //             }
                //             getIntakeNoteMiscByPatientsID(context,
                //                 patientId: 1)
                //                 .then((data) {
                //               noteMiscController.add(data);
                //             }).catchError((error) {
                //               // Handle error
                //             });
                //           });
                //         },
                //         items: dropDownMenuItems,
                //       );
                //     } else {
                //       return SizedBox();
                //     }
                //   },
                // ),
                FutureBuilder<List<MiscNotesDocTypeModal>>(
                  future: getMisNotesDoc(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        width: 350,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          AppString.dataNotFound,
                          style: CustomTextStylesCommon.commonStyle(
                            fontWeight: FontWeightManager.medium,
                            fontSize: FontSize.s12,
                            color: ColorManager.mediumgrey,
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      List<DropdownMenuItem<String>> dropDownMenuItems = snapshot.data!
                          .map((doc) => DropdownMenuItem<String>(
                        value: doc.documentType,
                        child: Text(doc.documentType),
                      ))
                          .toList();

                      // Set initial values for docTypeId and documentTypeName based on the first document
                      docTypeId ??= snapshot.data![0].doctTypeId;
                      documentTypeName ??= snapshot.data![0].documentType;

                      return CICCDropdown(
                        initialValue: selectedDocType ?? dropDownMenuItems[0].value,
                        onChange: (val) {
                          setState(() {
                            selectedDocType = val;
                            for (var doc in snapshot.data!) {
                              if (doc.documentType == val) {
                                docTypeId = doc.doctTypeId;
                                documentTypeName = doc.documentType;
                              }
                            }

                            // Call another function after dropdown selection (e.g., re-fetching data)
                            getIntakeNoteMiscByPatientsID(context, patientId: 1).then((data) {
                              noteMiscController.add;
                            }).catchError((error) {
                              // Handle error
                              print("Error fetching data: $error");
                            });
                          });
                        },
                        items: dropDownMenuItems,
                      );
                    } else {
                      return SizedBox.shrink(); // Return an empty widget if no data
                    }
                  },
                ),
                SizedBox(height: AppSize.s10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        AppString.name_of_the_document,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.s10),
                Container(
                  height: AppSize.s30,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    cursorHeight: 18,
                    controller: widget.nameDocController,
                    style: GoogleFonts.firaSans(
                      fontSize: AppSize.s12,
                      fontWeight: FontWeightManager.regular,
                      color: ColorManager.lightgreyheading,
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorManager.containerBorderGrey,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorManager.containerBorderGrey,
                          width: 1.0,
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(height: AppSize.s5),
                widget.radioButton ?? Offstage(),
                SizedBox(height: AppSize.s10),
                SizedBox(height: AppSize.s10),
                // FutureBuilder<List<EmployeeDocSetupModal>>(
                //     future: getEmployeeDocSetupDropDown(context),
                //     builder: (context,snapshot) {
                //       if(snapshot.connectionState == ConnectionState.waiting){
                //         return Container(
                //           width: 350,
                //           height: 30,
                //           decoration: BoxDecoration(color: ColorManager.white,borderRadius: BorderRadius.circular(10)),
                //         );
                //
                //       }
                //       if (snapshot.data!.isEmpty) {
                //         return Center(
                //           child: Text(
                //             AppString.dataNotFound,
                //             style: CustomTextStylesCommon.commonStyle(
                //               fontWeight: FontWeightManager.medium,
                //               fontSize: FontSize.s12,
                //               color: ColorManager.mediumgrey,
                //             ),
                //           ),
                //         );
                //       }
                //       if(snapshot.hasData){
                //         List dropDown = [];
                //         int docType = 0;
                //         List<DropdownMenuItem<String>> dropDownMenuItems = [];
                //         for(var i in snapshot.data!){
                //           dropDownMenuItems.add(
                //             DropdownMenuItem<String>(
                //               child: Text(i.documentName),
                //               value: i.documentName,
                //             ),
                //           );
                //         }
                //         return StatefulBuilder(
                //           builder: (BuildContext context, void Function(void Function()) setState) {
                //             return  CICCDropdown(
                //                 initialValue: dropDownMenuItems[0].value,
                //                 onChange: (val){
                //                   for(var a in snapshot.data!){
                //                     if(a.documentName == val){
                //                       documentMetaDataId = a.employeeDocMetaDataId;
                //                       documentSetupId = a.employeeDocTypeSetupId;
                //                       //docMetaId = docType;
                //                     }
                //                   }
                //                   print(":::${docType}");
                //                   //print(":::<>${docMetaId}");
                //                 },
                //                 items:dropDownMenuItems
                //             );
                //           },
                //         );
                //       }else{
                //         return SizedBox();
                //       }
                //     }
                // ),
                ///
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppString.upload_document,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.s10),
                Container(
                  height: AppSize.s30,
                  width: AppSize.s650,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorManager.containerBorderGrey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
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
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.regular,
                                color: ColorManager.lightgreyheading,
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
                // widget.child2 ?? Offstage(),

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
                    setState(() {
                      _isLoading = true;
                    });
                    String expiryTypeToSend =
                    selectedExpiryType == "Not Applicable"
                        ? "--"
                        : widget.calenderController.text;
                    try {
                      ApiData response =  await addNotesMiscPost(
                        context: context,
                        patientId: widget.patientId!,
                        docTypeId: 1, //  docTypeId,
                        docName: nameController.text,
                        docUrl: "some_doc_url",
                        // createdAt: calenderController.text,
                        createdAt:  "2024-08-16T09:39:48.030Z",
                        docType: selectedDocType!,
                        expDate: "2024-08-16T09:39:48.030Z",
                        // expDate:
                        // "${calenderController.text}T09:39:48.030Z",
                      );
                      if(response.statusCode == 200 ||response.statusCode == 201 ){
                        await uploadDocumentsMiscNotes(
                            context: context,
                            documentFile: filePath,
                            miscNoteId: response.miscNoteId!);
                      }
                      print("DocName${widget.nameDocController.text}");
                      //GetLabReport(context, 1);
                      Navigator.pop(context);
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
