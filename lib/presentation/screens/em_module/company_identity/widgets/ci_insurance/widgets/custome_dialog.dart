import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/confirmation_constant.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../../widgets/button_constant.dart';
import '../../../../widgets/text_form_field_const.dart';
import '../../ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import '../../whitelabelling/success_popup.dart';

class CustomPopup extends StatelessWidget {
   final TextEditingController controller;
   final VoidCallback onPressed;
   final String title;
   CustomPopup({Key? key,required this.controller, required this.onPressed, required this.title}) : super(key: key);
   int zoneId=1;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s550,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              height: AppSize.s40,
              width: AppSize.s400,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaSans(
                      fontSize: 13,
                      fontWeight:
                      FontWeightManager.semiBold,
                      color: ColorManager.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close,
                      color: ColorManager.white,),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: controller,
                    keyboardType: TextInputType.text,
                    text: 'Vendor Name',
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: controller,
                    keyboardType: TextInputType.text,
                    text: AppString.address,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: controller,
                    keyboardType: TextInputType.text,
                    text: AppString.city,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: controller,
                    keyboardType: TextInputType.text,
                    text: AppString.email,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: controller,
                    keyboardType: TextInputType.text,
                    text: AppString.phone,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: controller,
                    keyboardType: TextInputType.text,
                    text: AppString.workemail,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: controller,
                    keyboardType: TextInputType.text,
                    text:"Work Phone",
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),
            // Column(
            //   children: [Text(AppString.zone),
            //     FutureBuilder<List<AEClinicalZone>>(
            //       future: HrAddEmplyClinicalZoneApi(
            //         context,
            //       ),
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState ==
            //             ConnectionState.waiting) {
            //           return Shimmer.fromColors(
            //             baseColor: Colors.grey[300]!,
            //             highlightColor: Colors.grey[100]!,
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(
            //                   horizontal: 7),
            //               child: Container(
            //                 width: AppSize.s250,
            //                 height: AppSize.s40,
            //                 decoration: BoxDecoration(
            //                     color: Colors.grey[300]),
            //               ),
            //             ),
            //           );
            //         } else if (snapshot.hasError) {
            //           return CustomDropdownTextField(
            //             labelText: 'Zone',
            //             labelStyle: TextStyle(
            //               fontSize: 12,
            //               color: Color(0xff575757),
            //               fontWeight: FontWeight.w400,
            //             ),
            //             labelFontSize: 12,
            //             items: ['Error'],
            //           );
            //         } else if (snapshot.hasData) {
            //           List<String> dropDownList = snapshot.data!
            //               .map((zone) => zone.zoneName ?? '')
            //               .toList();
            //           print("Zone: ");
            //           return CustomDropdownTextField(
            //             labelText: 'Zone',
            //             labelStyle: GoogleFonts.firaSans(
            //               fontSize: 12,
            //               color: Color(0xff575757),
            //               fontWeight: FontWeight.w400,
            //             ),
            //             labelFontSize: 12,
            //             items: dropDownList,
            //             onChanged: (newValue) {
            //               // Handle onChanged here if needed
            //             },
            //           );
            //         } else {
            //           return CustomDropdownTextField(
            //             labelText: 'Zone',
            //             labelStyle: GoogleFonts.firaSans(
            //               fontSize: 12,
            //               color: Color(0xff575757),
            //               fontWeight: FontWeight.w400,
            //             ),
            //             labelFontSize: 12,
            //             items: ['No Data'],
            //           );
            //         }
            //       },
            //     ),
            //
            //
            //   ],
            // ),


            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.zone,
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color:ColorManager.granitegray,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 4),
                  FutureBuilder<List<AEClinicalZone>>(
                      future: HrAddEmplyClinicalZoneApi(context),
                      builder: (context,snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 350,
                                height: 30,
                                decoration: BoxDecoration(color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
                              )
                          );
                        }
                        if (snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              AppString.dataNotFound,
                              style: CustomTextStylesCommon.commonStyle(
                                fontWeight: FontWeightManager.medium,
                                fontSize: FontSize.s12,
                                color: ColorManager.mediumgrey,
                              ),
                            ),
                          );
                        }
                        if(snapshot.hasData){
                          List dropDown = [];
                          int docType = 0;
                          List<DropdownMenuItem<String>> dropDownMenuItems = [];
                          for(var i in snapshot.data!){
                            dropDownMenuItems.add(
                              DropdownMenuItem<String>(
                                child: Text(i.zoneName!),
                                value: i.zoneName ,
                              ),
                            );
                          }
                          return CICCDropdown(
                              initialValue: AppString.zone,
                              onChange: (val){
                                for(var a in snapshot.data!){
                                  if(a.zoneName == val){
                                    docType = a.zoneID!;
                                     zoneId= docType;

                                  }
                                }

                                print(":::${docType}");
                                print(":::<>${zoneId}");
                              },
                              items:dropDownMenuItems
                          );
                        }else{
                          return SizedBox();
                        }
                      }
                  ),
                ]
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p24),
              child: Center(
                child: CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.Add,
                  onPressed: () {
                    onPressed();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddSuccessPopup(message: 'Added Successfully',);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
