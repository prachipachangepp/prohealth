import 'package:flutter/material.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/employee_profile/search_profile_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/profile_editor/profile_editor.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/clinical_licenses.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/form_status.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/profilebar_editor.dart';

import '../../../../../app/resources/hr_resources/string_manager.dart';
import '../../../../widgets/widgets/profile_bar/profile_bar.dart';
import '../widgets/child_tabbar_screen/bancking_child/banking_head_tabbar.dart';
import '../widgets/child_tabbar_screen/documents_child/acknowledgements_child_tabbar.dart';
import '../widgets/child_tabbar_screen/documents_child/add_vaccination_child_tabbar.dart';
import '../widgets/child_tabbar_screen/documents_child/compensation_child_tabbar.dart';
import '../widgets/child_tabbar_screen/documents_child/other_child_tabbar.dart';
import '../widgets/child_tabbar_screen/payrates_child/pay_rates_head_tabbar.dart';
import '../widgets/child_tabbar_screen/qualifications_child/education_child_tabbar.dart';
import '../widgets/child_tabbar_screen/qualifications_child/employment_child_tabbar.dart';
import '../widgets/child_tabbar_screen/qualifications_child/licenses_child_tabbar.dart';
import '../widgets/child_tabbar_screen/qualifications_child/references_child_tabbar.dart';
import '../widgets/child_tabbar_screen/termination/termination_head_tabbar.dart';
import '../widgets/child_tabbar_screen/timeoff_child/time_off_head_tabbar.dart';

class ManageScreen extends StatefulWidget {
  final int employeeId;
  final SearchByEmployeeIdProfileData? searchByEmployeeIdProfileData;
  final PageController pageManageController;
  final int? employeeEnrollId;
  final Function() onRefresh;

  ManageScreen({
    super.key,
    this.searchByEmployeeIdProfileData,
    required this.employeeId,
    required this.onRefresh,
    required this.pageManageController,
    this.employeeEnrollId,
  });

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  bool _isEditMode = false;
  // final  _isEditMode = ;

  ProfileEditorModal? _prefilledData;

