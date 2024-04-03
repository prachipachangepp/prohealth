import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/log_in/log_in_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/login_screen/sub_login_page.dart';
import 'package:prohealth/presentation/widgets/login_screen/widgets/login_flow_base_struct.dart';

import 'forgot_screen/forgot_pass_screen.dart';

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

  // Future<void> _loginWithEmail() async {
  //   String username = _emailController.text.trim();
  //   String password = _passwordController.text.trim();
  //
  //   LoginManager loginManager = LoginManager();
  //   try {
  //     await loginManager.login(username: username, password: password);
  //     Navigator.push(context,
  //         MaterialPageRoute(builder: (context) => const SubLoginScreen()));
  //   } catch (e) {
  //     print('Login failed: $e');
  //   }
  // }
  Future<void> _loginWithEmail() async {
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
                left: MediaQuery.of(context).size.width / 15,
                right: MediaQuery.of(context).size.width / 12,
                top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 80.0),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontFamily: 'FiraSans',
                          color: Color(0xff686464),
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    ///todo prachi
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        width: 380,
                        height: 280,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 380,
                              height: 280,
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
                                        MediaQuery.of(context).size.width /
                                            120),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8),
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
                                                    fontSize: 15,
                                                    color: _selectedIndex == 0
                                                        ? Colors.blue
                                                        : const Color(
                                                            0xff686464),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                _selectedIndex == 0
                                                    ? Container(
                                                        width: MediaQuery.of(
                                                                    context)
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
                                                    fontSize: 15,
                                                    color: _selectedIndex == 1
                                                        ? Colors.blue
                                                        : const Color(
                                                            0xff686464),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                _selectedIndex == 1
                                                    ? Container(
                                                        width: MediaQuery.of(
                                                                    context)
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
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              99),
                                      child: PageView(
                                        controller: _pageController,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          /// Page 1: Log in with mail
                                          Container(
                                            width: 380,
                                            height: 200,
                                            child: Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    child: TextFormField(
                                                      controller:
                                                          _emailController,
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Email',
                                                        labelStyle: TextStyle(
                                                            fontSize: 14),
                                                        border:
                                                            UnderlineInputBorder(),
                                                      ),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return "Enter Email";
                                                        }
                                                        final bool emailValid =
                                                            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                                .hasMatch(
                                                                    value);
                                                        if (!emailValid) {
                                                          return "Enter Valid Email";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    child: TextFormField(
                                                      controller:
                                                          _passwordController,
                                                      keyboardType:
                                                          TextInputType
                                                              .visiblePassword,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Password',
                                                        labelStyle: TextStyle(
                                                            fontSize: 14),
                                                        border:
                                                            UnderlineInputBorder(),
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
                                                          return "Enter Password";
                                                        } else if (value
                                                                .length <
                                                            6) {
                                                          return "Password should be at least 6 characters long";
                                                        }
                                                        return null;
                                                      },
                                                      obscureText:
                                                          !_isPasswordVisible,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  _isLoading
                                                      ? CircularProgressIndicator()
                                                      : _loginSuccessful
                                                          ? CircularProgressIndicator()
                                                          : CustomButton(
                                                              text: 'Log In',
                                                              onPressed: () {
                                                                if (_formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  setState(() {
                                                                    _isLoading =
                                                                        true;
                                                                  });
                                                                  _loginWithEmail();
                                                                }
                                                              },
                                                              width: 90.0,
                                                              height: 30.0,
                                                            ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          /// Page 2: Log in with authenticator
                                          Container(
                                            width: 380,
                                            height: 200,
                                            // color: Colors.blue,
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    child: TextField(
                                                      cursorHeight: 25,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Email',
                                                        labelStyle: TextStyle(
                                                            fontSize: 14),
                                                        border:
                                                            UnderlineInputBorder(),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  CustomButton(
                                                    text: 'Next',
                                                    onPressed: () {},
                                                    width: 90.0,
                                                    height: 30.0,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 175.0),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 2,
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
//class LoginScreen extends StatefulWidget {
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   PageController _pageController = PageController();
//   int _selectedIndex = -1;
//   FocusNode fieldOne = FocusNode();
//   FocusNode fieldTow = FocusNode();
//   final _formKey = GlobalKey<FormState>();
//   bool _isObscure = true;
//   bool isPasswordVisible = true;
//
//   void _navigateToPage(int page) {
//     _pageController.animateToPage(
//       page,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _handleSelected(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     _navigateToPage(index);
//   }
//
//   ///for signup
//   // Future<void> _signUpWithEmail() async {
//   //   String email = _emailController.text.trim();
//   //   String password = _passwordController.text.trim();
//   //
//   //   SignUpManager signUpManager = SignUpManager();
//   //   try {
//   //     await signUpManager.login(email: email, password: password);
//   //     Navigator.push(context,
//   //         MaterialPageRoute(builder: (context) => const SubLoginScreen()));
//   //   } catch (e) {
//   //     print('Login failed: $e');
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return LoginBaseConstant(
//       child: Column(
//         children: [
//           ///logo
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                 width: 365,
//                 height: 110,
//                 child: Image.asset('images/logo_login.png'),
//               )
//             ],
//           ),
//           // SizedBox(height: 20,),
//           Padding(
//             padding: EdgeInsets.only(
//                 left: MediaQuery.of(context).size.width / 15,
//                 right: MediaQuery.of(context).size.width / 12,
//                 top: 60),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(left: 80.0),
//                       child: Text(
//                         'Log In',
//                         style: TextStyle(
//                           fontFamily: 'FiraSans',
//                           color: Color(0xff686464),
//                           fontSize: 40,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//
//                     ///todo prachi
//                     Material(
//                       elevation: 5,
//                       borderRadius: BorderRadius.circular(24),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: 380,
//                             height: 270,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(24),
//                               color: Colors.white,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Headings
//                                 Padding(
//                                   padding: EdgeInsets.all(
//                                       MediaQuery.of(context).size.width / 120),
//                                   child: Container(
//                                     width: double.infinity,
//                                     padding: const EdgeInsets.all(8),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () {
//                                             _handleSelected(0);
//                                           },
//                                           child: Column(
//                                             children: [
//                                               Text(
//                                                 "Login with Email",
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 15,
//                                                   color: _selectedIndex == 0
//                                                       ? Colors.blue
//                                                       : const Color(0xff686464),
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 1),
//                                               _selectedIndex == 0
//                                                   ? Container(
//                                                       width:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .width /
//                                                               12,
//                                                       height: 2,
//                                                       color: Colors.blue,
//                                                     )
//                                                   : Container(),
//                                             ],
//                                           ),
//                                         ),
//                                         GestureDetector(
//                                           onTap: () {
//                                             _handleSelected(1);
//                                           },
//                                           child: Column(
//                                             children: [
//                                               Text(
//                                                 "Login with Authenticator",
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 15,
//                                                   color: _selectedIndex == 1
//                                                       ? Colors.blue
//                                                       : const Color(0xff686464),
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 1),
//                                               _selectedIndex == 1
//                                                   ? Container(
//                                                       width:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .width /
//                                                               8,
//                                                       height: 2,
//                                                       color: Colors.blue,
//                                                     )
//                                                   : Container(),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//
//                                 ///todo prachi
//                                 Expanded(
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal:
//                                             MediaQuery.of(context).size.width /
//                                                 99),
//                                     child: PageView(
//                                       controller: _pageController,
//                                       scrollDirection: Axis.horizontal,
//                                       children: [
//                                         /// Page 1: Log in with mail
//                                         Container(
//                                           width: 380,
//                                           height: 200,
//                                           child: Form(
//                                             key: _formKey,
//                                             child: Column(
//                                               children: [
//                                                 Padding(
//                                                   padding: EdgeInsets.symmetric(
//                                                       horizontal: 20),
//                                                   child:
//
//                                                       ///email
//                                                       TextFormField(
//                                                           controller:
//                                                               _emailController,
//                                                           keyboardType:
//                                                               TextInputType
//                                                                   .emailAddress,
//                                                           focusNode: fieldOne,
//                                                           decoration:
//                                                               InputDecoration(
//                                                             labelText: 'Email',
//                                                             labelStyle:
//                                                                 TextStyle(
//                                                                     fontSize:
//                                                                         14),
//                                                             border:
//                                                                 UnderlineInputBorder(),
//                                                           ),
//                                                           validator: (value) {
//                                                             final bool
//                                                                 emailValid =
//                                                                 RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                                                                     .hasMatch(
//                                                                         value!);
//
//                                                             if (value.isEmpty) {
//                                                               return "Enter Email";
//                                                             } else if (!emailValid) {
//                                                               return "Enter Valid Email";
//                                                             }
//                                                             return null;
//                                                           }),
//                                                 ),
//                                                 const SizedBox(height: 2),
//                                                 Padding(
//                                                   padding: EdgeInsets.symmetric(
//                                                       horizontal: 20),
//                                                   child:
//
//                                                       ///password
//                                                       TextFormField(
//                                                     controller:
//                                                         _passwordController,
//                                                     keyboardType: TextInputType
//                                                         .visiblePassword,
//                                                     // obscureText: true,
//                                                     decoration: InputDecoration(
//                                                         labelText: 'Password',
//                                                         labelStyle: TextStyle(
//                                                             fontSize: 14),
//                                                         border:
//                                                             UnderlineInputBorder(),
//                                                         suffixIcon: IconButton(
//                                                           icon:
//                                                               isPasswordVisible
//                                                                   ? const Icon(
//                                                                       Icons
//                                                                           .visibility_off,
//                                                                     )
//                                                                   : const Icon(
//                                                                       Icons
//                                                                           .visibility,
//                                                                     ),
//                                                           onPressed: () {
//                                                             setState(() {
//                                                               isPasswordVisible =
//                                                                   !isPasswordVisible;
//                                                             });
//                                                           },
//                                                         )),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Enter Password";
//                                                       } else if (_passwordController
//                                                               .text.length <
//                                                           6) {
//                                                         return "";
//                                                       }
//                                                       return null;
//                                                     },
//                                                     obscureText:
//                                                         isPasswordVisible,
//                                                   ),
//                                                 ),
//                                                 const SizedBox(height: 10),
//                                                 CustomButton(
//                                                     text: 'LogIn',
//                                                     onPressed: () async {
//                                                       ///for login
//                                                       () async {
//                                                         if (_formKey
//                                                             .currentState!
//                                                             .validate()) {
//                                                           final loginRequest =
//                                                               LoginRequestData(
//                                                                   username:
//                                                                       _emailController
//                                                                           .text,
//                                                                   password:
//                                                                       _passwordController
//                                                                           .text);
//                                                           print(_emailController
//                                                               .text);
//                                                           var user = await LoginManager()
//                                                               .loginUser(
//                                                                   email:
//                                                                       _emailController
//                                                                           .text,
//                                                                   password:
//                                                                       _passwordController
//                                                                           .text);
//                                                           if (user != null) {
//                                                             print(user);
//                                                             LoginRequestData
//                                                                 userData = user;
//                                                             final SharedPreferences
//                                                                 sharedPreferences =
//                                                                 await SharedPreferences
//                                                                     .getInstance();
//                                                             sharedPreferences
//                                                                 .setString(
//                                                                     'email',
//                                                                     userData
//                                                                         .username!);
//                                                           }
//
//                                                           // final response = await LoginManager().loginUser(loginRequest);
//                                                           //   if (response
//                                                           //           .statusCode ==
//                                                           //       200) {
//                                                           //     Map<String, dynamic>
//                                                           //         responseData =
//                                                           //         jsonDecode(
//                                                           //             response
//                                                           //                 .body);
//                                                           //     if (responseData
//                                                           //         .containsKey(
//                                                           //             'response')) {
//                                                           //       print("check1");
//                                                           //       Map<String, dynamic>
//                                                           //           responseMap =
//                                                           //           responseData[
//                                                           //               'response'];
//                                                           //       if (responseMap
//                                                           //           .containsKey(
//                                                           //               'data')) {
//                                                           //         print("check2");
//                                                           //         Map<String,
//                                                           //                 dynamic>
//                                                           //             dataMap =
//                                                           //             responseMap[
//                                                           //                 'data'];
//                                                           //       }
//                                                           //     }
//                                                           //   }
//                                                         }
//                                                         // UserCredential authResult =
//                                                         //     await FirebaseAuth.instance
//                                                         //         .signInWithEmailAndPassword(
//                                                         //   email: _emailController.text,
//                                                         //   password: _passwordController.text,
//                                                         // );
//
//                                                         // String userEmail =
//                                                         //     authResult.user!.email!;
//                                                         // String userRole =
//                                                         //     await checkUserRoleByEmail(userEmail);
//                                                       };
//                                                     }),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//
//                                         /// Page 2: Log in with authenticator
//                                         Container(
//                                           width: 380,
//                                           height: 200,
//                                           // color: Colors.blue,
//                                           child: Center(
//                                             child: Column(
//                                               children: [
//                                                 const Padding(
//                                                   padding: EdgeInsets.symmetric(
//                                                       horizontal: 20),
//                                                   child: TextField(
//                                                     cursorHeight: 25,
//                                                     decoration: InputDecoration(
//                                                       labelText: 'Email',
//                                                       labelStyle: TextStyle(
//                                                           fontSize: 14),
//                                                       border:
//                                                           UnderlineInputBorder(),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 const SizedBox(height: 20),
//                                                 CustomButton(
//                                                   text: 'Next',
//                                                   onPressed: () {},
//                                                   width: 90.0,
//                                                   height: 30.0,
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 175.0),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => ForgotPassScreen()));
//                         },
//                         child: const Text(
//                           'Forgot your account password ?',
//                           style: TextStyle(
//                             fontFamily: 'FiraSans',
//                             color: Color(0xff1696C8),
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                         width: MediaQuery.of(context).size.width / 3,
//                         height: MediaQuery.of(context).size.height / 2,
//                         child: Image.asset(
//                           'images/amico.png',
//                         ))
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
