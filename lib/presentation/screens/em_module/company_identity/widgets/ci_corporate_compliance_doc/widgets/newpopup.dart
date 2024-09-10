import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../app/services/api/managers/establishment_manager/newpopup_manager.dart';
import '../../../../../../../data/api_data/api_data.dart';

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
  final Widget child;
  final String title;
  bool? loadingDuration;
  final VoidCallback onPressed;
  final double? height;
  final Widget? uploadField;
  dynamic filePath;
  String? fileName;

  VCScreenPopupADDConst({
    super.key,
    required this.child,
    required this.title,
    required this.onPressed,
    this.height,
    this.loadingDuration,
    this.uploadField,
    this.fileName,this.filePath,
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
                     widget.uploadField!,
                      // Container(
                      //   height: AppSize.s30,
                      //   width: AppSize.s354,
                      //   // margin: EdgeInsets.symmetric(horizontal: 5),
                      //   decoration: BoxDecoration(
                      //    // color: Colors.greenAccent,
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
