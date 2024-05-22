import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/login_flow_api/log_in/log_in_manager.dart';
import 'package:prohealth/presentation/screens/desktop_module/widgets/login_screen/forgot_screen/forgot_pass_screen.dart';
import 'package:prohealth/presentation/screens/desktop_module/widgets/profile_bar/widget/screen_transition.dart';
import 'package:prohealth/presentation/screens/mobile_module/widgets/mobile_const.dart';

import '../../../app/resources/color.dart';
import '../../../app/resources/const_string.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/theme_manager.dart';
import '../../../app/resources/value_manager.dart';
import '../desktop_module/hr_module/manage/widgets/custom_icon_button_constant.dart';

class MobileLogInWithPass extends StatefulWidget {
  final String email;
  const MobileLogInWithPass({Key? key, required this.email}) : super(key: key);

  @override
  State<MobileLogInWithPass> createState() =>
      _MobileLogInWithPassState(email: email);
}

class _MobileLogInWithPassState extends State<MobileLogInWithPass> {
  final String email;
  bool _isLoading = false;
  String? _errorMessage;
  _MobileLogInWithPassState({required this.email});
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
    return MobileConst(
      titleText: 'Log In',
      textAction: '',
      onTap: () {
        Navigator.push(
          context,
          RouteTransitions.slideTransition(page: ForgotPassScreen()),
        );
      },
      mobileChild: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppString.enterpasstologin,
              style: CustomTextStylesCommon.commonStyle(
                  color: ColorManager.darkgrey,
                  fontSize: FontSize.s10,
                  fontWeight: FontWeightManager.bold),
            ),
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
                      _obscureText ? Icons.visibility : Icons.visibility_off,
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
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: ColorManager.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
