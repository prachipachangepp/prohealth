import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../controller/controller.dart';

///getx
class AppBarTabBarConstant extends StatelessWidget {
  final MyAppTabBarController controller;

  const AppBarTabBarConstant(this.controller);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
        length: controller.tabs.length,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: ColorManager.white,
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
                            color: ColorManager.black.withOpacity(0.25),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFF50B5E5),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: const Color(0xFF686464),
                      labelColor: ColorManager.white,
                      labelStyle: const TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: FontSize.s14,
                        color: Color(0xFF686464),
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelColor: ColorManager.black,
                       physics: NeverScrollableScrollPhysics(),
                      // onTap: (_){},
                    ),
                  ),
                  const SizedBox(width: AppSize.s30),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            //width: 301,
                            height: AppSize.s25,
                            decoration: BoxDecoration(
                              border:
                              Border.all(color: const Color(0xFF686464), width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 14),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'John S',
                                        hintStyle:TextStyle(color: Color(0xff686464),
                                          fontFamily: 'FiraSans',
                                          fontSize: FontSize.s10,
                                          fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  const Icon(Icons.search, color: Color(0xff686464),size: 15),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSize.s10),
                        Container(
                          height: AppSize.s25,
                            width: AppSize.s37,
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child:  Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: 6.0,),
                              child: Center(child: Image.asset('images/menu_icon.png',)),
                            )),
                        const SizedBox(width: AppSize.s20),
                        Container(
                            height: AppSize.s25,
                            width: AppSize.s32,
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              boxShadow: [
                                BoxShadow(
                                  color: ColorManager.black.withOpacity(0.25),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text('DZ',
                                style: TextStyle(
                                  fontFamily: 'FiraSans',
                                  fontSize: FontSize.s13,
                                  fontWeight: FontWeight.w400,
                                ),textAlign: TextAlign.center,),
                            )),
                        const SizedBox(
                          width: AppSize.s40,
                        ),
                        ElevatedButton(
                          onPressed: () {

                          },
                          child: const Text(
                            'See All',
                            style: TextStyle(
                                fontFamily: 'FiraSans',
                                fontSize: FontSize.s13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            backgroundColor: const Color(0xFF1696C8),
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSize.s20),
            Container(
              //color: Colors.grey,
              height: controller.tabBarViewHeight,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: controller.tabViews,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
