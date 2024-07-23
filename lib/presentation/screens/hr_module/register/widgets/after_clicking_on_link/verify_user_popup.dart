import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';

import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../../app/services/api/managers/hr_module_manager/progress_form_manager/onboarding_verify_user.dart';
//import '../../../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../taxtfield_constant.dart';
import 'on_boarding_welcome.dart';

class EnterEmailAndOTPDialog extends StatefulWidget {
  @override
  _EnterEmailAndOTPDialogState createState() => _EnterEmailAndOTPDialogState();
}

class _EnterEmailAndOTPDialogState extends State<EnterEmailAndOTPDialog> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode Otpbutton = FocusNode();

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
        height: 300,
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
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomTextFieldRegister(
                      focusNode: emailFocusNode,
                      onFieldSubmitted: (String value) {
                        FocusScope.of(context).requestFocus(Otpbutton);
                      },
                      height: AppSize.s35,
                      width: MediaQuery.of(context).size.width / 5,
                      controller: emailController,
                      labelText: 'Email',
                      keyboardType: TextInputType.text,
                      padding: const EdgeInsets.only(
                          bottom: AppPadding.p5, left: AppPadding.p20),
                      onChanged: (value) {
                        setState(() {
                          emailEntered = value
                              .isNotEmpty; // Update emailEntered based on email field
                        });
                      },
                      validator: (value) {
                        if (value != null) {
                          return 'Please enter an email address';
                        } else if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                            .hasMatch(value!)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    isLoading
                        ? SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: ColorManager.blueprime,
                            ))
                        : ElevatedButton(
                            focusNode: Otpbutton,
                            autofocus: true,
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
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                                  }
                                : null,
                            child: const Text('Enter OTP'),
                          ),
                    const SizedBox(height: 20),
                    Column(
                      children: <Widget>[
                        CustomTextFieldRegister(
                          height: AppSize.s35,
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
                              return AppString.enterText;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF50B5E5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      onPressed: otpEnabled
                          ? () {
                              // if (_formKey.currentState!.validate() &&
                              //     otpController.text.isEmpty) {
                              //   // widget.onSavePressed();
                              // } else {
                              //   print(" wait");
                              //   // setState(() {
                              //   //   _documentUploaded = widget.AcknowledgementnameController.text.isNotEmpty;
                              //   // });
                              // }
                              String email = emailController.text;
                              String otp = otpController.text;
                              print('Email: $email, OTP: $otp');
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: OnBoardingCongratulation(),
                                  );
                                },
                              );
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

/////////////////

////

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../../../../app/resources/const_string.dart';
// import '../../../../../../app/resources/value_manager.dart';
// import '../../../../../widgets/widgets/constant_textfield/const_textfield.dart';
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
//   bool otpEnabled = false;
//   bool emailEntered = false;
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       backgroundColor: Colors.white,
//       titlePadding: EdgeInsets.zero,
//       title: Container(
//         height: 50,
//         decoration: BoxDecoration(
//           color: Color(0xff50B5E5),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(13),
//             topRight: Radius.circular(13),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 16),
//               child: Row(
//                 children: [
//                   Icon(Icons.person_outline, color: Colors.white, size: 20),
//                   SizedBox(width: 8),
//                   Text(
//                     AppString.verify_user,
//                     style: GoogleFonts.firaSans(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.close, color: Colors.white),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           CustomTextFieldRegister(
//             height: AppSize.s35,
//             width: MediaQuery.of(context).size.width / 6,
//             controller: emailController,
//             labelText:'Email',
//             keyboardType: TextInputType.text,
//             padding: EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
//             onChanged: (value) {
//               setState(() {
//                 emailEntered = value.isNotEmpty; // Update emailEntered based on email field
//               });
//             },
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return AppString.enterText;
//               }
//               return null;
//             },
//           ),
//
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: emailEntered ? () {
//               setState(() {
//                 isLoading = true; // Step 2: Set loading state to true
//                 otpEnabled = true;
//               });
//               // Simulate API call delay (replace with actual API call)
//               Future.delayed(Duration(seconds: 2), () {
//                 setState(() {
//                   isLoading = false; // Step 3: Set loading state to false when done
//                 });
//               });
//             } : null, // Disable button if email not entered
//             child: isLoading ? CircularProgressIndicator() : Text('Enter OTP'), // Show loader if loading
//           ),
//           SizedBox(height: 20),
//           Column(
//             children: <Widget>[
//               CustomTextFieldRegister(
//                 height: AppSize.s35,
//                 width: MediaQuery.of(context).size.width / 6,
//                 controller: otpController,
//                 labelText:'Enter OTP',
//                 enabled: otpEnabled,
//                 keyboardType: TextInputType.text,
//                 padding: EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
//                 onChanged: (value) {},
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return AppString.enterText;
//                   }
//                   return null;
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         ElevatedButton(
//           onPressed: otpEnabled ? () {
//             // Handle OTP submission logic here
//             String email = emailController.text;
//             String otp = otpController.text;
//             print('Email: $email, OTP: $otp');
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return Dialog(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   child: OnBoardingCongratulation(),
//                 );
//               },
//             );
//           } : null, // Disable button if OTP not entered
//           child: Text('Submit'),
//         ),
//       ],
//     );
//   }
// }

/////////////////////////////////////raw///////////////////
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../../../../app/resources/const_string.dart';
// import '../../../../../../app/resources/value_manager.dart';
// import '../../../../../widgets/widgets/constant_textfield/const_textfield.dart';
// import '../../taxtfield_constant.dart';
//
// class EnterEmailAndOTPDialog extends StatefulWidget {
//   @override
//   _EnterEmailAndOTPDialogState createState() => _EnterEmailAndOTPDialogState();
// }
//
// class _EnterEmailAndOTPDialogState extends State<EnterEmailAndOTPDialog> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController otpController = TextEditingController();
//   bool otpEnabled = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       backgroundColor: Colors.white,
//       titlePadding: EdgeInsets.zero,
//       title: Container(
//         height: 50,
//         decoration: BoxDecoration(
//           color: Color(0xff50B5E5),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(13),
//             topRight: Radius.circular(13),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 16),
//               child: Row(
//                 children: [
//                   Icon(Icons.person_outline, color: Colors.white, size: 20),
//                   SizedBox(width: 8),
//                   Text(
//                     AppString.verify_user,
//                     style: GoogleFonts.firaSans(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.close, color: Colors.white),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           CustomTextFieldRegister(
//             height: AppSize.s35,
//             width: MediaQuery.of(context).size.width / 6,
//             controller: emailController,
//             labelText:'Email',
//
//             keyboardType: TextInputType.text,
//             padding:
//                 EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
//             onChanged: (value) {},
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return AppString.enterText;
//               }
//               return null;
//             },
//           ),
//
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 otpEnabled = true;
//               });
//             },
//             child: Text('Enter OTP'),
//           ),
//           SizedBox(height: 20),
//           Column(
//             children: <Widget>[
//
//               CustomTextFieldRegister(
//                 height: AppSize.s35,
//                 width: MediaQuery.of(context).size.width / 6,
//                 controller: otpController,
//                 labelText:'Enter OTP',
//                 enabled: otpEnabled,
//
//                 keyboardType: TextInputType.text,
//                 padding:
//                 EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
//                 onChanged: (value) {},
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return AppString.enterText;
//                   }
//                   return null;
//                 },
//               ),
//
//             ],
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         ElevatedButton(
//           onPressed: () {
//             // Handle OTP submission logic here
//             String email = emailController.text;
//             String otp = otpController.text;
//             print('Email: $email, OTP: $otp');
//             Navigator.of(context).pop();
//           },
//           child: Text('Submit'),
//         ),
//       ],
//     );
//   }
// }
///////////////////////////////////////////////////

// class EmailOtpDialog extends StatefulWidget {
//   @override
//   _EmailOtpDialogState createState() => _EmailOtpDialogState();
// }
//
// class _EmailOtpDialogState extends State<EmailOtpDialog> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();
//
//   bool otpSent = false; // Flag to track whether OTP has been sent
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Enter Email and OTP'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           TextField(
//             controller: emailController,
//             keyboardType: TextInputType.emailAddress,
//             decoration: InputDecoration(
//               hintText: 'Enter your email',
//             ),
//           ),
//           SizedBox(height: 20.0),
//           if (!otpSent) // Show OTP input only if OTP has not been sent
//             TextField(
//               controller: otpController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 hintText: 'Enter OTP',
//               ),
//             ),
//         ],
//       ),
//       actions: <Widget>[
//         if (!otpSent) // Show 'Send OTP' button if OTP has not been sent
//           TextButton(
//             onPressed: () {
//               // Simulate OTP sending logic (in real app, this would send OTP via email or SMS)
//               setState(() {
//                 otpSent = true;
//               });
//             },
//             child: Text('Send OTP'),
//           ),
//         ElevatedButton(
//           onPressed: () {
//             // Implement your submit logic here (could validate OTP, etc.)
//             String email = emailController.text;
//             String otp = otpController.text;
//
//             // For simplicity, just print email and OTP here
//             print('Email: $email, OTP: $otp');
//
//             // Close the dialog
//             Navigator.of(context).pop();
//           },
//           child: Text('Submit'),
//         ),
//       ],
//     );
//   }
// }
