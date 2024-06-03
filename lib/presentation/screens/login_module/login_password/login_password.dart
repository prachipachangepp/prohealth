import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/managers/auth/auth_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/presentation/screens/desktop_module/widgets/login_screen/widgets/login_flow_base_struct.dart';
import 'package:prohealth/presentation/screens/login_module/forget_password/forget_password_screen.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/const_string.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/theme_manager.dart';
import '../../../../app/resources/value_manager.dart';
import '../../../../app/services/login_flow_api/log_in/log_in_manager.dart';
import '../../../widgets/responsive_screen.dart';
import '../../desktop_module/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../desktop_module/widgets/profile_bar/widget/screen_transition.dart';
import '../../mobile_module/mobile_const.dart';
import '../../tablet_module/tab_const.dart';

class LoginWithPassword extends StatefulWidget {
  static const String label = "/logInWithPassword";
  final String email;
  const LoginWithPassword({super.key, required this.email});

  @override
  State<LoginWithPassword> createState() =>
      _LoginWithPasswordState(email: email);
}

class _LoginWithPasswordState extends State<LoginWithPassword> {
  final String email;
  bool _isLoading = false;
  String? _errorMessage;
  _LoginWithPasswordState({required this.email});
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]\.com$');
  bool _obscureText = true;

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      ApiData apiData =
          await AuthManager.signInWithEmail(email, _passwordController.text);
      if (apiData.success) {}
      AuthService.loginWithEmail(
        context,
        widget.email,
        _passwordController,
        true,
        (isLoading) {
          setState(() {
            _isLoading = isLoading;
          });
        },
        (errorMessage) {
          setState(() {
            _errorMessage = errorMessage;
            _isLoading = false;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
        mobile: MobileConst(
          containerHeight:
              MediaQuery.of(context).size.height / 2, // specify desired height
          containerWidth: MediaQuery.of(context).size.width / 1.1,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ForgetPassword()));
          },
          titleText: AppString.login,
          textAction: AppString.forgotpass,
          mobileChild: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 8,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.enterpasstologin,
                        style: CustomTextStylesCommon.commonStyle(
                            color: ColorManager.mediumgrey,
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.medium),
                      ),
                    ],
                  ),
                  TextFormField(
                    style: CustomTextStylesCommon.commonStyle(
                      color: ColorManager.black.withOpacity(0.5),
                      fontWeight: FontWeightManager.medium,
                      fontSize: FontSize.s14,
                    ),
                    onFieldSubmitted: (_) {
                      _login();
                    },
                    obscuringCharacter: '*',
                    controller: _passwordController,
                    cursorColor: ColorManager.black,
                    cursorHeight: 22,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: AppPadding.p1),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorManager.black.withOpacity(0.5),
                          width: 0.5,
                        ),
                      ),
                      hintText: AppString.enterpass,
                      hintStyle: EmailTextStyle.enterEmail(context),
                      labelText: AppString.password,
                      labelStyle: EmailTextStyle.enterEmail(context),
                      errorStyle: CustomTextStylesCommon.commonStyle(
                        color: ColorManager.red,
                        fontSize: FontSize.s10,
                        fontWeight: FontWeightManager.bold,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.enterpass;
                      }
                      return null;
                    },
                  ),

                  ///button
                  _isLoading
                      ? CircularProgressIndicator(
                          color: ColorManager.blueprime,
                        )
                      : CustomButton(
                          borderRadius: 23.82,
                          height: MediaQuery.of(context).size.height / 24,
                          width: MediaQuery.of(context).size.width / 3,
                          paddingVertical: AppPadding.p5,
                          text: AppString.loginbtn,
                          style: CustomTextStylesCommon.commonStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.bold,
                            color: ColorManager.white,
                          ),
                          onPressed: _isLoading ? () {} : _login,
                        ),
                  if (_errorMessage != null)
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppPadding.p10),
                      child: Text(
                        _errorMessage!,
                        style: CustomTextStylesCommon.commonStyle(
                          color: ColorManager.red,
                          fontSize: FontSize.s10,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        web: LoginBaseConstant(
          onTap: () {
            Navigator.push(
              context,
              RouteTransitions.slideTransition(page: ForgetPassword()),
            );
          },
          titleText: AppString.login,
          textAction: AppString.forgotpass,
          // textActionPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 5),
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 30,
                      ),
                      child: TextFormField(
                        style: CustomTextStylesCommon.commonStyle(
                          color: ColorManager.black.withOpacity(0.5),
                          fontWeight: FontWeightManager.medium,
                          fontSize: FontSize.s14,
                        ),
                        onFieldSubmitted: (_) {
                          _login();
                        },
                        obscuringCharacter: '*',
                        controller: _passwordController,
                        cursorColor: ColorManager.black,
                        cursorHeight: 22,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: AppPadding.p1),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorManager.black.withOpacity(0.5),
                              width: 0.5,
                            ),
                          ),
                          hintText: AppString.enterpass,
                          hintStyle: EmailTextStyle.enterEmail(context),
                          labelText: AppString.password,
                          labelStyle: EmailTextStyle.enterEmail(context),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterpass;
                          }
                          return null;
                        },
                      ),
                    ),

                    ///button
                    _isLoading
                        ? CircularProgressIndicator(
                            color: ColorManager.blueprime,
                          )
                        : CustomButton(
                            borderRadius: 24,
                            height: MediaQuery.of(context).size.height / 18,
                            width: MediaQuery.of(context).size.height / 4,
                            text: AppString.loginbtn,
                            onPressed: _isLoading ? () {} : _login,
                          ),
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppPadding.p10),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: ColorManager.red),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        tablet: LoginBaseConstTab(
          titleText: AppString.login,
          onTap: () {
            Navigator.push(
              context,
              RouteTransitions.slideTransition(page: ForgetPassword()),
            );
          },
          textAction: AppString.forgotpass,
          childTab: Container(
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 30,
                    ),
                    child: TextFormField(
                      style: CustomTextStylesCommon.commonStyle(
                        color: ColorManager.black.withOpacity(0.5),
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSize.s14,
                      ),
                      onFieldSubmitted: (_) {
                        _login();
                      },
                      obscuringCharacter: '*',
                      controller: _passwordController,
                      cursorColor: ColorManager.black,
                      cursorHeight: 22,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: AppPadding.p1),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorManager.black.withOpacity(0.5),
                            width: 0.5,
                          ),
                        ),
                        hintText: AppString.enterpass,
                        hintStyle: EmailTextStyle.enterEmail(context),
                        labelText: AppString.password,
                        labelStyle: EmailTextStyle.enterEmail(context),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.enterpass;
                        }
                        return null;
                      },
                    ),
                  ),

                  ///button
                  _isLoading
                      ? CircularProgressIndicator(
                          color: ColorManager.blueprime,
                        )
                      : CustomButton(
                          borderRadius: 24,
                          height: MediaQuery.of(context).size.height / 18,
                          width: MediaQuery.of(context).size.height / 4,
                          text: AppString.loginbtn,
                          onPressed: _isLoading ? () {} : _login,
                        ),
                  if (_errorMessage != null)
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppPadding.p10),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: ColorManager.red),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}
