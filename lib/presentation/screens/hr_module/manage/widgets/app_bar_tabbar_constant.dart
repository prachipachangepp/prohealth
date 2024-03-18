import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/controller/controller.dart';

///getx
class AppBarTabBarConstant extends StatelessWidget {
  final MyAppTabBarController controller;

  AppBarTabBarConstant(this.controller);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height / 18,
            width: controller.tabBarViewWidth,
            child: Row(
              children: [
                Expanded(
                  child: TabBar(
                    tabs: controller.tabs,
                    isScrollable: false,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xFF50B5E5),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Color(0xFF686464),
                    labelColor: Colors.white,
                    labelStyle: TextStyle(
                      fontFamily: 'FiraSans',
                      fontSize: 12,
                      color: Color(0xFF686464),
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelColor: Colors.black,
                  ),
                ),
                SizedBox(width: 10), // Add space between tabs and TextField
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: Color(0xFF686464), width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 14),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'John S',
                                      hintStyle:
                                      TextStyle(color: Color(0xff686464)),
                                    ),
                                  ),
                                ),
                                Icon(Icons.search, color: Color(0xff686464)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(child: Icon(Icons.menu)),
                          )),
                      SizedBox(width: 10),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('DZ'),
                          )),
                      SizedBox(
                        width: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'See All',
                          style: TextStyle(
                              fontFamily: 'FiraSans',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          backgroundColor: Color(0xFF50B5E5),
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            //color: Colors.grey,
            height: controller.tabBarViewHeight,
            child: TabBarView(
              children: controller.tabViews,
            ),
          ),
        ],
      ),
    );
  }
}
