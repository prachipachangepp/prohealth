
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../../app/services/api/managers/hr_module_manager/progress_form_manager/onboarding_verifyuser_manager.dart';
import '../../taxtfield_constant.dart';
import 'on_boarding_welcome.dart';


class VerifyUserpopup extends StatefulWidget {
  @override
  VerifyUserpopupState createState() => VerifyUserpopupState();
}
class VerifyUserpopupState extends State<VerifyUserpopup> {


  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode otpFocusNode = FocusNode();

  bool otpEnabled = false;
  bool emailEntered = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height:  MediaQuery.of(context).size.height*0.4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xff50B5E5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        const Icon(Icons.person_outline,
                            color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          AppString.verify_user,
                          style: GoogleFonts.firaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomTextFieldRegister(
                      focusNode: emailFocusNode,
                      onFieldSubmitted: (String value) {
                        FocusScope.of(context).requestFocus(otpFocusNode);
                      },
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.width / 5,
                      controller: emailController,
                      labelText: 'Email',
                      keyboardType: TextInputType.text,
                      padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
                      onChanged: (value) {
                        setState(() {
                          emailEntered = value.isNotEmpty;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email address';
                        } else if (!RegExp(
                            r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      // // Ensure minimum size when empty
                      // minWidth: MediaQuery.of(context).size.width / 5,
                      // minHeight: MediaQuery.of(context).size.height / 20,
                    ),


                    // CustomTextFieldRegister(
                    //   focusNode: emailFocusNode,
                    //   onFieldSubmitted: (String value) {
                    //     FocusScope.of(context).requestFocus(otpFocusNode);
                    //   },
                    //   height:MediaQuery.of(context).size.height / 20,
                    //   width: MediaQuery.of(context).size.width / 5,
                    //   controller: emailController,
                    //   labelText: 'Email',
                    //   keyboardType: TextInputType.text,
                    //   padding: const EdgeInsets.only(
                    //       bottom: AppPadding.p5, left: AppPadding.p20),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       emailEntered = value.isNotEmpty;
                    //     });
                    //   },
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter an email address';
                    //     } else if (!RegExp(
                    //         r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                    //         .hasMatch(value)) {
                    //       return 'Please enter a valid email address';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    const SizedBox(height: 20),
                    isLoading
                        ? SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        color: ColorManager.blueprime,
                      ),
                    )
                        : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF50B5E5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      onPressed: emailEntered
                          ? () async {
                        setState(() {
                          isLoading = true;
                          otpEnabled = true;
                        });
                        await postverifyuser(
                            context, emailController.text);
                        Future.delayed(
                          const Duration(seconds: 2),
                              () {
                            setState(() {
                              isLoading = false;
                            });
                          },
                        );
                      }
                          : null,
                      child: const Text('Enter OTP'),
                    ),
                    const SizedBox(height: 20),
                    CustomTextFieldRegister(
                      height:MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.width / 5,
                      controller: otpController,
                      labelText: 'Enter OTP',
                      enabled: otpEnabled,
                      keyboardType: TextInputType.number,
                      padding: const EdgeInsets.only(
                          bottom: AppPadding.p5, left: AppPadding.p20),
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter OTP';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF50B5E5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      onPressed: otpEnabled //&& otpController.text.isNotEmpty
                          ? ()async {
                        if (_formKey.currentState!.validate())  {
                          String email = emailController.text;
                           String otp = otpController.text;
                          print('Email: $email, OTP: $otp');
                           showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return   Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0),
                                ),
                                child: OnBoardingCongratulation(),
                              );
                            },
                          );
                        }else(){
                          return const Text("password is not correct");
                        };
                      }
                          : null,
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
//



