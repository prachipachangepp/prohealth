import 'package:flutter/material.dart';
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SubLoginScreen()),
      );
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
      child: Column(
        children: [
          ///logo
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.height / 3),
                child: Image.asset(
                  'images/logo_login.png',
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 5,
                ),
              )
            ],
          ),
          // SizedBox(
          //   height: ,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height / 10),
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontFamily: 'FiraSans',
                        color: Color(0xff686464),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 100,
                  ),

                  ///todo prachi
                  Material(
                    elevation: 9,
                    borderRadius: BorderRadius.circular(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3.3,
                          height: MediaQuery.of(context).size.height / 2.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Headings
                              Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 120),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width / 70),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    80,
                                                color: _selectedIndex == 0
                                                    ? Colors.blue
                                                    : const Color(0xff686464),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            _selectedIndex == 0
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            12,
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
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    80,
                                                color: _selectedIndex == 1
                                                    ? Colors.blue
                                                    : const Color(0xff686464),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            _selectedIndex == 1
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
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
                                      horizontal:
                                          MediaQuery.of(context).size.width /
                                              99),
                                  child: PageView(
                                    controller: _pageController,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      /// Page 1: Log in with mail
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.1,
                                                  child: TextFormField(
                                                    controller:
                                                        _emailController,
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    decoration: InputDecoration(
                                                      labelText: 'Email',
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Enter Email';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.1,
                                                  child: TextFormField(
                                                    controller:
                                                        _passwordController,
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                    decoration: InputDecoration(
                                                      labelText: 'Password',
                                                      suffixIcon: IconButton(
                                                        icon: _isPasswordVisible
                                                            ? Icon(Icons
                                                                .visibility_off)
                                                            : Icon(Icons
                                                                .visibility),
                                                        onPressed: () {
                                                          setState(() {
                                                            _isPasswordVisible =
                                                                !_isPasswordVisible;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Enter Password';
                                                      }
                                                      return null;
                                                    },
                                                    obscureText:
                                                        !_isPasswordVisible,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      99,
                                                ),
                                                _isLoading
                                                    ? CircularProgressIndicator(
                                                        strokeWidth: 2.0,
                                                      )
                                                    : !_loginSuccessful
                                                        ? CustomButton(
                                                            text: 'Log In',
                                                            onPressed: () {
                                                              if (_formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                setState(() {
                                                                  _isLoading =
                                                                      true;
                                                                  _errorMessage =
                                                                      null;
                                                                });
                                                                _loginWithEmail();
                                                              }
                                                              print(
                                                                  'Button pressed!');
                                                            },
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                10,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                22,
                                                          )
                                                        : SizedBox(),
                                                if (_errorMessage != null)
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              99,
                                                    ),
                                                    child: Text(
                                                      _errorMessage!,
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          )),

                                      /// Page 2: Log in with authenticator
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        // color: Colors.blue,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: TextField(
                                                  cursorHeight: 25,
                                                  decoration: InputDecoration(
                                                    labelText: 'Email',
                                                    labelStyle:
                                                        TextStyle(fontSize: 14),
                                                    border:
                                                        UnderlineInputBorder(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    99,
                                              ),
                                              CustomButton(
                                                  text: 'Next',
                                                  onPressed: () {},
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      22)
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 80,
                  ),

                  ///forget password text
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassScreen()));
                      },
                      child: const Text(
                        'Forgot your account password ?',
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
              // SizedBox(width: MediaQuery.of(context).size.width / 8),
              Image.asset(
                'images/amico.png',
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 2,
              )
            ],
          )
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
