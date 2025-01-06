import 'package:flutter/material.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/login_resources/login_flow_theme_const.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/auth/auth_manager.dart';
import '../../../../../data/api_data/api_data.dart';
import '../../../../widgets/widgets/profile_bar/widget/screen_transition.dart';
import '../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../home_module/home_screen.dart';
import '../../../../widgets/tablet_constant/tab_const.dart';
import '../../forget_password/forget_password_screen.dart';

class LoginPassswordTab extends StatefulWidget {
  static const String label = "/logInWithPassword";
  final String email;
  const LoginPassswordTab({super.key, required this.email});

  @override
  State<LoginPassswordTab> createState() => _LoginPassswordTabState(email: email);
}

class _LoginPassswordTabState extends State<LoginPassswordTab> {
  final String email;
  bool _isLoading = false;
  String? _errorMessage;
  _LoginPassswordTabState({required this.email});
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
    return LoginBaseConstTab(
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
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.white,
                    decoration: TextDecoration.none,
                  ),
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
    );
  }
}
