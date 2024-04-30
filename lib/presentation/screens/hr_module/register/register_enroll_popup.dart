import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';

import '../../../widgets/custom_icon_button_constant.dart';
import '../../../widgets/mcq_const_widget/mcq_const_widget.dart';

///saloni

class RegisterEnrollAlertDialog {
  final TextEditingController controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  int? _selectedItemIndex;
  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
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
                            height: AppSize.s26,
                            width: MediaQuery.of(context).size.width / 7,
                            controller: controller,
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
                          CustomTextFieldRegister(
                            height: AppSize.s25,
                            width: MediaQuery.of(context).size.width / 7,
                            controller: controller,
                            labelText: AppString.speciality,
                            keyboardType: TextInputType.text,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down,
                              color: ColorManager.blueprime,
                            ),
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
                          CustomTextFieldRegister(
                            height: AppSize.s25,
                            width: MediaQuery.of(context).size.width / 7,
                            controller: controller,
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
                          CustomTextFieldRegister(
                            height: AppSize.s25,
                            width: MediaQuery.of(context).size.width / 7,
                            controller: controller,
                            labelText: AppString.zone,
                            keyboardType: TextInputType.text,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down,
                              color: ColorManager.blueprime,
                            ),
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
                        ],
                      ),
                      Column(
                        children: [
                          CustomTextFieldRegister(
                            height: AppSize.s25,
                            width: MediaQuery.of(context).size.width / 7,
                            controller: controller,
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
                          CustomTextFieldRegister(
                            height: AppSize.s25,
                            //cursorHeight: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            controller: controller,
                            labelText: AppString.typeClinician,
                            keyboardType: TextInputType.text,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down,
                              color: ColorManager.blueprime,
                            ),
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
                          CustomTextFieldRegister(
                            height: AppSize.s25,
                            width: MediaQuery.of(context).size.width / 7,
                            controller: controller,
                            labelText: AppString.city,
                            keyboardType: TextInputType.text,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down,
                              color: ColorManager.blueprime,
                            ),
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
                            height: AppSize.s35,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CustomTextFieldRegister(
                            height: AppSize.s25,
                            width: MediaQuery.of(context).size.width / 7,
                            controller: controller,
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
                          CustomTextFieldRegister(
                            height: AppSize.s25,
                            width: MediaQuery.of(context).size.width / 7,
                            controller: controller,
                            labelText: AppString.reportingOffice,
                            keyboardType: TextInputType.text,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down,
                              color: ColorManager.blueprime,
                            ),
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
                            height: 10,
                          ),
                          CustomTextFieldRegister(
                            height: AppSize.s27,
                            width: MediaQuery.of(context).size.width / 7,
                            controller: controller,
                            labelText: AppString.country,
                            keyboardType: TextInputType.text,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down,
                              color: ColorManager.blueprime,
                            ),
                            padding: EdgeInsets.only(
                                bottom: AppPadding.p5, left: AppPadding.p20),
                            onChanged: (value) {
                              // Handle text change
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppString.enterText;
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: AppSize.s35,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s5,
                  ),
                  Divider(
                    color: ColorManager.cream,
                    thickness: 4,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  SizedBox(
                    height: AppSize.s6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconButtonConst(
                          text: AppString.next, onPressed: () {}),
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }
}
