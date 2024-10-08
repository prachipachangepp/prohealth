import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/login_resources/login_flow_theme_const.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/auth/auth_manager.dart';
import '../../../../../data/navigator_arguments/screen_arguments.dart';
import '../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../../widgets/mobile_constant/mobile_const.dart';
import '../../forget_pass_verification/forget_pass_verification.dart';
import '../../login/login_screen.dart';

class ForgetPasswordMobile extends StatefulWidget {
  const ForgetPasswordMobile({super.key});

  @override
  State<ForgetPasswordMobile> createState() => _ForgetPasswordMobileState();
}

class _ForgetPasswordMobileState extends State<ForgetPasswordMobile> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();

  void submitForm() {
    if (formKey.currentState!.validate()) {
      setState(() {});
      AuthManager().forgotPassword(emailController.text, context);
      Navigator.pushNamed(context, VerifyPassword.routeName,
          arguments: ScreenArguments(title: emailController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MobileConst(
      titleText: AppString.forgotpassword,
      textAction: AppString.backtologin,
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      },
      containerHeight:
          MediaQuery.of(context).size.height / 2, // specify desired height
      containerWidth: MediaQuery.of(context).size.width / 1.1,
      mobileChild: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                AppString.forgotentermobile,
                style: GoogleFonts.firaSans(
                  color: ColorManager.mediumgrey,
                  fontSize: FontSize.s10,
                  fontWeight: FontWeightManager.medium,
                ),
              ),
              TextFormField(
                focusNode: emailFocusNode,
                keyboardType: TextInputType.visiblePassword,
                controller: emailController,
                style: CustomTextStylesCommon.commonStyle(
                  color: Color(0xff000000).withOpacity(0.5),
                  fontWeight: FontWeightManager.medium,
                  //fontSize: MediaQuery.of(context).size.width / 92,
                  fontSize: FontSize.s14,
                ),
                cursorHeight: 22,
                cursorColor: ColorManager.black,
                decoration: InputDecoration(
                  errorStyle: CustomTextStylesCommon.commonStyle(
                    color: ColorManager.red,
                    fontSize: FontSize.s10,
                    fontWeight: FontWeightManager.bold,
                  ),
                  contentPadding: const EdgeInsets.only(top: 2),
                  hintText: AppString.emailhint,
                  hintStyle: EmailTextStyle.enterEmail(context),
                  labelText: AppString.email,
                  labelStyle: EmailTextStyle.enterEmail(context),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorManager.black.withOpacity(0.5), width: 0.5),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppString.enteremail;
                  }
                  // if (!emailRegex.hasMatch(value)) {
                  //   return AppString.entervalidemail;
                  // }
                  return null;
                },
                onFieldSubmitted: (_) {
                  submitForm();
                },
              ),

              ///button
              Center(
                child: CustomButton(
                  borderRadius: 23.82,
                  height: MediaQuery.of(context).size.height / 24,
                  width: MediaQuery.of(context).size.width / 3,
                  paddingVertical: AppPadding.p5,
                  text: AppString.continuet,
                  style: CustomTextStylesCommon.commonStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.bold,
                  ),
                  onPressed: submitForm,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
