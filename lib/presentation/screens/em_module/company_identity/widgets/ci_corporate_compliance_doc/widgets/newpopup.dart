import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../app/services/api/managers/establishment_manager/newpopup_manager.dart';
import '../../../../../../../data/api_data/api_data.dart';
import '../../../../../../../data/api_data/establishment_data/ci_manage_button/newpopup_data.dart';

class VCScreenPopupEditConst extends StatefulWidget {
  final Widget child;
  final String title;
  bool? loadingDuration;
  final VoidCallback? onSavePressed;
  final double? height;
  final Widget? uploadField;
  VCScreenPopupEditConst({
    super.key,
    required this.child,
    required this.title,
    this.onSavePressed,
    this.height,
    this.loadingDuration,
    this.uploadField,
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
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s420,
        height: widget.height == null ? AppSize.s300 : widget.height,
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
                    padding: const EdgeInsets.only(left: 25),
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
                  // SMTextFConst(
                  //   enable: false,
                  //   // readOnly: true,
                  //   controller: widget.idOfDocController,
                  //   keyboardType: TextInputType.text,
                  //   text: AppString.id_of_the_document,
                  // ),
                  // SizedBox(height: AppSize.s12),
                  // SMTextFConst(
                  //   controller: widget.nameDocController,
                  //   keyboardType: TextInputType.text,
                  //   text: AppString.name_of_the_document,
                  // ),
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
                      SizedBox(height:AppSize.s12),
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

                      SizedBox(height: AppSize.s5),
                      /// upload  doc
                      Container(
                        height: AppSize.s30,
                        width: AppSize.s354,
                        // margin: EdgeInsets.symmetric(horizontal: 5),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                    ],
                  ),
                  //       SizedBox(height: AppSize.s5),
                  //       if (widget.child1 != null) ...[
                  //         Text(
                  //           AppString.sub_type_of_the_document,
                  //           style: GoogleFonts.firaSans(
                  //             fontSize: FontSize.s12,
                  //             fontWeight: FontWeightManager.bold,
                  //             color: ColorManager.mediumgrey,
                  //             decoration: TextDecoration.none,
                  //           ),
                  //         ),
                  //         SizedBox(height: AppSize.s5),
                  //       ],
                  //       widget.child1 ?? Offstage(),
                ],
              ),
            ),
            // SizedBox(height: AppSize.s5),
            // ///radio
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
            //   child: widget.radioButton,
            // ),
            // SizedBox(height: AppSize.s10),
            //
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: AppPadding.p20,
            //     right: AppPadding.p20,
            //   ),
            //   child: widget.child2,
            // ),
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





////add

class VCScreenPopupADDConst extends StatefulWidget {
  // final Widget child;
  final String title;
  bool? loadingDuration;
  final VoidCallback onPressed;
  final double? height;
  final Widget? uploadField;
  dynamic filePath;
  String? fileName;
  // final Visibility? child3;
  final Function(int) onDocTypeSelected;
  final Function(String?) onExpiryDateSelected;

  VCScreenPopupADDConst({
    super.key,
    // required this.child,
    required this.title,
    required this.onPressed,
    this.height,
    this.loadingDuration,
    this.uploadField,
    this.fileName,this.filePath,
    required this.onDocTypeSelected,
    required this.onExpiryDateSelected,
    // this.child3,
  });

  @override
  State<VCScreenPopupADDConst> createState() => _VCScreenPopupADDConstState();
}

