import 'package:flutter/material.dart';
import 'package:prohealth/presentation/widgets/login_screen/login_screen.dart';
import '../../../screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../widgets/login_flow_base_struct.dart';

class ChangePasswordScreen extends StatefulWidget {
   ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
   final TextEditingController controllerNew = TextEditingController();
   final TextEditingController controllerConfirm = TextEditingController();
   bool _obscureText = true;

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
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Password',
                      style: TextStyle(
                        fontFamily: 'FiraSans',
                        color: Color(0xff686464),
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(24),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 380,
                            height: 250,
                            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 40),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(24),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Set the new password for your account so you can login and\naccess all features.',
                                  style: TextStyle(
                                    fontFamily: 'FiraSans',
                                    color: Color(0xff686464),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextField(
                                  controller: controllerNew,
                                  style: TextStyle(
                                    fontFamily: 'FiraSans',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                  cursorColor: Colors.black,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                        size: 15,
                                        color: Color(0xffACA5BB),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    ),
                                    labelText: 'Enter New Password',
                                    labelStyle: TextStyle(fontSize: 10, color: Color(0xff000000).withOpacity(0.9), fontWeight: FontWeight.w500),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff50B5E5)),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              TextField(
                                controller: controllerConfirm,
                                style: TextStyle(
                                  fontFamily: 'FiraSans',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                                cursorColor: Colors.black,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                      size: 15,
                                      color: Color(0xffACA5BB),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                  labelText: 'Confirm Password',
                                  labelStyle: TextStyle(fontSize: 10, color: Color(0xff000000).withOpacity(0.9), fontWeight: FontWeight.w500),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff50B5E5)),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                                SizedBox(height: 12),
                                Center(
                                  child: CustomButton(
                                    width: 150.0,
                                    height: 30.0,
                                    text:
                                    'Update Password',
                                    onPressed:
                                        () {
                                      showDialog(context: context, builder: (BuildContext context){
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                            content: Container(
                                              padding: EdgeInsets.only(top: 25),
                                              height: 400,
                                              width: 500,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset('images/upload.png',width: 125,height: 125,),
                                                  Text('Successfully',style: TextStyle(
                                                    fontFamily: 'FiraSans',
                                                    fontSize: 30,
                                                    color: Color(0xff686464),
                                                    fontWeight: FontWeight.w700,
                                                  ),),
                                                  Text('Your password has been reset successfully',style: TextStyle(
                                                    fontFamily: 'FiraSans',
                                                    fontSize: 12,
                                                    color: Color(0xff686464),
                                                    fontWeight: FontWeight.w500,
                                                  ),),
                                                  CustomButton(
                                                      width: 282,
                                                      height: 46,
                                                      text: 'Continue',
                                                      borderRadius: 28,
                                                      onPressed: (){})
                                                ],
                                              ),
                                            )
                                        );
                                      });
                                   //   Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordVerifyScreen()));
                                    },

                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 300.0),
                      child: GestureDetector(
                        onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          'Back to login',
                          textAlign: TextAlign.right,
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
                        height: MediaQuery.of(context).size.height/2,
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
