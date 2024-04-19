import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/login_screen/login_screen.dart';

class ChangePasswordScreen extends StatefulWidget {

  ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController controllerNew = TextEditingController();
  final TextEditingController controllerConfirm = TextEditingController();
  List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());
  bool _obscureText = true;
  bool _obscureTextconfirm = true;
  final _formKey = GlobalKey<FormState>();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmpassFocusNode = FocusNode();
  String? _errorMessage;
  late Timer _timer;
  int _timerCount = 30;
  bool isOtpFieldEmpty = true;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_timerCount == 0) {
        timer.cancel();
      } else {
        setState(() {
          _timerCount--;
        });
      }
    });
  }

  String getTimerString() {
    int minutes = _timerCount ~/ 60;
    int seconds = _timerCount % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Container(
        // height: 725,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/login_screen_no_blur.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height / 30,
                  vertical: MediaQuery.of(context).size.width / 40),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 9, sigmaY: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff000000).withOpacity(0.045),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(1, 4),
                        ),
                      ],
                      color: Color(0xffFFFFFF).withOpacity(0.35),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Column(
                      children: [
                        ///logo & head text
                        Padding(
                          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/30,
                              left: MediaQuery.of(context).size.width/12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Verification',
                                style: GoogleFonts.firaSans(
                                  color: Color(0xff686464),
                                  fontSize: 40,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Image.asset(
                                'images/logo_login.png',
                                width: MediaQuery.of(context).size.width / 5,
                                height:
                                MediaQuery.of(context).size.height / 5,
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///todo saloni
                                ///main container
                                Material(
                                  elevation: 9,
                                  borderRadius: BorderRadius.circular(24),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width / 3.5,
                                        height: MediaQuery.of(context).size.height / 1.6,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(24),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xff000000).withOpacity(0.1), // 0x1A for the first shadow
                                                spreadRadius: 0,
                                                blurRadius: 0,
                                                offset: Offset(0, 0),
                                              ),
                                              BoxShadow(
                                                color: Color(0xff000000).withOpacity(0.1), // 0x1A for the second shadow
                                                spreadRadius: 1,
                                                blurRadius: 4,
                                                offset: Offset(0, 3),
                                              ),
                                            ]
                                        ),
                                        ///column
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width / 30,
                                          vertical: MediaQuery.of(context).size.height/40),
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Enter your 4 digits code that you received on your email.',
                                                  style: GoogleFonts.firaSans(
                                                    color: Color(0xff686464),
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: List.generate(
                                                    6,
                                                        (index) => Container(
                                                      width: MediaQuery.of(context).size.width/40,
                                                      height: 40,
                                                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/200),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(2),
                                                        border: Border.all(
                                                          color: Color(0xff9BADCA),
                                                          width: 0.55,
                                                        ),
                                                      ),
                                                      child: TextFormField(
                                                        style:GoogleFonts.firaSans(
                                                          color: Color(0xff000000).withOpacity(0.7),
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 12,
                                                        ),
                                                        controller: _otpControllers[index],
                                                        cursorColor: Colors.black,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                        ],
                                                        keyboardType: TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        maxLength: 1,
                                                        decoration: InputDecoration(
                                                          contentPadding: const EdgeInsets. only(bottom: 10),
                                                          counterText: '',

                                                          border: InputBorder.none,
                                                        ),
                                                        validator: (value) {
                                                          return value!.isEmpty
                                                              ? 'Please enter OTP'
                                                              : null;
                                                        },
                                                        onChanged: (value) {
                                                          setState(() {
                                                            isOtpFieldEmpty = _otpControllers.any((controller) => controller.text.isEmpty);
                                                          });
                                                          if (!isOtpFieldEmpty) {
                                                            FocusScope.of(context).nextFocus();
                                                          } else if (value.isNotEmpty && index == 5) {
                                                            String enteredOTP = _otpControllers.map((controller) =>
                                                            controller.text).join();
                                                            bool anyFieldEmpty = _otpControllers.any((controller) => controller.text.isEmpty);
                                                            if (!anyFieldEmpty &&
                                                                (_formKey.currentState
                                                                    ?.validate() ??
                                                                    false)) {
                                                              FocusScope.of(context).requestFocus(passwordFocusNode);
                                                            }
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                    '${getTimerString()}',
                                                    style: GoogleFonts.firaSans(
                                                      color: Color(0xffF2451C),
                                                      fontSize: 8,
                                                      fontWeight: FontWeight.w600,)
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: GoogleFonts.firaSans(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xff686464),
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: 'If you didn’t receive a code! ',
                                                      ),
                                                      TextSpan(
                                                        text: 'Resend',
                                                        style: GoogleFonts.firaSans(
                                                          color: Color(0xffF2451C),
                                                        ),
                                                        recognizer: TapGestureRecognizer()
                                                          ..onTap = () {
                                                            //Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
                                                          },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(),
                                                Text(
                                                  'Set the new password for your account so you can login and\naccess all features.',
                                                  style: GoogleFonts.firaSans(
                                                    color: isOtpFieldEmpty? Colors.grey : Color(0xff686464),
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                TextFormField(
                                                  style: GoogleFonts.firaSans(
                                                    color: Color(0xff000000).withOpacity(0.5),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                  focusNode: passwordFocusNode,
                                                  onFieldSubmitted: (_) {
                                                    FocusScope.of(context)
                                                        .requestFocus(confirmpassFocusNode);
                                                  },
                                                  cursorHeight: 22,
                                                  obscuringCharacter: '*',
                                                  controller: controllerNew,
                                                  cursorColor: Colors.black,
                                                  obscureText: _obscureText,
                                                  decoration: InputDecoration(
                                                    contentPadding: const EdgeInsets. only(top: 2),
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
                                                    labelStyle: GoogleFonts.firaSans(
                                                      color: isOtpFieldEmpty? Colors.grey : Color(0xff686464),
                                                      //Color(0xff000000).withOpacity(0.3),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    border: UnderlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black),
                                                    ),
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(color: Color(0xff000000).withOpacity(0.5), width: 0.5),
                                                    ),
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.grey),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Enter Password';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                TextFormField(
                                                  focusNode: confirmpassFocusNode,
                                                  onFieldSubmitted: (_) {
                                                    //_loginWithEmail();
                                                  },
                                                  cursorHeight: 22,
                                                  obscuringCharacter: '*',
                                                  controller: controllerConfirm,
                                                  style: GoogleFonts.firaSans(
                                                    color: Color(0xff000000).withOpacity(0.5),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                  cursorColor: Colors.black,
                                                  obscureText: _obscureTextconfirm,
                                                  decoration: InputDecoration(
                                                    contentPadding: const EdgeInsets. only(top: 2),
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
                                                    labelStyle: GoogleFonts.firaSans(
                                                      color: isOtpFieldEmpty? Colors.grey : Color(0xff686464),
                                                      //Color(0xff000000).withOpacity(0.3),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    border: UnderlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black),
                                                    ),
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(color: Color(0xff000000).withOpacity(0.5), width: 0.5),
                                                    ),
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.grey),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Enter Confirm Password';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                SizedBox(height: 12),
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
                                                      width: MediaQuery.of(context).size.width / 7,
                                                      height: MediaQuery.of(context).size.height / 22,
                                                      text: 'Update Password',
                                                      backgroundColor: isOtpFieldEmpty? Colors.grey : Color(0xFF50B5E5),
                                                      onPressed: () async{
                                                        if(_formKey.currentState!.validate()) {
                                                          if (controllerNew.text != controllerConfirm.text) {
                                                            setState(() {
                                                              _errorMessage = 'Passwords do not match.';
                                                            });
                                                            return;
                                                          }
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
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .center,
                                                                        children: [
                                                                          Image.asset(
                                                                            'images/upload.png',
                                                                            width: 125,
                                                                            height: 125,
                                                                          ),
                                                                          Text(
                                                                            'Successfully',
                                                                            style: GoogleFonts.firaSans(
                                                                              fontSize: 30,
                                                                              color: Color(0xff686464),
                                                                              fontWeight: FontWeight.w700,),
                                                                          ),
                                                                          Text(
                                                                            'Your password has been reset successfully',
                                                                            style: GoogleFonts.firaSans(
                                                                              fontSize: 12,
                                                                              color: Color(0xff686464),
                                                                              fontWeight: FontWeight.w500,),
                                                                          ),
                                                                          CustomButton(
                                                                              width: 182,
                                                                              height: 46,
                                                                              text: 'CONTINUE',
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
                                                        }
                                                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordVerifyScreen()));
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                if (_errorMessage != null)
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                    child: Text(
                                                      _errorMessage!,
                                                      style: TextStyle(color: Colors.red),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height / 60,),
                                ///back to login text
                                Padding(
                                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/4.5),
                                  child: GestureDetector(
                                    onTap: (){},
                                    child: Text(
                                      'Back to login',
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.firaSans(
                                        color: Color(0xff1696C8),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Image.asset(
                              'images/amico.png',
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 2,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}