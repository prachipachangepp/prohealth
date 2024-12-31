import 'package:flutter/material.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/health.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/emp_doc_popup_const.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';

class ManageEmployDocument extends StatefulWidget {
  const ManageEmployDocument({super.key});

  @override
  State<ManageEmployDocument> createState() => _ManageEmployDocumentState();
}

class _ManageEmployDocumentState extends State<ManageEmployDocument> {
  final PageController _managePageController = PageController();
  int _selectedIndex = 1;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _managePageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ManageEmpDocWidget(
      managePageController: _managePageController,
      selectedIndex: _selectedIndex,
      selectButton: _selectButton,
    );
  }
}

class ManageEmpDocWidget extends StatefulWidget {
  final PageController managePageController;
  final int selectedIndex;
  final Function(int) selectButton;
  ManageEmpDocWidget({
    Key? key,
    required this.managePageController,
    required this.selectedIndex,
    required this.selectButton,
  }) : super(key: key);

  @override
  State<ManageEmpDocWidget> createState() => _ManageEmpDocWidgetState();
}

class _ManageEmpDocWidgetState extends State<ManageEmpDocWidget> {
  TextEditingController nameDocController = TextEditingController();
  TextEditingController idDocController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController daysController = TextEditingController(text: "1");
  final PageController _managePageController = PageController();
  String? selectedYear;

