import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/app/theme_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/add_employee/add_employee_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/controller/controller.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/web_manage/manage_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/app_bar_tabbar_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/onboarding_screen.dart';

import '../../screens/hr_module/register/register_screen.dart';
///tabbar saloni
///appbar prachi
class MyAppBar extends StatelessWidget {
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
      tabBarViewWidth: MediaQuery.of(context).size.width / 1.1,
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
                // width: 80,
                // color: Colors.tealAccent,
                child: Image.asset('images/logo.png'),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topLeft: Radius.circular(15)),
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
                        // padding: EdgeInsets.all(2),
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
                    Container(
                      height: 33,
                      width: MediaQuery.of(context).size.width / 5.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text("Human Resource Manager",
                            style:
                                ThemeManagerLightblue.customTextStyle(context)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 200),
                      child: ClipOval(
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            splashColor: Colors.white,
                            onTap: () {},
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width / 37,
                                height: 33,
                                child: Icon(
                                  Icons.add,
                                  color: Color(0xff2B647F),
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 20,
                    ),
                    Container(
                        height: 33,
                        width: MediaQuery.of(context).size.width / 8.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.phone,
                                color: Color(0xff2B647F),
                                size: MediaQuery.of(context).size.width / 50,
                              ),
                              Icon(
                                Icons.comment,
                                color: Color(0xff2B647F),
                                size: MediaQuery.of(context).size.width / 50,
                              ),
                              Icon(
                                Icons.mail,
                                color: Color(0xff2B647F),
                                size: MediaQuery.of(context).size.width / 50,
                              )
                            ])),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 60,
                    ),
                    Container(
                      height: 33,
                      width: MediaQuery.of(context).size.width / 15,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Material(
                        shape: CircleBorder(),
                        color: Colors.transparent,
                        child: InkWell(
                          customBorder: CircleBorder(),
                          onTap: () {},
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Admin",
                                  style: RegisterTableHead.customTextStyle(
                                      context),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.width / 60,
                                ),
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 60,
                    ),
                    InkWell(
                      splashColor: Colors.white, // Splash color
                      onTap: () {},
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width / 37,
                          height: 33,
                          child: Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width / 50,
                          )),
                    ),
                    InkWell(
                      splashColor: Colors.white, // Splash color
                      onTap: () {},
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width / 37,
                          height: 33,
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width / 50,
                          )),
                    ),
                  ])),
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
