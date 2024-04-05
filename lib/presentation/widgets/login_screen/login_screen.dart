import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prohealth/app/services/api/log_in/log_in_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/login_screen/forgot_screen/forgot_pass_screen.dart';
import 'package:prohealth/presentation/widgets/login_screen/sub_login_page.dart';
import 'package:prohealth/presentation/widgets/login_screen/widgets/login_flow_base_struct.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  PageController _pageController = PageController();
  int _selectedIndex = -1;
  FocusNode fieldOne = FocusNode();
  FocusNode fieldTow = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  String? _errorMessage;
  bool _showEmailInput = true;
  // bool _isLoading = false;
  bool _loginSuccessful = false;
  void _navigateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _handleSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _navigateToPage(index);
  }

  /// log in screen method api call
  Future<void> _loginWithEmail() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter username and password.';
      });
      return;
    }

    String username = _emailController.text.trim();
    String password = _passwordController.text.trim();

    LoginManager loginManager = LoginManager();
    try {
      await loginManager.login(username: username, password: password);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => SubLoginScreen()),
      // );
    } catch (e) {
      print('Login failed: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginBaseConstant(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ForgotPassScreen()));
      },
      // child2: null,
      titleText: 'Log In',
      textAction: 'Forgot your account password ?',
      textActionPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 5.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Headings
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 120,
                vertical: MediaQuery.of(context).size.width / 150),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 120),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _handleSelected(0);
                    },
                    child: Column(
                      children: [
                        Text(
                          "Login with Email",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width / 90,
                            color: _selectedIndex == 0
                                ? Colors.blue
                                : const Color(0xff686464),
                          ),
                        ),
                        const SizedBox(height: 5),
                        _selectedIndex == 0
                            ? Container(
                                width: MediaQuery.of(context).size.width / 12,
                                height: 2,
                                color: Colors.blue,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _handleSelected(1);
                    },
                    child: Column(
                      children: [
                        Text(
                          "Login with Authenticator",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width / 90,
                            color: _selectedIndex == 1
                                ? Colors.blue
                                : const Color(0xff686464),
                          ),
                        ),
                        const SizedBox(height: 5),
                        _selectedIndex == 1
                            ? Container(
                                width: MediaQuery.of(context).size.width / 8,
                                height: 2,
                                color: Colors.blue,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          ///todo prachi
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 99),
              child: PageView(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                children: [
                  /// Page 1: Log in with mail
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 4,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: TextFormField(
                              cursorColor: Colors.black,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelText: 'Email',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Email';
                                }
                                return null;
                              },
                            ),
                          ),
                          // SizedBox(height: 10),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: TextFormField(
                              cursorColor: Colors.black,
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  icon: _isPasswordVisible
                                      ? Icon(Icons.visibility_off_outlined,color: Color(0xffACA5BB),)
                                      : Icon(Icons.visibility_outlined,color: Color(0xffACA5BB),),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Password';
                                }
                                return null;
                              },
                              obscureText: !_isPasswordVisible,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 120,
                          ),
                          _isLoading
                              ? Center(
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    width:
                                        MediaQuery.of(context).size.height / 14,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : !_loginSuccessful
                                  ? Center(
                                      child: CustomButton(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                20,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                8,
                                        text: 'LogIn',
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              _isLoading = true;
                                              _errorMessage = null;
                                            });
                                            _loginWithEmail();
                                          }
                                          print('Button pressed!');
                                        },
                                      ),
                                    )
                                  : SizedBox(),
                          if (_errorMessage != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 99,
                              ),
                              child: Text(
                                _errorMessage!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  /// Page 2: Log in with authenticator
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 4,
                    // color: Colors.blue,
                    child: Center(
                      child: Column(

                        children: _showEmailInput
                            ? [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20),
                            child: TextField(
                              controller: _emailController,
                              cursorHeight: 25,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(fontSize: 14),
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height:
                            MediaQuery.of(context).size.height / 15,
                          ),
                          Center(
                            child: CustomButton(
                                height:
                                MediaQuery.of(context).size.height /
                                    20,
                                width:
                                MediaQuery.of(context).size.height /
                                    8,
                                onPressed: () {
                                  setState(() {
                                    _showEmailInput = false;
                                  });
                                },
                                text: 'Next'),
                          )
                        ]
                            : [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              4,
                                  (index) => Container(
                                width: MediaQuery.of(context).size.width/35,
                                height: 40,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  // border: Border.all(
                                  //   color: Color(0xff9BADCA),
                                  //   width: 0.55,
                                  // ),
                                ),
                                child: TextField(
                                  cursorColor: Colors.black,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  ],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black,width: 2),
                                ),
                                  ),
                                  onChanged: (value) {},
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height:
                            MediaQuery.of(context).size.height / 20,
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'FiraSans',
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
                                  style: TextStyle(color: Color(0xff50B5E5)),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
                                    },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height:
                            MediaQuery.of(context).size.height / 20,
                          ),
                          Center(
                            child: CustomButton(
                                height:
                                MediaQuery.of(context).size.height /
                                    20,
                                width:
                                MediaQuery.of(context).size.height /
                                    8,
                                onPressed: () {
                                  setState(() {
                                    _showEmailInput = false;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SubLoginScreen()),
                                  );
                                },
                                text: 'LogIn'),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Form(
//   key: _formKey,
//   child: Column(
//     children: [
//       Padding(
//         padding:
//             EdgeInsets.symmetric(
//                 horizontal: 20),
//         child: TextFormField(
//           controller:
//               _emailController,
//           keyboardType:
//               TextInputType
//                   .emailAddress,
//           decoration:
//               InputDecoration(
//             labelText: 'Email',
//             labelStyle: TextStyle(
//                 fontSize: 14),
//             border:
//                 UnderlineInputBorder(),
//           ),
//           validator: (value) {
//             if (value == null ||
//                 value.isEmpty) {
//               return "Enter Email";
//             }
//             final bool emailValid =
//                 RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                     .hasMatch(
//                         value);
//             if (!emailValid) {
//               return "Enter Valid Email";
//             }
//             return null;
//           },
//         ),
//       ),
//       SizedBox(height: 10),
//       Padding(
//         padding:
//             EdgeInsets.symmetric(
//                 horizontal: 20),
//         child: TextFormField(
//           controller:
//               _passwordController,
//           keyboardType:
//               TextInputType
//                   .visiblePassword,
//           decoration:
//               InputDecoration(
//             labelText: 'Password',
//             labelStyle: TextStyle(
//                 fontSize: 14),
//             border:
//                 UnderlineInputBorder(),
//             suffixIcon: IconButton(
//               icon: _isPasswordVisible
//                   ? Icon(Icons
//                       .visibility_off)
//                   : Icon(Icons
//                       .visibility),
//               onPressed: () {
//                 setState(() {
//                   _isPasswordVisible =
//                       !_isPasswordVisible;
//                 });
//               },
//             ),
//           ),
//           validator: (value) {
//             if (value == null ||
//                 value.isEmpty) {
//               return "Enter Password";
//             } else if (value
//                     .length <
//                 6) {
//               return "Password should be at least 6 characters long";
//             }
//             return null;
//           },
//           obscureText:
//               !_isPasswordVisible,
//         ),
//       ),
//       SizedBox(height: 5),
//       _isLoading
//           ? CircularProgressIndicator()
//           : _loginSuccessful
//               ? CircularProgressIndicator()
//               : CustomButton(
//                   text: 'Log In',
//                   onPressed: () {
//                     if (_formKey
//                         .currentState!
//                         .validate()) {
//                       setState(() {
//                         _isLoading =
//                             true;
//                       });
//                       _loginWithEmail();
//                     }
//                   },
//                   width: 90.0,
//                   height: 30.0,
//                 ),
//     ],
//   ),
// ),
