import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/managers/auth/auth_manager.dart';
import 'package:prohealth/presentation/widgets/mobile_constant/mobile_const.dart';
import '../../../../../app/constants/app_config.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/login_resources/login_flow_theme_const.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../widgets/widgets/profile_bar/widget/screen_transition.dart';
import '../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../login/login_screen.dart';

class MobileUpdatePass extends StatefulWidget {
  final String email;
  final String otp;
  const MobileUpdatePass({Key? key, required this.email, required this.otp});

  @override
  State<MobileUpdatePass> createState() => _MobileUpdatePassState();
}

class _MobileUpdatePassState extends State<MobileUpdatePass> {
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

  Future<void> updatePassword(String email, String otp) async {
    String newPassword = newPasswordController.text;
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "email": email,
        "verificationCode": otp,
        "newPassword": newPassword
      });

      var response = await Dio().post(
        '${AppConfig.endpoint}/auth/ResetPassword',
        // http://54.245.136.133:3000/auth/ResetPassword
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
    return  MobileConst(
      onTap: () {
        Navigator.push(
          context,
          RouteTransitions.slideTransition(page: LoginScreen()),
        );
      },
      textAction: AppString.backtologin,
      titleText: AppString.newPass,
      containerHeight: MediaQuery.of(context).size.height /
          1.6, // specify desired height
      containerWidth: MediaQuery.of(context).size.width / 1.1,
      mobileChild: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                AppString.setnewPassword,
                style: CustomTextStylesCommon.commonStyle(
                    color: ColorManager.mediumgrey,
                    fontSize: FontSize.s10,
                    // fontSize: MediaQuery.of(context).size.width/33,
                    fontWeight: FontWeight.w500),
              ),
              TextFormField(
                style: CustomTextStylesCommon.commonStyle(
                  color: ColorManager.black.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.s14,
                ),
                focusNode: newPasswordFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context)
                      .requestFocus(confirmPasswordFocusNode);
                },
                cursorHeight: 22,
                obscuringCharacter: '*',
                controller: controllerNew,
                cursorColor: Colors.black,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: AppPadding.p2),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: AppSize.s15,
                      color: ColorManager.whitesheed,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  labelText: AppString.newPass,
                  labelStyle: EmailTextStyle.enterEmail(context),
                  hintText: AppString.enternewpass,
                  hintStyle: EmailTextStyle.enterEmail(context),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorManager.black.withOpacity(0.5),
                        width: 0.5),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.grey),
                  ),
                  errorStyle: CustomTextStylesCommon.commonStyle(
                    color: ColorManager.red,
                    fontSize: FontSize.s10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppString.enterpass;
                  }
                  return null;
                },
              ),
              TextFormField(
                focusNode: confirmPasswordFocusNode,
                onFieldSubmitted: (_) {
                  // _showSuccessDialog();
                },
                cursorHeight: 22,
                obscuringCharacter: '*',
                controller: controllerConfirm,
                style: CustomTextStylesCommon.commonStyle(
                  color: ColorManager.black.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.s14,
                ),
                cursorColor: ColorManager.black,
                obscureText: _obscureTextconfirm,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 2),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureTextconfirm
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: AppSize.s15,
                      color: ColorManager.whitesheed,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureTextconfirm = !_obscureTextconfirm;
                      });
                    },
                  ),
                  labelText: AppString.confmpass,
                  labelStyle: EmailTextStyle.enterEmail(context),
                  hintText: AppString.enterconfmpass,
                  hintStyle: EmailTextStyle.enterEmail(context),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorManager.black.withOpacity(0.5),
                        width: 0.5),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.grey),
                  ),
                  errorStyle: CustomTextStylesCommon.commonStyle(
                    color: ColorManager.red,
                    fontSize: FontSize.s10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppString.enterconfmpass;
                  }
                  return null;
                },
              ),

              ///button
              Center(
                child: _isUpdatingPassword
                    ? CircularProgressIndicator(
                    color: ColorManager.blueprime)
                    : CustomButton(
                  borderRadius: 23.82,
                  height: MediaQuery.of(context).size.height / 24,
                  width: MediaQuery.of(context).size.width / 2.6,
                  paddingVertical: AppPadding.p5,
                  text: AppString.updatepass,
                  style: CustomTextStylesCommon.commonStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeight.w700,
                  ),
                  backgroundColor: ColorManager.blueprime,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (controllerNew.text !=
                          controllerConfirm.text) {
                        setState(() {
                          _errorMessage = AppString.passdontmatch;
                        });
                        return;
                      }
                      setState(() {
                        _isUpdatingPassword = true;
                      });
                      try {
                        await AuthManager().confirmPassword(
                            widget.email,
                            widget.otp,
                            controllerNew.text,
                            context);
                        print('${widget.email}');
                        print('${controllerNew.text}');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: ColorManager.white,
                              content: Container(
                                padding: EdgeInsets.only(
                                    top: AppPadding.p25),
                                height: AppSize.s300,
                                width: AppSize.s400,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'images/upload.png',
                                      width: AppSize.s88,
                                      height: AppSize.s88,
                                    ),
                                    Text(
                                      AppString.successfully,
                                      style: CustomTextStylesCommon
                                          .commonStyle(
                                        color:
                                        ColorManager.mediumgrey,
                                        fontSize: FontSize.s18,
                                        fontWeight:
                                        FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      AppString.resetsuccessfully,
                                      style: CustomTextStylesCommon
                                          .commonStyle(
                                        color:
                                        ColorManager.mediumgrey,
                                        fontSize: FontSize.s10,
                                        fontWeight:
                                        FontWeight.w500,
                                      ),
                                    ),
                                    CustomButton(
                                      width: AppSize.s181,
                                      height: AppSize.s35,
                                      text: AppString.continuebutton,
                                      style: CustomTextStylesCommon
                                          .commonStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.s10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      borderRadius: 19.37,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()),
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
                        // AlertDialog(
                        //   backgroundColor:
                        //   ColorManager.white,
                        //   content:
                        //   Container(
                        //     padding: EdgeInsets.only(top: AppPadding.p10),
                        //     height: AppSize.s300,
                        //     width: AppSize.s400,
                        //     child:
                        //     Column(
                        //       mainAxisAlignment:
                        //       MainAxisAlignment
                        //           .spaceEvenly,
                        //       crossAxisAlignment:
                        //       CrossAxisAlignment
                        //           .center,
                        //       children: [
                        //         Text(
                        //           AppString
                        //               .threetimepasscanchange,
                        //           style:
                        //           GoogleFonts.firaSans(
                        //             fontSize:
                        //             FontSize.s30,
                        //             color:
                        //             Color(0xff686464),
                        //             fontWeight:
                        //             FontWeightManager.bold,
                        //           ),
                        //         ),
                        //         Text(
                        //           AppString
                        //               .cannotchangepass,
                        //           style: CustomTextStylesCommon.commonStyle(
                        //             color:ColorManager.darkgrey,
                        //             fontSize: FontSize.s12,
                        //             fontWeight: FontWeightManager.medium,
                        //           ),
                        //         ),
                        //         CustomButton(
                        //           width: AppSize.s181,
                        //           height: AppSize.s45,
                        //           text: AppString.continuebutton,
                        //           borderRadius:
                        //           24,
                        //           onPressed:
                        //               () {
                        //             Navigator.push(
                        //               context,
                        //               MaterialPageRoute(builder: (context) => MobileLogIn()),
                        //             );
                        //           },
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // );
                        print(
                            'Error occurred while confirming password: $e');
                        // Handle error
                      } finally {
                        setState(() {
                          _isUpdatingPassword = false;
                        });
                      }
                    }
                  },
                ),
              ),
              if (_errorMessage != null)
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 80),
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
