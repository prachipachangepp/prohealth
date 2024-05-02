import 'dart:async';
import 'dart:convert';
import 'dart:js';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/login_screen/login_screen.dart';
import '../../../../app/resources/color.dart';
import '../../../../app/services/api_hr/confirm_pass/confirm_pass_manager.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String email;
  ChangePasswordScreen({super.key, required this.email});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController controllerNew = TextEditingController();
  final TextEditingController controllerConfirm = TextEditingController();
  List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  List<FocusNode> _focusNodes =
  List.generate(6, (_) => FocusNode());
  bool _obscureText = true;
  bool _obscureTextconfirm = true;
  final _formKey = GlobalKey<FormState>();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  String? _errorMessage;
  late Timer _timer;
  int _timerCount = 30;
  bool isOtpFieldEmpty = true;
  ConfirmPassManager confirmPassManager = ConfirmPassManager();
  TextEditingController newPasswordController = TextEditingController();
  List<bool> _otpFieldFilledStatus = List.generate(6, (_) => false);
  bool _isUpdatingPassword = false;

  Future<void> updatePassword() async {
    // Replace 'email', 'otp', and 'newPassword' with actual values
    String email = 'user@example.com';
    String otp = '123456';
    String newPassword = newPasswordController.text;

    try {
      var headers = {'Content-Type': 'application/json'};

      var data = json.encode({
        "email": email,
        "verificationCode": otp,
        "newPassword": newPassword
      });

      var response = await Dio().post(
        'https://wwx3rebc2b.execute-api.us-west-1.amazonaws.com/dev/serverlessSetup/auth/confirmPassword',
        data: data,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        print('Password changed successfully');
        print(json.encode(response.data));
        // Optionally, navigate back to the login screen
        Navigator.pop(context as BuildContext);
      } else {
        print('Failed to change password: ${response.statusMessage}');
        // Print response data for debugging if needed
        print(json.encode(response.data));
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  // Future<void> confirmPassword() async {
  //   var headers = {
  //     'Content-Type': 'application/json'
  //   };
  //   var data = json.encode({
  //     "email": "srojkrjha@gmail.com",
  //     "verificationCode": "009031",
  //     "newPassword": "Test@test12"
  //   });
  //   var dio = Dio();
  //   var response = await dio.request(
  //     '${AppConfig.endpoint}/auth/confirmPassword',
  //    // 'https://wwx3rebc2b.execute-api.us-west-1.amazonaws.com/dev/serverlessSetup/auth/confirmPassword',
  //     options: Options(
  //       method: 'POST',
  //       headers: headers,
  //     ),
  //     data: data,
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print(json.encode(response.data));
  //   }
  //   else {
  //     print(response.statusMessage);
  //   }
  // }
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
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width / 30,
                              left: MediaQuery.of(context).size.width / 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppString.verfication,
                                style: GoogleFonts.firaSans(
                                  color: Color(0xff686464),
                                  fontSize: 40,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Image.asset(
                                'images/logo_login.png',
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.height / 5,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.6,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xff000000)
                                                    .withOpacity(0.1),
                                                spreadRadius: 0,
                                                blurRadius: 0,
                                                offset: Offset(0, 0),
                                              ),
                                              BoxShadow(
                                                color: Color(0xff000000)
                                                    .withOpacity(0.1),
                                                spreadRadius: 1,
                                                blurRadius: 4,
                                                offset: Offset(0, 3),
                                              ),
                                            ]),

                                        ///column
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30,
                                              vertical: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  40),
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppString.entersixdigitCode,
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
                                                      width: MediaQuery.of(context).size.width / 40,
                                                      height: 40,
                                                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 200),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xff9BADCA),
                                                          width: 0.55,
                                                        ),
                                                      ),
                                                      child: TextFormField(
                                                        style: GoogleFonts
                                                            .firaSans(
                                                          color: Color(0xff000000).withOpacity(0.7),
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 12,
                                                        ),
                                                        controller: _otpControllers[index],
                                                        cursorColor: Colors.black,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                        ],
                                                        keyboardType:
                                                            TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        maxLength: 1,
                                                        focusNode: _focusNodes[index],
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 10),
                                                          counterText: '',
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                        validator: (value) {
                                                          return value!.isEmpty
                                                              ? AppString
                                                                  .enterotp
                                                              : null;
                                                        },
                                                        onChanged: (value) {
                                                          _otpFieldFilledStatus[index] = value.isNotEmpty;
                                                          bool allFieldsFilled = _otpFieldFilledStatus.every((filled) => filled);
                                                          setState(() {
                                                            isOtpFieldEmpty = !allFieldsFilled;
                                                          });
                                                          if (value.isNotEmpty && index < 5) {
                                                            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                                                          } else if (value.isNotEmpty && index == 5) {
                                                            FocusScope.of(context).requestFocus(newPasswordFocusNode);
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text('${getTimerString()}',
                                                    style: GoogleFonts.firaSans(
                                                      color: Color(0xffF2451C),
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                                RichText(
                                                  text: TextSpan(
                                                    style: GoogleFonts.firaSans(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff686464),
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                          text: AppString
                                                              .didntrecieveCode),
                                                      TextSpan(
                                                        text: AppString.resend,
                                                        style: GoogleFonts
                                                            .firaSans(
                                                          color:
                                                              Color(0xffF2451C),
                                                        ),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                //Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
                                                              },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(),
                                                Text(
                                                  AppString.setnewPassword,
                                                  style: GoogleFonts.firaSans(
                                                    color: isOtpFieldEmpty
                                                        ? Colors.grey
                                                        : Color(0xff686464),
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                TextFormField(
                                                  style: GoogleFonts.firaSans(
                                                    color: Color(0xff000000)
                                                        .withOpacity(0.5),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                  focusNode: newPasswordFocusNode,
                                                  onFieldSubmitted: (_) {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                        confirmPasswordFocusNode);
                                                  },
                                                  cursorHeight: 22,
                                                  obscuringCharacter: '*',
                                                  controller: controllerNew,
                                                  cursorColor: Colors.black,
                                                  obscureText: _obscureText,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            top: 2),
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                        _obscureText
                                                            ? Icons
                                                                .visibility_outlined
                                                            : Icons
                                                                .visibility_off_outlined,
                                                        size: 15,
                                                        color:
                                                            Color(0xffACA5BB),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _obscureText =
                                                              !_obscureText;
                                                        });
                                                      },
                                                    ),
                                                    labelText:
                                                        AppString.enternewpass,
                                                    labelStyle:
                                                        GoogleFonts.firaSans(
                                                      color: isOtpFieldEmpty
                                                          ? Colors.grey
                                                          : Color(0xff686464),
                                                      //Color(0xff000000).withOpacity(0.3),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    border:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                                  0xff000000)
                                                              .withOpacity(0.5),
                                                          width: 0.5),
                                                    ),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Enter Password';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                TextFormField(
                                                  focusNode:
                                                  confirmPasswordFocusNode,
                                                  onFieldSubmitted: (_) {
                                                    //_loginWithEmail();
                                                  },
                                                  cursorHeight: 22,
                                                  obscuringCharacter: '*',
                                                  controller: controllerConfirm,
                                                  style: GoogleFonts.firaSans(
                                                    color: Color(0xff000000)
                                                        .withOpacity(0.5),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                  cursorColor: Colors.black,
                                                  obscureText:
                                                      _obscureTextconfirm,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            top: 2),
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                        _obscureTextconfirm
                                                            ? Icons
                                                                .visibility_outlined
                                                            : Icons
                                                                .visibility_off_outlined,
                                                        size: 15,
                                                        color:
                                                            Color(0xffACA5BB),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _obscureTextconfirm =
                                                              !_obscureTextconfirm;
                                                        });
                                                      },
                                                    ),
                                                    labelText:
                                                        AppString.confmpass,
                                                    labelStyle:
                                                        GoogleFonts.firaSans(
                                                      color: isOtpFieldEmpty
                                                          ? Colors.grey
                                                          : Color(0xff686464),
                                                      //Color(0xff000000).withOpacity(0.3),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    border:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                                  0xff000000)
                                                              .withOpacity(0.5),
                                                          width: 0.5),
                                                    ),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return AppString
                                                          .enterconfmpass;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                SizedBox(height: 12),
                                                Center(
                                                  child: _isUpdatingPassword
                                                      ? CircularProgressIndicator( color: ColorManager.blueprime)
                                                      : Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x40000000),
                                                          offset: Offset(0, 4),
                                                          blurRadius: 4,
                                                          spreadRadius: 0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: CustomButton(
                                                      width: MediaQuery.of(context).size.width / 7,
                                                      height: MediaQuery.of(context).size.height / 22,
                                                      text: AppString.updatepass,
                                                      backgroundColor: isOtpFieldEmpty ? Colors.grey : Color(0xFF50B5E5),
                                                      onPressed: () async {
                                                        if (_formKey.currentState!.validate()) {
                                                          if (controllerNew.text != controllerConfirm.text) {
                                                            setState(() {
                                                              _errorMessage =
                                                                  'Passwords do not match.';
                                                            });
                                                            return;
                                                          }
                                                          setState(() {
                                                            _isUpdatingPassword = true;
                                                          });
                                                          try {
                                                            await ConfirmPassManager()
                                                                .confirmPassword(
                                                              widget.email,
                                                              _otpControllers
                                                                  .map((controller) =>
                                                                      controller
                                                                          .text)
                                                                  .join(),
                                                              controllerNew
                                                                  .text,
                                                            );
                                                            print(
                                                                '${widget.email}');
                                                            print(
                                                                '${controllerNew.text}');
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  content:
                                                                      Container(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                25),
                                                                    height: 400,
                                                                    width: 500,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          'images/upload.png',
                                                                          width:
                                                                              125,
                                                                          height:
                                                                              125,
                                                                        ),
                                                                        Text(
                                                                          AppString
                                                                              .successfully,
                                                                          style:
                                                                              GoogleFonts.firaSans(
                                                                            fontSize:
                                                                                30,
                                                                            color:
                                                                                Color(0xff686464),
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          AppString
                                                                              .resetsuccessfully,
                                                                          style:
                                                                              GoogleFonts.firaSans(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Color(0xff686464),
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                        CustomButton(
                                                                          width:
                                                                              182,
                                                                          height:
                                                                              46,
                                                                          text:
                                                                              AppString.continuebutton,
                                                                          borderRadius:
                                                                              28,
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => LoginScreen()),
                                                                            );
                                                                          },
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          } catch (e) {
                                                            AlertDialog(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              content:
                                                                  Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            25),
                                                                height: 400,
                                                                width: 500,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      AppString
                                                                          .threetimepasscanchange,
                                                                      style: GoogleFonts
                                                                          .firaSans(
                                                                        fontSize:
                                                                            30,
                                                                        color: Color(
                                                                            0xff686464),
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      AppString
                                                                          .cannotchangepass,
                                                                      style: GoogleFonts
                                                                          .firaSans(
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0xff686464),
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    CustomButton(
                                                                      width:
                                                                          182,
                                                                      height:
                                                                          46,
                                                                      text:
                                                                          'CONTINUE',
                                                                      borderRadius:
                                                                          28,
                                                                      onPressed:
                                                                          () {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => LoginScreen()),
                                                                        );
                                                                      },
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                            print(
                                                                'Error occurred while confirming password: $e');
                                                            // Handle error
                                                          }
                                                          finally{
                                                            setState(() {
                                                              _isUpdatingPassword = false;
                                                            });
                                                          }
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                if (_errorMessage != null)
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0),
                                                    child: Text(
                                                      _errorMessage!,
                                                      style: TextStyle(
                                                          color: Colors.red),
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
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 60,
                                ),

                                ///back to login text
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width /
                                          4.5),
                                  child: GestureDetector(
                                    onTap: () {
                                     // updatePassword();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginScreen()),
                                      );
                                    },
                                    child: Text(
                                      AppString.backtologin,
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