//////////////////////////
/////////////////
//////
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/color.dart';
//
// import '../../../../../../app/resources/const_string.dart';
// import '../../../../../../app/resources/value_manager.dart';
// import '../../../../../../app/services/api/managers/hr_module_manager/progress_form_manager/onboarding_verifyuser_manager.dart';
// //import '../../../../../widgets/widgets/constant_textfield/const_textfield.dart';
// import '../../taxtfield_constant.dart';
// import 'on_boarding_welcome.dart';
//
// class EnterEmailAndOTPDialog extends StatefulWidget {
//   @override
//   _EnterEmailAndOTPDialogState createState() => _EnterEmailAndOTPDialogState();
// }
//
// class _EnterEmailAndOTPDialogState extends State<EnterEmailAndOTPDialog> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController otpController = TextEditingController();
//
//   final _formKey = GlobalKey<FormState>();
//
//   FocusNode emailFocusNode = FocusNode();
//   FocusNode Otpbutton = FocusNode();
//
//   bool otpEnabled = false;
//   bool emailEntered = false;
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       backgroundColor: Colors.white,
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.3,
//         height: 300,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Container(
//               height: 50,
//               decoration: const BoxDecoration(
//                 color: Color(0xff50B5E5),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(13),
//                   topRight: Radius.circular(13),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 16),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.person_outline,
//                             color: Colors.white, size: 20),
//                         const SizedBox(width: 8),
//                         Text(
//                           AppString.verify_user,
//                           style: GoogleFonts.firaSans(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.close, color: Colors.white),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Form(
//                 key: _formKey,
//                 // autovalidateMode: AutovalidateMode.onUserInteraction,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     CustomTextFieldRegister(
//                       focusNode: emailFocusNode,
//                       onFieldSubmitted: (String value) {
//                         FocusScope.of(context).requestFocus(Otpbutton);
//                       },
//                       height: AppSize.s35,
//                       width: MediaQuery.of(context).size.width / 5,
//                       controller: emailController,
//                       labelText: 'Email',
//                       keyboardType: TextInputType.text,
//                       padding: const EdgeInsets.only(
//                           bottom: AppPadding.p5, left: AppPadding.p20),
//                       onChanged: (value) {
//                         setState(() {
//                           emailEntered = value
//                               .isNotEmpty; // Update emailEntered based on email field
//                         });
//                       },
//                       validator: (value) {
//                         if (value != null) {
//                           return 'Please enter an email address';
//                         } else if (!RegExp(
//                                 r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
//                             .hasMatch(value!)) {
//                           return 'Please enter a valid email address';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     isLoading
//                         ? SizedBox(
//                             height: 25,
//                             width: 25,
//                             child: CircularProgressIndicator(
//                               color: ColorManager.blueprime,
//                             ))
//                         : ElevatedButton(
//                             focusNode: Otpbutton,
//                             autofocus: true,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF50B5E5),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(6.0),
//                               ),
//                             ),
//                             onPressed: emailEntered
//                                 ? () async {
//                                     setState(() {
//                                       isLoading = true;
//                                       otpEnabled = true;
//                                     });
//                                     await postverifyuser(
//                                         context, emailController.text);
//                                     Future.delayed(const Duration(seconds: 2),
//                                         () {
//                                       setState(() {
//                                         isLoading = false;
//                                       });
//                                     });
//                                   }
//                                 : null,
//                             child: const Text('Enter OTP'),
//                           ),
//                     const SizedBox(height: 20),
//                     Column(
//                       children: <Widget>[
//                         CustomTextFieldRegister(
//                           height: AppSize.s35,
//                           width: MediaQuery.of(context).size.width / 5,
//                           controller: otpController,
//                           labelText: 'Enter OTP',
//                           enabled: otpEnabled,
//                           keyboardType: TextInputType.number,
//                           padding: const EdgeInsets.only(
//                               bottom: AppPadding.p5, left: AppPadding.p20),
//                           onChanged: (value) {},
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return AppString.enterText;
//                             }
//                             return null;
//                           },
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF50B5E5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(6.0),
//                         ),
//                       ),
//                       onPressed: otpEnabled
//                           ? () {
//                               if (_formKey.currentState!.validate() &&
//                                   otpController.text.isEmpty) {
//                                 // widget.onSavePressed();
//                               } else {
//                                 print(" wait");
//                                 // setState(() {
//                                 //   _documentUploaded = widget.AcknowledgementnameController.text.isNotEmpty;
//                                 // });
//                               }
//                               String email = emailController.text;
//                               String otp = otpController.text;
//                               print('Email: $email, OTP: $otp');
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return Dialog(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20.0),
//                                     ),
//                                     child: OnBoardingCongratulation(),
//                                   );
//                                 },
//                               );
//                             }
//                           : null,
//                       child: const Text('Submit'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

/////////////////

////
