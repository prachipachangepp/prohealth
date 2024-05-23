import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/presentation/screens/desktop_module/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/mobile_module/mobile_email_verify_screen.dart';
import 'package:prohealth/presentation/screens/mobile_module/widgets/mobile_const.dart';

import '../../../app/resources/color.dart';
import '../../../app/resources/const_string.dart';
import '../../../app/services/login_flow_api/get_otp/getotp_manager.dart';

class MobileLogIn extends StatefulWidget {
  const MobileLogIn({Key? key}) : super(key: key);

  @override
  State<MobileLogIn> createState() => _MobileLogInState();
}

class _MobileLogInState extends State<MobileLogIn> {
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
      body: MobileConst(
        containerHeight:
            MediaQuery.of(context).size.height / 2, // specify desired height
        containerWidth: MediaQuery.of(context).size.width / 1.1,
        onTap: () {},
        titleText: AppString.login,
        textAction: '',
        mobileChild: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 8,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height / 16,
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
                              builder: (context) => MobileEmailVerifyScreen(
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
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              Center(
                child: _isSendingEmail
                    ? CircularProgressIndicator(
                        color: ColorManager.blueprime,
                      )
                    : CustomButton(
                        borderRadius: 28,
                        height: MediaQuery.of(context).size.height / 22,
                        width: MediaQuery.of(context).size.height / 5.3,
                        text: AppString.next,
                        style: TextStyle(fontSize: 13),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            setState(() {
                              _isSendingEmail = true;
                            });
                            try {
                              await GetOTPService.getOTP(_emailController.text);
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      MobileEmailVerifyScreen(
                                          email: _emailController.text),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0);
                                    const end = Offset.zero;
                                    const curve = Curves.ease;

                                    var tween = Tween(begin: begin, end: end)
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
            ],
          ),
        ),
      ),
    );
  }
}
