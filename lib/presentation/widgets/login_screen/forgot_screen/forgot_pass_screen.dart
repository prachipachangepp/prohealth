///enter functionality
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/login_flow_api/forgot_pass/forgot_pass_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/login_screen/forgot_screen/change_password.dart';
import 'package:prohealth/presentation/widgets/login_screen/login_screen.dart';
import 'package:prohealth/presentation/widgets/login_screen/widgets/login_flow_base_struct.dart';
import 'package:prohealth/presentation/widgets/profile_bar/widget/screen_transition.dart';
import '../../../../app/resources/const_string.dart';

class ForgotPassScreen extends StatefulWidget {
  ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
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
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 40),
        child: Form(
          key: _formKey,
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
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 100),
                child: TextFormField(
                  controller: _emailController,
                  style: CustomTextStylesCommon.commonStyle(
                    color: ColorManager.black.withOpacity(0.5),
                    fontWeight: FontWeightManager.medium,
                    fontSize: FontSize.s12,
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
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 99,
              ),
              ///button
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0, 4),
                        blurRadius: 3,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: CustomButton(
                    borderRadius: 24,
                    height: MediaQuery.of(context).size.height / 18,
                    width: MediaQuery.of(context).size.height / 4,
                    text: AppString.continuet,
                    onPressed: _submitForm,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      String email = _emailController.text;
      _forgotPassManager.forgotPassword(email);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangePasswordScreen(
            email: _emailController.text,
          ),
        ),
      );
      print(AppString.forgotbtnpress);
    }
  }
}