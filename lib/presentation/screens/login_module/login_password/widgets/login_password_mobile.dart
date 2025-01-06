import 'package:flutter/material.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/login_resources/login_flow_theme_const.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/auth/auth_manager.dart';
import '../../../../../data/api_data/api_data.dart';
import '../../../home_module/home_screen.dart';
import '../../../../widgets/mobile_constant/mobile_const.dart';
import '../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../forget_password/forget_password_screen.dart';

class LoginPasswordMobile extends StatefulWidget {
  static const String label = "/logInWithPassword";
  final String email;
  const LoginPasswordMobile({super.key, required this.email});

  @override
  State<LoginPasswordMobile> createState() => _LoginPasswordMobileState(email: email);
}

class _LoginPasswordMobileState extends State<LoginPasswordMobile> {
  final String email;
  bool _isLoading = false;
  String? _errorMessage;
  _LoginPasswordMobileState({required this.email});
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
      ApiData apiData = await AuthManager.signInWithEmail(
          email, _passwordController.text, context);
      if (apiData.success) {
        Navigator.pushNamed(context, HomeScreen.routeName);
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = apiData.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  MobileConst(
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
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              TextFormField(
                style: CustomTextStylesCommon.commonStyle(
                  color: ColorManager.black.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
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
                    fontWeight: FontWeight.w700,
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
                  fontWeight: FontWeight.w700,
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
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
