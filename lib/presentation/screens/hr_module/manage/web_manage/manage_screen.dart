import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/bottom_row.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/add_vaccination_child_tabbar.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/compensation_child_tabbar.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/other_child_tabbar.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/head_tabbar_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/head_tabbar_screen/banking_head_tabbar.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/head_tabbar_screen/health_records_head_tabbar.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/head_tabbar_screen/inventory_head_tabbar.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/head_tabbar_screen/pay_rates_head_tabbar.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/head_tabbar_screen/termination_head_tabbar.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/head_tabbar_screen/time_off_head_tabbar.dart';
import 'package:prohealth/presentation/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/profile_bar/profile_bar.dart';
import '../controller/controller.dart';
import '../widgets/child_tabbar_screen/documents_child/acknowledgements_child_tabbar.dart';
import '../widgets/child_tabbar_screen/qualifications_child/education_child_tabbar.dart';
import '../widgets/child_tabbar_screen/qualifications_child/employment_child_tabbar.dart';
import '../widgets/child_tabbar_screen/qualifications_child/licenses_child_tabbar.dart';
import '../widgets/child_tabbar_screen/qualifications_child/references_child_tabbar.dart';
///done by saloni
class ManageScreen extends StatefulWidget {
  @override
  State<ManageScreen> createState() => _ManageScreenState();
}
class _ManageScreenState extends State<ManageScreen> {
  late CenteredTabBarChildController childController;
  late CenteredTabBarChildController childControlleOne;
  late CenteredTabBarController centeredTabBarController;

  @override
  void initState() {
    childController = CenteredTabBarChildController(
      tabs: [
        Tab(text: 'Employment'),
        Tab(text: 'Education'),
        Tab(text: 'References'),
        Tab(text: 'Licenses'),
      ],
      tabViews: [
        ///employment
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  margin: EdgeInsets.only(right: 40),
                  child: CustomIconButton(
                      text: 'Add', icon: Icons.add, onPressed: () {}),
                ),
              ],
            ),
            EmploymentContainerConstant(),
          ],
        ),
        ///education
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  margin: EdgeInsets.only(right: 20),
                  child: CustomIconButton(
                      text: 'Add', icon: Icons.add, onPressed: () {}),
                ),
              ],
            ),
            EducationChildTabbar(),
          ],
        ),
        ///reference
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  margin: EdgeInsets.only(right: 20),
                  child: CustomIconButton(
                      text: 'Add', icon: Icons.add, onPressed: () {}),
                ),
              ],
            ),
            SizedBox(height: 1,),
            ReferencesChildTabbar(),
          ],
        ),
        ///license
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 27,
                  width: 250,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(top: 2,bottom: 1,left: 4),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                    border: Border.all(color: Color(0xffB1B1B1)), // Black border
                    borderRadius: BorderRadius.circular(5), // Rounded corners
                  ),
                  child: DropdownButtonFormField<String>(
                    focusColor: Colors.transparent,
                    icon: Icon(Icons.arrow_drop_down_sharp,color: Color(0xff50B5E5),),
                    decoration: InputDecoration.collapsed(hintText: ''),
                    items: <String>['Select Document', 'Drivers License', 'CPR', 'Liability Insurence']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                    },
                    value: 'Select Document',style: TextStyle(color: Color(0xff686464),fontSize: 12),
                  ),
                ),
                Container(
                  width: 100,
                  margin: EdgeInsets.only(right: 20),
                  child: CustomIconButton(
                      text: 'Add', icon: Icons.add, onPressed: () {}),
                ),
              ],
            ),
            SizedBox(height: 1,),
            LicensesChildTabbar(),
          ],
        ),
      ],
    );
    childControlleOne = CenteredTabBarChildController(tabs: [
      Tab(text: 'Acknowledgements'),
      Tab(text: 'Compensation'),
      Tab(text: 'Additional Vaccination'),
      Tab(text: 'Others'),
    ], tabViews: [
      ///aknowledgment
      Column(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
             // width: 100,
              margin: EdgeInsets.only(right: 20),
              child: CustomIconButton(
                  text: 'Add New', icon: Icons.add, onPressed: () {}),
            ),
          ],
        ),
          SizedBox(height: 30,),
          AcknowledgementsChildBar(),
        ],
      ),
      ///compensation
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                // width: 100,
                margin: EdgeInsets.only(right: 60),
                child: CustomIconButton(
                    text: 'Add New', icon: Icons.add, onPressed: () {}),
              ),
            ],
          ),
          SizedBox(height: 20,),
          CompensationChildTabbar(),
        ],
      ),
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                // width: 100,
                margin: EdgeInsets.only(right: 60),
                child: CustomIconButton(
                    text: 'Add New', icon: Icons.add, onPressed: () {}),
              ),
            ],
          ),
          SizedBox(height: 20,),
          AdditionalVaccinationsChildBar(),
        ],
      ),
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                // width: 100,
                margin: EdgeInsets.only(right: 60),
                child: CustomIconButton(
                    text: 'Add New', icon: Icons.add, onPressed: () {}),
              ),
            ],
          ),
          SizedBox(height: 20,),
          OtherChildTabbar(),
        ],
      ),
    ]);

    centeredTabBarController = Get.put(CenteredTabBarController(
      tabs: [
        Tab(text: 'Qualifications'),
        Tab(text: 'Documents'),
        Tab(text: 'Banking'),
        Tab(text: 'Health Records'),
        Tab(text: 'Inventory'),
        Tab(text: 'Pay Rates'),
        Tab(text: 'Termination'),
        Tab(text: 'Time Off'),
      ],
      tabViews: [
        CenteredTabBarChild(childController),
        CenteredTabBarChild(childControlleOne),
        BankingHeadTabbar(),
        HealthRecordsHeadTabbar(),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  // width: 100,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        //spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(right: 10),
                  child: CustomIconButton(
                      text: 'Add New', icon: Icons.add, onPressed: () {}),
                ),
              ],
            ),
            SizedBox(height: 20,),
            InventoryHeadTabbar(),
          ],
        ),
        PayRatesHeadTabbar(),
        TerminationHeadTabbar(),
        TimeOffHeadTabbar(),
      ],
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      /// green blue container
      ProfileBar(),
      ///TabBar
      CenteredTabBar(),
      /// bottom row
      BottomBarRow(),
    ]);
  }
}
