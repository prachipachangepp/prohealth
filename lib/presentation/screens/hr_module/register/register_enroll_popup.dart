import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/register/offer_letter_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/dropdown_const.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../widgets/widgets/custom_icon_button_constant.dart';
import 'widgets/mcq_widget_register.dart';

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
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.5,
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
                                child: MyDropdownTextField(
                                  hint: AppString.speciality,
                                  items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                                  onChanged: (String? newValue) {
                                    print('Selected item: $newValue');
                                  },
                                ),
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

                              child: MyDropdownTextField(
                                hint: AppString.zone,

                                //width: MediaQuery.of(context).size.width/7,
                                // height: AppSize.s25,
                                items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                                onChanged: (String? newValue) {
                                  print('Selected item: $newValue');
                                },
                              ),
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width/7,
                              height: AppSize.s30,
                              //alignment: Alignment.center,
                              //color: Colors.cyan,

                              child: MyDropdownTextField(
                                hint: AppString.clinician,

                                //width: MediaQuery.of(context).size.width/7,
                                // height: AppSize.s25,
                                items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                                onChanged: (String? newValue) {
                                  print('Selected item: $newValue');
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

                              child: MyDropdownTextField(
                                hint: AppString.city,

                                //width: MediaQuery.of(context).size.width/7,
                                // height: AppSize.s25,
                                items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                                onChanged: (String? newValue) {
                                  print('Selected item: $newValue');
                                },
                              ),
                            ),

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

                              child: MyDropdownTextField(
                                hint: AppString.reportingOffice,

                                //width: MediaQuery.of(context).size.width/7,
                                // height: AppSize.s25,
                                items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                                onChanged: (String? newValue) {
                                  print('Selected item: $newValue');
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

                              child: MyDropdownTextField(
                                hint: AppString.country,

                                //width: MediaQuery.of(context).size.width/7,
                                // height: AppSize.s25,
                                items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                                onChanged: (String? newValue) {
                                  print('Selected item: $newValue');
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
                      height: AppSize.s20,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              RegisterPopupMcq(
                                title: AppString.employment,
                                items: [
                                  AppString.fullTime,
                                  AppString.partTime,
                                  AppString.perDiem
                                ],
                                onChanged: (selectedIndex) {
                                  print(AppString.selectIndex + '$selectedIndex');
                                  _selectedItemIndex = selectedIndex;
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              RegisterPopupMcq(
                                title: AppString.service,
                                items: [
                                  AppString.homeHealth,
                                  AppString.hospice,
                                  AppString.homeCare,
                                  AppString.palliative
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    ///////////////////////////////
                    // SizedBox(
                    //   height: AppSize.s15,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconButtonConst(
                            text: AppString.next, onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => OfferLetterScreen()));

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
