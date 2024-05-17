import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/login_flow_api/get_otp/getotp_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/login_screen/verify_screen.dart';
import 'package:prohealth/presentation/widgets/login_screen/widgets/login_flow_base_struct.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginBaseConstant(
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
                    ///textfield Email
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 30,
                      ),
                      child: Expanded(
                        child: TextFormField(
                          style: CustomTextStylesCommon.commonStyle(
                            color: Color(0xff000000).withOpacity(0.5),
                            fontWeight: FontWeightManager.medium,
                            fontSize: FontSize.s14,
                          ),
                          focusNode: emailFocusNode,
                          controller: _emailController,
                          cursorColor: Colors.black,
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
                                await GetOTPService.getOTP(
                                    _emailController.text);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VerifyScreen(
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
                    Center(
                      child: _isSendingEmail
                          ? CircularProgressIndicator(
                              color: ColorManager.blueprime,
                            )
                          : Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x40000000),
                                      offset: Offset(0, 4),
                                      blurRadius: 3,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: CustomButton(
                                  borderRadius: 28,
                                  height:
                                      MediaQuery.of(context).size.height / 18,
                                  width:
                                      MediaQuery.of(context).size.height / 5.3,
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
                                                VerifyScreen(
                                                    email:
                                                        _emailController.text),
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              const begin = Offset(1.0, 0.0);
                                              const end = Offset.zero;
                                              const curve = Curves.ease;

                                              var tween = Tween(
                                                      begin: begin, end: end)
                                                  .chain(
                                                      CurveTween(curve: curve));
                                              return SlideTransition(
                                                position:
                                                    animation.drive(tween),
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
                            ),
                    ),
                  ])),
        ),
      ),
    );
  }
}
