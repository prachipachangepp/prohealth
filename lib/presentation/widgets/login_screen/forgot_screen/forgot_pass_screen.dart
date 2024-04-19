import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/forgot_pass/forgot_pass_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/login_screen/forgot_screen/change_password.dart';
import 'package:prohealth/presentation/widgets/login_screen/login_screen.dart';
import '../widgets/login_flow_base_struct.dart';

class ForgotPassScreen extends StatefulWidget {
  ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  FocusNode emailFocusNode = FocusNode();
  ForgotPassManager _forgotPassManager = ForgotPassManager();
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

  @override
  Widget build(BuildContext context) {
    return LoginBaseConstant(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      textActionPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4.5),
      titleText: 'Forgot Password',
      textAction: 'Back to Login',
      child: Padding(
        padding: EdgeInsets.all( MediaQuery.of(context).size.width / 40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Enter your email for the verification process,we will send 6\ndigits code to your email.',
                style: GoogleFonts.firaSans(
                  color: Color(0xff686464),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 100),
                child: TextFormField(
                  // focusNode: emailFocusNode,
                  // onFieldSubmitted: (_) {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => PasswordVerifyScreen()),
                  //   );
                  // },
                  controller: _emailcontroller,
                  style:GoogleFonts.firaSans(
                    color: Color(0xff000000).withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  cursorHeight: 22,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets. only(top: 2),
                    labelText: 'Email',
                    labelStyle: GoogleFonts.firaSans(
                      color: Color(0xff000000).withOpacity(0.3),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:  Color(0xff000000).withOpacity(0.5),width: 0.5),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Email';
                    }
                    if (!emailRegex.hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 99,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: CustomButton(
                    borderRadius: 28,
                      text: 'Continue',
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          String email = _emailcontroller.text;
                          //_forgotPassword(email);
                          _forgotPassManager.forgotPassword(email);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePasswordScreen(email: _emailcontroller.text,)),
                          );
                          print('forgot button press');
                        }
                      },
                      width: MediaQuery.of(context).size.width / 9,
                      height: MediaQuery.of(context).size.height / 22),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}