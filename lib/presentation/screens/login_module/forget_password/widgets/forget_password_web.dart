import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/services/api/managers/auth/auth_manager.dart';
import '../../../../../data/navigator_arguments/screen_arguments.dart';
import '../../../../widgets/widgets/login_screen/widgets/login_flow_base_struct.dart';
import '../../../../widgets/widgets/profile_bar/widget/screen_transition.dart';
import '../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../forget_pass_verification/forget_pass_verification.dart';
import '../../login/login_screen.dart';

class ForgetPasswordWeb extends StatefulWidget {
  const ForgetPasswordWeb({
    super.key,
  });

  @override
  State<ForgetPasswordWeb> createState() => _ForgetPasswordWebState();
}

class _ForgetPasswordWebState extends State<ForgetPasswordWeb> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();

  // final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

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
    return LoginBaseConstant(
        onTap: () {
          Navigator.push(
            context,
            RouteTransitions.slideTransition(page: const LoginScreen()),
          );
        },
        titleText: AppString.forgotpassword,
        textAction: AppString.backtologin,
        textActionPadding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width / 2),
        child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: ColorManager.white,
              ),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        AppString.forgotenter,
                        style: GoogleFonts.firaSans(
                          letterSpacing: 0.5,
                          color: ColorManager.mediumgrey,
                          fontSize: MediaQuery.of(context).size.width / 120,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                      TextFormField(
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
                                color: ColorManager.black.withOpacity(0.5),
                                width: 0.5),
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
                          borderRadius: 24,
                          height: MediaQuery.of(context).size.height / 18,
                          width: MediaQuery.of(context).size.width / 10,
                          text: AppString.continuet,
                          onPressed: submitForm,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