  int _selectedIndex = 0;
  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _managePageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmployeeDocTab(context);
  }

  String selectType = "Health";
  void onChange(String select) {
    setState(() {
      selectType = select;
    });
  }

  var metaDocID = AppConfig.healthDocId;
  String? expiryType;
  bool _isLoading = false;
  int docMetaId = 1;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p75,
                      vertical: AppPadding.p20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomIconButtonConst(
                        width: AppSize.s170,
                        text: AppStringEM.adddoctype,
                        onPressed: () async {
                          idDocController.clear();
                          nameDocController.clear();
                          dateController.clear();
                          String? selectedExpiryType = expiryType;
                          selectedExpiryType = "";
                          String? selectedDocType;
                          selectedYear = AppConfig.year;
                          daysController.text = "1";

                          int docMetaId = 0;

                          int subDocId = _selectedIndex == 0
                              ? AppConfig.healthDocId
                              : _selectedIndex == 1
                              ? AppConfig.certificationDocId
                              : _selectedIndex == 2
                              ? AppConfig.employmentDocId
                              : _selectedIndex == 3
                              ? AppConfig.clinicalVerificationDocId
                              : _selectedIndex == 4
                              ? AppConfig.acknowledgementDocId
                              : _selectedIndex == 5
                              ? AppConfig.compensationDocId
                              : AppConfig.performanceDocId;

                          String NewText = _selectedIndex == 0
                              ? AppStringEM.health
                              : _selectedIndex == 1
                              ? AppStringEM.certifications
                              : _selectedIndex == 2
                              ? AppStringEM.employment
                              : _selectedIndex == 3
                              ? AppStringEM.clinicalVerify
                              : _selectedIndex == 4
                              ? AppStringEM.acknowledgement
                              : _selectedIndex == 5
                              ? AppStringEM.compensation
                              : AppStringEM.performance;

                          List<DropdownMenuItem<String>> dropDownMenuItems = [];
                          final docTypes = await getEmployeeDocTab(context);
                          if (docTypes.isNotEmpty) {
                            for (var i in docTypes) {
                              dropDownMenuItems.add(
                                DropdownMenuItem<String>(
                                  child: Text(i.employeeDocType),
                                  value: i.employeeDocType,
                                ),
                              );
                            }
                            selectedDocType = dropDownMenuItems[0].value;
                            docMetaId = docTypes[0].employeeDocMetaDataId;
                          }

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context, void Function(void Function()) setState) {
                                  return EmpDocADDPopup(
                                    title: AddPopupString.addDocument,
                                   Subdocid:subDocId,
                                  );
                                },
                              );
                            },
                          );
                        },
                        icon: Icons.add,
                      ),
                    ],
                  ),
                ),


          /// tab bar
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p15),
            child: Container(
              height: AppSize.s30,
              width: MediaQuery.of(context).size.width / 1.2025,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
                color: ColorManager.blueprime,
                // color: Colors.yellow,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Container(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 8.422,
                        padding: const EdgeInsets.symmetric(vertical: AppPadding.p3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 0
                              ? ColorManager.white
                              : Colors.transparent,
                        ),
                        child: Text(
                         AppStringEM.health,
                          textAlign: TextAlign.center,
                          style:  BlueBgTabbar.customTextStyle(0, _selectedIndex),
                        ),
                      ),
                      onTap: () {
                        _selectButton(0);
                        // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                      }),
                  InkWell(
                      child: Container(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 8.421,
                        padding: const EdgeInsets.symmetric(vertical: AppPadding.p3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 1
                              ? ColorManager.white
                              : Colors.transparent,
                        ),
                        child: Text(
                          AppStringEM.certifications,
                          textAlign: TextAlign.center,
                          style: BlueBgTabbar.customTextStyle(1, _selectedIndex),
                        ),
                      ),
                      onTap: () {
                        _selectButton(1);
                        // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                      }),
                  InkWell(
                      child: Container(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 8.421,
                        padding: const EdgeInsets.symmetric(vertical: AppPadding.p3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 2
                              ? ColorManager.white
                              : Colors.transparent,
                        ),
                        child: Text(
                          AppStringEM.employment,
                          textAlign: TextAlign.center,
                          style:  BlueBgTabbar.customTextStyle(2, _selectedIndex),
                        ),
                      ),
                      onTap: () {
                        _selectButton(2);
                        // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                      }),
                  InkWell(
                      child: Container(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 8.421,
                        padding: const EdgeInsets.symmetric(vertical: AppPadding.p3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 3
                              ? ColorManager.white
                              : Colors.transparent,
                        ),
                        child: Text(
                          AppStringEM.clinicalVerify,
                          textAlign: TextAlign.center,
                          style:  BlueBgTabbar.customTextStyle(3, _selectedIndex),
                        ),
                      ),
                      onTap: () {
                        _selectButton(3);
                        // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                      }),
                  InkWell(
                      child: Container(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 8.421,
                        padding: const EdgeInsets.symmetric(vertical: AppPadding.p3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 4
                              ? ColorManager.white
                              : Colors.transparent,
                        ),
                        child: Text(
                         AppStringEM.acknowledgement,
                          textAlign: TextAlign.center,
                          style:  BlueBgTabbar.customTextStyle(4, _selectedIndex),
                        ),
                      ),
                      onTap: () {
                        _selectButton(4);
                        // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                      }),
                  InkWell(
                      child: Container(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 8.421,
                        padding: const EdgeInsets.symmetric(vertical: AppPadding.p3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 5
                              ? ColorManager.white
                              : Colors.transparent,
                        ),
                        child: Text(
                          AppStringEM.compensation,
                          textAlign: TextAlign.center,
                          style:  BlueBgTabbar.customTextStyle(5, _selectedIndex),
                        ),
                      ),
                      onTap: () {
                        _selectButton(5);
                        // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                      }),
                  InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Container(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 8.421,
                        padding: const EdgeInsets.symmetric(vertical: AppPadding.p3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 6
                              ? ColorManager.white
                              : Colors.transparent,
                        ),
                        child: Text(
                          AppStringEM.performance,
                          textAlign: TextAlign.center,
                          style:  BlueBgTabbar.customTextStyle(6, _selectedIndex),
                        ),
                      ),
                      onTap: () {
                        _selectButton(6);
                        // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                      }),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSize.s30,),
          Expanded(
            flex: 10,
            child: Stack(children: [
              Container(
                //height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    color: Color(0xFFF2F9FC),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.faintGrey,
                        blurRadius: 2,
                        spreadRadius: -2,
                        offset: Offset(0, -4),
                      ),
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 45,
                    right: MediaQuery.of(context).size.width / 45,
                    top: MediaQuery.of(context).size.width / 45),
                child: PageView(
                    controller: _managePageController,
                    onPageChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      HealthEmpDoc(metaDocID: AppConfig.healthDocId),
                      HealthEmpDoc(metaDocID: AppConfig.certificationDocId),
                      HealthEmpDoc(metaDocID: AppConfig.employmentDocId),
                      HealthEmpDoc(metaDocID: AppConfig.clinicalVerificationDocId),
                      HealthEmpDoc(metaDocID: AppConfig.acknowledgementDocId),
                      HealthEmpDoc(metaDocID: AppConfig.compensationDocId),
                      HealthEmpDoc(metaDocID: AppConfig.performanceDocId),
                    ]),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
