import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../../app/services/login_flow_api/confirm_pass/confirm_pass_manager.dart';
import '../../../../../../constants/app_config.dart';
import '../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../profile_bar/widget/screen_transition.dart';
import '../login_screen.dart';
import '../widgets/login_flow_base_struct.dart';

class NewPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;
  NewPasswordScreen({required this.email, required this.otp});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController controllerNew = TextEditingController();
  final TextEditingController controllerConfirm = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  bool _obscureText = true;
  bool _obscureTextconfirm = true;
  String? _errorMessage;
  bool _isUpdatingPassword = false;
  final _formKey = GlobalKey<FormState>();

  // void _showSuccessDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: ColorManager.white,
  //         content: Container(
  //           padding: EdgeInsets.only(top: AppPadding.p25),
  //           height: AppSize.s300,
  //           width: AppSize.s400,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Image.asset(
  //                 'images/upload.png',
  //                 width: AppSize.s120,
  //                 height: AppSize.s120,
  //               ),
  //               Text(
  //                 AppString.successfully,
  //                 style: CustomTextStylesCommon.commonStyle(
  //                   color: ColorManager.darkgrey,
  //                   fontSize: FontSize.s30,
  //                   fontWeight: FontWeightManager.extrabold,
  //                 ),
  //               ),
  //               Text(
  //                 AppString.resetsuccessfully,
  //                 style: CustomTextStylesCommon.commonStyle(
  //                   color: ColorManager.darkgrey,
  //                   fontSize: FontSize.s12,
  //                   fontWeight: FontWeightManager.medium,
  //                 ),
  //               ),
  //               CustomButton(
  //                 width: AppSize.s181,
  //                 height: AppSize.s45,
  //                 text: AppString.continuebutton,
  //                 borderRadius: 24,
  //                 onPressed: () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (context) => LoginScreen()),
  //                   );
  //                 },
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<void> updatePassword( String email, String otp) async {
    String newPassword = newPasswordController.text;
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "email": email,
        "verificationCode": otp,
        "newPassword": newPassword
      });

      var response = await Dio().post(
        '${AppConfig.endpoint}/auth/confirmPassword',
        data: data,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        print(AppString.resetsuccessfully);
        print(json.encode(response.data));
        Navigator.pop(context as BuildContext);
      } else {
        print('Failed to change password: ${response.statusMessage}');
        print(json.encode(response.data));
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return LoginBaseConstant(
      onTap: () {
        Navigator.push(
          context,
          RouteTransitions.slideTransition(page: LoginScreen()),
        );
      },
      textAction: AppString.backtologin,
      titleText: AppString.newPass,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: MediaQuery.of(context).size.width / 3.6,
          height: MediaQuery.of(context).size.height / 2.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: ColorManager.white,
          ),
          child:  Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.setnewPassword,
                    style: CustomTextStylesCommon.commonStyle(
                      color:
                      ColorManager.mediumgrey,
                      fontSize: FontSize.s10,
                      fontWeight: FontWeightManager.semiBold,
                    ),
                  ),
                  ///txtfield
                  TextFormField(
                    style: CustomTextStylesCommon.commonStyle(
                      color: ColorManager.black.withOpacity(0.5),
                      fontWeight: FontWeightManager.medium,
                      fontSize: FontSize.s14,
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
                      const EdgeInsets.only(top: AppPadding.p2),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons
                              .visibility_outlined
                              : Icons
                              .visibility_off_outlined,
                          size: AppSize.s15,
                          color: ColorManager.whitesheed,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText =
                            !_obscureText;
                          });
                        },
                      ),
                      labelText: AppString.newPass,
                      labelStyle: EmailTextStyle.enterEmail(context),
                      hintText: AppString.enternewpass,
                      hintStyle: EmailTextStyle.enterEmail(context),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorManager.black),
                      ),
                      focusedBorder:
                      UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorManager.black
                                .withOpacity(0.5),
                            width: 0.5),
                      ),
                      enabledBorder:
                      UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorManager.grey),
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty) {
                        return AppString.enterpass;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    focusNode:
                    confirmPasswordFocusNode,
                    onFieldSubmitted: (_) {
                      // _showSuccessDialog();
                    },
                    cursorHeight: 22,
                    obscuringCharacter: '*',
                    controller: controllerConfirm,
                    style: CustomTextStylesCommon.commonStyle(
                      color: ColorManager.black.withOpacity(0.5),
                      fontWeight: FontWeightManager.medium,
                      fontSize: FontSize.s14,
                    ),
                    cursorColor: ColorManager.black,
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
                          size: AppSize.s15,
                          color: ColorManager.whitesheed,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureTextconfirm =
                            !_obscureTextconfirm;
                          });
                        },
                      ),
                      labelText: AppString.confmpass,
                      labelStyle: EmailTextStyle.enterEmail(context),
                      hintText: AppString.enterconfmpass,
                      hintStyle: EmailTextStyle.enterEmail(context),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorManager.black),
                      ),
                      focusedBorder:
                      UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorManager.black
                                .withOpacity(0.5),
                            width: 0.5),
                      ),
                      enabledBorder:
                      UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorManager.grey),
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

                  ///button
                  Center(
                    child: _isUpdatingPassword
                        ? CircularProgressIndicator(
                        color: ColorManager
                            .blueprime)
                        : CustomButton(
                          width: MediaQuery.of(
                              context).size.width / 7,
                          height: MediaQuery.of(context).size.height / 22,
                          text: AppString.updatepass,
                          backgroundColor:  ColorManager.blueprime,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (controllerNew.text != controllerConfirm.text) {
                                setState(() {
                                  _errorMessage = AppString.passdontmatch;
                                });
                                return;
                              }
                              setState(() {
                                _isUpdatingPassword =
                                true;
                              });
                              try {
                                await ConfirmPassManager()
                                    .confirmPassword(
                                  widget.email,
                                  widget.otp,
                                  controllerNew.text,
                                );
                                print(
                                    '${widget.email}');
                                print(
                                    '${controllerNew.text}');
                                showDialog(
                                  context:
                                  context,
                                  builder:
                                      (BuildContext
                                  context) {
                                    return
                                      AlertDialog(
                                        backgroundColor:
                                        ColorManager.white,
                                        content:
                                        Container(
                                          padding:
                                          EdgeInsets.only(top: AppPadding.p25),
                                          height: AppSize.s300,
                                          width: AppSize.s400,
                                          child:
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'images/upload.png',
                                                width: AppSize.s120,
                                                height: AppSize.s120,
                                              ),
                                              Text(
                                                AppString.successfully,
                                                style: CustomTextStylesCommon.commonStyle(
                                                  color: ColorManager.darkgrey,
                                                  fontSize: FontSize.s30,
                                                  fontWeight: FontWeightManager.extrabold,
                                                ),
                                              ),
                                              Text(
                                                AppString.resetsuccessfully,
                                                style: CustomTextStylesCommon.commonStyle(
                                                  color: ColorManager.darkgrey,
                                                  fontSize: FontSize.s12,
                                                  fontWeight: FontWeightManager.medium,
                                                ),
                                              ),
                                              CustomButton(
                                                width: AppSize.s181,
                                                height: AppSize.s45,
                                                text: AppString.continuebutton,
                                                borderRadius: 24,
                                                onPressed: () {
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
                                  ColorManager.white,
                                  content:
                                  Container(
                                    padding: EdgeInsets.only(top: AppPadding.p10),
                                    height: AppSize.s300,
                                    width: AppSize.s400,
                                    child:
                                    Column(
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
                                          style:
                                          GoogleFonts.firaSans(
                                            fontSize:
                                            FontSize.s30,
                                            color:
                                            Color(0xff686464),
                                            fontWeight:
                                            FontWeightManager.bold,
                                          ),
                                        ),
                                        Text(
                                          AppString
                                              .cannotchangepass,
                                          style: CustomTextStylesCommon.commonStyle(
                                            color:ColorManager.darkgrey,
                                            fontSize: FontSize.s12,
                                            fontWeight: FontWeightManager.medium,
                                          ),
                                        ),
                                        CustomButton(
                                          width: AppSize.s181,
                                          height: AppSize.s45,
                                          text: AppString.continuebutton,
                                          borderRadius:
                                          24,
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
                                print(
                                    'Error occurred while confirming password: $e');
                                // Handle error
                              } finally {
                                setState(() {
                                  _isUpdatingPassword =
                                  false;
                                });
                              }
                            }
                          },
                        ),
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets
                          .symmetric(vertical: 8.0),
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
      ),
    );
  }
}