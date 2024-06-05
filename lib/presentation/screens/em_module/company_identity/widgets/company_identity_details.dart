import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/bottom_row.dart';

import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';

class CIDetailsScreen extends StatelessWidget {
  const CIDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController secNumberController = TextEditingController();
    TextEditingController primNumController = TextEditingController();
    TextEditingController altNumController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    return
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p14),
              child: Row(
                children: [
                  Text(
                    'Details',
                    style: CompanyIdentityManageHeadings.customTextStyle(context),
                  ),
                ],
              ),
            ),
            Container(
              height: AppSize.s250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 2,
                  color: ColorManager.black.withOpacity(0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withOpacity(0.15),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SMTextFConst(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        text: 'Office Name',
                      ),
                      SizedBox(height: AppSize.s4),
                      SMTextFConst(
                        controller: secNumberController,
                        keyboardType: TextInputType.number,
                        text: 'Secondary Number',
                      ),
                      SizedBox(height: AppSize.s4),
                      SMTextFConst(
                        controller: addressController,
                        keyboardType: TextInputType.text,
                        text: 'Address',
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SMTextFConst(
                        controller: primNumController,
                        keyboardType: TextInputType.number,
                        text: 'Primary Number',
                      ),
                      SizedBox(height: AppSize.s4),
                      SMTextFConst(
                        controller: altNumController,
                        keyboardType: TextInputType.number,
                        text: 'Alternative Phone',
                      ),
                      SizedBox(height: AppSize.s4),
                      SMTextFConst(
                        controller: emailController,
                        keyboardType: TextInputType.text,
                        text: 'Primary Email',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p14),
              child: Row(
                children: [
                  Text(
                    'Services',
                    style: CompanyIdentityManageHeadings.customTextStyle(context),
                  ),
                ],
              ),
            ),
            Container(
              height: AppSize.s181,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 2,
                  color: ColorManager.black.withOpacity(0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withOpacity(0.15),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
                color: Colors.white,
              ),
              child: Row(),
            ),
          ],
        ),
      );

    //   Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: AppPadding.p120),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Expanded(
    //         flex: 1,
    //         child: Row(
    //           children: [
    //             Text('Details',
    //               style: CompanyIdentityManageHeadings.customTextStyle(context),),
    //           ],
    //         ),
    //       ),
    //       Expanded(
    //         flex: 6,
    //         child: Container(
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(16),
    //             border: Border.all(
    //               width: 2,
    //               color: ColorManager.black.withOpacity(0.2)
    //             ),
    //             boxShadow: [
    //               BoxShadow(
    //                 color: ColorManager.black.withOpacity(0.15),
    //                 offset: Offset(0, 4),
    //                 blurRadius: 4,
    //                 spreadRadius: 0,
    //               ),
    //             ],
    //             color: Colors.white,
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   SMTextFConst(controller: nameController,
    //                       keyboardType: TextInputType.text,
    //                       text: 'Office Name'),
    //                   SizedBox(height: AppSize.s4,),
    //                   SMTextFConst(controller: secNumberController,
    //                       keyboardType: TextInputType.number,
    //                       text: 'Secondary Number'),
    //                   SizedBox(height: AppSize.s4,),
    //                   SMTextFConst(controller: addressController,
    //                       keyboardType: TextInputType.text,
    //                       text: 'Address'),
    //                 ],),
    //               Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                 SMTextFConst(controller: primNumController,
    //                     keyboardType: TextInputType.number,
    //                     text: 'Primary Number'),
    //                 SizedBox(height: AppSize.s4,),
    //                 SMTextFConst(controller: altNumController,
    //                     keyboardType: TextInputType.number,
    //                     text: 'Alternative Phone'),
    //                   SizedBox(height: AppSize.s4,),
    //                 SMTextFConst(controller: emailController,
    //                     keyboardType: TextInputType.text,
    //                     text: 'Primary Email'),
    //               ],),
    //
    //             ],
    //           ),
    //         ),
    //       ),
    //
    //       Expanded(
    //         flex: 1,
    //         child: Row(
    //           children: [
    //             Text('Services',
    //               style: CompanyIdentityManageHeadings.customTextStyle(context),),
    //           ],
    //         ),
    //       ),
    //       Expanded(
    //           flex: 3,
    //           child:Container(
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(16),
    //               border: Border.all(
    //                   width: 2,
    //                   color: ColorManager.black.withOpacity(0.2)
    //               ),
    //               boxShadow: [
    //                 BoxShadow(
    //                   color: ColorManager.black.withOpacity(0.15),
    //                   offset: Offset(0, 4),
    //                   blurRadius: 4,
    //                   spreadRadius: 0,
    //                 ),
    //               ],
    //               color: Colors.white,
    //             ),
    //             child: Row(),
    //           )),
    //       Expanded(
    //         flex: 1,
    //         child: Row(
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
