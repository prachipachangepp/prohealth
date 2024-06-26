import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

class AddOfficeSumbitButton extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController emailController;
  final TextEditingController mobNumController;
  final TextEditingController secNumController;
  final TextEditingController OptionalController;
  final Future<void> Function() onPressed;
  const AddOfficeSumbitButton({super.key, required this.nameController, required this.addressController, required this.emailController, required this.mobNumController, required this.secNumController, required this.OptionalController, required this.onPressed});

  @override
  State<AddOfficeSumbitButton> createState() => _AddOfficeSumbitButtonState();
}

class _AddOfficeSumbitButtonState extends State<AddOfficeSumbitButton> {
  bool isLoading =false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s390,
        height: AppSize.s470,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add New Office',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaSans(
                      fontSize: 13,
                      fontWeight:
                      FontWeightManager.semiBold,
                      color: ColorManager.primary,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.nameController,
                    keyboardType: TextInputType.text,
                    text: 'Name',
                  ),
                  const SizedBox(height: AppSize.s9),
                  SMTextFConst(
                    controller: widget.addressController,
                    keyboardType:
                    TextInputType.streetAddress,
                    text: 'Address',
                  ),
                  const SizedBox(height: AppSize.s9),
                  SMTextFConst(
                    controller: widget.emailController,
                    keyboardType:
                    TextInputType.emailAddress,
                    text: 'Email',
                  ),
                  const SizedBox(height: AppSize.s9),
                  SMTextFConst(
                    controller: widget.mobNumController,
                    keyboardType: TextInputType.number,
                    text: 'Primary Phone',
                  ),
                  const SizedBox(height: AppSize.s9),
                  SMTextFConst(
                    controller: widget.secNumController,
                    keyboardType: TextInputType.number,
                    text: 'Secondary Phone',
                  ),
                  const SizedBox(height: AppSize.s9),
                  SMTextFConst(
                    controller: widget.OptionalController,
                    keyboardType: TextInputType.number,
                    text: 'Alternative Phone',
                  ),

                ],
              ),
            ),
            Spacer(),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p10),
              child: Center(
                child:  isLoading
                    ? SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: ColorManager.blueprime,
                  ),
                )
                    :CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.submit,
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await widget.onPressed();
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                      widget.nameController.clear();
                      widget.mobNumController.clear();
                      widget.addressController.clear();
                      widget.emailController.clear();
                      widget.secNumController.clear();
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
