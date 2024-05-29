// import 'package:flutter/material.dart';
// import 'package:prohealth/app/resources/const_string.dart';
// import 'package:prohealth/presentation/screens/tablet_module/login_screen_flow/tab_forgot_pass.dart';
// import 'package:prohealth/presentation/screens/tablet_module/tab_const.dart';
//
// import '../../../../app/resources/color.dart';
// import '../../../../app/resources/font_manager.dart';
// import '../../../../app/resources/theme_manager.dart';
// import '../../../../app/resources/value_manager.dart';
// import '../../../../app/services/login_flow_api/log_in/log_in_manager.dart';
// import '../../desktop_module/hr_module/manage/widgets/custom_icon_button_constant.dart';
// import '../../desktop_module/widgets/profile_bar/widget/screen_transition.dart';
//
// class TabPassLoginScreen extends StatefulWidget {
//   final String email;
//   const TabPassLoginScreen({super.key, required this.email});
//
//   @override
//   State<TabPassLoginScreen> createState() => _TabPassLoginScreenState(email: email);
// }
//
// class _TabPassLoginScreenState extends State<TabPassLoginScreen> {
//   final String email;
//   bool _isLoading = false;
//   String? _errorMessage;
//   _TabPassLoginScreenState({required this.email});
//   final TextEditingController _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
//   bool _obscureText = true;
//
//   void _login() {
//     if (_formKey.currentState?.validate() ?? false) {
//       setState(() {
//         _isLoading = true;
//         _errorMessage = null;
//       });
//
//       AuthService.loginWithEmail(
//         context,
//         widget.email,
//         _passwordController,
//         true,
//             (isLoading) {
//           setState(() {
//             _isLoading = isLoading;
//           });
//         },
//             (errorMessage) {
//           setState(() {
//             _errorMessage = errorMessage;
//             _isLoading = false;
//           });
//         },
//       );
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return LoginBaseConstTab(
//         titleText: AppString.login,
//         onTap: (){
//           Navigator.push(
//             context,
//             RouteTransitions.slideTransition(page: TabForgotPassScreen()),
//           );
//         },
//         textAction: AppString.forgotpass,
//       childTab: Container(
//         height: MediaQuery.of(context).size.height/3.5,
//         width: MediaQuery.of(context).size.width/2,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(25)
//         ),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: MediaQuery.of(context).size.width / 30,
//               ),
//               child: TextFormField(
//                 style: CustomTextStylesCommon.commonStyle(
//                   color: ColorManager.black.withOpacity(0.5),
//                   fontWeight: FontWeightManager.medium,
//                   fontSize: FontSize.s14,
//                 ),
//                 onFieldSubmitted: (_) {
//                   _login();
//                 },
//                 obscuringCharacter: '*',
//                 controller: _passwordController,
//                 cursorColor: ColorManager.black,
//                 cursorHeight: 22,
//                 obscureText: _obscureText,
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.only(top: AppPadding.p1),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                       color: ColorManager.black.withOpacity(0.5),
//                       width: 0.5,
//                     ),
//                   ),
//                   hintText: AppString.enterpass,
//                   hintStyle:  EmailTextStyle.enterEmail(context),
//                   labelText: AppString.password,
//                   labelStyle: EmailTextStyle.enterEmail(context),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _obscureText
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                       color: Colors.grey,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _obscureText = !_obscureText;
//                       });
//                     },
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return AppString.enterpass;
//                   }
//                   return null;
//                 },
//               ),
//             ),
//             ///button
//             _isLoading
//                 ? CircularProgressIndicator(
//               color: ColorManager.blueprime,
//             )
//                 : CustomButton(
//               borderRadius: 24,
//               height: MediaQuery.of(context).size.height / 18,
//               width: MediaQuery.of(context).size.height / 4,
//               text: AppString.loginbtn,
//               onPressed: _isLoading ? () {} : _login,
//             ),
//             if (_errorMessage != null)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
//                 child: Text(
//                   _errorMessage!,
//                   style: TextStyle(color: ColorManager.red),
//                 ),
//               ),
//           ],
//         ),
//       ),
//
//       ),);
//   }
// }
