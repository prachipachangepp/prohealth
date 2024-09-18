import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
class EditScreen extends StatelessWidget {
  // static const String routeName = "/edit";
  final ValueNotifier<bool> isEditModeNotifier;
  final VoidCallback onCancel;

  EditScreen({required this.isEditModeNotifier, required this.onCancel});
  TextEditingController nameController = TextEditingController();
  TextEditingController deptController = TextEditingController();
  TextEditingController empTypeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ssNController = TextEditingController();
  TextEditingController workPhoneController = TextEditingController();
  TextEditingController phoneNController = TextEditingController();
  TextEditingController personalEmailController = TextEditingController();
  TextEditingController workEmailController = TextEditingController();
  TextEditingController zoneController = TextEditingController();
  TextEditingController countyController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController reportingOfficeController = TextEditingController();
  TextEditingController summaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
        Column(
          children: [
            Expanded(
              child: Container(
                // height: 550,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.  withOpacity(0.5),
                      offset: Offset(0, -4),
                      // blurRadius: 8.0,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: Offset(0, 4),
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(
                          AppString.editProfile,
                          style: EditProfile.customEditTextStyle(),) ,

                        CustomIconButton(
                          icon: Icons.upload_outlined,
                          text: AppString.photo, onPressed: () async {  },
                            // onPressed: () {} ,
                        )
                      ],),
                    ),
                    ///
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HRManageTextField(
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            text: AppString.name,
                            cursorHeight: 12, labelText: AppString.name,
                            labelStyle: GoogleFonts.firaSans(
                                fontSize: 12
                            ), labelFontSize: 12),
                        HRManageTextField(
                            controller: empTypeController,
                            keyboardType: TextInputType.text,
                            text: AppString.employmentType,
                            cursorHeight: 12, labelText: AppString.employmentType,
                            labelStyle: GoogleFonts.firaSans(
                                fontSize: 12
                            ), labelFontSize: 12),
                        HRManageDropdown(controller: deptController,
                            labelText: AppString.dept,
                            labelStyle: GoogleFonts.firaSans(
                                fontSize: 12
                            ), labelFontSize: 12,
                            items: ['Clinical', 'Sales','Administration'])
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HRManageTextField(
                            controller: addressController,
                            keyboardType: TextInputType.text,
                            text: AppString.address,
                            cursorHeight: 12, labelText: AppString.address,
                            labelStyle: GoogleFonts.firaSans(
                                fontSize: 12
                            ), labelFontSize: 12),
                        HRManageTextField(
                            controller: ageController,
                            keyboardType: TextInputType.text,
                            text: AppString.age,
                            suffixIcon: Icon(Icons.calendar_month_outlined),
                            cursorHeight: 12, labelText: AppString.age,
                            labelStyle: GoogleFonts.firaSans(
                                fontSize: 12
                            ), labelFontSize: 12),
                        HRManageDropdown(controller: genderController,
                            labelText: AppString.gender,
                            labelStyle: GoogleFonts.firaSans(
                                fontSize: 12
                            ), labelFontSize: 12,
                            items: ['Male', 'Female',])

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HRManageDropdown(controller: ssNController,
                            labelText: AppString.ssn,
                            labelStyle: GoogleFonts.firaSans(
                                fontSize: 12
                            ), labelFontSize: 12,
                            items: ['SSN 1', 'SSN 2']),
                        HRManageTextField(
                            controller: phoneNController,
                            keyboardType: TextInputType.text,
                            text: AppString.phone_number,
                            cursorHeight: 12, labelText: AppString.phone_number,
                            labelStyle: GoogleFonts.firaSans(
                                fontSize: 12
                            ), labelFontSize: 12),
                        HRManageTextField(
                            controller: workPhoneController,
                            keyboardType: TextInputType.text,
                            text: AppString.workno,
                            cursorHeight: 12, labelText: AppString.workno,
                            labelStyle: GoogleFonts.firaSans(
                                fontSize: 12
                            ), labelFontSize: 12),

                      ],
                    ),
                    ///
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HRManageTextField(
                            controller: personalEmailController,
                            keyboardType: TextInputType.text,
                            text: AppString.personalEmail,
                            cursorHeight: 12, labelText: AppString.personalEmail,
                            labelStyle: GoogleFonts.firaSans(
                                fontSize: 12
                            ), labelFontSize: 12),
                        HRManageTextField(
                            controller: workEmailController,
                            keyboardType: TextInputType.text,
                            text: AppString.workemail,
                            cursorHeight: 12, labelText: AppString.workemail,
                            labelStyle: GoogleFonts.firaSans(
                                fontSize: 12
                            ), labelFontSize: 12),
                        HRManageDropdown(controller: zoneController,
                            labelText: AppString.zone,
                            labelStyle: GoogleFonts.firaSans(
                                fontSize: 12
                            ), labelFontSize: 12,
                            items: ['Clinical', 'Sales','Administration'])

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HRManageTextField(
                            controller: countyController,
                            keyboardType: TextInputType.text,
                            text: AppString.county,
                            cursorHeight: 12, labelText: AppString.county,
                            labelStyle: GoogleFonts.firaSans(
                                fontSize: 12
                            ), labelFontSize: 12),
                        HRManageTextField(
                            controller: serviceController,
                            keyboardType: TextInputType.text,
                            text: AppString.service,
                            cursorHeight: 12, labelText: AppString.service,
                            labelStyle: GoogleFonts.firaSans(
                                fontSize: 12
                            ), labelFontSize: 12),
                        HRManageDropdown(controller: reportingOfficeController,
                            labelText: AppString.reportingOffice,
                            labelStyle: GoogleFonts.firaSans(
                                fontSize: 12
                            ), labelFontSize: 12,
                            items: ['Clinical', 'Sales','Administration'])
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HRManageTextField(
                            controller: summaryController,
                            keyboardType: TextInputType.text,
                            text: AppString.summary,
                            cursorHeight: 12, labelText: AppString.summary,
                            labelStyle: GoogleFonts.firaSans(
                                fontSize: 12
                            ), labelFontSize: 12),
                       SizedBox(
                         width: 320,
                         height: 40,
                       ),
                        SizedBox( width: 320,
                          height: 40,)
                      ],
                    ),
                    ///
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          height: 32,
                          width: 100,
                          onPressed: (){} , text: 'Save',),
                         SizedBox(width: 30,),
                        CustomButtonTransparent(
                          height: 27,
                          width: 90,
                          text: 'Cancel', onPressed: () {
                          isEditModeNotifier.value = false;
                          //   onCancel();
                        },)
                        // CustomButton(
                        //   height: 27,
                        //   width: 90,
                        //   onPressed: (){
                        //   isEditModeNotifier.value = false;
                        //   onCancel();
                        // }, text: 'Cancel',)
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        );
  }
}

class EditProfile {
  static TextStyle customEditTextStyle() {
    return GoogleFonts.firaSans(
      fontSize: FontSize.s12,
      fontWeight: FontWeight.w700,
          // : FontWeight.w500,
      color: ColorManager.blueprime,
      // decoration: TextDecoration.none,
    );
  }
}