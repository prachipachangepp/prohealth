import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

import '../../whitelabelling/success_popup.dart';

class AddOfficeSumbitButton extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController emailController;
  final TextEditingController mobNumController;
  final TextEditingController secNumController;
  final TextEditingController OptionalController;
  final Future<void> Function() onPressed;
  final GlobalKey<FormState> formKey;
  AddOfficeSumbitButton({super.key, required this.nameController, required this.addressController, required this.emailController, required this.mobNumController, required this.secNumController, required this.OptionalController, required this.onPressed, required this.formKey});

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
            Container(
              height: 40,
              width: AppSize.s390,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
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
                      color: ColorManager.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: Colors.white,),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p15,
              ),
              child: Form(
                key: widget.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SMTextFConst(
                      controller: widget.nameController,
                      keyboardType: TextInputType.text,
                      text: 'Name',
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please enter name";
                        }
                        if(!value.contains(RegExp(r'[0-9]'))){
                          return 'Please enter valid name';
                        }
                        return "";
                      },
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
            ),
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
                      if(widget.formKey.currentState!.validate()){
                        await widget.onPressed();
                      }else{
                        print('Validation error');
                      }

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
