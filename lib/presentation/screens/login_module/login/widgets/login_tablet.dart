import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/services/login_flow_api/get_otp/getotp_manager.dart';
import '../../../desktop_module/hr_module/manage/controller/controller.dart';
import '../../../desktop_module/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../tablet_module/login_screen_flow/tab_verify.dart';
import '../../../tablet_module/tab_const.dart';

class LoginTablet extends StatefulWidget {
  const LoginTablet({super.key});

  @override
  State<LoginTablet> createState() => _LoginTabletState();
}

class _LoginTabletState extends State<LoginTablet> {
  final ScreenSizeController myController = Get.find();
  final TextEditingController _emailController = TextEditingController();
  FocusNode fieldOne = FocusNode();
  FocusNode fieldTow = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  bool _isSendingEmail = false;
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  String? otpFromRunTab;
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoginBaseConstTab(
      titleText: AppString.login, onTap: () {},
      textAction: '',
      //textActionPadding: EdgeInsets.only(right: 10),
      childTab: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: MediaQuery.of(context).size.height / 3.5,
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///textfield Email
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 23,
                      ),

                      ///todo saloni change every hardcoded colors
                      child: TextFormField(
                        style: CustomTextStylesCommon.commonStyle(
                          color: Color(0xff000000).withOpacity(0.5),
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
                              color: Color(0xff000000).withOpacity(0.5),
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
                          if (!emailRegex.hasMatch(value)) {
                            return AppString.entervalidemail;
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) async {
                          if (_formKey.currentState?.validate() ?? false) {
                            setState(() {
                              _isSendingEmail = true;
                            });
                            try {
                              await GetOTPService.getOTP(_emailController.text);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TabVerifyScreen(
                                      email: _emailController.text),
                                ),
                              );
                            } catch (e) {
                              // Handle error
                              print('Error occurred: $e');
                            } finally {
                              setState(() {
                                _isSendingEmail = false;
                              });
                            }
                          }
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
                              height: MediaQuery.of(context).size.height / 22,
                              width: MediaQuery.of(context).size.height / 6,
                              text: AppString.next,
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  setState(() {
                                    _isSendingEmail = true;
                                  });
                                  try {
                                    await GetOTPService.getOTP(
                                        _emailController.text);
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        transitionDuration:
                                            Duration(milliseconds: 500),
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            TabVerifyScreen(
                                                email: _emailController.text),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          const begin = Offset(1.0, 0.0);
                                          const end = Offset.zero;
                                          const curve = Curves.ease;

                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          return SlideTransition(
                                            position: animation.drive(tween),
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  } catch (e) {
                                    // Handle error
                                    print('Error occurred: $e');
                                  } finally {
                                    setState(() {
                                      _isSendingEmail = false;
                                    });
                                  }
                                }
                              },
                            ),
                    ),
                  ])),
        ),
      ),
    ));
  }
}
