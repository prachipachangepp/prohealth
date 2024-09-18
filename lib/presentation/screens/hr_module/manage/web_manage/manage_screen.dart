import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/data/api_data/hr_module_data/employee_profile/search_profile_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/profile_editor/profile_editor.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/profilebar_editor.dart';
import '../../../../../app/resources/hr_resources/string_manager.dart';
import '../../../../widgets/widgets/profile_bar/profile_bar.dart';
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
import '../widgets/child_tabbar_screen/bancking_child/banking_head_tabbar.dart';
import '../widgets/child_tabbar_screen/health_record_child/health_records_head_tabbar.dart';
import '../widgets/child_tabbar_screen/payrates_child/pay_rates_head_tabbar.dart';
import '../widgets/child_tabbar_screen/termination/termination_head_tabbar.dart';
import '../widgets/child_tabbar_screen/timeoff_child/time_off_head_tabbar.dart';

class ManageScreen extends StatelessWidget {
  final int employeeId;
  final SearchByEmployeeIdProfileData? searchByEmployeeIdProfileData;
  final PageController pageManageController;

  ManageScreen({super.key, this.searchByEmployeeIdProfileData, required this.employeeId, required this.pageManageController, });

  // bool _isEditMode = false;
  final ValueNotifier<bool> _isEditMode = ValueNotifier<bool>(false);
  ProfileEditorModal? _prefilledData;
  // final ValueNotifier<bool> _isEditMode = ValueNotifier<bool>(false); // Use ValueNotifier to track edit mode
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Expanded(
          //   child: ListView(
          //     scrollDirection: Axis.vertical,
          //     children: [
                // Green blue container
                ///
                // ProfileBar(
                //   searchByEmployeeIdProfileData: searchByEmployeeIdProfileData!,
                //   onEditPressed: () {
                //     // pageManageController.animateToPage(5,
                //     //   duration: Duration(milliseconds: 500),
                //     //   curve: Curves.ease,
                //     // );
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => EditScreen(
                //           isEditModeNotifier: _isEditMode,
                //         ),
                //       ),
                //     );
                //   },
                // ),
                ///
        Expanded(
        child: ValueListenableBuilder<bool>(
        valueListenable: _isEditMode,
        builder: (context, isEditMode, child) {
          return isEditMode
              ? ProfileEditScreen(
            isEditModeNotifier: _isEditMode,
            onCancel: () {
              _isEditMode.value = false;
            }, employeeId: employeeId,
          )
              : ListView(
            scrollDirection: Axis.vertical,
            children: [
              // Profile Bar
              ProfileBar(
                searchByEmployeeIdProfileData:
                searchByEmployeeIdProfileData!,

                onEditPressed: () {
                  _isEditMode.value = true;
                },
              ),

              ///sub tab bar
              DefaultTabController(
                length: 7,
                child: Column(

                  ///sub tab bar
                  children: [
                    TabBar(
                      indicatorWeight: 6,
                      overlayColor: MaterialStateProperty.all(
                          Colors.transparent),
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 6, color: Color(
                              0xFF50B5E5)),
                          borderRadius: BorderRadius.circular(13)),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Color(0xFF50B5E5),
                      labelStyle: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                      unselectedLabelColor: ColorManager.textPrimaryColor,
                      dividerColor: Colors.transparent,
                      tabs: [
                        Tab(text: AppStringHr.qualification),
                        Tab(text: AppStringHr.documents),
                        Tab(text: AppStringHr.bankings),
                        Tab(text: AppStringHr.inventory),
                        Tab(text: AppStringHr.payRate),
                        Tab(text: AppStringHr.termination),
                        Tab(text: AppStringHr.timeOff),
                      ],
                    ),
                    SizedBox(
                      height: 420.0, // Adjust height as needed
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [

                          /// Qualification Tab Views
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: DefaultTabController(
                              length: 4,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: Color(0xFF50B5E5),
                                      boxShadow: [
                                        BoxShadow(
                                          // color: Colors.black.withOpacity(0.2),
                                          color: Colors.black.withOpacity(0.25),
                                          spreadRadius: 1,
                                          blurRadius: 4,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    height: 30,
                                    width: 620.0,
                                    child: TabBar(
                                      isScrollable: false,
                                      tabs: [
                                        Tab(text: AppStringHr.employment),
                                        Tab(text: AppStringHr.education),
                                        Tab(text: AppStringHr.referance),
                                        Tab(text: AppStringHr.license),
                                      ],
                                      dividerColor: Colors.transparent,
                                      indicator: BoxDecoration(
                                          boxShadow: [BoxShadow(
                                            // color: Colors.black.withOpacity(0.2),
                                            color: Colors.black.withOpacity(
                                                0.2),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                          ],
                                          borderRadius: BorderRadius.circular(
                                              50), // Creates border
                                          color: Colors.white),
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      indicatorColor: Colors.white,
                                      labelColor: Color(0xFF686464),
                                      unselectedLabelStyle: GoogleFonts
                                          .firaSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      labelStyle: GoogleFonts.firaSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      unselectedLabelColor: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  SizedBox(
                                    height: 265.0, // Adjust height as needed
                                    child: TabBarView(
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              EmploymentContainerConstant(
                                                  employeeId: employeeId!),
                                              SizedBox(height: 30),
                                            ],
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              EducationChildTabbar(
                                                  employeeId: searchByEmployeeIdProfileData!
                                                      .employeeId!),
                                            ],
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              ReferencesChildTabbar(
                                                  employeeId: searchByEmployeeIdProfileData!
                                                      .employeeId!),
                                            ],
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              LicensesChildTabbar(
                                                  employeeId: searchByEmployeeIdProfileData!
                                                      .employeeId!),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// Documents Tab Views
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: DefaultTabController(
                              length: 4,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: Color(0xFF50B5E5),
                                      boxShadow: [
                                        BoxShadow(
                                          // color: Colors.black.withOpacity(0.2),
                                          color: Colors.black.withOpacity(0.25),
                                          spreadRadius: 1,
                                          blurRadius: 4,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    height: 30,
                                    width: 620.0,
                                    child: TabBar(
                                      isScrollable: false,
                                      tabs: [
                                        Tab(text: AppStringHr.acknowledgement),
                                        Tab(text: AppStringHr.compensation),
                                        Tab(text: AppStringHr.addVaccination),
                                        Tab(text: AppStringHr.others),
                                      ],
                                      dividerColor: Colors.transparent,
                                      indicator: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              50), // Creates border
                                          color: Colors.white),
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      indicatorColor: Colors.white,
                                      labelColor: Color(0xFF686464),
                                      unselectedLabelStyle: GoogleFonts
                                          .firaSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      labelStyle: GoogleFonts.firaSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      unselectedLabelColor: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 265.0, // Adjust height as needed
                                    child: TabBarView(
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              AcknowledgementsChildBar(
                                                  employeeId: searchByEmployeeIdProfileData!
                                                      .employeeId!),
                                            ],
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              CompensationChildTabbar(
                                                  employeeId: searchByEmployeeIdProfileData!
                                                      .employeeId!),
                                            ],
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              AdditionalVaccinationsChildBar(
                                                  employeeId: searchByEmployeeIdProfileData!
                                                      .employeeId!),
                                            ],
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              OtherChildTabbar(
                                                  employeeId: searchByEmployeeIdProfileData!
                                                      .employeeId!),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// Banking Tab
                          BankingHeadTabbar(
                              employeeID: searchByEmployeeIdProfileData!
                                  .employeeId!),

                          /// Inventory Tab
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                InventoryHeadTabbar(
                                    employeeId: searchByEmployeeIdProfileData!
                                        .employeeId!),
                              ],
                            ),
                          ),

                          // Pay Rates Tab
                          PayRatesHeadTabbar(
                            employeeId: searchByEmployeeIdProfileData!
                                .employeeId!,),

                          // Termination Tab
                          TerminationHeadTabbar(
                            employeeId: searchByEmployeeIdProfileData!
                                .employeeId!,),

                          // Time Off Tab
                          const TimeOffHeadTabbar(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Bottom row
          );
        }),
      ),
          BottomBarRow(),
    ]
      )
    );
  }
}
