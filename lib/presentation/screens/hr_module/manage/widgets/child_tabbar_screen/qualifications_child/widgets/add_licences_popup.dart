import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';

class AddLicencesPopup extends StatefulWidget {
  final TextEditingController LivensureController;
  final TextEditingController issueDateController;
  final TextEditingController expiryDateController;
  final TextEditingController issuingOrganizationController;
  final TextEditingController countryController;
  final TextEditingController numberIDController;
  final String title;
  final Widget child;
  final VoidCallback onpressedClose;
  final Future<void> Function() onpressedSave;

  AddLicencesPopup({super.key, required this.LivensureController, required this.issueDateController, required this.expiryDateController, required this.issuingOrganizationController, required this.countryController, required this.numberIDController, required this.onpressedClose, required this.onpressedSave, required this.title, required this.child});

  @override
  State<AddLicencesPopup> createState() => _AddLicencesPopupState();
}

class _AddLicencesPopupState extends State<AddLicencesPopup> {
  final DateTime _selectedIssueDate = DateTime.now();
  final DateTime _selectedExpDate = DateTime.now();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width/1.5,
        height:MediaQuery.of(context).size.height/1.7,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xff50B5E5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                    child: Text(widget.title,style: GoogleFonts.firaSans(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    icon: const Icon(Icons.close,color: Colors.white,),
                  ),
                ],
              ),
            ),
            SizedBox(height:MediaQuery.of(context).size.height/20),
            Padding(
              padding: const EdgeInsets.only(right: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.child,
                  SizedBox(width: 20,),
                  CustomIconButton(icon: Icons.file_upload_outlined,text: 'Upload License', onPressed: () async
                  {
                    FilePickerResult? result =
                    await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                    );
                    if (result != null) {
                      PlatformFile file = result.files.first;
                      print('File picked: ${file.name}');
                    } else {
                      // User canceled the picker
                    }
                  },
                  ),
                ],
              ),
            ),
             SizedBox(height:MediaQuery.of(context).size.height/20), //10
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextFieldRegister(
                  height: AppSize.s30,
                  width: MediaQuery.of(context).size.width/6,
                  controller: widget.LivensureController,
                  labelText: "Livensure/Certification",
                  keyboardType: TextInputType.text,
                  padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                  onChanged: (value) {

                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.enterText;
                    }
                    return null;
                  },
                ),
                CustomTextFieldRegister(
                  height: AppSize.s30,
                  width: MediaQuery.of(context).size.width/6,
                  controller: widget.issueDateController,
                  labelText: "Issue Date",
                  keyboardType: TextInputType.text,
                  suffixIcon: Icon(Icons.calendar_month_outlined,color: ColorManager.blueprime,),
                  padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                    onTap: () async{
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: _selectedIssueDate,
                        firstDate: DateTime(1100),
                        lastDate: DateTime(2025),
                      );
                      if (date != null) {
                        String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                        widget.issueDateController.text = formattedDate;
                        //field.didChange(formattedDate);
                      }
                    },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.enterText;
                    }
                    return null;
                  },
                ),
                CustomTextFieldRegister(
                  height: AppSize.s30,
                  width: MediaQuery.of(context).size.width/6,
                  controller: widget.expiryDateController,
                  labelText: "Expiry Date",
                  keyboardType: TextInputType.text,
                  suffixIcon: Icon(Icons.calendar_month_outlined,color: ColorManager.blueprime,),
                  padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                  onTap: () async{
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: _selectedExpDate,
                      firstDate: DateTime(1100),
                      lastDate: DateTime(2025),
                    );
                    if (date != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                      widget.expiryDateController.text = formattedDate;
                      //field.didChange(formattedDate);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.enterText;
                    }
                    return null;
                  },
                ),

              ],
            ),
            SizedBox(height:MediaQuery.of(context).size.height/20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextFieldRegister(
                  height: AppSize.s30,
                  width: MediaQuery.of(context).size.width/6,
                  controller: widget.issuingOrganizationController,
                  labelText: "Issuing Organization",
                  keyboardType: TextInputType.text,
                  padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                  onChanged: (value) {

                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.enterText;
                    }
                    return null;
                  },
                ),
                CustomTextFieldRegister(
                  height: AppSize.s30,
                  width: MediaQuery.of(context).size.width/6,
                  controller: widget.countryController,
                  labelText: "Country",
                  keyboardType: TextInputType.text,
                  padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                  onChanged: (value) {

                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.enterText;
                    }
                    return null;
                  },
                ),
                CustomTextFieldRegister(
                  height: AppSize.s30,
                  width: MediaQuery.of(context).size.width/6,
                  controller: widget.numberIDController,
                  labelText: "Number/ID",
                  keyboardType: TextInputType.text,
                  padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                  onChanged: (value) {

                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.enterText;
                    }
                    return null;
                  },
                ),

              ],
            ),
            SizedBox(height:MediaQuery.of(context).size.height/10),
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButtonTransparent(text: "Cancel", onPressed: () async{
                    widget.onpressedClose();
                  }),
                  SizedBox(width: 10,),
                  isLoading
                      ? SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator( color: ColorManager.blueprime,))
                      :CustomElevatedButton(text: "Save",onPressed: () async{
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await widget.onpressedSave();
                      widget.LivensureController.clear();
                      widget.issuingOrganizationController.clear();
                      widget.issueDateController.clear();
                      widget.expiryDateController.clear();
                      widget.countryController.clear();
                      widget.numberIDController.clear();
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          Future.delayed(Duration(seconds: 3), () {
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context).pop();
                            }
                          });
                          return AddSuccessPopup(message: 'Added Successfully',);
                        },
                      );
                    }
                  }),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


