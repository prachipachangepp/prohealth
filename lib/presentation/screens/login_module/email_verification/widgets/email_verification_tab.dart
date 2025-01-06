import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/auth/auth_manager.dart';
import '../../../../../data/api_data/api_data.dart';
import '../../../../widgets/tablet_constant/tab_const.dart';
import '../../../home_module/home_screen.dart';
import '../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../login_password/login_password.dart';

class EmailVerifyTab extends StatefulWidget {
  final String email;
  const EmailVerifyTab({super.key, required this.email});

  @override
  State<EmailVerifyTab> createState() => _EmailVerifyTabState();
}

class _EmailVerifyTabState extends State<EmailVerifyTab> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  bool _isVerifyingOTP = false;
  String? _errorMessage = "";

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
    return LoginBaseConstTab(
      titleText: AppString.verification,
      onTap: () {},
      textAction: '',
      childTab: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: ColorManager.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                child: Text(
                  AppString.enter6digitcode,
                  style: CustomTextStylesCommon.commonStyle(
                      color: ColorManager.darkgrey,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w700),
                ),
              ),

              ///txtfield
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  6,
                  (index) => Container(
                    width: MediaQuery.of(context).size.width / 25,
                    height: MediaQuery.of(context).size.height / 22,
                    margin: EdgeInsets.symmetric(horizontal: AppPadding.p6),
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
                      style: TextStyle(
                        color: ColorManager.darkgrey,
                        //fontSize: FontSize.s10,
                        fontSize: MediaQuery.of(context).size.width / 77,
                        fontWeight: FontWeight.w600,
                      )),
                  TextButton(
                    onPressed: () {},
                    child: Text(AppString.resend,
                        style: CustomTextStylesCommon.commonStyle(
                          color: ColorManager.blueprime,
                          fontSize: FontSize.s14,
                          fontWeight: FontWeight.w600,
                        )),
                  )
                ],
              ),

              ///button
              CustomButton(
                borderRadius: 23.82,
                paddingVertical: AppPadding.p5,
                height: MediaQuery.of(context).size.height / 24,
                width: MediaQuery.of(context).size.width / 3,
                text: _isVerifyingOTP ? AppString.verify : AppString.loginbtn,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.white,
                    decoration: TextDecoration.none,
                  ),
                onPressed: () {
                  _verifyOTPAndLogin();
                },
              ),
              if (_errorMessage != null)
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

              ///bottomtxt
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p16),
                child: InkWell(
                  child: Text(
                    AppString.donthaveauth,
                    style: CustomTextStylesCommon.commonStyle(
                      color: ColorManager.blueprime,
                      fontSize: FontSize.s10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            LoginWithPassword(email: widget.email!),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
