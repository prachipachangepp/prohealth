import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/auth/auth_manager.dart';
import '../../../../../data/api_data/api_data.dart';
import '../../../../widgets/mobile_constant/mobile_const.dart';
import '../../../home_module/home_screen.dart';
import '../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../login_password/login_password.dart';

class EmailVerifyMobile extends StatefulWidget {
  final String email;
  const EmailVerifyMobile({super.key, required this.email});

  @override
  State<EmailVerifyMobile> createState() => _EmailVerifyMobileState();
}

class _EmailVerifyMobileState extends State<EmailVerifyMobile> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  bool _isVerifyingOTP = false;
  String? _errorMessage = "";

  ///
  Future<void> _verifyOTPAndLogin() async {
    setState(() {
      _isVerifyingOTP = true;
      _errorMessage = "";
    });
    String enteredOTP =
        _otpControllers.map((controller) => controller.text).join();
    ApiData result = await AuthManager.verifyOTPAndLogin(
        email: widget.email, otp: enteredOTP, context: context);
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
    return MobileConst(
      containerHeight:
          MediaQuery.of(context).size.height / 1.9, // specify desired height
      containerWidth: MediaQuery.of(context).size.width / 1.1,
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginWithPassword(email: AppString.email),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
        );
      },
      textAction: AppString.donthaveauth,
      titleText: AppString.verification,
      mobileChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: Column(
          children: [
            Text(
              AppString.enter6digitcode,
              style: CustomTextStylesCommon.commonStyle(
                  color: ColorManager.mediumgrey,
                  fontSize: FontSize.s10,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 60,
            ),

            ///txtfield
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                6,
                (index) => Container(
                  width: MediaQuery.of(context).size.width / 13,
                  height: MediaQuery.of(context).size.height / 23,
                  margin: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
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
                      contentPadding: EdgeInsets.only(bottom: AppSize.s15),
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
                    style: CustomTextStylesCommon.commonStyle(
                      color: ColorManager.mediumgrey,
                      fontSize: FontSize.s10,
                      fontWeight: FontWeight.w500,
                    )),
                TextButton(
                  onPressed: () {},
                  child: Text(AppString.resend,
                      style: CustomTextStylesCommon.commonStyle(
                        color: ColorManager.blueprime,
                        fontSize: FontSize.s10,
                        fontWeight: FontWeight.w600,
                      )),
                )
              ],
            ),

            ///button
            CustomButton(
              borderRadius: 23.82,
              height: MediaQuery.of(context).size.height / 23,
              width: MediaQuery.of(context).size.width / 3.8,
              paddingVertical: AppPadding.p5,
              text: _isVerifyingOTP ? AppString.verify : AppString.loginbtn,
              style: CustomTextStylesCommon.commonStyle(
                color: ColorManager.white,
                fontSize: FontSize.s14,
                fontWeight: FontWeight.w700,
              ),
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
                    fontSize: FontSize.s10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
