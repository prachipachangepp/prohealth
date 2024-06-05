import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/auth/auth_manager.dart';
import '../../../../../data/api_data/api_data.dart';
import '../../../../../data/navigator_arguments/screen_arguments.dart';

import '../../../../widgets/widgets/login_screen/widgets/login_flow_base_struct.dart';
import '../../../home_module/home_screen.dart';
import '../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../login_password/login_password.dart';

class EmailVerifyWeb extends StatefulWidget {
  static const String routeName = "/emailVerification";
  const EmailVerifyWeb({super.key});

  @override
  State<EmailVerifyWeb> createState() => _EmailVerifyWebState();
}

class _EmailVerifyWebState extends State<EmailVerifyWeb> {
  final List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());
  bool _isVerifyingOTP = false;
  String? _errorMessage = "";
  String? email = "";

  Future<void> _verifyOTPAndLogin() async {
    setState(() {
      _isVerifyingOTP = true;
      _errorMessage = "";
    });
    String enteredOTP =
    _otpControllers.map((controller) => controller.text).join();
    ApiData result = await AuthManager.verifyOTPAndLogin(
        email: email!, otp: enteredOTP, context: context);
    if (result.success) {
      Navigator.pushNamed(context, HomeScreen.routeName);
    } else {
      setState(() {
        _errorMessage = result.message;
      });
    }
    setState(() {
      _isVerifyingOTP = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    email = args.title!;
    return LoginBaseConstant(
      onTap: () {},
      textAction: '',
      titleText: AppString.verification,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: MediaQuery.of(context).size.width / 3.5,
          height: MediaQuery.of(context).size.height / 2.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: ColorManager.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppString.enter6digitcode,
                  style: CustomTextStylesCommon.commonStyle(
                      color: ColorManager.darkgrey,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.bold),
                ),

                ///txtfield
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                        (index) => Container(
                      // width: MediaQuery.of(context).size.width /45,
                      width: MediaQuery.of(context).size.width / 45,
                      height: MediaQuery.of(context).size.height / 19,
                      margin: EdgeInsets.symmetric(
                          horizontal:
                          MediaQuery.of(context).size.width / 150),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.26),
                        border: Border.all(
                          color: ColorManager.bluecontainer,
                          width: 0.85,
                        ),
                      ),
                      child: TextFormField(
                        controller: _otpControllers[index],
                        cursorColor: ColorManager.black,
                        cursorHeight: 20,
                        cursorWidth: 2,
                        cursorRadius: const Radius.circular(1),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                          ),
                        ],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        maxLength: 1,
                        decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.only(bottom: AppSize.s15),
                          counterText: '',
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          return value!.isEmpty ? AppString.otp : null;
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isNotEmpty && index == 5) {
                            _verifyOTPAndLogin();
                          }
                        },
                      ),
                    ),
                  ),
                ),

                ///didnt receive code
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppString.didntrecieveCode,
                        style: CodeVerficationText.VerifyCode(context)),
                    TextButton(
                      onPressed: () {},
                      child: Text(AppString.resend,
                          style: CustomTextStylesCommon.commonStyle(
                            color: ColorManager.blueprime,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.semiBold,
                          )),
                    )
                  ],
                ),

                ///button
                CustomButton(
                  borderRadius: 24,
                  height: MediaQuery.of(context).size.height / 18,
                  width: MediaQuery.of(context).size.height / 4,
                  text: _isVerifyingOTP
                      ? AppString.verify
                      : AppString.loginbtn,
                  onPressed: () {
                    _verifyOTPAndLogin();
                  },
                ),
                if (_errorMessage!.isNotEmpty)
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

                ///bottomtxt
                InkWell(
                  child: Text(
                    AppString.donthaveauth,
                    style: CustomTextStylesCommon.commonStyle(
                      color: ColorManager.blueprime,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.medium,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration:
                        const Duration(milliseconds: 500),
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                            LoginWithPassword(email: email!),
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
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
