import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/compensation_add_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/health_record_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/other_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/hr_resources/string_manager.dart';
import '../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../widgets/widgets/profile_bar/profile_bar.dart';
import '../../../em_module/widgets/button_constant.dart';
import '../../../em_module/widgets/text_form_field_const.dart';
import '../controller/controller.dart';
import '../widgets/bottom_row.dart';
import '../widgets/child_tabbar_constant.dart';
import '../widgets/child_tabbar_screen/documents_child/acknowledgements_child_tabbar.dart';
import '../widgets/child_tabbar_screen/documents_child/add_vaccination_child_tabbar.dart';
import '../widgets/child_tabbar_screen/documents_child/compensation_child_tabbar.dart';
import '../widgets/child_tabbar_screen/documents_child/other_child_tabbar.dart';
import '../widgets/child_tabbar_screen/qualifications_child/education_child_tabbar.dart';
import '../widgets/child_tabbar_screen/qualifications_child/employment_child_tabbar.dart';
import '../widgets/child_tabbar_screen/qualifications_child/licenses_child_tabbar.dart';
import '../widgets/child_tabbar_screen/qualifications_child/references_child_tabbar.dart';
import '../widgets/head_tabbar_constant.dart';
import '../widgets/child_tabbar_screen/bancking_child/banking_head_tabbar.dart';
import '../widgets/child_tabbar_screen/health_record_child/health_records_head_tabbar.dart';
import '../widgets/child_tabbar_screen/payrates_child/pay_rates_head_tabbar.dart';
import '../widgets/child_tabbar_screen/termination/termination_head_tabbar.dart';
import '../widgets/child_tabbar_screen/timeoff_child/time_off_head_tabbar.dart';
///done by saloni
class ManageScreen extends StatefulWidget {
  @override
  State<ManageScreen> createState() => _ManageScreenState();
}
class _ManageScreenState extends State<ManageScreen> {
  late CenteredTabBarChildController childController;
  late CenteredTabBarChildController childControlleOne;
  late CenteredTabBarController centeredTabBarController;
  TextEditingController nameController = TextEditingController();
  // TextEditingController secfaxController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController secNumberController = TextEditingController();
  TextEditingController primNumController = TextEditingController();
  TextEditingController altNumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController hcoNumController = TextEditingController();
  TextEditingController medicareController = TextEditingController();
  TextEditingController npiNumController = TextEditingController();
  TextEditingController faxontroller = TextEditingController();
  ///
  TextEditingController addressCtlr = TextEditingController();
  TextEditingController nameCtlr = TextEditingController();


  TextEditingController compensitionAddIdController = TextEditingController();
  TextEditingController compensitionAddNameController = TextEditingController();

  TextEditingController healthRecordAddIdController = TextEditingController();
  TextEditingController healthRecordAddNameController = TextEditingController();

  TextEditingController otherAddIdController = TextEditingController();
  TextEditingController otherAddNameController = TextEditingController();