class _VCScreenPopupADDConstState extends State<VCScreenPopupADDConst> {
  int docTypeId = 0;
  String? documentTypeName;
  dynamic filePath;
  String? selectedDocType;
  String fileName = '';
  String _url = "";
  bool showExpiryDateField = false;
  TextEditingController expiryDateController = TextEditingController();
  int docTypeMetaIdCC = AppConfig.corporateAndCompliance;
  int selectedSubDocId = AppConfig.subDocId1Licenses;
  @override
  void initState() {
    super.initState();
    _url = "";
    showExpiryDateField;// Reset _url when the popup is initialized
  }
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
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s420,
        height: widget.height == null ? AppSize.s350 : widget.height,
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
                    padding: const EdgeInsets.only(left: 25),
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
                  // SMTextFConst(
                  //   enable: false,
                  //   // readOnly: true,
                  //   controller: widget.idOfDocController,
                  //   keyboardType: TextInputType.text,
                  //   text: AppString.id_of_the_document,
                  // ),
                  // SizedBox(height: AppSize.s12),
                  // SMTextFConst(
                  //   controller: widget.nameDocController,
                  //   keyboardType: TextInputType.text,
                  //   text: AppString.name_of_the_document,
                  // ),
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
                      FutureBuilder<List<TypeofDocpopup>>(
                        future: getTypeofDoc(context,
                            docTypeMetaIdCC, selectedSubDocId) ,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              width: 350,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(8),
                              ),
                            );
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(
                              child: Text(
                                AppString.dataNotFound,
                                style: CustomTextStylesCommon
                                    .commonStyle(
                                  fontWeight:
                                  FontWeightManager.medium,
                                  fontSize: FontSize.s12,
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
                                  value: doc.docname,
                                  child: Text(doc.docname!),
                                ))
                                .toList();

                            return
                              // StatefulBuilder(
                              //   builder: (context, setState) {
                              //     return Column(
                              //       children: [
                              //         CICCDropdown(
                              //           initialValue: "Select",
                              //           onChange: (val) {
                              //             setState(() {
                              //               for (var doc in snapshot.data!) {
                              //                 if (doc.docname == val) {
                              //                   docTypeId = doc.orgDocumentSetupid!;
                              //
                              //                   // Show expiry date field only if expirytype is "issuer expiry"
                              //                   showExpiryDateField = doc.expirytype == AppConfig.issuer;
                              //                 }
                              //               }
                              //             });
                              //           },
                              //           items: dropDownMenuItems,
                              //         ),
                              //         Visibility(
                              //           visible: showExpiryDateField, // Conditionally display expiry date field
                              //           child: Padding(
                              //             padding: const EdgeInsets.only(top: 8.0),
                              //             child: Container(
                              //               height: 30, // Set height to 30
                              //               width: 175, // Set width to 175
                              //               child: TextField(
                              //                 controller: expiryDateController,
                              //                 readOnly: true,
                              //                 decoration: InputDecoration(
                              //                   labelText: "Expiry Date",
                              //                   labelStyle: TextStyle(fontSize: 14), // Adjust label font size
                              //                   suffixIcon: IconButton(
                              //                     icon: Icon(Icons.calendar_today, size: 16), // Adjust icon size
                              //                     onPressed: () async {
                              //                       DateTime? pickedDate = await showDatePicker(
                              //                         context: context,
                              //                         initialDate: DateTime.now(),
                              //                         firstDate: DateTime(2000),
                              //                         lastDate: DateTime(2101),
                              //                       );
                              //                       if (pickedDate != null) {
                              //                         setState(() {
                              //                           expiryDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                              //                         });
                              //                       }
                              //                     },
                              //                   ),
                              //                   border: OutlineInputBorder(),
                              //                   contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0), // Adjust padding
                              //                   hintText: 'YYYY-MM-DD',
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     );
                              //   },
                              // );
                              ///
                              StatefulBuilder(
                                builder: (context, setState) {
                                  return Column(
                                    children: [
                                      CICCDropdown(
                                        initialValue: "Select",
                                        onChange: (val) {
                                          setState(() {
                                            // Always reset the expiry field visibility to false initially
                                            showExpiryDateField = false;
                                            // Loop through the documents and check the selected value
                                            for (var doc in snapshot.data!) {
                                              if (doc.docname ==
                                                  val) {
                                                docTypeId = doc.orgDocumentSetupid!;

                                                // Show expiry date field only if expirytype is "issuer expiry"
                                                if (doc.expirytype ==
                                                    AppConfig
                                                        .issuer) {
                                                  showExpiryDateField =
                                                  true;
                                                }
                                              }
                                            }
                                          });
                                        },
                                        items: dropDownMenuItems,
                                      ),
                                      Visibility(
                                        visible: showExpiryDateField,

                                        /// Conditionally display expiry date field
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              top: 8.0),
                                          child: Container(
                                            height: 30,
                                            width: 352,
                                            child: TextField(
                                              controller:
                                              expiryDateController,
                                              style: GoogleFonts
                                                  .firaSans(
                                                fontSize:
                                                FontSize.s12,
                                                fontWeight:
                                                FontWeightManager
                                                    .bold,
                                                color: ColorManager
                                                    .mediumgrey,
                                              ),
                                              readOnly: true,
                                              decoration:
                                              InputDecoration(
                                                labelText:
                                                "Expiry Date",
                                                labelStyle:
                                                GoogleFonts
                                                    .firaSans(
                                                  fontSize:
                                                  FontSize.s12,
                                                  fontWeight:
                                                  FontWeightManager
                                                      .semiBold,
                                                  color: ColorManager
                                                      .mediumgrey,
                                                ),
                                                suffixIcon:
                                                IconButton(
                                                  icon: Icon(
                                                      Icons
                                                          .calendar_today,
                                                      size: 16),
                                                  onPressed:
                                                      () async {
                                                    DateTime?
                                                    pickedDate =
                                                    await showDatePicker(
                                                      context:
                                                      context,
                                                      initialDate:
                                                      DateTime
                                                          .now(),
                                                      firstDate:
                                                      DateTime(
                                                          2000),
                                                      lastDate:
                                                      DateTime(
                                                          2101),
                                                    );
                                                    if (pickedDate !=
                                                        null) {
                                                      setState(() {
                                                        expiryDateController
                                                            .text = DateFormat(
                                                            'yyyy-MM-dd')
                                                            .format(
                                                            pickedDate);
                                                      });
                                                    }
                                                  },
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorManager
                                                            .fmediumgrey)),
                                                contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal:
                                                    10.0), // Adjust padding
                                                hintText:
                                                'YYYY-MM-DD',
                                                hintStyle: GoogleFonts
                                                    .firaSans(
                                                  fontSize:
                                                  FontSize.s12,
                                                  fontWeight:
                                                  FontWeightManager
                                                      .bold,
                                                  color: ColorManager
                                                      .mediumgrey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                      SizedBox(height: AppSize.s5),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppPadding.p20,
                          right: AppPadding.p20,

                        ),
                        // child: widget.child3,
                      ),
                      SizedBox(height:AppSize.s12),
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

                      SizedBox(height: AppSize.s5),
                      /// upload  doc
                      Container(
                        height: AppSize.s30,
                        width: AppSize.s354,
                        // margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.containerBorderGrey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function())
                              setState) {
                            return Padding(
                              padding: const EdgeInsets.all(0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    fileName,
                                    style: GoogleFonts.firaSans(
                                      fontSize: FontSize.s12,
                                      fontWeight:
                                      FontWeightManager.regular,
                                      color: ColorManager
                                          .lightgreyheading,
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
                                    highlightColor:
                                    Colors.transparent,
                                    hoverColor: Colors.transparent,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // Container(
                      //   height: AppSize.s30,
                      //   width: AppSize.s354,
                      //   // margin: EdgeInsets.symmetric(horizontal: 5),
                      //   decoration: BoxDecoration(
                      //     // color: Colors.greenAccent,
                      //     border: Border.all(
                      //       color: ColorManager.containerBorderGrey,
                      //       width: 1,
                      //     ),
                      //     borderRadius: BorderRadius.circular(4),
                      //   ),
                      //   child: StatefulBuilder(
                      //     builder: (BuildContext context,
                      //         void Function(void Function()) setState) {
                      //       return Padding(
                      //         padding: const EdgeInsets.all(0),
                      //         child: Row(
                      //           mainAxisAlignment:
                      //           MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text(
                      //               fileName,
                      //               style: GoogleFonts.firaSans(
                      //                 fontSize: FontSize.s12,
                      //                 fontWeight: FontWeightManager.regular,
                      //                 color: ColorManager.lightgreyheading,
                      //               ),
                      //             ),
                      //             IconButton(
                      //               padding: EdgeInsets.all(4),
                      //               onPressed: _pickFile,
                      //               icon: Icon(
                      //                 Icons.file_upload_outlined,
                      //                 color: ColorManager.black,
                      //                 size: 17,
                      //               ),
                      //               splashColor: Colors.transparent,
                      //               highlightColor: Colors.transparent,
                      //               hoverColor: Colors.transparent,
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                  //       SizedBox(height: AppSize.s5),
                  //       if (widget.child1 != null) ...[
                  //         Text(
                  //           AppString.sub_type_of_the_document,
                  //           style: GoogleFonts.firaSans(
                  //             fontSize: FontSize.s12,
                  //             fontWeight: FontWeightManager.bold,
                  //             color: ColorManager.mediumgrey,
                  //             decoration: TextDecoration.none,
                  //           ),
                  //         ),
                  //         SizedBox(height: AppSize.s5),
                  //       ],
                  //       widget.child1 ?? Offstage(),
                ],
              ),
            ),
            // SizedBox(height: AppSize.s5),
            // ///radio
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
            //   child: widget.radioButton,
            // ),
            // SizedBox(height: AppSize.s10),
            //
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: AppPadding.p20,
            //     right: AppPadding.p20,
            //   ),
            //   child: widget.child2,
            // ),
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
                  text: AppStringEM.add, //submit
                  onPressed: () async{
                    // //  print('File path on pressed ${filePath}');
                    // setState(() {
                    // _isLoading = true;
                    // });
                    // // String expiryTypeToSend =
                    // // selectedExpiryType == "Not Applicable"
                    // // ? "Not Applicable"
                    // //     : calenderController.text;
                    // try {
                    // ApiData response =
                    // await addOrgDocPPPost(
                    // context: context,
                    // orgDocumentSetupid: null,
                    // idOfDocument: docTypeMetaId,
                    // expiryDate: "2024-08-16T09:39:48.030Z",
                    // docCreatedat: "2024-08-16T09:39:48.030Z",
                    // companyid: widget.companyID,
                    // url: "url",
                    // officeid: widget.officeId,);
                    // if (response.statusCode ==200 || response.statusCode==201){
                    // await uploadDocumentsoffice(context: context, documentFile: filepath!, orgOfficeDocumentId: response.orgOfficeDocumentId!);
                    // }
                    //
                    // // await addManageCCVCPPPost(
                    // //   context: context,
                    // //   name: docNamecontroller.text,
                    // // docTypeID: docTypeMetaId,
                    // //   docSubTypeID: docSubTypeMetaId,
                    // //   expiryType: selectedExpiryType.toString(),
                    // //   expiryDate: calenderController.text,//expiryTypeToSend,
                    // //   expiryReminder: selectedExpiryType.toString(),
                    // //   officeId: widget.officeId,
                    // //   idOfDoc: docIdController.text
                    // // );
                    // // Navigator.pop(context);
                    // } finally {
                    // setState(() {
                    // _isLoading = false;
                    // });
                    // }
                    // },

                    widget.onPressed!();
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



class UploadDocumentAddPopup extends StatefulWidget {
   final Widget child;
  final String title;
  bool? loadingDuration;
  final VoidCallback onPressed;
  final double? height;
  // final Widget? uploadField;
  dynamic filePath;
  String? fileName;
  // final Visibility? child3;
 UploadDocumentAddPopup({
     required this.child,
    required this.title,
    required this.onPressed,
   this.loadingDuration,
    this.height,
    // this.uploadField,
    // this.child3
 });

  @override
  State<UploadDocumentAddPopup> createState() => _UploadDocumentAddPopupState();
}

class _UploadDocumentAddPopupState extends State<UploadDocumentAddPopup> {
  int docTypeId = 0;
  String? documentTypeName;
  dynamic filePath;
  String? selectedDocType;
  String fileName = '';
  String _url = "";
  bool showExpiryDateField = false;
  TextEditingController expiryDateController = TextEditingController();
  int docTypeMetaIdCC = AppConfig.vendorContracts;
  int selectedSubDocId = AppConfig.subDocId6Leases;
  @override
  void initState() {
    super.initState();
    _url = "";
    showExpiryDateField;// Reset _url when the popup is initialized
  }
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


  @override
  Widget build(BuildContext context) {
    return  Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s420,
        height: widget.height == null ? AppSize.s350 : widget.height,
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
                    padding: const EdgeInsets.only(left: 25),
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
                  // SMTextFConst(
                  //   enable: false,
                  //   // readOnly: true,
                  //   controller: widget.idOfDocController,
                  //   keyboardType: TextInputType.text,
                  //   text: AppString.id_of_the_document,
                  // ),
                  // SizedBox(height: AppSize.s12),
                  // SMTextFConst(
                  //   controller: widget.nameDocController,
                  //   keyboardType: TextInputType.text,
                  //   text: AppString.name_of_the_document,
                  // ),
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
                      widget.child,
                      // FutureBuilder<List<TypeofDocpopup>>(
                      //   future: getTypeofDoc(context,
                      //       docTypeMetaIdCC, selectedSubDocId) ,
                      //   builder: (context, snapshot) {
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       return Container(
                      //         width: 350,
                      //         height: 30,
                      //         decoration: BoxDecoration(
                      //           borderRadius:
                      //           BorderRadius.circular(8),
                      //         ),
                      //       );
                      //     }
                      //
                      //     if (!snapshot.hasData ||
                      //         snapshot.data!.isEmpty) {
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
                      //
                      //     if (snapshot.hasData) {
                      //       List<DropdownMenuItem<String>>
                      //       dropDownMenuItems = snapshot.data!
                      //           .map((doc) =>
                      //           DropdownMenuItem<String>(
                      //             value: doc.docname,
                      //             child: Text(doc.docname!),
                      //           ))
                      //           .toList();
                      //
                      //       return
                      //         // StatefulBuilder(
                      //         //   builder: (context, setState) {
                      //         //     return Column(
                      //         //       children: [
                      //         //         CICCDropdown(
                      //         //           initialValue: "Select",
                      //         //           onChange: (val) {
                      //         //             setState(() {
                      //         //               for (var doc in snapshot.data!) {
                      //         //                 if (doc.docname == val) {
                      //         //                   docTypeId = doc.orgDocumentSetupid!;
                      //         //
                      //         //                   // Show expiry date field only if expirytype is "issuer expiry"
                      //         //                   showExpiryDateField = doc.expirytype == AppConfig.issuer;
                      //         //                 }
                      //         //               }
                      //         //             });
                      //         //           },
                      //         //           items: dropDownMenuItems,
                      //         //         ),
                      //         //         Visibility(
                      //         //           visible: showExpiryDateField, // Conditionally display expiry date field
                      //         //           child: Padding(
                      //         //             padding: const EdgeInsets.only(top: 8.0),
                      //         //             child: Container(
                      //         //               height: 30, // Set height to 30
                      //         //               width: 175, // Set width to 175
                      //         //               child: TextField(
                      //         //                 controller: expiryDateController,
                      //         //                 readOnly: true,
                      //         //                 decoration: InputDecoration(
                      //         //                   labelText: "Expiry Date",
                      //         //                   labelStyle: TextStyle(fontSize: 14), // Adjust label font size
                      //         //                   suffixIcon: IconButton(
                      //         //                     icon: Icon(Icons.calendar_today, size: 16), // Adjust icon size
                      //         //                     onPressed: () async {
                      //         //                       DateTime? pickedDate = await showDatePicker(
                      //         //                         context: context,
                      //         //                         initialDate: DateTime.now(),
                      //         //                         firstDate: DateTime(2000),
                      //         //                         lastDate: DateTime(2101),
                      //         //                       );
                      //         //                       if (pickedDate != null) {
                      //         //                         setState(() {
                      //         //                           expiryDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                      //         //                         });
                      //         //                       }
                      //         //                     },
                      //         //                   ),
                      //         //                   border: OutlineInputBorder(),
                      //         //                   contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0), // Adjust padding
                      //         //                   hintText: 'YYYY-MM-DD',
                      //         //                 ),
                      //         //               ),
                      //         //             ),
                      //         //           ),
                      //         //         ),
                      //         //       ],
                      //         //     );
                      //         //   },
                      //         // );
                      //         ///
                      //         StatefulBuilder(
                      //           builder: (context, setState) {
                      //             return Column(
                      //               children: [
                      //                 CICCDropdown(
                      //                   initialValue: "Select",
                      //                   onChange: (val) {
                      //                     setState(() {
                      //                       // Always reset the expiry field visibility to false initially
                      //                       showExpiryDateField = false;
                      //                       // Loop through the documents and check the selected value
                      //                       for (var doc in snapshot.data!) {
                      //                         if (doc.docname ==
                      //                             val) {
                      //                           docTypeId = doc.orgDocumentSetupid!;
                      //
                      //                           // Show expiry date field only if expirytype is "issuer expiry"
                      //                           if (doc.expirytype ==
                      //                               AppConfig
                      //                                   .issuer) {
                      //                             showExpiryDateField =
                      //                             true;
                      //                           }
                      //                         }
                      //                       }
                      //                     });
                      //                   },
                      //                   items: dropDownMenuItems,
                      //                 ),
                      //                 Visibility(
                      //                   visible: showExpiryDateField,
                      //
                      //                   /// Conditionally display expiry date field
                      //                   child: Padding(
                      //                     padding:
                      //                     const EdgeInsets.only(
                      //                         top: 8.0),
                      //                     child: Container(
                      //                       height: 30,
                      //                       width: 352,
                      //                       child: TextField(
                      //                         controller:
                      //                         expiryDateController,
                      //                         style: GoogleFonts
                      //                             .firaSans(
                      //                           fontSize:
                      //                           FontSize.s12,
                      //                           fontWeight:
                      //                           FontWeightManager
                      //                               .bold,
                      //                           color: ColorManager
                      //                               .mediumgrey,
                      //                         ),
                      //                         readOnly: true,
                      //                         decoration:
                      //                         InputDecoration(
                      //                           labelText:
                      //                           "Expiry Date",
                      //                           labelStyle:
                      //                           GoogleFonts
                      //                               .firaSans(
                      //                             fontSize:
                      //                             FontSize.s12,
                      //                             fontWeight:
                      //                             FontWeightManager
                      //                                 .semiBold,
                      //                             color: ColorManager
                      //                                 .mediumgrey,
                      //                           ),
                      //                           suffixIcon:
                      //                           IconButton(
                      //                             icon: Icon(
                      //                                 Icons
                      //                                     .calendar_today,
                      //                                 size: 16),
                      //                             onPressed:
                      //                                 () async {
                      //                               DateTime?
                      //                               pickedDate =
                      //                               await showDatePicker(
                      //                                 context:
                      //                                 context,
                      //                                 initialDate:
                      //                                 DateTime
                      //                                     .now(),
                      //                                 firstDate:
                      //                                 DateTime(
                      //                                     2000),
                      //                                 lastDate:
                      //                                 DateTime(
                      //                                     2101),
                      //                               );
                      //                               if (pickedDate !=
                      //                                   null) {
                      //                                 setState(() {
                      //                                   expiryDateController
                      //                                       .text = DateFormat(
                      //                                       'yyyy-MM-dd')
                      //                                       .format(
                      //                                       pickedDate);
                      //                                 });
                      //                               }
                      //                             },
                      //                           ),
                      //                           border: OutlineInputBorder(
                      //                               borderSide: BorderSide(
                      //                                   color: ColorManager
                      //                                       .fmediumgrey)),
                      //                           contentPadding:
                      //                           EdgeInsets.symmetric(
                      //                               vertical: 8.0,
                      //                               horizontal:
                      //                               10.0), // Adjust padding
                      //                           hintText:
                      //                           'YYYY-MM-DD',
                      //                           hintStyle: GoogleFonts
                      //                               .firaSans(
                      //                             fontSize:
                      //                             FontSize.s12,
                      //                             fontWeight:
                      //                             FontWeightManager
                      //                                 .bold,
                      //                             color: ColorManager
                      //                                 .mediumgrey,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             );
                      //           },
                      //         );
                      //     } else {
                      //       return SizedBox();
                      //     }
                      //   },
                      // ),
                      SizedBox(height: AppSize.s5),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppPadding.p20,
                          right: AppPadding.p20,

                        ),
                        // child: widget.child3,
                      ),
                      SizedBox(height:AppSize.s12),
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

                      SizedBox(height: AppSize.s5),
                      /// upload  doc
                      Container(
                        height: AppSize.s30,
                        width: AppSize.s354,
                        // margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.containerBorderGrey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function())
                              setState) {
                            return Padding(
                              padding: const EdgeInsets.all(0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    fileName,
                                    style: GoogleFonts.firaSans(
                                      fontSize: FontSize.s12,
                                      fontWeight:
                                      FontWeightManager.regular,
                                      color: ColorManager
                                          .lightgreyheading,
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
                                    highlightColor:
                                    Colors.transparent,
                                    hoverColor: Colors.transparent,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // Container(
                      //   height: AppSize.s30,
                      //   width: AppSize.s354,
                      //   // margin: EdgeInsets.symmetric(horizontal: 5),
                      //   decoration: BoxDecoration(
                      //     // color: Colors.greenAccent,
                      //     border: Border.all(
                      //       color: ColorManager.containerBorderGrey,
                      //       width: 1,
                      //     ),
                      //     borderRadius: BorderRadius.circular(4),
                      //   ),
                      //   child: StatefulBuilder(
                      //     builder: (BuildContext context,
                      //         void Function(void Function()) setState) {
                      //       return Padding(
                      //         padding: const EdgeInsets.all(0),
                      //         child: Row(
                      //           mainAxisAlignment:
                      //           MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text(
                      //               fileName,
                      //               style: GoogleFonts.firaSans(
                      //                 fontSize: FontSize.s12,
                      //                 fontWeight: FontWeightManager.regular,
                      //                 color: ColorManager.lightgreyheading,
                      //               ),
                      //             ),
                      //             IconButton(
                      //               padding: EdgeInsets.all(4),
                      //               onPressed: _pickFile,
                      //               icon: Icon(
                      //                 Icons.file_upload_outlined,
                      //                 color: ColorManager.black,
                      //                 size: 17,
                      //               ),
                      //               splashColor: Colors.transparent,
                      //               highlightColor: Colors.transparent,
                      //               hoverColor: Colors.transparent,
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                  //       SizedBox(height: AppSize.s5),
                  //       if (widget.child1 != null) ...[
                  //         Text(
                  //           AppString.sub_type_of_the_document,
                  //           style: GoogleFonts.firaSans(
                  //             fontSize: FontSize.s12,
                  //             fontWeight: FontWeightManager.bold,
                  //             color: ColorManager.mediumgrey,
                  //             decoration: TextDecoration.none,
                  //           ),
                  //         ),
                  //         SizedBox(height: AppSize.s5),
                  //       ],
                  //       widget.child1 ?? Offstage(),
                ],
              ),
            ),
            // SizedBox(height: AppSize.s5),
            // ///radio
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
            //   child: widget.radioButton,
            // ),
            // SizedBox(height: AppSize.s10),
            //
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: AppPadding.p20,
            //     right: AppPadding.p20,
            //   ),
            //   child: widget.child2,
            // ),
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
                  text: AppStringEM.add, //submit
                  onPressed: () async{
                    // //  print('File path on pressed ${filePath}');
                    // setState(() {
                    // _isLoading = true;
                    // });
                    // // String expiryTypeToSend =
                    // // selectedExpiryType == "Not Applicable"
                    // // ? "Not Applicable"
                    // //     : calenderController.text;
                    // try {
                    // ApiData response =
                    // await addOrgDocPPPost(
                    // context: context,
                    // orgDocumentSetupid: null,
                    // idOfDocument: docTypeMetaId,
                    // expiryDate: "2024-08-16T09:39:48.030Z",
                    // docCreatedat: "2024-08-16T09:39:48.030Z",
                    // companyid: widget.companyID,
                    // url: "url",
                    // officeid: widget.officeId,);
                    // if (response.statusCode ==200 || response.statusCode==201){
                    // await uploadDocumentsoffice(context: context, documentFile: filepath!, orgOfficeDocumentId: response.orgOfficeDocumentId!);
                    // }
                    //
                    // // await addManageCCVCPPPost(
                    // //   context: context,
                    // //   name: docNamecontroller.text,
                    // // docTypeID: docTypeMetaId,
                    // //   docSubTypeID: docSubTypeMetaId,
                    // //   expiryType: selectedExpiryType.toString(),
                    // //   expiryDate: calenderController.text,//expiryTypeToSend,
                    // //   expiryReminder: selectedExpiryType.toString(),
                    // //   officeId: widget.officeId,
                    // //   idOfDoc: docIdController.text
                    // // );
                    // // Navigator.pop(context);
                    // } finally {
                    // setState(() {
                    // _isLoading = false;
                    // });
                    // }
                    // },

                    widget.onPressed!();
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

///manage policy post
class PoliciesProcedureAddPopUp extends StatefulWidget {
  final String title;
  bool? loadingDuration;
  final VoidCallback onPressed;
  final double? height;
  final Widget? uploadField;
  dynamic filePath;
  String? fileName;
  final Function(int) onDocTypeSelected;
  final Function(String?) onExpiryDateSelected;
   PoliciesProcedureAddPopUp({
    super.key,
    // required this.child,
    required this.title,
    required this.onPressed,
    this.height,
    this.loadingDuration,
    this.uploadField,
    this.fileName,this.filePath,
     required this.onDocTypeSelected,
     required this.onExpiryDateSelected,
});

  @override
  State<PoliciesProcedureAddPopUp> createState() => _PoliciesProcedureAddPopUpState();
}

class _PoliciesProcedureAddPopUpState extends State<PoliciesProcedureAddPopUp> {
  int docTypeId = 0;
  String? documentTypeName;
  dynamic filePath;
  String? selectedDocType;
  String fileName = '';
  String _url = "";
  bool showExpiryDateField = false;
  TextEditingController expiryDateController = TextEditingController();
  int docTypeMetaIdPP = AppConfig.policiesAndProcedure;
  int selectedSubDocId = AppConfig.subDocId0;
  @override
  void initState() {
    super.initState();
    _url = "";
    showExpiryDateField;// Reset _url when the popup is initialized
  }
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


  @override
  Widget build(BuildContext context) {
    return  Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s420,
        height: widget.height == null ? AppSize.s350 : widget.height,
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
                    padding: const EdgeInsets.only(left: 25),
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
                      FutureBuilder<List<TypeofDocpopup>>(
                        future: getTypeofDoc(context, docTypeMetaIdPP, selectedSubDocId) ,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              width: 350,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(8),
                              ),
                            );
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(
                              child: Text(
                                AppString.dataNotFound,
                                style: CustomTextStylesCommon
                                    .commonStyle(
                                  fontWeight:
                                  FontWeightManager.medium,
                                  fontSize: FontSize.s12,
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
                                  value: doc.docname,
                                  child: Text(doc.docname!),
                                ))
                                .toList();

                            return
                              ///
                              StatefulBuilder(
                                builder: (context, setState) {
                                  return Column(
                                    children: [
                                      CICCDropdown(
                                        initialValue: "Select",
                                        onChange: (val) {
                                          setState(() {
                                            showExpiryDateField = false;
                                            for (var doc in snapshot.data!) {
                                              if (doc.docname == val) {
                                                docTypeId = doc.orgDocumentSetupid!;
                                                widget.onDocTypeSelected(docTypeId);
                                                print(doc.orgDocumentSetupid);

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
                                      Visibility(
                                        visible: showExpiryDateField,

                                        /// Conditionally display expiry date field
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              top: 8.0),
                                          child: Container(
                                            height: 30,
                                            width: 352,
                                            child: TextField(
                                              controller:
                                              expiryDateController,
                                              style: GoogleFonts
                                                  .firaSans(
                                                fontSize:
                                                FontSize.s12,
                                                fontWeight:
                                                FontWeightManager
                                                    .bold,
                                                color: ColorManager
                                                    .mediumgrey,
                                              ),
                                              readOnly: true,
                                              decoration:
                                              InputDecoration(
                                                labelText:
                                                "Expiry Date",
                                                labelStyle:
                                                GoogleFonts
                                                    .firaSans(
                                                  fontSize:
                                                  FontSize.s12,
                                                  fontWeight:
                                                  FontWeightManager
                                                      .semiBold,
                                                  color: ColorManager
                                                      .mediumgrey,
                                                ),
                                                suffixIcon:
                                                IconButton(
                                                  icon: Icon(
                                                      Icons
                                                          .calendar_today,
                                                      size: 16),
                                                  onPressed:
                                                      () async {
                                                    DateTime?
                                                    pickedDate =
                                                    await showDatePicker(
                                                      context:
                                                      context,
                                                      initialDate:
                                                      DateTime
                                                          .now(),
                                                      firstDate:
                                                      DateTime(
                                                          2000),
                                                      lastDate:
                                                      DateTime(
                                                          2101),
                                                    );
                                                    if (pickedDate !=
                                                        null) {
                                                      setState(() {
                                                        expiryDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                        widget.onExpiryDateSelected(expiryDateController.text); // Pass expiry date back to parent screen
                                                      });
                                                    }
                                                  },
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorManager
                                                            .fmediumgrey)),
                                                contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal:
                                                    10.0), // Adjust padding
                                                hintText:
                                                'YYYY-MM-DD',
                                                hintStyle: GoogleFonts
                                                    .firaSans(
                                                  fontSize:
                                                  FontSize.s12,
                                                  fontWeight:
                                                  FontWeightManager
                                                      .bold,
                                                  color: ColorManager
                                                      .mediumgrey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                      SizedBox(height: AppSize.s5),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppPadding.p20,
                          right: AppPadding.p20,

                        ),
                        // child: widget.child3,
                      ),
                      SizedBox(height:AppSize.s12),
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

                      SizedBox(height: AppSize.s5),
                      /// upload  doc
                      Container(
                        height: AppSize.s30,
                        width: AppSize.s354,
                        // margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.containerBorderGrey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function())
                              setState) {
                            return Padding(
                              padding: const EdgeInsets.all(0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    fileName,
                                    style: GoogleFonts.firaSans(
                                      fontSize: FontSize.s12,
                                      fontWeight:
                                      FontWeightManager.regular,
                                      color: ColorManager
                                          .lightgreyheading,
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
                                    highlightColor:
                                    Colors.transparent,
                                    hoverColor: Colors.transparent,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                  text: AppStringEM.add, //submit
                  onPressed: () async{
                    widget.onPressed();
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
