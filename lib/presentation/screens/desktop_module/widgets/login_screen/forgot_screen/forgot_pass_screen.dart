///enter functionality
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/login_flow_api/forgot_pass/forgot_pass_manager.dart';
import 'package:prohealth/presentation/screens/desktop_module/widgets/login_screen/forgot_screen/verify_password.dart';

import '../../../../../../app/resources/const_string.dart';
import '../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../profile_bar/widget/screen_transition.dart';
import '../login_screen.dart';
import '../widgets/login_flow_base_struct.dart';

class ForgotPassScreen extends StatefulWidget {
  ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();

  ForgotPassManager _forgotPassManager = ForgotPassManager();
  int _passwordChangeAttempts = 0;
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
  bool isExceedingLimit() {
    return _passwordChangeAttempts >= 3;
  }

  @override
  Widget build(BuildContext context) {
    return LoginBaseConstant(
      onTap: () {
        Navigator.push(
          context,
          RouteTransitions.slideTransition(page: LoginScreen()),
        );
      },
      titleText: AppString.forgotpassword,
      textAction: AppString.backtologin,
        textActionPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width/2),
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
    ))
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
          builder: (context) => VerifyPasswordScreen(
            email: _emailController.text,
          ),
        ),
      );
      print(AppString.forgotbtnpress);
    }
  }
}