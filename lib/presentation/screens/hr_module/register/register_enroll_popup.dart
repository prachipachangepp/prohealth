import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import 'package:prohealth/presentation/screens/hr_module/register/offer_letter_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/dropdown_const.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import '../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../widgets/widgets/custom_icon_button_constant.dart';
import '../add_employee/widget/mcq_widget_add-employee.dart';
import 'widgets/mcq_widget_register.dart';

// class RegisterEnrollAlertDialog {
//   final TextEditingController controller = TextEditingController();
//   final TextEditingController firstName = TextEditingController();
//   final TextEditingController lastName = TextEditingController();
//   final TextEditingController phone = TextEditingController();
//   final TextEditingController email = TextEditingController();
//   FocusNode _focusNode = FocusNode();
//   int? _selectedItemIndex;
// /////
//   void show(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           backgroundColor: Colors.white,
//           titlePadding: EdgeInsets.zero,
//          // contentPadding: EdgeInsets.zero,
//           title: Container(
//              //height: 35,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 topRight: Radius.circular(12)
//               ),
//               color: Color(0xff50B5E5)
//             ),
//             child:Padding(
//               padding: const EdgeInsets.all(10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     AppString.enroll,
//                     style: CustomTextStylesCommon.commonStyle(
//                       fontSize: FontSize.s14,
//                       color: ColorManager.white,
//                       fontWeight: FontWeightManager.bold,
//                     ),
//                   ),
//                   IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: Icon(Icons.close, color: ColorManager.white,))
//                 ],
//               ),
//             ),
//           ),
//           content: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Container(
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 height: MediaQuery.of(context).size.height * 0.5,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     color: ColorManager.white),
//                 child: Column(
//                   children: [
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //   children: [
//                     //     Text(
//                     //       AppString.enroll,
//                     //       style: CustomTextStylesCommon.commonStyle(
//                     //         fontSize: FontSize.s14,
//                     //         color: ColorManager.primary,
//                     //         fontWeight: FontWeightManager.bold,
//                     //       ),
//                     //     ),
//                     //     IconButton(
//                     //         onPressed: () {
//                     //           Navigator.pop(context);
//                     //         },
//                     //         icon: Icon(Icons.close))
//                     //   ],
//                     // ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           children: [
//                             CustomTextFieldRegister(
//                               height: AppSize.s30,
//                               width: MediaQuery.of(context).size.width / 7,
//                               controller: firstName,
//                               labelText: AppString.fname,
//                               keyboardType: TextInputType.text,
//                               padding: EdgeInsets.only(
//                                   bottom: AppPadding.p5, left: AppPadding.p20),
//                               onChanged: (value) {},
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return AppString.enterText;
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(
//                               height: AppSize.s10,
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width / 7,
//                               height: AppSize.s30,
//                               child: Container(
//                                 // decoration: BoxDecoration(
//                                 //   border: Border.all( color: Color(0xffB1B1B1),), // Set border color here
//                                 //   borderRadius: BorderRadius.circular(5.0), // Optional: Add rounded corners
//                                 // ),
//                                 child: MyDropdownTextField(
//                                   hint: AppString.speciality,
//                                   items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
//                                   onChanged: (String? newValue) {
//                                     print('Selected item: $newValue');
//                                   },
//                                 ),
//                               ),
//                             ),
//                             // SizedBox(
//                             //   width: MediaQuery.of(context).size.width/7,
//                             //   height: AppSize.s30,
//                             //   //alignment: Alignment.center,
//                             //   //color: Colors.cyan,
//                             //
//                             //   child: MyDropdownTextField(
//                             //     hint: AppString.speciality,
//                             //
//                             //     //width: MediaQuery.of(context).size.width/7,
//                             //     // height: AppSize.s25,
//                             //     items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
//                             //     onChanged: (String? newValue) {
//                             //
//                             //       print('Selected item: $newValue');
//                             //     },
//                             //   ),
//                             // ),
//
//                             SizedBox(
//                               height: AppSize.s10,
//                             ),
//                             CustomTextFieldRegister(
//                               height: AppSize.s30,
//                               width: MediaQuery.of(context).size.width / 7,
//                               controller: email,
//                               labelText: AppString.email,
//                               keyboardType: TextInputType.text,
//                               padding: EdgeInsets.only(
//                                   bottom: AppPadding.p5, left: AppPadding.p20),
//                               onChanged: (value) {},
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return AppString.enterText;
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(
//                               height: AppPadding.p10,
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width/7,
//                               height: AppSize.s30,
//                               //alignment: Alignment.center,
//                               //color: Colors.cyan,
//
//                               child: MyDropdownTextField(
//                                 hint: AppString.zone,
//
//                                 //width: MediaQuery.of(context).size.width/7,
//                                 // height: AppSize.s25,
//                                 items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
//                                 onChanged: (String? newValue) {
//                                   print('Selected item: $newValue');
//                                 },
//                               ),
//                             ),
//
//                           ],
//                         ),
//                         ///////////////////
//                         Column(
//                           children: [
//                             CustomTextFieldRegister(
//                               height: AppSize.s30,
//                               width: MediaQuery.of(context).size.width / 7,
//                               controller: lastName,
//                               labelText: AppString.lname,
//                               keyboardType: TextInputType.text,
//                               padding: EdgeInsets.only(
//                                   bottom: AppPadding.p5, left: AppPadding.p20),
//                               onChanged: (value) {},
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return AppString.enterText;
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(
//                               height: AppSize.s10,
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width/7,
//                               height: AppSize.s30,
//                               //alignment: Alignment.center,
//                               //color: Colors.cyan,
//
//                               child: MyDropdownTextField(
//                                 hint: AppString.clinician,
//
//                                 //width: MediaQuery.of(context).size.width/7,
//                                 // height: AppSize.s25,
//                                 items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
//                                 onChanged: (String? newValue) {
//                                   print('Selected item: $newValue');
//                                 },
//                               ),
//                             ),
//
//                             SizedBox(
//                               height: AppSize.s10,
//                             ),
//
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width/7,
//                               height: AppSize.s30,
//                               //alignment: Alignment.center,
//                               //color: Colors.cyan,
//
//                               child: MyDropdownTextField(
//                                 hint: AppString.city,
//
//                                 //width: MediaQuery.of(context).size.width/7,
//                                 // height: AppSize.s25,
//                                 items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
//                                 onChanged: (String? newValue) {
//                                   print('Selected item: $newValue');
//                                 },
//                               ),
//                             ),
//
//                             // MyDropdownButton(
//                             //   width: MediaQuery.of(context).size.width/7,
//                             //   height: AppSize.s25,
//                             //
//                             //   items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
//                             //  onChanged: (String? newValue) {
//                             //    print('Selected item: $newValue');
//                             //
//                             //  },),
//                             //
//                             //
//                             //
//                             // CustomTextFieldRegister(
//                             //
//                             //   height: AppSize.s25,
//                             //   width: MediaQuery.of(context).size.width/7,
//                             //   controller: controller,
//                             //   labelText: AppString.city,
//                             //   keyboardType: TextInputType.text,
//                             //   suffixIcon: Icon(Icons.arrow_drop_down,color: ColorManager.blueprime,),
//                             //   padding: EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
//                             //   onChanged: (value) {                          },
//                             //   validator: (value) {
//                             //     if (value == null || value.isEmpty) {
//                             //       return AppString.enterText;
//                             //     }
//                             //     return null;
//                             //   },
//                             // ),
//                             SizedBox(
//                               height: AppSize.s35,
//                             ),
//                           ],
//                         ),
//                         //////////////////////////
//                         Column(
//                           children: [
//                             CustomTextFieldRegister(
//                               height: AppSize.s30,
//                               width: MediaQuery.of(context).size.width / 7,
//                               controller: phone,
//                               labelText: AppString.phoneNumber,
//                               keyboardType: TextInputType.text,
//                               padding: EdgeInsets.only(
//                                   bottom: AppPadding.p5, left: AppPadding.p20),
//                               onChanged: (value) {},
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return AppString.enterText;
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(
//                               height: AppSize.s10,
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width/7,
//                               height: AppSize.s30,
//                               //alignment: Alignment.center,
//                               //color: Colors.cyan,
//
//                               child: MyDropdownTextField(
//                                 hint: AppString.reportingOffice,
//
//                                 //width: MediaQuery.of(context).size.width/7,
//                                 // height: AppSize.s25,
//                                 items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
//                                 onChanged: (String? newValue) {
//                                   print('Selected item: $newValue');
//                                 },
//                               ),
//                             ),
//
//                             SizedBox(
//                               height: AppSize.s10,
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width/7,
//                               height: AppSize.s30,
//                               //alignment: Alignment.center,
//                               //color: Colors.cyan,
//
//                               child: MyDropdownTextField(
//                                 hint: AppString.country,
//
//                                 //width: MediaQuery.of(context).size.width/7,
//                                 // height: AppSize.s25,
//                                 items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
//                                 onChanged: (String? newValue) {
//                                   print('Selected item: $newValue');
//                                 },
//                               ),
//                             ),
//
//                             SizedBox(
//                               height: AppSize.s35,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     ///////////////////////////////////////
//                     SizedBox(
//                       height: AppSize.s10,
//                     ),
//                     Divider(
//                       color: ColorManager.cream,
//                       thickness: 4,
//                     ),
//                     SizedBox(
//                       height: AppSize.s20,
//                     ),
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Column(
//                             children: [
//                               RegisterPopupMcq(
//                                 title: AppString.employment,
//                                 items: [
//                                   AppString.fullTime,
//                                   AppString.partTime,
//                                   AppString.perDiem
//                                 ],
//                                 onChanged: (selectedIndex) {
//                                   print(AppString.selectIndex + '$selectedIndex');
//                                   _selectedItemIndex = selectedIndex;
//                                 },
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               RegisterPopupMcq(
//                                 title: AppString.service,
//                                 items: [
//                                   AppString.homeHealth,
//                                   AppString.hospice,
//                                   AppString.homeCare,
//                                   AppString.palliative
//                                 ],
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                     ///////////////////////////////
//                     // SizedBox(
//                     //   height: AppSize.s15,
//                     // ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CustomIconButtonConst(
//                             text: AppString.next, onPressed: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context) => OfferLetterScreen()));
//
//                             }),
//                       ],
//                     ),
//                   ],
//                 )),
//           ),
//         );
//       },
//     );
//   }
// }


class RegisterEnrollAlertDialog {
  final TextEditingController controller = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  FocusNode _focusNode = FocusNode();
  int? _selectedItemIndex;

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.zero,
          // contentPadding: EdgeInsets.zero,
          title: Container(
            //height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)
                ),
                color: Color(0xff50B5E5)
            ),
            child:Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppString.enroll,
                    style: CustomTextStylesCommon.commonStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.white,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: ColorManager.white,))
                ],
              ),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorManager.white),
                child: Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       AppString.enroll,
                    //       style: CustomTextStylesCommon.commonStyle(
                    //         fontSize: FontSize.s14,
                    //         color: ColorManager.primary,
                    //         fontWeight: FontWeightManager.bold,
                    //       ),
                    //     ),
                    //     IconButton(
                    //         onPressed: () {
                    //           Navigator.pop(context);
                    //         },
                    //         icon: Icon(Icons.close))
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            CustomTextFieldRegister(
                              height: AppSize.s30,
                              width: MediaQuery.of(context).size.width / 7,
                              controller: firstName,
                              labelText: AppString.fname,
                              keyboardType: TextInputType.text,
                              padding: EdgeInsets.only(
                                  bottom: AppPadding.p5, left: AppPadding.p20),
                              onChanged: (value) {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppString.enterText;
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: AppSize.s10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 7,
                              height: AppSize.s30,
                              child: Container(
                                // decoration: BoxDecoration(
                                //   border: Border.all( color: Color(0xffB1B1B1),), // Set border color here
                                //   borderRadius: BorderRadius.circular(5.0), // Optional: Add rounded corners
                                // ),
                                child:
                                FutureBuilder<List<AEClinicalDiscipline>>(
                                  future: HrAddEmplyClinicalDisciplinApi(
                                      context, 1),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          child: Container(
                                            width: 180,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color:
                                                ColorManager.faintGrey),
                                          ),
                                        ),
                                      );
                                    }
                                    if (snapshot.hasData) {
                                      List<String> dropDownList = [];
                                      for (var i in snapshot.data!) {
                                        dropDownList.add(i.empType!);
                                      }
                                      return MyDropdownTextField(
                                        hint: AppString.speciality,
                                        // labelStyle: GoogleFonts.firaSans(
                                        //   fontSize: 10,
                                        //   color: Color(0xff575757),
                                        //   fontWeight: FontWeight.w400,
                                        // ),
                                        // labelFontSize: 10,
                                        items: dropDownList,
                                        onChanged: (newValue) {
                                          for (var a in snapshot.data!) {
                                            if (a.empType == newValue) {
                                              // int docType = a.employeeTypesId;
                                              // Do something with docType
                                            }
                                          }
                                        },
                                      );
                                    } else {
                                      return const Offstage();
                                    }
                                  },
                                ),
                                // MyDropdownTextField(
                                //   hint: AppString.speciality,
                                //   items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                                //   onChanged: (String? newValue) {
                                //     print('Selected item: $newValue');
                                //   },
                                // ),
                              ),
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width/7,
                            //   height: AppSize.s30,
                            //   //alignment: Alignment.center,
                            //   //color: Colors.cyan,
                            //
                            //   child: MyDropdownTextField(
                            //     hint: AppString.speciality,
                            //
                            //     //width: MediaQuery.of(context).size.width/7,
                            //     // height: AppSize.s25,
                            //     items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                            //     onChanged: (String? newValue) {
                            //
                            //       print('Selected item: $newValue');
                            //     },
                            //   ),
                            // ),

                            SizedBox(
                              height: AppSize.s10,
                            ),
                            CustomTextFieldRegister(
                              height: AppSize.s30,
                              width: MediaQuery.of(context).size.width / 7,
                              controller: email,
                              labelText: AppString.email,
                              keyboardType: TextInputType.text,
                              padding: EdgeInsets.only(
                                  bottom: AppPadding.p5, left: AppPadding.p20),
                              onChanged: (value) {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppString.enterText;
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: AppPadding.p10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/7,
                              height: AppSize.s30,
                              //alignment: Alignment.center,
                              //color: Colors.cyan,

                              child:
                              FutureBuilder<List<AEClinicalZone>>(
                                future: HrAddEmplyClinicalZoneApi(
                                  context,
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7),
                                        child: Container(
                                          width: 180,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300]),
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return MyDropdownTextField(
                                      hint: AppString.zone,
                                      // labelText: 'Zone',
                                      // labelStyle: TextStyle(
                                      //   fontSize: 12,
                                      //   color: Color(0xff575757),
                                      //   fontWeight: FontWeight.w400,
                                      // ),
                                      // labelFontSize: 12,
                                      items: ['Error'],
                                    );
                                  } else if (snapshot.hasData) {
                                    List<String> dropDownList = snapshot
                                        .data!
                                        .map((zone) => zone.zoneName ?? '')
                                        .toList();
                                    return MyDropdownTextField(
                                      hint: AppString.zone,
                                      // labelText: 'Zone',
                                      // labelStyle: TextStyle(
                                      //   fontSize: 12,
                                      //   color: Color(0xff575757),
                                      //   fontWeight: FontWeight.w400,
                                      // ),
                                      // labelFontSize: 12,
                                      items: dropDownList,
                                      onChanged: (newValue) {
                                        // Handle onChanged here if needed
                                      },
                                    );
                                  } else {
                                    return MyDropdownTextField(
                                      hint: AppString.zone,
                                      // labelText: 'Zone',
                                      // labelStyle: TextStyle(
                                      //   fontSize: 12,
                                      //   color: Color(0xff575757),
                                      //   fontWeight: FontWeight.w400,
                                      // ),
                                      // labelFontSize: 12,
                                      items: ['No Data'],
                                    );
                                  }
                                },
                              ),
                              // MyDropdownTextField(
                              //   hint: AppString.zone,
                              //
                              //   //width: MediaQuery.of(context).size.width/7,
                              //   // height: AppSize.s25,
                              //   items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                              //   onChanged: (String? newValue) {
                              //     print('Selected item: $newValue');
                              //   },
                              // ),
                            ),

                          ],
                        ),
                        ///////////////////
                        Column(
                          children: [
                            CustomTextFieldRegister(
                              height: AppSize.s30,
                              width: MediaQuery.of(context).size.width / 7,
                              controller: lastName,
                              labelText: AppString.lname,
                              keyboardType: TextInputType.text,
                              padding: EdgeInsets.only(
                                  bottom: AppPadding.p5, left: AppPadding.p20),
                              onChanged: (value) {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppString.enterText;
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: AppSize.s10,
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width/7,
                            //   height: AppSize.s30,
                            //   //alignment: Alignment.center,
                            //   //color: Colors.cyan,
                            //
                            //   child: MyDropdownTextField(
                            //     hint: AppString.clinician,
                            //
                            //     //width: MediaQuery.of(context).size.width/7,
                            //     // height: AppSize.s25,
                            //     items: dropDownList,
                            //     onChanged: (String? newValue) {
                            //       print('Selected item: $newValue');
                            //     },
                            //   ),
                            // ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/7,
                              height: AppSize.s30,
                              //alignment: Alignment.center,
                              //color: Colors.cyan,

                              child:
                              FutureBuilder<List<HRClinical>>(
                                future: companyAllHrClinicApi(context),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7),
                                        child: Container(
                                          width: 180,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300]),
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return MyDropdownTextField(
                                      hint: AppString.clinician,
                                      // labelText: 'Zone',
                                      // labelStyle: TextStyle(
                                      //   fontSize: 12,
                                      //   color: Color(0xff575757),
                                      //   fontWeight: FontWeight.w400,
                                      // ),
                                      // labelFontSize: 12,
                                      items: ['Error'],
                                    );
                                  } else if (snapshot.hasData) {
                                    List<String> dropDownList = snapshot
                                        .data!
                                        .map((clinician) => clinician.empType ?? '')
                                        .toList();
                                    return MyDropdownTextField(
                                      hint: AppString.clinician,
                                      // labelText: 'Zone',
                                      // labelStyle: TextStyle(
                                      //   fontSize: 12,
                                      //   color: Color(0xff575757),
                                      //   fontWeight: FontWeight.w400,
                                      // ),
                                      // labelFontSize: 12,
                                      items: dropDownList,
                                      onChanged: (newValue) {
                                        // Handle onChanged here if needed
                                      },
                                    );
                                  } else {
                                    return MyDropdownTextField(
                                      hint: AppString.clinician,
                                      // labelText: 'Zone',
                                      // labelStyle: TextStyle(
                                      //   fontSize: 12,
                                      //   color: Color(0xff575757),
                                      //   fontWeight: FontWeight.w400,
                                      // ),
                                      // labelFontSize: 12,
                                      items: ['No Data'],
                                    );
                                  }
                                },
                              ),
                              // MyDropdownTextField(
                              //   hint: AppString.zone,
                              //
                              //   //width: MediaQuery.of(context).size.width/7,
                              //   // height: AppSize.s25,
                              //   items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                              //   onChanged: (String? newValue) {
                              //     print('Selected item: $newValue');
                              //   },
                              // ),
                            ),

                            SizedBox(
                              height: AppSize.s10,
                            ),

                            SizedBox(
                              width: MediaQuery.of(context).size.width/7,
                              height: AppSize.s30,
                              //alignment: Alignment.center,
                              //color: Colors.cyan,

                              child:
                              FutureBuilder<List<AEClinicalCity>>(
                                future: HrAddEmplyClinicalCityApi(context),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7),
                                        child: Container(
                                          width: 180,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color:
                                              ColorManager.faintGrey),
                                        ),
                                      ),
                                    );
                                  }
                                  if (snapshot.hasData) {
                                    List<String> dropDownList = [];
                                    for (var i in snapshot.data!) {
                                      dropDownList.add(i.cityName!);
                                    }
                                    return MyDropdownTextField(
                                      hint: AppString.city,
                                      // labelStyle: GoogleFonts.firaSans(
                                      //   fontSize: 12,
                                      //   color: Color(0xff575757),
                                      //   fontWeight: FontWeight.w400,
                                      // ),
                                      // labelFontSize: 12,
                                      items: dropDownList,
                                    );
                                  } else {
                                    return const Offstage();
                                  }
                                },
                              ),),
                            //   MyDropdownTextField(
                            //     hint: AppString.city,
                            //
                            //     //width: MediaQuery.of(context).size.width/7,
                            //     // height: AppSize.s25,
                            //     items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                            //     onChanged: (String? newValue) {
                            //       print('Selected item: $newValue');
                            //     },
                            //   ),
                            // ),

                            // MyDropdownButton(
                            //   width: MediaQuery.of(context).size.width/7,
                            //   height: AppSize.s25,
                            //
                            //   items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                            //  onChanged: (String? newValue) {
                            //    print('Selected item: $newValue');
                            //
                            //  },),
                            //
                            //
                            //
                            // CustomTextFieldRegister(
                            //
                            //   height: AppSize.s25,
                            //   width: MediaQuery.of(context).size.width/7,
                            //   controller: controller,
                            //   labelText: AppString.city,
                            //   keyboardType: TextInputType.text,
                            //   suffixIcon: Icon(Icons.arrow_drop_down,color: ColorManager.blueprime,),
                            //   padding: EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                            //   onChanged: (value) {                          },
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return AppString.enterText;
                            //     }
                            //     return null;
                            //   },
                            // ),
                            SizedBox(
                              height: AppSize.s35,
                            ),
                          ],
                        ),
                        //////////////////////////
                        Column(
                          children: [
                            CustomTextFieldRegister(
                              height: AppSize.s30,
                              width: MediaQuery.of(context).size.width / 7,
                              controller: phone,
                              labelText: AppString.phoneNumber,
                              keyboardType: TextInputType.text,
                              padding: EdgeInsets.only(
                                  bottom: AppPadding.p5, left: AppPadding.p20),
                              onChanged: (value) {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppString.enterText;
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: AppSize.s10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/7,
                              height: AppSize.s30,
                              //alignment: Alignment.center,
                              //color: Colors.cyan,

                              child:FutureBuilder<List<AEClinicalDiscipline>>(
                                future: HrAddEmplyClinicalDisciplinApi(
                                    context, 1),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7),
                                        child: Container(
                                          width: 180,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color:
                                              ColorManager.faintGrey),
                                        ),
                                      ),
                                    );
                                  }
                                  if (snapshot.hasData) {
                                    List<String> dropDownList = [];
                                    for (var i in snapshot.data!) {
                                      dropDownList.add(i.empType!);
                                    }
                                    return MyDropdownTextField(
                                      hint: AppString.speciality,
                                      // labelStyle: GoogleFonts.firaSans(
                                      //   fontSize: 10,
                                      //   color: Color(0xff575757),
                                      //   fontWeight: FontWeight.w400,
                                      // ),
                                      // labelFontSize: 10,
                                      items: dropDownList,
                                      onChanged: (newValue) {
                                        for (var a in snapshot.data!) {
                                          if (a.empType == newValue) {
                                            // int docType = a.employeeTypesId;
                                            // Do something with docType
                                          }
                                        }
                                      },
                                    );
                                  } else {
                                    return const Offstage();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: AppSize.s10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/7,
                              height: AppSize.s30,
                              //alignment: Alignment.center,
                              //color: Colors.cyan,

                              child: FutureBuilder<List<AEClinicalReportingOffice>>(
                                future: HrAddEmplyClinicalReportingOfficeApi(context, 11),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7),
                                        child: Container(
                                          width: 180,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color:
                                              ColorManager.faintGrey),
                                        ),
                                      ),
                                    );
                                  }
                                  if (snapshot.hasData) {
                                    List<String> dropDownList = [];
                                    for (var i in snapshot.data!) {
                                      if (i.name != null) {
                                        dropDownList.add(i.name!);
                                      }
                                    }
                                    return MyDropdownTextField(items: dropDownList,hint: 'Reporting Office');
                                    //   CustomDropdownTextField(
                                    //   labelText: 'Reporting Office',
                                    //   labelStyle: GoogleFonts.firaSans(
                                    //     fontSize: 10,
                                    //     color: Color(0xff575757),
                                    //     fontWeight: FontWeight.w400,
                                    //   ),
                                    //   labelFontSize: 10,
                                    //   items: dropDownList,
                                    //   onChanged: (newValue) {
                                    //     for (var a in snapshot.data!) {
                                    //       if (a.name == newValue) {
                                    //         // int? docType = a.companyOfficeID;
                                    //       }
                                    //     }
                                    //   },
                                    // );
                                  } else {
                                    return const Offstage();
                                  }
                                },
                              ),
                            ),

                            SizedBox(
                              height: AppSize.s35,
                            ),
                          ],
                        ),
                      ],
                    ),
                    ///////////////////////////////////////
                    SizedBox(
                      height: AppSize.s10,
                    ),
                    Divider(
                      color: ColorManager.cream,
                      thickness: 4,
                    ),
                    SizedBox(
                      height: AppSize.s30,
                    ),
                    ///service radio button
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<List<AEClinicalService>>(
                              future:
                              HrAddEmplyClinicalServiceRadioButtonApi(
                                  context, 1),
                              builder: (context, snap) {
                                if (snap.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child:
                                        CircularProgressIndicator(
                                          color:
                                          ColorManager.blueprime,
                                        )),
                                  );
                                }
                                if (snap.hasData) {
                                  List<String> serviceName = [];
                                  for (var i in snap.data!) {
                                    serviceName.add(i.serviceName!);
                                  }
                                  return McqWidget(
                                    title: 'Service',
                                    items: serviceName,
                                    onChanged: (int) {},
                                  );
                                }
                                return SizedBox();
                              }),
                          // Column(
                          //   children: [
                          //     RegisterPopupMcq(
                          //       title: AppString.employment,
                          //       items: [
                          //         AppString.fullTime,
                          //         AppString.partTime,
                          //         AppString.perDiem
                          //       ],
                          //       onChanged: (selectedIndex) {
                          //         print(AppString.selectIndex + '$selectedIndex');
                          //         _selectedItemIndex = selectedIndex;
                          //       },
                          //     ),
                          //   ],
                          // ),
                          // Column(
                          //   children: [

                          // RegisterPopupMcq(
                          //   title: AppString.service,
                          //   items: [
                          //     AppString.homeHealth,
                          //     AppString.hospice,
                          //     AppString.homeCare,
                          //     AppString.palliative
                          //   ],
                          // ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                    ///employment radio button
                    // Expanded(
                    //   child: Row(
                    //     children: [
                    //       RegisterPopupMcq(
                    //         title: AppString.employment,
                    //         items: [
                    //           AppString.fullTime,
                    //           AppString.partTime,
                    //           AppString.perDiem
                    //         ],
                    //         onChanged: (selectedIndex) {
                    //           print(AppString.selectIndex + '$selectedIndex');
                    //           _selectedItemIndex = selectedIndex;
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    ///////////////////////////////
                    // SizedBox(
                    //   height: AppSize.s15,
                    // ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          McqWidget(title: AppString.employment,
                              items: [
                                AppString.fullTime,
                                AppString.partTime,
                                AppString.perDiem
                              ],),
                        ],
                      ),
                    ),
                // RegisterPopupMcq(
                //                 title: AppString.employment,
                //                 items: [
                //                   AppString.fullTime,
                //                   AppString.partTime,
                //                   AppString.perDiem
                //                 ],
                //                 onChanged: (selectedIndex) {
                //                   print(AppString.selectIndex + '$selectedIndex');
                //                   _selectedItemIndex = selectedIndex;
                //                 },
                //               ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconButtonConst(
                            text: AppString.next, onPressed: () {
                              showDialog(context: context, builder: (BuildContext context) {
                                return OfferLetterScreen();
                              });
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => OfferLetterScreen()));

                        }),
                      ],
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
