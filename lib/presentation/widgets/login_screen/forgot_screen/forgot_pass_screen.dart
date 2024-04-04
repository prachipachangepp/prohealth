import 'package:flutter/material.dart';
import 'package:prohealth/presentation/widgets/login_screen/widgets/login_flow_base_struct.dart';
import 'package:prohealth/presentation/widgets/login_screen/forgot_screen/password_verification.dart';
import '../../../screens/hr_module/manage/widgets/custom_icon_button_constant.dart';

class ForgotPassScreen extends StatelessWidget {
   ForgotPassScreen({super.key});

  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return LoginBaseConstant(
        child: Column(
          children: [
            ///logo
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 365,
                  height: 110,
                  child: Image.asset('images/logo_login.png'),
                )
              ],
            ),
            // SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 20,
                  top: 60),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontFamily: 'FiraSans',
                          color: Color(0xff686464),
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(24),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 360,
                              height: 250,
                              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 40),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(24),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Enter your email for the verification process,we will send 4\ndigits code to your email.',
                                    style: TextStyle(
                                      fontFamily: 'FiraSans',
                                      color: Color(0xff686464),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextField(
                                    controller: controller,
                                    style: TextStyle(
                                      fontFamily: 'FiraSans',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: TextStyle(fontSize: 14,color: Color(0xff000000).withOpacity(0.9)),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xff50B5E5)),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Center(
                                    child: CustomButton(
                                      text:
                                      'Continue',
                                      onPressed:
                                          () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordVerifyScreen()));
                                      },
                                      width: 90.0,
                                      height: 30.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 280.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Back to login',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'FiraSans',
                              color: Color(0xff1696C8),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height/2,
                          child: Image.asset(
                            'images/amico.png',
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
    );
  }
}
