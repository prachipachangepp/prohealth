import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/data/api_data/hr_module_data/employee_profile/search_profile_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import '../../../../../app/resources/hr_resources/string_manager.dart';
import '../../../../widgets/widgets/profile_bar/profile_bar.dart';
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
  final int? employeeId;
  final SearchByEmployeeIdProfileData? searchByEmployeeIdProfileData;
   ManageScreen({super.key,  this.searchByEmployeeIdProfileData,this.employeeId,});
  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  late CenteredTabBarChildController childController;
  late CenteredTabBarChildController childControlleOne;
  late CenteredTabBarController centeredTabBarController;



  /// Add employee
  TextEditingController positionTitleController = TextEditingController();
  TextEditingController leavingResonController = TextEditingController();
  TextEditingController startDateContoller = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController lastSupervisorNameController = TextEditingController();
  TextEditingController supervisorMobileNumber = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController employeerController = TextEditingController();
  TextEditingController emergencyMobileNumber = TextEditingController();

  /// Add Reference
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController titlePositionController = TextEditingController();
  TextEditingController knowPersonController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController associationLengthController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();



  /// Add Education
  TextEditingController collegeUniversityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController majorSubjectController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  String expiryType = '';

  ///
  TextEditingController addressCtlr = TextEditingController();
  TextEditingController nameCtlr = TextEditingController();




  /// Acknowlpdgement


  @override
  void initState() {
    // List<Tab> tabs = [];
    // await FutureBuilder<List<EmployeeDocTabModal>>(
    //     future: getEmployeeDocTab(context),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return Row(children:List.generate(snapshot.data!.length, (index){
    //           tabs.add(Tab(text:snapshot.data![index].employeeDocType));
    //           return Offstage();
    //         }));
    //       } else {
    //         return SizedBox(height: 1,width: 1,);
    //       }
    //     });

    childController = CenteredTabBarChildController(
      tabs: [
        Tab(text: AppStringHr.employment,),
        Tab(text: AppStringHr.education),
        Tab(text: AppStringHr.referance),
        Tab(text: AppStringHr.license),
      ],
      tabViews: [
        ///employment
        SingleChildScrollView(
          child: Column(
            children: [
              EmploymentContainerConstant(employeeId: widget.searchByEmployeeIdProfileData!.employeeId!,),
            ],
          ),
        ),

        ///education
        SingleChildScrollView(
          child: Column(
            children: [
              EducationChildTabbar(employeeId:widget.searchByEmployeeIdProfileData!.employeeId!),
            ],
          ),
        ),

        ///reference
        SingleChildScrollView(
          child: Column(
            children: [
              ReferencesChildTabbar(employeeId: widget.searchByEmployeeIdProfileData!.employeeId!),
            ],
          ),
        ),

        ///license
        SingleChildScrollView(
          child: Column(
            children: [
              LicensesChildTabbar(employeeId: widget.searchByEmployeeIdProfileData!.employeeId!),
            ],
          ),
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
      const SingleChildScrollView(
        child: Column(
          children: [
            AcknowledgementsChildBar(),
          ],
        ),
      ),

      ///compensation
      const SingleChildScrollView(
        child: Column(
          children: [
            CompensationChildTabbar(),
          ],
        ),
      ),
      const SingleChildScrollView(
        child: Column(
          children: [
            AdditionalVaccinationsChildBar(),
          ],
        ),
      ),
      const SingleChildScrollView(
        child: Column(
          children: [
            OtherChildTabbar(),
          ],
        ),
      ),
    ]);

    centeredTabBarController = Get.put(CenteredTabBarController(
      tabs: [
        Tab(text: AppStringHr.qualification),
        Tab(text: AppStringHr.documents),
        Tab(text: AppStringHr.bankings),
        // Tab(text: AppStringHr.healthRcord),
        Tab(text: AppStringHr.inventory),
        Tab(text: AppStringHr.payRate),
        Tab(text: AppStringHr.termination),
        Tab(text: AppStringHr.timeOff),
      ],
      tabViews: [
        CenteredTabBarChild(childController),
        CenteredTabBarChild(childControlleOne),
        BankingHeadTabbar(),
        // HealthRecordsHeadTabbar(),
        SingleChildScrollView(
          child: Column(
            children: [
              InventoryHeadTabbar(employeeId: widget.searchByEmployeeIdProfileData!.employeeId!,),
            ],
          ),
        ),
        const PayRatesHeadTabbar(),
        const TerminationHeadTabbar(),
        const TimeOffHeadTabbar(),
      ],
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return

      // Scaffold(
      //   backgroundColor: Colors.white,
      //   body: ListView(scrollDirection: Axis.vertical, children: [
      //             /// green blue container
      //             ProfileBar(searchByEmployeeIdProfileData: widget.searchByEmployeeIdProfileData!,),
      //
      //             ///TabBar
      //             CenteredTabBar(),
      //
      //             /// bottom row
      //             const BottomBarRow()
      //           ]),
      //        );


      Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  /// green blue container
                  ProfileBar(searchByEmployeeIdProfileData: widget.searchByEmployeeIdProfileData!),

                  ///TabBar
                  CenteredTabBar(),
                ],
              ),
            ),
            /// bottom row
            const BottomBarRow(),
          ],
        ),
      );
  }
}
