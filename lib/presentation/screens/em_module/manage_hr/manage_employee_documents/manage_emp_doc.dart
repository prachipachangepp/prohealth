import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/app.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/emp_documents/health.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/emp_doc_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../data/api_data/establishment_data/employee_doc/employee_doc_data.dart';

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
                      horizontal: MediaQuery.of(context).size.width / 24,
                      vertical: AppPadding.p20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomIconButtonConst(
                        width: 170,
                        text: 'Add Document',
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
                              ? "Health"
                              : _selectedIndex == 1
                              ? "Certification"
                              : _selectedIndex == 2
                              ? "Employment"
                              : _selectedIndex == 3
                              ? "Clinical Verification"
                              : _selectedIndex == 4
                              ? "Acknowledgement"
                              : _selectedIndex == 5
                              ? "Compensation"
                              : "Performance";

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
                                  return EmpDocEditPopup(
                                    title: 'Add Document',
                                    idOfDocController: idDocController,
                                    nameDocController: nameDocController,
                                    calenderController: dateController,
                                    loadingDuration: _isLoading,
                                    onSavePredded: () async {
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      int threshold = 0;
                                      if (selectedExpiryType == AppConfig.scheduled && daysController.text.isNotEmpty) {
                                        int enteredValue = int.parse(daysController.text);
                                        if (selectedYear == AppConfig.year) {
                                          threshold = enteredValue * 365;
                                        } else if (selectedYear == AppConfig.month) {
                                          threshold = enteredValue * 30;
                                        }
                                      }
                                      await addEmployeeDocSetup(
                                        context: context,
                                        docName: nameDocController.text,
                                        expiryDate: "",//expiryDate,
                                        remainderThreshold: selectedExpiryType.toString(),
                                        empDocMetaDataId: subDocId,
                                        idOfDoc: idDocController.text,
                                        expiryType: selectedExpiryType.toString(),
                                        threshold: threshold, // Pass calculated or 0
                                      );

                                      print(nameDocController.text);
                                      print(idDocController.text);
                                      print(subDocId);
                                      print(selectedExpiryType.toString());

                                      Navigator.pop(context);
                                      nameDocController.clear();
                                      dateController.clear();
                                    },
                                    child: Container(
                                      width: 354,
                                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: ColorManager.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: ColorManager.fmediumgrey,width: 1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                           NewText,
                                            style: CustomTextStylesCommon.commonStyle(
                                              fontWeight: FontWeightManager.medium,
                                              fontSize: FontSize.s12,
                                              color: ColorManager.mediumgrey,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.transparent,
                                            //color: ColorManager.mediumgrey,
                                          ),
                                        ],
                                      ),
                                    ),
                                    radioButton: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Expiry Type",
                                          style: GoogleFonts.firaSans(
                                            fontSize: FontSize.s12,
                                            fontWeight: FontWeight.w700,
                                            color: ColorManager.mediumgrey,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                        CustomRadioListTile(
                                          value: "Not Applicable",
                                          groupValue: selectedExpiryType,

                                          onChanged: (value) {
                                            setState(() {
                                              selectedExpiryType = value;
                                            });
                                          },
                                          title: "Not Applicable",
                                        ),
                                        CustomRadioListTile(
                                          value: 'Scheduled',
                                          groupValue: selectedExpiryType,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedExpiryType = value;
                                            });
                                          },
                                          title: 'Scheduled',
                                        ),
                                        CustomRadioListTile(
                                          value: 'Issuer Expiry',
                                          groupValue: selectedExpiryType,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedExpiryType = value;
                                            });
                                          },
                                          title: 'Issuer Expiry',
                                        ),
                                      ],
                                    ),
                                    child2: Visibility(
                                      visible:
                                      selectedExpiryType == AppConfig.scheduled,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 50,
                                                //color: ColorManager.red,
                                                child: TextFormField(
                                                  controller:
                                                  daysController, // Use the controller initialized with "1"
                                                  cursorColor:
                                                  ColorManager.black,
                                                  cursorWidth: 1,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: FontSize.s10,
                                                    fontWeight:
                                                    FontWeightManager
                                                        .medium,
                                                    color:
                                                    ColorManager.mediumgrey,
                                                  ),
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 2),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                    ),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 2),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                    ),
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                  ),
                                                  keyboardType:
                                                  TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.digitsOnly, // This ensures only digits are accepted
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Container(
                                                height: 30,
                                                width: 80,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: ColorManager
                                                          .fmediumgrey),
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                ),
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  value:
                                                  selectedYear, // Initial value (you should define this variable)
                                                  items: [
                                                    DropdownMenuItem(
                                                      value: AppConfig.year,
                                                      child: Text(
                                                        AppConfig.year,
                                                        style: GoogleFonts
                                                            .firaSans(
                                                          fontSize:
                                                          FontSize.s10,
                                                          fontWeight:
                                                          FontWeightManager
                                                              .medium,
                                                          color: ColorManager
                                                              .mediumgrey,
                                                        ),
                                                      ),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: AppConfig.month,
                                                      child: Text(
                                                        AppConfig.month,
                                                        style: GoogleFonts
                                                            .firaSans(
                                                          fontSize:
                                                          FontSize.s10,
                                                          fontWeight:
                                                          FontWeightManager
                                                              .medium,
                                                          color: ColorManager
                                                              .mediumgrey,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedYear = value; // Update the selected option (Year/Month)
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                    InputBorder.none,
                                                    focusedBorder:
                                                    InputBorder.none,
                                                    hintText: AppConfig.year,
                                                    hintStyle:
                                                    GoogleFonts.firaSans(
                                                      fontSize: FontSize.s10,
                                                      fontWeight: FontWeightManager.medium,
                                                      color: ColorManager.mediumgrey,
                                                    ),
                                                    contentPadding:
                                                    EdgeInsets.only(
                                                        bottom: 20),
                                                  ),
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: ColorManager.black,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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
            padding: const EdgeInsets.only(left: 15),
            child: Container(
              height: 28,
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
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width / 8.422,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 0
                              ? ColorManager.white
                              : Colors.transparent,
                        ),
                        child: Text(
                          'Health',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeightManager.semiBold,
                            color: _selectedIndex == 0
                                ? ColorManager.mediumgrey
                                : ColorManager.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        _selectButton(0);
                        // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                      }),
                  InkWell(
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width / 8.421,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 1
                              ? ColorManager.white
                              : Colors.transparent,
                        ),
                        child: Text(
                          'Certifications',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeightManager.semiBold,
                            color: _selectedIndex == 1
                                ? ColorManager.mediumgrey
                                : ColorManager.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        _selectButton(1);
                        // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                      }),
                  InkWell(
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width / 8.421,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 2
                              ? ColorManager.white
                              : Colors.transparent,
                        ),
                        child: Text(
                          'Employment',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeightManager.semiBold,
                            color: _selectedIndex == 2
                                ? ColorManager.mediumgrey
                                : ColorManager.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        _selectButton(2);
                        // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                      }),
                  InkWell(
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width / 8.421,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 3
                              ? ColorManager.white
                              : Colors.transparent,
                        ),
                        child: Text(
                          'Clinical Verification',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeightManager.semiBold,
                            color: _selectedIndex == 3
                                ? ColorManager.mediumgrey
                                : ColorManager.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        _selectButton(3);
                        // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                      }),
                  InkWell(
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width / 8.421,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 4
                              ? ColorManager.white
                              : Colors.transparent,
                        ),
                        child: Text(
                          'Acknowledgement',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeightManager.semiBold,
                            color: _selectedIndex == 4
                                ? ColorManager.mediumgrey
                                : ColorManager.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        _selectButton(4);
                        // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                      }),
                  InkWell(
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width / 8.421,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 5
                              ? ColorManager.white
                              : Colors.transparent,
                        ),
                        child: Text(
                          'Compensation',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeightManager.semiBold,
                            color: _selectedIndex == 5
                                ? ColorManager.mediumgrey
                                : ColorManager.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        _selectButton(5);
                        // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                      }),
                  InkWell(
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width / 8.421,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 6
                              ? ColorManager.white
                              : Colors.transparent,
                        ),
                        child: Text(
                          'Performance',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeightManager.semiBold,
                            color: _selectedIndex == 6
                                ? ColorManager.mediumgrey
                                : ColorManager.white,
                          ),
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
          const SizedBox(height: 30,),
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
