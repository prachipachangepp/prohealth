import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/resources/color.dart';
import '../../../app/resources/font_manager.dart';
import '../../screens/home_module/home_screen.dart';
import '../widgets/const_appbar/controller.dart';

class AppBarWeb extends StatelessWidget {
  AppBarWeb({super.key});
  final HRController hrController = Get.put(HRController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppBar().preferredSize.height + 15,
      child: Row(
        children: [
          Container(
            width: 200,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Image.asset(
              'images/logo_login.png',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 240,
            margin:
                const EdgeInsets.only(left: 20, right: 0, top: 5, bottom: 5),
            child: Material(
              elevation: 8,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff51B5E6),
                      Color(0xff008ABD),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 280,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // scrollDirection: Axis.horizontal,
                      children: [
                        ///ask klip
                        Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(22),
                          elevation: 4,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff51B5E6),
                                    Color(0xff008ABD),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(22)),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset("images/mike.png"),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ask',
                                      style: GoogleFonts.jost(
                                          color: Colors.white,
                                          fontSize: 10,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text("KLIP",
                                        style: GoogleFonts.jost(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width / 8,
                        // ),

                        ///Heading text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x40000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Establishment Manager',
                                    style: GoogleFonts.firaSans(
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff2B647F),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen()));
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: const Color(0xff434343),
                                      size: MediaQuery.of(context).size.width /
                                          100,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),

                            ///add button
                            Container(
                              width: 33,
                              height: 33,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x40000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()));
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Color(0xff2B647F), // Icon color
                                    size: 20, // Icon size
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width / 30,
                        // ),
                        Material(
                          elevation: 4,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                color: Colors.white,
                              ),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      'images/phone_app_bar.svg',
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    SvgPicture.asset(
                                      'images/message_app_bar.svg',
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    SvgPicture.asset(
                                      'images/email_app_bar.svg',
                                    ),
                                  ])),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width / 30,
                        // ),

                        ///dropdown
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white, width: 2),
                            color: Colors.transparent,
                          ),
                          child: Obx(
                            () => Center(
                              child: DropdownButton<String>(
                                icon: const Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                dropdownColor: ColorManager.white,
                                style: GoogleFonts.firaSans(
                                  fontSize: FontSize.s12,
                                  fontWeight:
                                      hrController.selectedItem.value.isNotEmpty
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                  color:
                                      hrController.selectedItem.value.isNotEmpty
                                          ? Colors.white
                                          : const Color(0xff9B9B9B),
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
                                      (String value) =>
                                          DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: hrController
                                                        .selectedItem.value ==
                                                    value
                                                ? ColorManager.white
                                                : const Color(0xff9B9B9B),
                                            fontFamily: 'FiraSans',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width / 50,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              splashColor: Colors.white, // Splash color
                              onTap: () {},
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: const Center(
                                    child: Icon(
                                      Icons.notifications_none_outlined,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                            InkWell(
                              splashColor: Colors.white,
                              onTap: () {},
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: const Center(
                                    child: Icon(
                                      Icons.settings_outlined,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width / 50,
                        // ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.white,
                              child: Image.asset(
                                "images/profile.png",
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "William Christiana",
                              style: GoogleFonts.firaSans(
                                color: Colors.white,
                                fontSize: FontSize.s9,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