  @override
  void initState() {
    childController = CenteredTabBarChildController(
      tabs: [
        Tab(text: AppStringHr.employment),
        Tab(text: AppStringHr.education),
        Tab(text: AppStringHr.referance),
        Tab(text: AppStringHr.license),
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
                  child: CustomIconButtonConst(
                      text: AppStringHr.add, icon: Icons.add, onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          content: Container(
                            height: 320,
                            width: 900,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Add Employee",
                                      style: GoogleFonts.firaSans(
                                      color: ColorManager.primary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                    ), ),
                                    IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: (){},
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 30,
                                    width: 160,
                                    child: CustomIconButtonConst(
                                      text: 'Add Employment',
                                      icon: Icons.add,
                                      onPressed: () {  },),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        HRManageTextField(
                                          controller: nameController,
                                          keyboardType: TextInputType.text,
                                          text: AppStringEM.companyName,
                                          cursorHeight: 9,
                                          labelText: 'Final Position Title',
                                          labelStyle: GoogleFonts.firaSans(
                                            color: ColorManager.greylight,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none,
                                          ),
                                          labelFontSize: 12,
                                        ),
                                        SizedBox(height: AppSize.s4),
                                        HRManageTextField(

                                          controller: nameController,
                                          keyboardType: TextInputType.text,
                                          text: AppStringEM.companyName,
                                          cursorHeight: 9,
                                          labelText: 'End Date',
                                          labelStyle: GoogleFonts.firaSans(
                                            color: ColorManager.greylight,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none,
                                          ),
                                          labelFontSize: 12,
                                        ),
                                        SizedBox(height: AppSize.s4),
                                        Text("Current work here",
                                            style: GoogleFonts.firaSans(
                                          color: ColorManager.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none,
                                        ), ),
                                        SizedBox(height: AppSize.s4),
                                        HRManageTextField(
                                          controller: nameController,
                                          keyboardType: TextInputType.text,
                                          text: AppStringEM.companyName,
                                          cursorHeight: 9,
                                          labelText: 'City',
                                          labelStyle: GoogleFonts.firaSans(
                                            color: ColorManager.greylight,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none,
                                          ),
                                          labelFontSize: 12,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        HRManageTextField(

                                          controller: nameController,
                                          keyboardType: TextInputType.text,
                                          text: AppStringEM.companyName,
                                          cursorHeight: 9,
                                          labelText: 'Final Position Title',
                                          labelStyle: GoogleFonts.firaSans(
                                            color: ColorManager.greylight,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none,
                                          ),
                                          labelFontSize: 12,
                                        ),
                                        SizedBox(height: AppSize.s4),
                                        HRManageTextField(

                                          controller: nameController,
                                          keyboardType: TextInputType.text,
                                          text: AppStringEM.companyName,
                                          cursorHeight: 9,
                                          labelText: 'Final Position Title',
                                          labelStyle: GoogleFonts.firaSans(
                                            color: ColorManager.greylight,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none,
                                          ),
                                          labelFontSize: 12,
                                        ),
                                        SizedBox(height: AppSize.s4),
                                        HRManageTextField(

                                          controller: nameController,
                                          keyboardType: TextInputType.text,
                                          text: AppStringEM.companyName,
                                          cursorHeight: 9,
                                          labelText: 'Final Position Title',
                                          labelStyle: GoogleFonts.firaSans(
                                            color: ColorManager.greylight,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none,
                                          ),
                                          labelFontSize: 12,
                                        ),
                                        SizedBox(height: AppSize.s4),
                                        HRManageTextField(

                                          controller: nameController,
                                          keyboardType: TextInputType.text,
                                          text: AppStringEM.companyName,
                                          cursorHeight: 9,
                                          labelText: 'Final Position Title',
                                          labelStyle: GoogleFonts.firaSans(
                                            color: ColorManager.greylight,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none,
                                          ),
                                          labelFontSize: 12,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        HRManageTextField(

                                          controller: nameController,
                                          keyboardType: TextInputType.text,
                                          text: AppStringEM.companyName,
                                          cursorHeight: 9,
                                          labelText: 'Final Position Title',
                                          labelStyle: GoogleFonts.firaSans(
                                            color: ColorManager.greylight,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none,
                                          ),
                                          labelFontSize: 12,
                                        ),
                                        SizedBox(height: AppSize.s4),
                                        HRManageTextField(

                                          controller: nameController,
                                          keyboardType: TextInputType.text,
                                          text: AppStringEM.companyName,
                                          cursorHeight: 9,
                                          labelText: 'Final Position Title',
                                          labelStyle: GoogleFonts.firaSans(
                                            color: ColorManager.greylight,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none,
                                          ),
                                          labelFontSize: 12,
                                        ),
                                        SizedBox(height: AppSize.s4),
                                        HRManageTextField(

                                          controller: nameController,
                                          keyboardType: TextInputType.text,
                                          text: AppStringEM.companyName,
                                          cursorHeight: 9,
                                          labelText: 'Final Position Title',
                                          labelStyle: GoogleFonts.firaSans(
                                            color: ColorManager.greylight,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none,
                                          ),
                                          labelFontSize: 12,
                                        ),
                                        SizedBox(height: AppSize.s4),
                                        HRManageTextField(

                                          controller: nameController,
                                          keyboardType: TextInputType.text,
                                          text: AppStringEM.companyName,
                                          cursorHeight: 9,
                                          labelText: 'Final Position Title',
                                          labelStyle: GoogleFonts.firaSans(
                                            color: ColorManager.greylight,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none,
                                          ),
                                          labelFontSize: 12,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child: CustomElevatedButton(
                                  width: 105,
                                  height: 31,
                                  text: 'Submit',
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  }),
                            )
                          ],
                        );
                      },
                    );
                  }),
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
                  child: CustomIconButtonConst(
                      text: AppStringHr.add, icon: Icons.add, onPressed: () {}),
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
                  child: CustomIconButtonConst(
                      text: AppStringHr.add, icon: Icons.add, onPressed: () {}),
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
                  child: CustomIconButtonConst(
                      text: AppStringHr.add, icon: Icons.add, onPressed: () {}),
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
      Tab(text: AppStringHr.acknowledgement),
      Tab(text: AppStringHr.compensation),
      Tab(text: AppStringHr.addVaccination),
      Tab(text: AppStringHr.others),
    ],
        tabViews: [
      ///aknowledgment
      Column(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
             // width: 100,
              margin: EdgeInsets.only(right: 20),
              child: CustomIconButtonConst(
                  text: AppStringHr.addNew, icon: Icons.add, onPressed: () {
                    // showDialog(context: context, builder: (context)=> AcknowledgementsAddPopup());
              }),
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
                child: CustomIconButtonConst(
                    text: AppStringHr.addNew, icon: Icons.add, onPressed: () {
                      showDialog(context: context, builder: (BuildContext context){
                        return CompensationAddEditPopup(idController: compensitionAddIdController, nameController: compensitionAddNameController, labelName: 'Add Compensation',);
                      });
                }),
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
                child: CustomIconButtonConst(
                    text: AppStringHr.addNew, icon: Icons.add, onPressed: () {
                  showDialog(context: context, builder: (BuildContext context){
                    return HealthRecordEditAddPopup(idController: healthRecordAddIdController, nameController: healthRecordAddNameController, labelName: 'Add Additional Vaccination',);
                  });

                }),
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
                child: CustomIconButtonConst(
                    text: AppStringHr.addNew, icon: Icons.add, onPressed: () {
                      showDialog(context: context, builder: (BuildContext context){
                        return OtherEditAddPopup(idController: otherAddIdController, nameController: otherAddNameController, labelName: 'Add');
                      });
                }),
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
        Tab(text: AppStringHr.qualification),
        Tab(text: AppStringHr.documents),
        Tab(text: AppStringHr.bankings),
        Tab(text: AppStringHr.healthRcord),
        Tab(text: AppStringHr.inventory),
        Tab(text: AppStringHr.payRate),
        Tab(text: AppStringHr.termination),
        Tab(text: AppStringHr.timeOff),
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
                  child: CustomIconButtonConst(
                      text: AppStringHr.addNew,
                      icon: Icons.add,
                      onPressed: () {
                        showDialog(context: context, builder: (_) => EquipmentAddPopup());
                      }),
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: Axis.vertical,
          children: [
        /// green blue container
       ProfileBar(),
       ///TabBar
       CenteredTabBar(),
       /// bottom row
       BottomBarRow()
      ]),
    );
  }
}
