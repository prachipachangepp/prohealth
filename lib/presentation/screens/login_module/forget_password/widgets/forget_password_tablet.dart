import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/services/login_flow_api/forgot_pass/forgot_pass_manager.dart';
import '../../../desktop_module/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../desktop_module/widgets/login_screen/login_screen.dart';
import '../../../desktop_module/widgets/profile_bar/widget/screen_transition.dart';
import '../../../tablet_module/tab_const.dart';
import '../../forget_pass_verification/forget_pass_verification.dart';
import '../../login/login_screen.dart';

class ForgetPasswordTablet extends StatefulWidget {
  const ForgetPasswordTablet({super.key});

  @override
  State<ForgetPasswordTablet> createState() => _ForgetPasswordTabletState();
}

class _ForgetPasswordTabletState extends State<ForgetPasswordTablet> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();
  ForgotPassManager _forgotPassManager = ForgotPassManager();
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

  @override
  Widget build(BuildContext context) {
    return LoginBaseConstTab(
      titleText: AppString.forgotpassword,
      onTap: (){
        Navigator.push(
          context,
          RouteTransitions.slideTransition(page: LoginScreen()),
        );
      },
      textAction: AppString.backtologin,
      childTab: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: MediaQuery.of(context).size.height/3.5,
          width: MediaQuery.of(context).size.width/2,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25)
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 30),
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
                    controller: _emailController,
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
                      if (!emailRegex.hasMatch(value)) {
                        return AppString.entervalidemail;
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      _submitForm();
                    },
                  ),
                  ///button
                  Center(
                    child: CustomButton(
                      borderRadius: 24,
                      height: MediaQuery.of(context).size.height / 18,
                      width: MediaQuery.of(context).size.width / 10,
                      text: AppString.continuet,
                      onPressed: _submitForm,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
      });
      String email = _emailController.text;
      _forgotPassManager.forgotPassword(email);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyPassword(
            email: _emailController.text,
          ),
        ),
      );
      print(AppString.forgotbtnpress);
    }
  }
}
