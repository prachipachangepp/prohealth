import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_role_manager_tab/widgets/ci_role_container_constant.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../widgets/widgets/login_screen/desk_dashboard_hrm.dart';
import '../../../../../responsive_screen_sm.dart';
import '../../../../../widgets/button_constant.dart';

class RoleManagerSales extends StatelessWidget {
  const RoleManagerSales({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    child: SingleChildScrollView(
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p220),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pick Employee',
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s10,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.fmediumgrey,
                        decoration: TextDecoration.none,
                      ),),
                    SizedBox(height: AppSize.s4,),
                    Container(
                      height: 30,
                      width: 354,
                      // margin: EdgeInsets.symmetric(horizontal: 20),
                      padding:
                      EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Color(0xff686464).withOpacity(0.5),
                            width: 1), // Black border
                        borderRadius:
                        BorderRadius.circular(8), // Rounded corners
                      ),
                      child: DropdownButtonFormField<String>(
                        focusColor: Colors.transparent,
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Color(0xff686464),
                        ),
                        decoration: InputDecoration.collapsed(hintText: ''),
                        items: <String>[
                          'ST',
                          'Option 2',
                          'Option 3',
                          'Option 4'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {},
                        value: 'ST',
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.fmediumgrey,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
            ],),
          ),
          SizedBox(height: 20,),
          ///row 1
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CIRoleContainerConstant(
                'Referral Resource Manager',
                AssetImage("images/r_r_m.png"),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width /
                    20,
              ),
              InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //         const HomeScreenHRM()));
                  },
                  child: const CIRoleContainerConstant(
                    'Business Intelligence & Reports',
                    AssetImage("images/b_i_r.png"),
                  )),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width /
                    20,
              ),
              CIRoleContainerConstant(
                'Intake & Scheduler',
                AssetImage("images/i_s.png"),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width /
                    20,
              ),
              CIRoleContainerConstant(
                'Rehab',
                AssetImage("images/rehab.png"),
              ),
            ],
          ),
          SizedBox(height: 20,),
          ///row 2
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CIRoleContainerConstant(
                'Home Care',
                AssetImage("images/h_c.png"),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width /
                    20,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ResponsiveScreenEM()));
                  },
                  child: const CIRoleContainerConstant(
                    'Establishment Manager',
                    AssetImage("images/e_m.png"),
                  )),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width /
                    20,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const HomeScreenHRM()));
                  },
                  child: const CIRoleContainerConstant(
                    'Human Resource Manager',
                    AssetImage("images/h_r_m.png"),
                  )),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width /
                    20,
              ),
              CIRoleContainerConstant(
                'Home Health EMR',
                AssetImage("images/h_h_emr.png"),
              ),
            ],
          ),
          SizedBox(height: 20,),
          ///row 3
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CIRoleContainerConstant(
                'Hospice EMR',
                AssetImage("images/h_emr.png"),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width /
                    20,
              ),
              CIRoleContainerConstant(
                'Finance',
                AssetImage("images/finance.png"),
              ),
              SizedBox(width:  MediaQuery.of(context)
                  .size
                  .width /
                  2.5,)
            ],
          ),
          SizedBox(height: 40,),
          ///button
          Center(
            child: CustomElevatedButton(
              width: AppSize.s105,
              height: AppSize.s30,
              text: AppStringEM.save,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    ),
    );
  }
}
