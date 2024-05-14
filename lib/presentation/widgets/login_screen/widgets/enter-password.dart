import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/login_flow_api/log_in/log_in_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/login_screen/forgot_screen/forgot_pass_screen.dart';
import 'package:prohealth/presentation/widgets/login_screen/widgets/login_flow_base_struct.dart';
import 'package:prohealth/presentation/widgets/profile_bar/widget/screen_transition.dart';
import '../../../../app/resources/color.dart';

class PasswordLoginScreen extends StatefulWidget {
  final String email;
  const PasswordLoginScreen({Key? key, required this.email}) : super(key: key);
  @override
  _PasswordLoginScreenState createState() =>
      _PasswordLoginScreenState(email: email);
}

class _PasswordLoginScreenState extends State<PasswordLoginScreen> {
  final String email;
  bool _isLoading = false;
  String? _errorMessage;
  _PasswordLoginScreenState({required this.email});
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
  bool _obscureText = true;

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      String enteredPassword = _passwordController.text;
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
    return LoginBaseConstant(
      onTap: () {
        Navigator.push(
          context,
          RouteTransitions.slideTransition(page: ForgotPassScreen()),
        );
      },
      titleText: AppString.login,
      textAction: AppString.forgotpass,
      textActionPadding:
          EdgeInsets.only(left: MediaQuery.of(context).size.width / 5.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 10,
                      horizontal: MediaQuery.of(context).size.width / 30,
                    ),
                    child: TextFormField(
                      style: CustomTextStylesCommon.commonStyle(
                        color: Color(0xff000000).withOpacity(0.5),
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSize.s14,
                      ),
                      onFieldSubmitted: (_) {
                        _login();
                      },
                      obscuringCharacter: '*',
                      controller: _passwordController,
                      cursorColor: Colors.black,
                      cursorHeight: 22,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 1),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff000000).withOpacity(0.5),
                            width: 0.5,
                          ),
                        ),
                        hintText: AppString.enterpass,
                        hintStyle:  EmailTextStyle.enterEmail(context),
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
                  // Display error message if exists
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: ColorManager.red),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
