import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../../app/resources/color.dart';
import '../../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../em_module/widgets/button_constant.dart';
import '../../../../../../widgets/constant_widgets/schedular_success_popup.dart';

class MiscellaneousAddPopUp extends StatefulWidget {
  final TextEditingController idDocController;
  final TextEditingController nameDocController;
  final TextEditingController calenderController;
  final VoidCallback onPressed;
  final Widget? child;
  final String title;
  final Widget? radioButton;
  final Widget? child2;
  final bool? loadingDuration;
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
      this.loadingDuration});

  @override
  State<MiscellaneousAddPopUp> createState() => _MiscellaneousAddPopUpState();
}

class _MiscellaneousAddPopUpState extends State<MiscellaneousAddPopUp> {
  String _fileName = 'Upload';

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
    }
  }

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
                widget.child ?? Offstage(),
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
                widget.child2 ?? Offstage(),
                SizedBox(height: AppSize.s10),
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
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _fileName,
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManager.lightgreyheading,
                          ),
                        ),
                        IconButton(
                          onPressed: _pickFile,
                          icon: Icon(
                            Icons.file_upload_outlined,
                            color: ColorManager.black,
                            size: 18,
                          ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
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
                        onPressed: widget.onPressed,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
