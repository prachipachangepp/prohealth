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
          content: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ColorManager.white),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppString.enroll,
                        style: CustomTextStylesCommon.commonStyle(
                          fontSize: FontSize.s14,
                          color: ColorManager.primary,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close))
                    ],
                  ),
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
                            width: MediaQuery.of(context).size.width/7,
                            height: AppSize.s30,
                            //alignment: Alignment.center,
                            //color: Colors.cyan,

                            child: MyDropdownTextField(
                              hint: AppString.speciality,

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
                    height: AppSize.s5,
                  ),
                  Divider(
                    color: ColorManager.cream,
                    thickness: 4,
                  ),
                  // Expanded(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  //       RegisterPopupMcq(
                  //         title: AppString.service,
                  //         items: [
                  //           AppString.homeHealth,
                  //           AppString.hospice,
                  //           AppString.homeCare,
                  //           AppString.palliative
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),

                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          RegisterPopupMcq(
                            title: AppString.service,
                            items: [
                              AppString.homeHealth,
                              AppString.hospice,
                              AppString.homeCare,
                              AppString.palliative
                            ],
                          )
                        ],
                      ),
                    ),
                  ),



                  ///////////////////////////////
                  SizedBox(
                    height: AppSize.s6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconButtonConst(
                          text: AppString.next, onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => OfferLetterScreen()));

                        showDialog(
                            context: context, builder: (BuildContext context){
                              return OfferLetterScreen();
                        },);
                          }),
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }
}
