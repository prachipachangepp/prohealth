import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/login_screen/login_screen.dart';
import 'package:prohealth/presentation/widgets/login_screen/widgets/login_flow_base_struct.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController controllerNew = TextEditingController();
  final TextEditingController controllerConfirm = TextEditingController();
  bool _obscureText = true;
  bool _obscureTextconfirm = true;

  @override
  Widget build(BuildContext context) {
    return LoginBaseConstant(
      onTap: () {},
      titleText: 'New Password',
      textAction: 'Back to Log In',
      textActionPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Set the new password for your account so you can login and\naccess all features.',
              style: TextStyle(
                fontFamily: 'FiraSans',
                color: Color(0xff686464),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              controller: controllerNew,
              style: TextStyle(
                fontFamily: 'FiraSans',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              cursorColor: Colors.black,
              obscureText: _obscureText,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 15,
                    color: Color(0xffACA5BB),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                labelText: 'Enter New Password',
                labelStyle: TextStyle(
                    fontSize: 10,
                    color: Color(0xff000000).withOpacity(0.9),
                    fontWeight: FontWeight.w500),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            TextField(
              controller: controllerConfirm,
              style: TextStyle(
                fontFamily: 'FiraSans',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              cursorColor: Colors.black,
              obscureText: _obscureTextconfirm,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureTextconfirm
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 15,
                    color: Color(0xffACA5BB),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureTextconfirm = !_obscureTextconfirm;
                    });
                  },
                ),
                labelText: 'Confirm Password',
                labelStyle: TextStyle(
                    fontSize: 10,
                    color: Color(0xff000000).withOpacity(0.9),
                    fontWeight: FontWeight.w500),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 12),
            Center(
              child: CustomButton(
                width: MediaQuery.of(context).size.width / 8,
                height: MediaQuery.of(context).size.height / 22,
                text: 'Update Password',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            backgroundColor: Colors.white,
                            content: Container(
                              padding: EdgeInsets.only(top: 25),
                              height: 400,
                              width: 500,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/upload.png',
                                    width: 125,
                                    height: 125,
                                  ),
                                  Text(
                                    'Successfully',
                                    style: TextStyle(
                                      fontFamily: 'FiraSans',
                                      fontSize: 30,
                                      color: Color(0xff686464),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Your password has been reset successfully',
                                    style: TextStyle(
                                      fontFamily: 'FiraSans',
                                      fontSize: 12,
                                      color: Color(0xff686464),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  CustomButton(
                                      width: 282,
                                      height: 46,
                                      text: 'Continue',
                                      borderRadius: 28,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()));
                                      })
                                ],
                              ),
                            ));
                      });
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordVerifyScreen()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
