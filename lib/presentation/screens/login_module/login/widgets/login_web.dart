// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/managers/auth/auth_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/presentation/screens/login_module/email_verification/email_verification.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../data/navigator_arguments/screen_arguments.dart';
import '../../../../widgets/widgets/login_screen/widgets/login_flow_base_struct.dart';
import '../../../hr_module/manage/widgets/custom_icon_button_constant.dart';

class LoginWeb extends StatefulWidget {
  const LoginWeb({super.key});

  @override
  State<LoginWeb> createState() => _LoginWebState();
}

class _LoginWebState extends State<LoginWeb> {
  TextEditingController _emailController = TextEditingController();
  FocusNode fieldOne = FocusNode();
  FocusNode fieldTow = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  bool _isSendingEmail = false;
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  String? otpFromRunTab;
  String? _errorMessage;
  void clearSvgCache() {
    final cache = PaintingBinding.instance.imageCache;
    cache.clear();
    cache.clearLiveImages();
  }

  @override
  void initState() {
    super.initState();
    clearSvgCache();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _getOtpByEmail() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSendingEmail = true;
      });
      try {
        ApiData response =
            await AuthManager.getOTP(_emailController.text, context);
        print(
            "Response::::::::${response.data}+${response.statusCode}+${response.message}");
        if (response.success) {
          Navigator.pushNamed(context, EmailVerification.routeName,
              arguments: ScreenArguments(title: _emailController.text));
        } else {
          setState(() {
            _errorMessage = response.message;
          });
        }
      } finally {
        setState(() {
          _isSendingEmail = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBaseConstant(
          onTap: () {},
          titleText: AppString.login,
          textAction: '',
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: ColorManager.white,
              ),
              child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Version 1.0.3 (5) demo",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        ///textfield Email
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 30,
                          ),
                          child: TextFormField(
                            style: CustomTextStylesCommon.commonStyle(
                              color: ColorManager.blackForLoginTexts,
                              fontWeight: FontWeightManager.medium,
                              fontSize: FontSize.s14,
                            ),
                            focusNode: emailFocusNode,
                            controller: _emailController,
                            cursorColor: ColorManager.black,
                            cursorHeight: 22,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(top: 1),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.blackForLoginTexts,
                                  width: 0.5,
                                ),
                              ),
                              labelText: AppString.email,
                              hintText: AppString.emailhint,
                              hintStyle: EmailTextStyle.enterEmail(context),
                              labelStyle: EmailTextStyle.enterEmail(context),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppString.enteremail;
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              _getOtpByEmail();
                            },
                          ),
                        ),
                        Center(
                          child: _isSendingEmail
                              ? CircularProgressIndicator(
                                  color: ColorManager.blueprime,
                                )
                              : CustomButton(
                                  borderRadius: 28,
                                  height: 40,
                                  width: 100,
                                  text: AppString.next,
                                  onPressed: () async {
                                    _getOtpByEmail();
                                  },
                                ),
                        ),
                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: Text(
                              _errorMessage!,
                              style: CustomTextStylesCommon.commonStyle(
                                color: ColorManager.red,
                                fontSize: FontSize.s14,
                                fontWeight: FontWeightManager.bold,
                              ),
                            ),
                          ),
                      ])),
            ),
          )),
    );
  }
}

///