  // final ValueNotifier<bool> _isEditMode = ValueNotifier<bool>(false); // Use ValueNotifier to track edit mode
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          Expanded(
              child: _isEditMode
                  ? ProfileEditScreen(
                      onCancel: () {
                        widget.onRefresh();
                        setState(() {
                          _isEditMode = false;
                        });
                      },
                      employeeId: widget.employeeId,
                      // employeeEnrollId: widget.employeeEnrollId!,
                    )
                  : ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        // Profile Bar
                        ProfileBar(
                          searchByEmployeeIdProfileData:
                              widget.searchByEmployeeIdProfileData!,
                          onEditPressed: () {
                            setState(() {
                              _isEditMode = true;
                            });
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
                                indicatorPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                indicator: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                        width: 6, color: Color(0xFF50B5E5)),
                                    borderRadius: BorderRadius.circular(13)),
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelColor: Color(0xFF50B5E5),
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                                unselectedLabelColor:
                                    ColorManager.textPrimaryColor,
                                dividerColor: Colors.transparent,
                                tabs: [
                                  Tab(
                                    text: AppStringHr.qualification,
                                  ),
                                  Tab(text: AppStringHr.documents),
                                  Tab(text: AppStringHr.bankings),
                                  Tab(text: AppStringHr.inventory),
                                  Tab(text: AppStringHr.payRate),
                                  Tab(text: AppStringHr.termination),
                                  Tab(text: AppStringHr.timeOff),
                                ],
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height /
                                    2, // Adjust height as needed
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 322.0,
                                                  right: 305,
                                                  top: 5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                  color: Color(0xFF50B5E5),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      // color: Colors.black.withOpacity(0.2),
                                                      color: Colors.black
                                                          .withOpacity(0.25),
                                                      spreadRadius: 1,
                                                      blurRadius: 4,
                                                      offset: Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                height: 30,
                                                // width: 720.0,
                                                child: TabBar(
                                                  isScrollable: false,
                                                  tabs: [
                                                    Tab(
                                                      text: AppStringHr
                                                          .employment,
                                                    ),
                                                    Tab(
                                                        text: AppStringHr
                                                            .education),
                                                    Tab(
                                                        text: AppStringHr
                                                            .referance),
                                                    Tab(
                                                        text: AppStringHr
                                                            .license),
                                                  ],
                                                  dividerColor:
                                                      Colors.transparent,
                                                  indicator: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          // color: Colors.black.withOpacity(0.2),
                                                          color: Colors.black
                                                              .withOpacity(0.2),
                                                          spreadRadius: 1,
                                                          blurRadius: 5,
                                                          offset: Offset(0, 3),
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50), // Creates border
                                                      color: Colors.white),
                                                  indicatorSize:
                                                      TabBarIndicatorSize.tab,
                                                  indicatorColor: Colors.white,
                                                  labelColor: Color(0xFF686464),
                                                  unselectedLabelStyle:
                                                      TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  labelStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  unselectedLabelColor:
                                                      Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Expanded(
                                              child: TabBarView(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                children: [
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        EmploymentContainerConstant(
                                                            employeeId: widget
                                                                .employeeId!),
                                                        SizedBox(height: 30),
                                                      ],
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        EducationChildTabbar(
                                                            employeeId: widget
                                                                .searchByEmployeeIdProfileData!
                                                                .employeeId!),
                                                      ],
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        ReferencesChildTabbar(
                                                            employeeId: widget
                                                                .searchByEmployeeIdProfileData!
                                                                .employeeId!),
                                                      ],
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        LicensesChildTabbar(
                                                            employeeId: widget
                                                                .searchByEmployeeIdProfileData!
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
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      child: DefaultTabController(
                                        length: widget
                                            .searchByEmployeeIdProfileData!.departmentId == 1?6:5,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 322.0,
                                                  right: 305,
                                                  top: 5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                  color: Color(0xFF50B5E5),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      // color: Colors.black.withOpacity(0.2),
                                                      color: Colors.black
                                                          .withOpacity(0.25),
                                                      spreadRadius: 1,
                                                      blurRadius: 4,
                                                      offset: Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                height: 30,
                                                // width: 820.0,
                                                child: TabBar(
                                                  isScrollable: false,
                                                  tabs: [
                                                    Tab(
                                                        text: AppStringHr
                                                            .acknowledgement),
                                                    Tab(
                                                        text: AppStringHr
                                                            .compensation),
                                                    Tab(
                                                        text: AppStringHr
                                                            .addVaccination),
                                                    Tab(
                                                        text:
                                                            AppStringHr.others),
                                                    Tab(
                                                        text: AppStringHr
                                                            .formStatus),
                                                    if(widget
                                                        .searchByEmployeeIdProfileData!.departmentId == 1)
                                                    Tab(text: AppStringHr.clinicalLicenses),
                                                  ],
                                                  dividerColor:
                                                      Colors.transparent,
                                                  //padding: EdgeInsets.only(top: 2),
                                                  indicator: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50), // Creates border
                                                      color: Colors.white),
                                                  indicatorSize:
                                                      TabBarIndicatorSize.tab,
                                                  indicatorColor: Colors.white,
                                                  labelColor: Color(0xFF686464),
                                                  unselectedLabelStyle:
                                                      TextStyle(
                                                    fontSize: AppSize.s14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  labelStyle: TextStyle(
                                                    fontSize: AppSize.s14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  unselectedLabelColor:
                                                      Colors.white,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: TabBarView(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                children: [
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        AcknowledgementsChildBar(
                                                            employeeId: widget
                                                                .searchByEmployeeIdProfileData!
                                                                .employeeId!),
                                                      ],
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        CompensationChildTabbar(
                                                            employeeId: widget
                                                                .searchByEmployeeIdProfileData!
                                                                .employeeId!),
                                                      ],
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        AdditionalVaccinationsChildBar(
                                                            employeeId: widget
                                                                .searchByEmployeeIdProfileData!
                                                                .employeeId!),
                                                      ],
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        OtherChildTabbar(
                                                            employeeId: widget
                                                                .searchByEmployeeIdProfileData!
                                                                .employeeId!),
                                                      ],
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top:
                                                                      AppPadding
                                                                          .p15),
                                                          child: FormStatusScreen(
                                                              employeeId: widget
                                                                  .searchByEmployeeIdProfileData!
                                                                  .employeeId!),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  widget
                                                      .searchByEmployeeIdProfileData!.departmentId == 1 ? SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        ClinicalLicensesDoc(
                                                            employeeId: widget
                                                                .searchByEmployeeIdProfileData!
                                                                .employeeId!),
                                                      ],
                                                    ),
                                                  ):Offstage()
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    /// Banking Tab
                                    BankingHeadTabbar(
                                        employeeID: widget
                                            .searchByEmployeeIdProfileData!
                                            .employeeId!),

                                    /// Inventory Tab
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          InventoryHeadTabbar(
                                              employeeId: widget
                                                  .searchByEmployeeIdProfileData!
                                                  .employeeId!),
                                        ],
                                      ),
                                    ),

                                    /// Pay Rates Tab
                                    PayRatesHeadTabbar(
                                      employeeId: widget
                                          .searchByEmployeeIdProfileData!
                                          .employeeId!,
                                    ),

                                    /// Termination Tab
                                    TerminationHeadTabbar(
                                      employeeId: widget
                                          .searchByEmployeeIdProfileData!
                                          .employeeId!,
                                    ),

                                    /// Time Off Tab
                                    const TimeOffHeadTabbar(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
          //BottomBarRow(),
        ]));
  }
}
