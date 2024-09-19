import 'package:flutter/material.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/login_resources/login_flow_theme_const.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/auth/auth_manager.dart';
import '../../../../../data/api_data/api_data.dart';
import '../../../../widgets/widgets/login_screen/widgets/login_flow_base_struct.dart';
import '../../../../widgets/widgets/profile_bar/widget/screen_transition.dart';
import '../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../home_module/home_screen.dart';
import '../../forget_password/forget_password_screen.dart';

class LoginPasswordWeb extends StatefulWidget {
  static const String label = "/logInWithPassword";
  final String email;
  const LoginPasswordWeb({super.key, required this.email});

  @override
  State<LoginPasswordWeb> createState() => _LoginPasswordWebState(email: email);
}

class _LoginPasswordWebState extends State<LoginPasswordWeb> {
  final String email;
  bool _isLoading = false;
  String? _errorMessage;
  _LoginPasswordWebState({required this.email});
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
        Navigator.pushNamed(context, HomeScreen.routeName,);
        String userName = apiData.data.toString();
        print('user Date ${apiData.data.toString()}');
       //Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
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
    return LoginBaseConstant(
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
                    style: LoginFlowTextField.customTextStyle(context),
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
                      style: LoginFlowErrorMsg.customTextStyle(context),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
