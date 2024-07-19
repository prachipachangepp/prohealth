import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import 'package:prohealth/presentation/screens/hr_module/register/confirmation_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/offer_letter_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/dropdown_const.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import '../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../widgets/widgets/custom_icon_button_constant.dart';
import '../add_employee/widget/mcq_widget_add-employee.dart';

class RegisterEnrollPopup extends StatefulWidget {
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController phone;
  final TextEditingController email;
  final VoidCallback onPressed;
  RegisterEnrollPopup({super.key, required this.firstName, required this.lastName, required this.phone, required this.email, required this.onPressed});

  @override
  State<RegisterEnrollPopup> createState() => _RegisterEnrollPopupState();
}

class _RegisterEnrollPopupState extends State<RegisterEnrollPopup> {
  FocusNode _focusNode = FocusNode();
  int? _selectedItemIndex;

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      // contentPadding: EdgeInsets.zero,
      title: Container(
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8)
            ),
            color: ColorManager.bluebottom
        ),
        child:Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppString.enroll,
                style: CustomTextStylesCommon.commonStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.white,
                  fontWeight: FontWeightManager.medium,
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close, color: ColorManager.white,))
            ],
          ),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: ColorManager.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFieldRegister(
                  height: AppSize.s35,
                  width: MediaQuery.of(context).size.width / 6,
                  controller: widget.firstName,
                  labelText: AppString.fname,
                  keyboardType: TextInputType.text,
                  padding: EdgeInsets.only(
                      bottom: AppPadding.p5, left: AppPadding.p20),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.enterText;
                    }
                    return null;
                  },
                ),
                CustomTextFieldRegister(
                  height: AppSize.s35,
                  width: MediaQuery.of(context).size.width / 6,
                  controller: widget.lastName,
                  labelText: AppString.lname,
                  keyboardType: TextInputType.text,
                  padding: EdgeInsets.only(
                      bottom: AppPadding.p5, left: AppPadding.p20),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.enterText;
                    }
                    return null;
                  },
                ),
                CustomTextFieldRegister(
                  height: AppSize.s35,
                  width: MediaQuery.of(context).size.width / 6,
                  controller: widget.email,
                  labelText: AppString.email,
                  keyboardType: TextInputType.text,
                  padding: EdgeInsets.only(
                      bottom: AppPadding.p5, left: AppPadding.p20),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.enterText;
                    }
                    return null;
                  },
                ),
                CustomTextFieldRegister(
                  height: AppSize.s35,
                  width: MediaQuery.of(context).size.width / 6,
                  controller: widget.phone,
                  labelText: AppString.phoneNumber,
                  keyboardType: TextInputType.text,
                  padding: EdgeInsets.only(
                      bottom: AppPadding.p5, left: AppPadding.p20),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.enterText;
                    }
                    return null;
                  },
                ),
                Center(
                  child: CustomIconButtonConst(
                      width: AppSize.s100,
                      text: AppString.enroll, onPressed: widget.onPressed),
                ),
              ],
            )),
      ),
    );
  }
}

///
class RegisterEnrollAlertDialog {
  final TextEditingController controller = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  FocusNode _focusNode = FocusNode();
  int? _selectedItemIndex;


  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.zero,
          // contentPadding: EdgeInsets.zero,
          title: Container(
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8)
                ),
                color: ColorManager.bluebottom
            ),
            child:Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppString.enroll,
                    style: CustomTextStylesCommon.commonStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.white,
                      fontWeight: FontWeightManager.medium,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: ColorManager.white,))
                ],
              ),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorManager.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFieldRegister(
                      height: AppSize.s35,
                      width: MediaQuery.of(context).size.width / 6,
                      controller: firstName,
                      labelText: AppString.fname,
                      keyboardType: TextInputType.text,
                      padding: EdgeInsets.only(
                          bottom: AppPadding.p5, left: AppPadding.p20),
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.enterText;
                        }
                        return null;
                      },
                    ),
                    CustomTextFieldRegister(
                      height: AppSize.s35,
                      width: MediaQuery.of(context).size.width / 6,
                      controller: lastName,
                      labelText: AppString.lname,
                      keyboardType: TextInputType.text,
                      padding: EdgeInsets.only(
                          bottom: AppPadding.p5, left: AppPadding.p20),
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.enterText;
                        }
                        return null;
                      },
                    ),
                    CustomTextFieldRegister(
                      height: AppSize.s35,
                      width: MediaQuery.of(context).size.width / 6,
                      controller: email,
                      labelText: AppString.email,
                      keyboardType: TextInputType.text,
                      padding: EdgeInsets.only(
                          bottom: AppPadding.p5, left: AppPadding.p20),
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.enterText;
                        }
                        return null;
                      },
                    ),
                    CustomTextFieldRegister(
                      height: AppSize.s35,
                      width: MediaQuery.of(context).size.width / 6,
                      controller: phone,
                      labelText: AppString.phoneNumber,
                      keyboardType: TextInputType.text,
                      padding: EdgeInsets.only(
                          bottom: AppPadding.p5, left: AppPadding.p20),
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.enterText;
                        }
                        return null;
                      },
                    ),
                    Center(
                      child: CustomIconButtonConst(
                        width: AppSize.s100,
                          text: AppString.enroll, onPressed: () {
                            // showDialog(context: context, builder: (BuildContext context) {
                            //   return ConfirmationPopup(onConfirm: (){}, title: 'Confirm Enrollment',
                            //     onCancel: () {
                            //     Navigator.pop(context);
                            //   },);
                            //     //OfferLetterScreen();
                            // });
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => OfferLetterScreen()));

                      }),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
