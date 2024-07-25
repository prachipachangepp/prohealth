import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';

class AddReferencePopup extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController titlePositionController;
  final TextEditingController knowPersonController;
  final TextEditingController companyNameController;
  final TextEditingController associationLengthController;
  final TextEditingController mobileNumberController;
  final String title;
  final VoidCallback onpressedClose;
  Future<void> Function() onpressedSave;
   AddReferencePopup({super.key, required this.nameController, required this.emailController, required this.titlePositionController, required this.knowPersonController, required this.companyNameController, required this.associationLengthController, required this.mobileNumberController, required this.onpressedClose, required this.onpressedSave, required this.title});

  @override
  State<AddReferencePopup> createState() => _AddReferencePopupState();
}

class _AddReferencePopupState extends State<AddReferencePopup> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width/1.5,
        height: MediaQuery.of(context).size.height/2,
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
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close,color: Colors.white,),
                  ),
                ],
              ),
            ),
            SizedBox(height:MediaQuery.of(context).size.height/20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextFieldRegister(
                  height: AppSize.s30,
                  width: MediaQuery.of(context).size.width/6,
                  controller: widget.nameController,
                  labelText: "Name",
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
                  controller: widget.emailController,
                  labelText: "Email",
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
                  controller: widget.titlePositionController,
                  labelText: "Title/Position",
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
            SizedBox(height:MediaQuery.of(context).size.height/20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextFieldRegister(
                  height: AppSize.s30,
                  width: MediaQuery.of(context).size.width/6,
                  controller: widget.knowPersonController,
                  labelText: "How do you know this person ?",
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
                  controller: widget.companyNameController,
                  labelText: "Company",
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
                  controller: widget.associationLengthController,
                  labelText: "Length of Association",
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
            SizedBox(height:MediaQuery.of(context).size.height/20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextFieldRegister(
                  height: AppSize.s30,
                  width: MediaQuery.of(context).size.width/6,
                  controller: widget.mobileNumberController,
                  labelText: "Mobile Number",
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
                SizedBox(width: MediaQuery.of(context).size.width/6,),
                SizedBox(width: MediaQuery.of(context).size.width/6,),
              ],
            ),
            SizedBox(height:MediaQuery.of(context).size.height/15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButtonTransparent(text: "Cancel", onPressed: () async{
                    widget.onpressedClose();
                  }),
                  const SizedBox(width: 10,),
                 isLoading ? SizedBox(
                   height: 25,
                     width: 25,
                     child: CircularProgressIndicator(color: ColorManager.blueprime,))
                     : CustomElevatedButton(text: "Save",onPressed: () async{
                   setState(() {
                     isLoading = true;
                   });
                   try {
                     await widget.onpressedSave();
                   } finally {
                     setState(() {
                       isLoading = false;
                     });
                     Navigator.pop(context);
                     widget.nameController.clear();
                     widget.emailController.clear();
                     widget.companyNameController.clear();
                     widget.titlePositionController.clear();
                     widget.mobileNumberController.clear();
                     widget.associationLengthController.clear();
                     widget.knowPersonController.clear();
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
