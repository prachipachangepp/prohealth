import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/controller/controller.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/head_tabbar_constant.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/login_screen_no_blur.png'),
                fit: BoxFit.fill),
          ),
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 58.0, vertical: 58),
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
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 90,
                      vertical: MediaQuery.of(context).size.height / 100),
                  child: Column(
                    children: [
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 80.0),
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
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 295,
                                  width: 380,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 38, vertical: 24),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff000000).withOpacity(0.3),
                                        // spreadRadius: 1,
                                        blurRadius: 22,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24)),
                                  ),
                                  child: Column(
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          border: UnderlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          border: UnderlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      CustomIconButton(text: 'Login',
                                          onPressed: (){})
                                    ],
                                  )
                                  // LoginTabBar(LoginTabBarController(tabs: [
                                  //   Tab(text: 'Login with Email',),
                                  //   Tab(text: 'Login with Authenticator',),
                                  // ], tabViews: [
                                  //   Center(child: Text('Login with Authenticator'),),
                                  //   Center(child: Text('Login with Authenticator'),),
                                  // ]))
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 175.0),
                                  child: Text(
                                    'Forgot your account password ?',
                                    style: TextStyle(
                                      fontFamily: 'FiraSans',
                                      color: Color(0xff1696C8),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    width: 443,
                                    height: 400,
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
                ),
              ),
            ),
          )),
    );
  }
}

//
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
//
// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('images/login_screen_no_blur.png'),
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           Positioned.fill(
//             child: Container(
//               color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
//             ),
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 58.0, vertical: 58),
//               child: Container(
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0xff000000).withOpacity(0.01),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                   color: Color(0xffFFFFFF).withOpacity(0.35),
//                   borderRadius: BorderRadius.all(Radius.circular(25)),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
