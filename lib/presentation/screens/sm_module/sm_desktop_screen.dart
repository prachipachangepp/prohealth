import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../hr_module/manage/widgets/custom_icon_button_constant.dart';
class SMDesktop extends StatelessWidget {
  final PageController _pageController = PageController();
  final SMController smController = Get.put(SMController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 131,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xff000000).withOpacity(0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
              color: Color(0xffFFFFFF),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          //  color: Colors.grey,
                          child: Image.asset('images/logo.png',fit: BoxFit.fill,),

                        )
                    ),
                    Expanded(
                      flex: 10,
                      child: Material(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 47,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x40000000), /// #000000 with 25% opacity
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff51B5E6),
                                Color(0xff008ABD),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              // begin: Alignment.centerLeft,
                              // end: Alignment.centerRight,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ///ask klip
                              Container(
                                width: 96,
                                height: 34,
                                decoration: BoxDecoration(
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Color(0xff000000).withOpacity(0.25),
                                  //     blurRadius: 4,
                                  //     offset: Offset(0, 4),
                                  //   ),
                                  // ],
                                    border: Border.all(color: Colors.white, width: 1,),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset("images/mike.png"),
                                    Column(children: [
                                      Text('Ask',
                                        style: GoogleFonts.jost(
                                            color: Colors.white,
                                            fontSize: 10,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.w200
                                        ),),
                                      Text("KLIP",
                                          style: GoogleFonts.jost(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none,
                                          )
                                      ),
                                    ],),

                                  ],
                                ), // Add child widgets here if needed
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width / 15,),
                              Expanded(
                                child: Container(
                                  width: 210,
                                  height: 34,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: MediaQuery.of(context).size.width / 100,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x40000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Establishment Manager',
                                          style: TextStyle(
                                            fontFamily: 'Fira Sans',
                                            fontSize: MediaQuery.of(context).size.width/110,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff2B647F),
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.close,
                                        color: Color(0xff434343),
                                        size: MediaQuery.of(context).size.width/100,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width / 80,),
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
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
                                      // Handle tap
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Color(0xff2B647F), // Icon color
                                      size: 20, // Icon size
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width / 20,),
                              Material(
                                elevation: 4,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                    height: 34,
                                    width: MediaQuery.of(context).size.width / 10,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(18)),
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
                              SizedBox(width: MediaQuery.of(context).size.width / 20,),
                              ///dropdown
                              Expanded(
                                child: Container(
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        border: InputBorder.none
                                    ),
                                    value: smController.selectedItem.value,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                    iconSize: 24,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontFamily: 'FiraSans',
                                      fontWeight: FontWeight.w200,
                                    ),
                                    onChanged: (newValue) {
                                      if (newValue != null) {
                                        smController.changeSelectedItem(newValue);
                                      }
                                    },
                                    dropdownColor: Colors.grey,
                                    items: ['Admin', 'Staff', 'Patient']
                                        .map<DropdownMenuItem<String>>(
                                          (String value) => DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                        .toList(),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width / 60,),
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
                              SizedBox(width: MediaQuery.of(context).size.width / 50,),
                              Column(
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                /// buttons
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        // color: Colors.yellow,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomButton(
                              height: 30,
                              width: 100,
                              onPressed: () {
                                if (_pageController.page != 0) {
                                  _pageController.animateToPage(0,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                }
                              },
                              text: 'Button 1',
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomButton(
                              height: 30,
                              width: 100,
                              onPressed: () {
                                if (_pageController.page != 1) {
                                  _pageController.animateToPage(1,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                }
                              },
                              text: 'Button 2',
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomButton(
                              height: 30,
                              width: 100,
                              onPressed: () {
                                if (_pageController.page != 2) {
                                  _pageController.animateToPage(2,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                }
                              },
                              text: 'Button 3',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(color: Colors.blue),
              Container(color: Colors.green),
              Container(color: Colors.orange),
            ],
          ),
        ),
      ],
    );
  }
}



class SMController extends GetxController{
  var selectedItem = 'Admin'.obs;
  void changeSelectedItem(String newItem) {
    selectedItem.value = newItem;
  }
}