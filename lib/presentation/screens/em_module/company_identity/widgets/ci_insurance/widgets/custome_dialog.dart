import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../widgets/button_constant.dart';
import '../../../../widgets/text_form_field_const.dart';
import '../../whitelabelling/success_popup.dart';

class CustomPopup extends StatefulWidget {
  final TextEditingController namecontroller;
  final TextEditingController? addressController;
  final TextEditingController? emailController;
  final TextEditingController? workemailController;
  final TextEditingController? phoneController;
  final TextEditingController? workPhoneController;
  final Widget? childZone;
  final Widget? childCity;
   final VoidCallback onPressed;
   final String title;
   CustomPopup({Key? key, required this.onPressed,
     required this.title, required this.namecontroller,
     this.addressController,
     this.emailController, this.workemailController,
     this.phoneController, this.workPhoneController,
     this.childZone, this.childCity}) : super(key: key);

  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: widget.childZone == null ? AppSize.s250 : AppSize.s550,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              height: AppSize.s40,
              width: AppSize.s400,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaSans(
                      fontSize: 13,
                      fontWeight:
                      FontWeightManager.semiBold,
                      color: ColorManager.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close,
                      color: ColorManager.white,),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.namecontroller,
                    keyboardType: TextInputType.text,
                    text: 'Vendor Name',
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),
            widget.addressController == null ? Offstage() :
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.addressController!,
                    keyboardType: TextInputType.text,
                    text: AppString.address,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),
            widget.childCity == null ? Offstage() :
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.city,
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color:ColorManager.granitegray,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 4),
                  widget.childCity!,
                ]
            ),
            SizedBox(height: AppSize.s5),
            widget.emailController == null ? Offstage() :
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.emailController!,
                    keyboardType: TextInputType.text,
                    text: AppString.email,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),
            widget.phoneController == null ? Offstage() :
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.phoneController!,
                    keyboardType: TextInputType.text,
                    text: AppString.phone,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),
            widget.workemailController == null ? Offstage() :
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.workemailController!,
                    keyboardType: TextInputType.text,
                    text: AppString.workemail,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),
            widget.workPhoneController == null ? Offstage() :
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.workPhoneController!,
                    keyboardType: TextInputType.text,
                    text:"Work Phone",
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),
            widget.childZone == null ? Offstage() :
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.zone,
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color:ColorManager.granitegray,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 4),
                   widget.childZone!,
                ]
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p24),
              child: Center(
                child: CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.Add,
                  onPressed: () {
                    widget.onPressed();
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddSuccessPopup(message: 'Added Successfully',);
                      },
                    );
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
