import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/scheduler_model/textfield_dropdown_constant/chatbotContainer.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';

import '../../../../../app/resources/theme_manager.dart';

class PatientDetailsCalender extends StatefulWidget {
  final VoidCallback onBack;
  const PatientDetailsCalender({super.key, required this.onBack});

  @override
  State<PatientDetailsCalender> createState() => _PatientDetailsCalenderState();
}

class _PatientDetailsCalenderState extends State<PatientDetailsCalender> {
  bool isSwitched = false;
  bool _isChatbotVisible = false;

  void _toggleChatbotVisibility() {
    setState(() {
      _isChatbotVisible = !_isChatbotVisible;
    });
  }
  // final PageController _pageController = PageController();
  //
  // int selectedIndex = 0;
  // void selectButton(int index) {
  //   setState(() {
  //     selectedIndex = index;
  //   });
  //
  //   _pageController.animateToPage(
  //     index,
  //     duration: const Duration(milliseconds: 500),
  //     curve: Curves.ease,
  //   );
  // }
  //
  // void pageTransition() {
  //   if (isSwitched) {
  //     selectButton(1);
  //   }else{
  //     selectButton(0);
  //   }
  // }
  @override
  void initState() {
    // TODO: implement initState
    //pageTransition();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:ColorManager.white,
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 100),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: widget.onBack,
                        label: Text(
                          'Back',
                          style: TextStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeight.w500,
                              color: ColorManager.textBlack),
                        ),
                        icon: Icon(Icons.keyboard_arrow_left_rounded, color: ColorManager.textBlack),
                      ),
                      Row(
                        children: [
                          CustomDropdownTextField(
                            width: 150,
                            isAstric:false,
                            // Adjust headText based on depId
                            initialValue: 'Employee Type',
                            headText: "", // Default fallback if depId doesn't match any of the expected values
                            items: ['Employee 1','Employee 2','Employee 3'],
                            onChanged: (newValue) {
                              // for (var a in snapshot.data!) {
                              //   if (a.empType == newValue) {
                              //     clinicialName = a.empType!;
                              //     clinicalId = a.employeeTypesId!;
                              //     print("Dept ID'''''' ${clinicalId}");
                              //     print("';';';''''''''Dept ID ${clinicialName}");
                              //     // Do something with docType
                              //   }
                              // }
                            },
                          ),
                          SizedBox(width: 10,),
                          CustomDropdownTextField(
                            width:150,
                            isAstric:false,
                            // Adjust headText based on depId
                            initialValue: 'Clinician Type',
                            headText: "", // Default fallback if depId doesn't match any of the expected values
                            items: ['Clinical 1','Clinical 2','Clinical 3'],
                            onChanged: (newValue) {
                              // for (var a in snapshot.data!) {
                              //   if (a.empType == newValue) {
                              //     clinicialName = a.empType!;
                              //     clinicalId = a.employeeTypesId!;
                              //     print("Dept ID'''''' ${clinicalId}");
                              //     print("';';';''''''''Dept ID ${clinicialName}");
                              //     // Do something with docType
                              //   }
                              // }
                            },
                          ),
                          SizedBox(width: 20,),
                          Text('SOC',style: DocumentTypeDataStyle.customTextStyle(context),),
                          SizedBox(width: 10,),
                          /// Toggle button
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;

                              });
                            },
                            activeColor: ColorManager.blueprime,
                            inactiveThumbColor: ColorManager.white,
                            inactiveTrackColor: Colors.grey,
                          ),
                          SizedBox(width: 10,),
                          //ToggleButtons(children: [], isSelected: [true]),
                          Text('POC',style: DocumentTypeDataStyle.customTextStyle(context),)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  // PageView(
                  //   controller: _pageController,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) { return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1,
                              vertical: 5,),
                            child:  Container(
                              height: AppSize.s88,
                              padding: EdgeInsets.symmetric(horizontal: AppPadding.p40),
                              margin: EdgeInsets.symmetric(horizontal: AppMargin.m2),
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorManager.black.withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          child:
                                          Image.asset('images/1.png'),
                                        ),
                                        SizedBox(width: AppSize.s7),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Corea",
                                              textAlign: TextAlign.center,
                                              style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                                fontWeight: FontWeight.w400,
                                                color: ColorManager.textBlack,),
                                            ),
                                            Text(
                                              "Anaxiety",
                                              textAlign: TextAlign.center,
                                              style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                                fontWeight: FontWeight.w600,
                                                color: ColorManager.mediumgrey,),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "images/sm/location.png",
                                          height: 25,width: 26,fit: BoxFit.fill,
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          "Tufts International Center, 20 Sawyer Ave,\nMedford MA 02155 ",
                                          textAlign: TextAlign.start,
                                          style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                            fontWeight: FontWeight.w400,
                                            color: ColorManager.textBlack,),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Icon(Icons.access_time_rounded,color: ColorManager.bluelight,),
                                        SizedBox(width: 10,),
                                        Text("08:05 AM TO 09:00 AM",style:DocumentTypeDataStyle.customTextStyle(context),)
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Row(
                                      children: [
                                        // Text("POC :",style: DocumentTypeDataStyle.customTextStyle(context),),
                                        //  Padding(
                                        //    padding: const EdgeInsets.all(8.0),
                                        //    child: Container(
                                        //      color: Color(0xFF527FB9),
                                        //      width: 19,
                                        //      height: 19,
                                        //      child: Center(
                                        //        child: Text("ST",style: TextStyle(
                                        //          // fontWeight: FontWeight.w600,
                                        //          // fontSize: FontSize.s13,
                                        //          color: ColorManager.white,
                                        //          decoration: TextDecoration.none,
                                        //        ),),
                                        //      ),
                                        //    ),
                                        //  ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            color: Color(0xFFFEBD4D),
                                            width: 19,
                                            height: 19,
                                            child: Center(
                                              child: Text("OT",style: TextStyle(
                                                // fontWeight: FontWeight.w600,
                                                //     fontSize: FontSize.s13,
                                                color: ColorManager.white,
                                                decoration: TextDecoration.none,
                                              ),),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          child:
                                          Image.asset('images/1.png'),
                                        ),
                                        SizedBox(width: AppSize.s7),
                                        Text(
                                          'Jeh Tiwari',
                                          style:DocumentTypeDataStyle.customTextStyle(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap:()=>_toggleChatbotVisibility,
                                    child: Image.asset("images/sm/contact_schedular.png",
                                      height: 50,width: 60,fit: BoxFit.fill,),
                                  ),

                                ],
                              ),
                            ),
                          ); },

                        ),
                      ),
                      // Expanded(
                      //   child: ListView.builder(
                      //     itemCount: 5,
                      //     itemBuilder: (BuildContext context, int index) { return Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 1,
                      //         vertical: 5,),
                      //       child:  Container(
                      //         height: AppSize.s88,
                      //         padding: EdgeInsets.symmetric(horizontal: AppPadding.p40),
                      //         margin: EdgeInsets.symmetric(horizontal: AppMargin.m2),
                      //         decoration: BoxDecoration(
                      //           color: ColorManager.white,
                      //           borderRadius: BorderRadius.circular(12),
                      //           boxShadow: [
                      //             BoxShadow(
                      //               color: ColorManager.black.withOpacity(0.2),
                      //               spreadRadius: 0,
                      //               blurRadius: 2,
                      //               offset: Offset(0, 2),
                      //             ),
                      //           ],
                      //         ),
                      //         child: Row(
                      //           //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Expanded(
                      //               child: Row(
                      //                 children: [
                      //                   CircleAvatar(
                      //                     child:
                      //                     Image.asset('images/1.png'),
                      //                   ),
                      //                   SizedBox(width: AppSize.s7),
                      //                   Column(
                      //                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                     mainAxisAlignment: MainAxisAlignment.center,
                      //                     children: [
                      //                       Text(
                      //                         "Corea",
                      //                         textAlign: TextAlign.center,
                      //                         style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                      //                           fontWeight: FontWeight.w400,
                      //                           color: ColorManager.textBlack,),
                      //                       ),
                      //                       Text(
                      //                         "Anaxiety",
                      //                         textAlign: TextAlign.center,
                      //                         style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                      //                           fontWeight: FontWeight.w600,
                      //                           color: ColorManager.mediumgrey,),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //
                      //             Expanded(
                      //               flex: 2,
                      //               child: Row(
                      //                 children: [
                      //                   Image.asset(
                      //                     "images/sm/location.png",
                      //                     height: 25,width: 26,fit: BoxFit.fill,
                      //                   ),
                      //                   SizedBox(width: 10,),
                      //                   Text(
                      //                     "Tufts International Center, 20 Sawyer Ave,\nMedford MA 02155 ",
                      //                     textAlign: TextAlign.start,
                      //                     style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                      //                       fontWeight: FontWeight.w400,
                      //                       color: ColorManager.textBlack,),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 2,
                      //               child: Row(
                      //                 children: [
                      //                   Icon(Icons.access_time_rounded,color: ColorManager.bluelight,),
                      //                   SizedBox(width: 10,),
                      //                   Text("08:05 AM TO 09:00 AM",style:DocumentTypeDataStyle.customTextStyle(context),)
                      //                 ],
                      //               ),
                      //             ),
                      //
                      //             Expanded(
                      //               child: Row(
                      //                 children: [
                      //                   // Text("POC :",style: DocumentTypeDataStyle.customTextStyle(context),),
                      //                   //  Padding(
                      //                   //    padding: const EdgeInsets.all(8.0),
                      //                   //    child: Container(
                      //                   //      color: Color(0xFF527FB9),
                      //                   //      width: 19,
                      //                   //      height: 19,
                      //                   //      child: Center(
                      //                   //        child: Text("ST",style: TextStyle(
                      //                   //          // fontWeight: FontWeight.w600,
                      //                   //          // fontSize: FontSize.s13,
                      //                   //          color: ColorManager.white,
                      //                   //          decoration: TextDecoration.none,
                      //                   //        ),),
                      //                   //      ),
                      //                   //    ),
                      //                   //  ),
                      //                   Padding(
                      //                     padding: const EdgeInsets.all(8.0),
                      //                     child: Container(
                      //                       color: Color(0xFFFEBD4D),
                      //                       width: 19,
                      //                       height: 19,
                      //                       child: Center(
                      //                         child: Text("OT",style: TextStyle(
                      //                           // fontWeight: FontWeight.w600,
                      //                           //     fontSize: FontSize.s13,
                      //                           color: ColorManager.white,
                      //                           decoration: TextDecoration.none,
                      //                         ),),
                      //                       ),
                      //                     ),
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //             Expanded(
                      //               child: Row(
                      //                 children: [
                      //                   CircleAvatar(
                      //                     child:
                      //                     Image.asset('images/1.png'),
                      //                   ),
                      //                   SizedBox(width: AppSize.s7),
                      //                   Text(
                      //                     'Jeh Tiwari',
                      //                     style:DocumentTypeDataStyle.customTextStyle(context),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //             Image.asset("images/sm/contact_schedular.png",
                      //               height: 50,width: 60,fit: BoxFit.fill,),
                      //
                      //           ],
                      //         ),
                      //       ),
                      //     ); },
                      //
                      //   ),
                      // ),
              //   ],
              // ),
              ],
            ),
                ),
          if (_isChatbotVisible)
            Positioned.fill(
              child: GestureDetector(
                onTap: _toggleChatbotVisibility, // Close popup on tapping outside
                child: Container(
                    color: Colors.transparent
                ),
              ),
            ),
          AnimatedPositioned(duration:Duration(milliseconds: 300),
              bottom: _isChatbotVisible ? 0 : -500, // Slide in from bottom-right
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 450,
                width: 500,


                child: ChatBotContainer(
                  onClose: _toggleChatbotVisibility,
                ),

              ) )
        ],
      ),
    );
  }
}
