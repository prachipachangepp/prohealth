import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/presentation/screens/hr_module/add_employee/add_employee_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/controller/controller.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/web_manage/manage_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/app_bar_tabbar_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/onboarding_screen.dart';
import 'package:prohealth/presentation/widgets/const_appbar/controller.dart';

import '../../../app/resources/theme_manager.dart';
import '../../screens/hr_module/register/register_screen.dart';

///tabbar saloni
///appbar prachi

class MyAppBar extends StatelessWidget {
  final HRController hrController = Get.put(HRController());
  final CustomButtonController customController =
      Get.put(CustomButtonController());
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyAppTabBarController(
      tabs: [
        Tab(text: 'Dashboard'),
        Tab(text: 'Manage'),
        Tab(text: 'Add Employee'),
        Tab(text: 'Register'),
        Tab(text: 'Onboarding'),
      ],
      tabViews: [
        Center(child: Text('Dashboard Screen')),
        ManageScreen(),
        AddEmployeeHomeScreen(),
        RegisterScreen(),
        OnBoardingScreen(),
      ],
      tabBarViewWidth: MediaQuery.of(context).size.width / 1.04,
      tabBarViewHeight: MediaQuery.of(context).size.height/1.2
    ));

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// first row logo
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 40,
                child: Image.asset('images/logo.png'),
              ),
            ),
            Expanded(
              flex: 4,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff008abd).withOpacity(0.9),
                          Color(0xff008abd).withOpacity(0.8)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.4, 0.7],
                        tileMode: TileMode.repeated,
                      ),
                    ),
                    child: Row(children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 99,
                        ),
                        child: Container(
                          height: 33,
                          width: 80,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("images/mike.png"),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Column(
                                  children: [
                                    Text("Ask",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 9)),
                                    Text("KLIP",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 10,
                      ),
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 5.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Human Resource Manager",
                                    style: ThemeManagerLightblue.customTextStyle(
                                        context)),
                                Icon(
                                  Icons.close,
                                  color: Color(0xff434343),
                                  size:
                                  MediaQuery.of(context).size.width / 70,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 120,
                      ),
                      GetBuilder<CustomButtonController>(
                        builder: (controller) => Material(
                          elevation: 3,
                          shape: CircleBorder(),
                          child: InkWell(
                            child: Container(
                              width: 33,
                              height: 33,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.add,
                                color: Color(0xff2B647F),
                                size: 25,
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 20,
                      ),
                      ///3 icons
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width / 10,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.phone_outlined,
                                    color: Color(0xff2B647F),
                                    size:
                                        MediaQuery.of(context).size.width / 70,
                                  ),
                                  Icon(
                                    Icons.mode_comment_outlined,
                                    color: Color(0xff2B647F),
                                    size:
                                        MediaQuery.of(context).size.width / 70,
                                  ),
                                  Icon(
                                    Icons.mail_outline_outlined,
                                    color: Color(0xff2B647F),
                                    size:
                                        MediaQuery.of(context).size.width / 70,
                                  )
                                ])),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 60,
                      ),
                      ///dropdown
                      Container(
                        height: 23,
                        width: 90,
                        // padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white),
                          color: Colors.transparent,
                        ),
                        child: Obx(
                          () => Center(
                            child: DropdownButton<String>(
                              icon: Icon(Icons.arrow_drop_down,
                                  size: MediaQuery.of(context).size.width / 89,
                                  color: Colors.white),
                              dropdownColor: Colors.grey,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 92,
                                color: Colors.white,
                              ),
                              underline: Container(),
                              value: hrController.selectedItem.value,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  hrController.changeSelectedItem(newValue);
                                }
                              },
                              items: ['Admin', 'Staff', 'Patient']
                                  .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white,
                                          fontFamily: 'FiraSans',
                                          fontSize: 11,
                                          fontWeight: FontWeight.w200,),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                      // Material(
                      //   elevation: 4,
                      //   borderRadius: BorderRadius.all(Radius.circular(20)),
                      //   child: Container(
                      //     height: 33,
                      //     width: MediaQuery.of(context).size.width / 15,
                      //     decoration: BoxDecoration(
                      //       border: Border.all(width: 1, color: Colors.white),
                      //       borderRadius: BorderRadius.all(Radius.circular(20)),
                      //     ),
                      //     child: Material(
                      //       shape: CircleBorder(),
                      //       color: Colors.transparent,
                      //       child: InkWell(
                      //         customBorder: CircleBorder(),
                      //         onTap: () {},
                      //         child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               Text(
                      //                 "Admin",
                      //                 style: RegisterTableHead.customTextStyle(
                      //                     context),
                      //               ),
                      //               Icon(
                      //                 Icons.arrow_drop_down_rounded,
                      //                 color: Colors.white,
                      //                 size: MediaQuery.of(context).size.width /
                      //                     60,
                      //               ),
                      //             ]),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 60,
                      ),
                      InkWell(
                        splashColor: Colors.white, // Splash color
                        onTap: () {},
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width / 37,
                            height: 25,
                            child: Icon(
                              Icons.notifications_none_outlined,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width / 68,
                            )),
                      ),
                      InkWell(
                        splashColor: Colors.white,
                        onTap: () {},
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width / 37,
                            height: 25,
                            child: Icon(
                              Icons.settings_outlined,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width / 68,
                            )),
                      ),
                      //SizedBox(width: MediaQuery.of(context).size.width/10,),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.white,
                              child: Image.asset("images/profile.png"),
                            ),
                            SizedBox(height: 2),
                            Flexible(
                              child: Text(
                                "William Christiana ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontFamily: 'FiraSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ])),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),

        ///second row title heading
        AppBarTabBarConstant(controller),
      ],
    );
  }
}
