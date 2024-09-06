import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
  final PageController _managePageController = PageController();

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
                      _selectedIndex == 0
                      ///Health
                      ? CustomIconButtonConst(
                        width: 170,
                        text: 'Add Document',
                        onPressed: () async {
                          idDocController.clear();
                          nameDocController.clear();
                          dateController.clear();
                          expiryType = "";
                          String? selectedDocType;
                          String? selectedExpiryType = expiryType;
                          int docMetaId = 0;
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
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return EmpDocEditPopup(
                                    title: 'Add Document',
                                    idOfDocController: idDocController,
                                    nameDocController: nameDocController,
                                    calenderController: dateController,
                                    loadingDuration: _isLoading,
                                    onSavePredded: () async {
                                      String expiryTypeToSend =
                                      selectedExpiryType == "Not Applicable"
                                          ? "Not Applicable"
                                          : dateController.text;
                                      await addEmployeeDocSetup(context,
                                          AppConfig.healthDocId,
                                          nameDocController.text,
                                          expiryTypeToSend,
                                          selectedExpiryType.toString(),
                                          idDocController.text);
                                      Navigator.pop(context);
                                      nameDocController.clear();
                                      dateController.clear();
                                      print('$AppConfig.healthDocId');
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
                                            'Health',
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
                                      visible: selectedExpiryType ==
                                              "Scheduled" ||
                                          selectedExpiryType == "Issuer Expiry",
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Expiry Date",
                                            style: GoogleFonts.firaSans(
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorManager.mediumgrey,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          SizedBox(height: AppSize.s5,),
                                          FormField<String>(
                                            builder:
                                                (FormFieldState<String> field) {
                                              return SizedBox(
                                                width: 354,
                                                height: 30,
                                                child: TextFormField(
                                                  controller: dateController,
                                                  cursorColor:
                                                      ColorManager.black,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: FontSize.s12,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        ColorManager.mediumgrey,
                                                  ),
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    hintText: 'mm-dd-yyyy',
                                                    hintStyle:
                                                        GoogleFonts.firaSans(
                                                      fontSize: FontSize.s12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: ColorManager
                                                          .mediumgrey,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: ColorManager
                                                              .fmediumgrey),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16),
                                                    suffixIcon: Icon(
                                                      Icons
                                                          .calendar_month_outlined,
                                                      color: ColorManager
                                                          .blueprime,
                                                    ),
                                                    errorText: field.errorText,
                                                  ),
                                                  onTap: () async {
                                                    DateTime? pickedDate =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                          firstDate: DateTime(1900),
                                                          lastDate: DateTime(2101),
                                                    );
                                                    if (pickedDate != null) {
                                                      dateController
                                                          .text = DateFormat(
                                                              'MM-dd-yyyy')
                                                          .format(pickedDate);
                                                    }
                                                  },
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'please select birth date';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              );
                                            },
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
                      )
                          : _selectedIndex == 1
                      /// certification
                          ? CustomIconButtonConst(
                        width: 170,
                        text: 'Add Document',
                        onPressed: () async {
                          idDocController.clear();
                          nameDocController.clear();
                          dateController.clear();
                          expiryType = "";
                          String? selectedDocType;
                          String? selectedExpiryType = expiryType;
                          int docMetaId = 0;
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
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return EmpDocEditPopup(
                                    title: 'Add Document',
                                    idOfDocController: idDocController,
                                    nameDocController: nameDocController,
                                    calenderController: dateController,
                                    loadingDuration: _isLoading,
                                    onSavePredded: () async {
                                      String expiryTypeToSend =
                                      selectedExpiryType == "Not Applicable"
                                          ? "Not Applicable"
                                          : dateController.text;
                                      await addEmployeeDocSetup(context,
                                          AppConfig.certificationDocId,
                                          nameDocController.text,
                                          expiryTypeToSend,
                                          selectedExpiryType.toString(),
                                          idDocController.text);
                                      Navigator.pop(context);
                                      nameDocController.clear();
                                      dateController.clear();
                                      print('$AppConfig.healthDocId');
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
                                            'Certifications',
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
                                      visible: selectedExpiryType ==
                                          "Scheduled" ||
                                          selectedExpiryType == "Issuer Expiry",
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Expiry Date",
                                            style: GoogleFonts.firaSans(
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorManager.mediumgrey,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          SizedBox(height: AppSize.s5,),
                                          FormField<String>(
                                            builder:
                                                (FormFieldState<String> field) {
                                              return SizedBox(
                                                width: 354,
                                                height: 30,
                                                child: TextFormField(
                                                  controller: dateController,
                                                  cursorColor:
                                                  ColorManager.black,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: FontSize.s12,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                    ColorManager.mediumgrey,
                                                  ),
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 1),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                    ),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 1),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                    ),
                                                    hintText: 'mm-dd-yyyy',
                                                    hintStyle:
                                                    GoogleFonts.firaSans(
                                                      fontSize: FontSize.s12,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      color: ColorManager
                                                          .mediumgrey,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: ColorManager
                                                              .fmediumgrey),
                                                    ),
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                    suffixIcon: Icon(
                                                      Icons
                                                          .calendar_month_outlined,
                                                      color: ColorManager
                                                          .blueprime,
                                                    ),
                                                    errorText: field.errorText,
                                                  ),
                                                  onTap: () async {
                                                    DateTime? pickedDate =
                                                    await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                      DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(2101),
                                                    );
                                                    if (pickedDate != null) {
                                                      dateController
                                                          .text = DateFormat(
                                                          'MM-dd-yyyy')
                                                          .format(pickedDate);
                                                    }
                                                  },
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'please select birth date';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              );
                                            },
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
                      )
                          : _selectedIndex == 2

                      ///Employement
                          ? CustomIconButtonConst(
                        width: 170,
                        text: 'Add Document',
                        onPressed: () async {
                          idDocController.clear();
                          nameDocController.clear();
                          dateController.clear();
                          expiryType = "";
                          String? selectedDocType;
                          String? selectedExpiryType = expiryType;
                          int docMetaId = 0;
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
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return EmpDocEditPopup(
                                    title: 'Add Document',
                                    idOfDocController: idDocController,
                                    nameDocController: nameDocController,
                                    calenderController: dateController,
                                    loadingDuration: _isLoading,
                                    onSavePredded: () async {
                                      String expiryTypeToSend =
                                      selectedExpiryType == "Not Applicable"
                                          ? "Not Applicable"
                                          : dateController.text;
                                      await addEmployeeDocSetup(context,
                                          AppConfig.employmentDocId,
                                          nameDocController.text,
                                          expiryTypeToSend,
                                          selectedExpiryType.toString(),
                                          idDocController.text);
                                      Navigator.pop(context);
                                      nameDocController.clear();
                                      dateController.clear();
                                      print('$AppConfig.employmentDocId');
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
                                            'Employment',
                                            style: CustomTextStylesCommon.commonStyle(
                                              fontWeight: FontWeightManager.medium,
                                              fontSize: FontSize.s12,
                                              color: ColorManager.mediumgrey,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.transparent,
                                            // color: ColorManager.mediumgrey,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // child: CICCDropdown(
                                    //   initialValue: "Select Employee Document",
                                    //   hintText: "Select Employee Document",
                                    //   onChange: (val) {
                                    //     setState(() {
                                    //       selectedDocType = val;
                                    //     });
                                    //     for (var a in docTypes) {
                                    //       if (a.employeeDocType == val) {
                                    //         setState(() {
                                    //           docMetaId = a.employeeDocMetaDataId;
                                    //         });
                                    //       }
                                    //     }
                                    //     print(":::${docMetaId}");
                                    //   },
                                    //   items: dropDownMenuItems,
                                    // ),

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
                                      visible: selectedExpiryType ==
                                          "Scheduled" ||
                                          selectedExpiryType == "Issuer Expiry",
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Expiry Date",
                                            style: GoogleFonts.firaSans(
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorManager.mediumgrey,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          SizedBox(height: AppSize.s5,),
                                          FormField<String>(
                                            builder:
                                                (FormFieldState<String> field) {
                                              return SizedBox(
                                                width: 354,
                                                height: 30,
                                                child: TextFormField(
                                                  controller: dateController,
                                                  cursorColor:
                                                  ColorManager.black,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: FontSize.s12,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                    ColorManager.mediumgrey,
                                                  ),
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 1),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                    ),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 1),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                    ),
                                                    hintText: 'mm-dd-yyyy',
                                                    hintStyle:
                                                    GoogleFonts.firaSans(
                                                      fontSize: FontSize.s12,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      color: ColorManager
                                                          .mediumgrey,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: ColorManager
                                                              .fmediumgrey),
                                                    ),
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                    suffixIcon: Icon(
                                                      Icons
                                                          .calendar_month_outlined,
                                                      color: ColorManager
                                                          .blueprime,
                                                    ),
                                                    errorText: field.errorText,
                                                  ),
                                                  onTap: () async {
                                                    DateTime? pickedDate =
                                                    await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                      DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(2101),
                                                    );
                                                    if (pickedDate != null) {
                                                      dateController
                                                          .text = DateFormat(
                                                          'MM-dd-yyyy')
                                                          .format(pickedDate);
                                                    }
                                                  },
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'please select birth date';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              );
                                            },
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
                      )
                          : _selectedIndex == 3
                      ///clinical verification
                          ? CustomIconButtonConst(
                        width: 170,
                        text: 'Add Document',
                        onPressed: () async {
                          idDocController.clear();
                          nameDocController.clear();
                          dateController.clear();
                          expiryType = "";
                          String? selectedDocType;
                          String? selectedExpiryType = expiryType;
                          int docMetaId = 0;
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
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return EmpDocEditPopup(
                                    title: 'Add Document',
                                    idOfDocController: idDocController,
                                    nameDocController: nameDocController,
                                    calenderController: dateController,
                                    loadingDuration: _isLoading,
                                    onSavePredded: () async {
                                      String expiryTypeToSend =
                                      selectedExpiryType == "Not Applicable"
                                          ? "Not Applicable"
                                          : dateController.text;
                                      await addEmployeeDocSetup(context,
                                          AppConfig.clinicalVerificationDocId,
                                          nameDocController.text,
                                          expiryTypeToSend,
                                          selectedExpiryType.toString(),
                                          idDocController.text);
                                      Navigator.pop(context);
                                      nameDocController.clear();
                                      dateController.clear();
                                      print('$AppConfig.clinicalVerificationDocId');
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
                                            'Clinical Verification',
                                            style: CustomTextStylesCommon.commonStyle(
                                              fontWeight: FontWeightManager.medium,
                                              fontSize: FontSize.s12,
                                              color: ColorManager.mediumgrey,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.transparent,
                                            // color: ColorManager.mediumgrey,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // child: CICCDropdown(
                                    //   initialValue: "Select Employee Document",
                                    //   hintText: "Select Employee Document",
                                    //   onChange: (val) {
                                    //     setState(() {
                                    //       selectedDocType = val;
                                    //     });
                                    //     for (var a in docTypes) {
                                    //       if (a.employeeDocType == val) {
                                    //         setState(() {
                                    //           docMetaId = a.employeeDocMetaDataId;
                                    //         });
                                    //       }
                                    //     }
                                    //     print(":::${docMetaId}");
                                    //   },
                                    //   items: dropDownMenuItems,
                                    // ),

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
                                      visible: selectedExpiryType ==
                                          "Scheduled" ||
                                          selectedExpiryType == "Issuer Expiry",
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Expiry Date",
                                            style: GoogleFonts.firaSans(
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorManager.mediumgrey,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          SizedBox(height: AppSize.s5,),
                                          FormField<String>(
                                            builder:
                                                (FormFieldState<String> field) {
                                              return SizedBox(
                                                width: 354,
                                                height: 30,
                                                child: TextFormField(
                                                  controller: dateController,
                                                  cursorColor:
                                                  ColorManager.black,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: FontSize.s12,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                    ColorManager.mediumgrey,
                                                  ),
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 1),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                    ),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 1),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                    ),
                                                    hintText: 'mm-dd-yyyy',
                                                    hintStyle:
                                                    GoogleFonts.firaSans(
                                                      fontSize: FontSize.s12,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      color: ColorManager
                                                          .mediumgrey,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: ColorManager
                                                              .fmediumgrey),
                                                    ),
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                    suffixIcon: Icon(
                                                      Icons
                                                          .calendar_month_outlined,
                                                      color: ColorManager
                                                          .blueprime,
                                                    ),
                                                    errorText: field.errorText,
                                                  ),
                                                  onTap: () async {
                                                    DateTime? pickedDate =
                                                    await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                      DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(2101),
                                                    );
                                                    if (pickedDate != null) {
                                                      dateController
                                                          .text = DateFormat(
                                                          'MM-dd-yyyy')
                                                          .format(pickedDate);
                                                    }
                                                  },
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'please select birth date';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              );
                                            },
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
                      )
                          : _selectedIndex == 4
                          ///Ackonwlwdgement
                          ? CustomIconButtonConst(
                        width: 170,
                        text: 'Add Document',
                        onPressed: () async {
                          idDocController.clear();
                          nameDocController.clear();
                          dateController.clear();
                          expiryType = "";
                          String? selectedDocType;
                          String? selectedExpiryType = expiryType;
                          int docMetaId = 0;
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
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return EmpDocEditPopup(
                                    title: 'Add Document',
                                    idOfDocController: idDocController,
                                    nameDocController: nameDocController,
                                    calenderController: dateController,
                                    loadingDuration: _isLoading,
                                    onSavePredded: () async {
                                      String expiryTypeToSend =
                                      selectedExpiryType == "Not Applicable"
                                          ? "Not Applicable"
                                          : dateController.text;
                                      await addEmployeeDocSetup(context,
                                          AppConfig.acknowledgementDocId,
                                          nameDocController.text,
                                          expiryTypeToSend,
                                          selectedExpiryType.toString(),
                                          idDocController.text);
                                      Navigator.pop(context);
                                      nameDocController.clear();
                                      dateController.clear();
                                      print('$AppConfig.clinicalVerificationDocId');
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
                                            'Acknowledgement',
                                            style: CustomTextStylesCommon.commonStyle(
                                              fontWeight: FontWeightManager.medium,
                                              fontSize: FontSize.s12,
                                              color: ColorManager.mediumgrey,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.transparent,
                                            // color: ColorManager.mediumgrey,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // child: CICCDropdown(
                                    //   initialValue: "Select Employee Document",
                                    //   hintText: "Select Employee Document",
                                    //   onChange: (val) {
                                    //     setState(() {
                                    //       selectedDocType = val;
                                    //     });
                                    //     for (var a in docTypes) {
                                    //       if (a.employeeDocType == val) {
                                    //         setState(() {
                                    //           docMetaId = a.employeeDocMetaDataId;
                                    //         });
                                    //       }
                                    //     }
                                    //     print(":::${docMetaId}");
                                    //   },
                                    //   items: dropDownMenuItems,
                                    // ),

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
                                      visible: selectedExpiryType ==
                                          "Scheduled" ||
                                          selectedExpiryType == "Issuer Expiry",
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Expiry Date",
                                            style: GoogleFonts.firaSans(
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorManager.mediumgrey,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          SizedBox(height: AppSize.s5,),
                                          FormField<String>(
                                            builder:
                                                (FormFieldState<String> field) {
                                              return SizedBox(
                                                width: 354,
                                                height: 30,
                                                child: TextFormField(
                                                  controller: dateController,
                                                  cursorColor:
                                                  ColorManager.black,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: FontSize.s12,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                    ColorManager.mediumgrey,
                                                  ),
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 1),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                    ),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 1),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                    ),
                                                    hintText: 'mm-dd-yyyy',
                                                    hintStyle:
                                                    GoogleFonts.firaSans(
                                                      fontSize: FontSize.s12,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      color: ColorManager
                                                          .mediumgrey,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: ColorManager
                                                              .fmediumgrey),
                                                    ),
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                    suffixIcon: Icon(
                                                      Icons
                                                          .calendar_month_outlined,
                                                      color: ColorManager
                                                          .blueprime,
                                                    ),
                                                    errorText: field.errorText,
                                                  ),
                                                  onTap: () async {
                                                    DateTime? pickedDate =
                                                    await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                      DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(2101),
                                                    );
                                                    if (pickedDate != null) {
                                                      dateController
                                                          .text = DateFormat(
                                                          'MM-dd-yyyy')
                                                          .format(pickedDate);
                                                    }
                                                  },
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'please select birth date';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              );
                                            },
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
                      )
                          : _selectedIndex == 5
                      //     ? CustomIconButtonConst(
                      //   width: 170,
                      //   text: 'Add Documenccc',
                      //   onPressed: () async {
                      //     idDocController.clear();
                      //     nameDocController.clear();
                      //     dateController.clear();
                      //     expiryType = "";
                      //     String? selectedDocType;
                      //     String? selectedExpiryType = expiryType;
                      //     int docMetaId = 0;
                      //     List<DropdownMenuItem<String>> dropDownMenuItems = [];
                      //     final docTypes = await getEmployeeDocTab(context);
                      //     if (docTypes.isNotEmpty) {
                      //       for (var i in docTypes) {
                      //         dropDownMenuItems.add(
                      //           DropdownMenuItem<String>(
                      //             child: Text(i.employeeDocType),
                      //             value: i.employeeDocType,
                      //           ),
                      //         );
                      //       }
                      //       selectedDocType = dropDownMenuItems[0].value;
                      //       docMetaId = docTypes[0].employeeDocMetaDataId;
                      //     }
                      //
                      //     showDialog(
                      //       context: context,
                      //       builder: (BuildContext context) {
                      //         return StatefulBuilder(
                      //           builder: (BuildContext context,
                      //               void Function(void Function()) setState) {
                      //             return EmpDocEditPopup(
                      //               title: 'Add Document',
                      //               idDocController: idDocController,
                      //               nameDocController: nameDocController,
                      //               calenderController: dateController,
                      //               loadingDuration: _isLoading,
                      //               onSavePredded: () async {
                      //                 await addEmployeeDocSetup(
                      //                   context,
                      //                   docMetaId,
                      //                   nameDocController.text,
                      //                   dateController.text,
                      //                   selectedExpiryType.toString(),
                      //                 );
                      //                 Navigator.pop(context);
                      //                 nameDocController.clear();
                      //                 dateController.clear();
                      //                 print('$docMetaId');
                      //               },
                      //               child: CICCDropdown(
                      //                 initialValue: "Select Employee Document",
                      //                 hintText: "Select Employee Document",
                      //                 onChange: (val) {
                      //                   setState(() {
                      //                     selectedDocType = val;
                      //                   });
                      //                   for (var a in docTypes) {
                      //                     if (a.employeeDocType == val) {
                      //                       setState(() {
                      //                         docMetaId = a.employeeDocMetaDataId;
                      //                       });
                      //                     }
                      //                   }
                      //                   print(":::${docMetaId}");
                      //                 },
                      //                 items: dropDownMenuItems,
                      //               ),
                      //
                      //               radioButton: Padding(
                      //                 padding:
                      //                 const EdgeInsets.only(left: 10.0),
                      //                 child: Column(
                      //                   mainAxisAlignment:
                      //                   MainAxisAlignment.start,
                      //                   crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       "Expiry Type",
                      //                       style: GoogleFonts.firaSans(
                      //                         fontSize: FontSize.s12,
                      //                         fontWeight: FontWeight.w700,
                      //                         color: ColorManager.mediumgrey,
                      //                         decoration: TextDecoration.none,
                      //                       ),
                      //                     ),
                      //                     CustomRadioListTile(
                      //                       value: "Not Applicable",
                      //                       groupValue: selectedExpiryType,
                      //
                      //                       onChanged: (value) {
                      //                         setState(() {
                      //                           selectedExpiryType = value;
                      //                         });
                      //                       },
                      //                       title: "Not Applicable",
                      //                     ),
                      //                     CustomRadioListTile(
                      //                       value: 'Scheduled',
                      //                       groupValue: selectedExpiryType,
                      //                       onChanged: (value) {
                      //                         setState(() {
                      //                           selectedExpiryType = value;
                      //                         });
                      //                       },
                      //                       title: 'Scheduled',
                      //                     ),
                      //                     CustomRadioListTile(
                      //                       value: 'Issuer Expiry',
                      //                       groupValue: selectedExpiryType,
                      //                       onChanged: (value) {
                      //                         setState(() {
                      //                           selectedExpiryType = value;
                      //                         });
                      //                       },
                      //                       title: 'Issuer Expiry',
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               child2: Visibility(
                      //                 visible: selectedExpiryType ==
                      //                     "Scheduled" ||
                      //                     selectedExpiryType == "Issuer Expiry",
                      //                 child: Column(
                      //                   crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       "Expiry Date",
                      //                       style: GoogleFonts.firaSans(
                      //                         fontSize: FontSize.s12,
                      //                         fontWeight: FontWeight.w700,
                      //                         color: ColorManager.mediumgrey,
                      //                         decoration: TextDecoration.none,
                      //                       ),
                      //                     ),
                      //                     FormField<String>(
                      //                       builder:
                      //                           (FormFieldState<String> field) {
                      //                         return SizedBox(
                      //                           width: 354,
                      //                           height: 30,
                      //                           child: TextFormField(
                      //                             controller: dateController,
                      //                             cursorColor:
                      //                             ColorManager.black,
                      //                             style: GoogleFonts.firaSans(
                      //                               fontSize: FontSize.s12,
                      //                               fontWeight: FontWeight.w700,
                      //                               color:
                      //                               ColorManager.mediumgrey,
                      //                             ),
                      //                             decoration: InputDecoration(
                      //                               enabledBorder:
                      //                               OutlineInputBorder(
                      //                                 borderSide: BorderSide(
                      //                                     color: ColorManager
                      //                                         .fmediumgrey,
                      //                                     width: 1),
                      //                                 borderRadius:
                      //                                 BorderRadius.circular(
                      //                                     8),
                      //                               ),
                      //                               focusedBorder:
                      //                               OutlineInputBorder(
                      //                                 borderSide: BorderSide(
                      //                                     color: ColorManager
                      //                                         .fmediumgrey,
                      //                                     width: 1),
                      //                                 borderRadius:
                      //                                 BorderRadius.circular(
                      //                                     8),
                      //                               ),
                      //                               hintText: 'mm-dd-yyyy',
                      //                               hintStyle:
                      //                               GoogleFonts.firaSans(
                      //                                 fontSize: FontSize.s12,
                      //                                 fontWeight:
                      //                                 FontWeight.w700,
                      //                                 color: ColorManager
                      //                                     .mediumgrey,
                      //                               ),
                      //                               border: OutlineInputBorder(
                      //                                 borderRadius:
                      //                                 BorderRadius.circular(
                      //                                     8),
                      //                                 borderSide: BorderSide(
                      //                                     width: 1,
                      //                                     color: ColorManager
                      //                                         .fmediumgrey),
                      //                               ),
                      //                               contentPadding:
                      //                               EdgeInsets.symmetric(
                      //                                   horizontal: 16),
                      //                               suffixIcon: Icon(
                      //                                 Icons
                      //                                     .calendar_month_outlined,
                      //                                 color: ColorManager
                      //                                     .blueprime,
                      //                               ),
                      //                               errorText: field.errorText,
                      //                             ),
                      //                             onTap: () async {
                      //                               DateTime? pickedDate =
                      //                               await showDatePicker(
                      //                                 context: context,
                      //                                 initialDate:
                      //                                 DateTime.now(),
                      //                                 firstDate: DateTime(2000),
                      //                                 lastDate: DateTime(3101),
                      //                               );
                      //                               if (pickedDate != null) {
                      //                                 dateController
                      //                                     .text = DateFormat(
                      //                                     'MM-dd-yyyy')
                      //                                     .format(pickedDate);
                      //                               }
                      //                             },
                      //                             validator: (value) {
                      //                               if (value == null ||
                      //                                   value.isEmpty) {
                      //                                 return 'please select birth date';
                      //                               }
                      //                               return null;
                      //                             },
                      //                           ),
                      //                         );
                      //                       },
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             );
                      //           },
                      //         );
                      //       },
                      //     );
                      //   },
                      //   icon: Icons.add,
                      // )
                      //     : _selectedIndex == 6

                        ///compensation
                          ? CustomIconButtonConst(
                        width: 170,
                        text: 'Add Document',
                        onPressed: () async {
                          idDocController.clear();
                          nameDocController.clear();
                          dateController.clear();
                          expiryType = "";
                          String? selectedDocType;
                          String? selectedExpiryType = expiryType;
                          int docMetaId = 0;
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
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return EmpDocEditPopup(
                                    title: 'Add Document',
                                    idOfDocController: idDocController,
                                    nameDocController: nameDocController,
                                    calenderController: dateController,
                                    loadingDuration: _isLoading,
                                    onSavePredded: () async {
                                      String expiryTypeToSend =
                                      selectedExpiryType == "Not Applicable"
                                          ? "Not Applicable"
                                          : dateController.text;
                                      await addEmployeeDocSetup(context,
                                          AppConfig.compensationDocId,
                                          nameDocController.text,
                                          expiryTypeToSend,
                                          selectedExpiryType.toString(),
                                          idDocController.text);
                                      Navigator.pop(context);
                                      nameDocController.clear();
                                      dateController.clear();
                                      print('$AppConfig.compensationDocId');
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
                                            'Compensation',
                                            style: CustomTextStylesCommon.commonStyle(
                                              fontWeight: FontWeightManager.medium,
                                              fontSize: FontSize.s12,
                                              color: ColorManager.mediumgrey,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.transparent,
                                            // color: ColorManager.mediumgrey,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // child: CICCDropdown(
                                    //   initialValue: "Select Employee Document",
                                    //   hintText: "Select Employee Document",
                                    //   onChange: (val) {
                                    //     setState(() {
                                    //       selectedDocType = val;
                                    //     });
                                    //     for (var a in docTypes) {
                                    //       if (a.employeeDocType == val) {
                                    //         setState(() {
                                    //           docMetaId = a.employeeDocMetaDataId;
                                    //         });
                                    //       }
                                    //     }
                                    //     print(":::${docMetaId}");
                                    //   },
                                    //   items: dropDownMenuItems,
                                    // ),

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
                                      visible: selectedExpiryType ==
                                          "Scheduled" ||
                                          selectedExpiryType == "Issuer Expiry",
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Expiry Date",
                                            style: GoogleFonts.firaSans(
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorManager.mediumgrey,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          SizedBox(height: AppSize.s5,),
                                          FormField<String>(
                                            builder:
                                                (FormFieldState<String> field) {
                                              return SizedBox(
                                                width: 354,
                                                height: 30,
                                                child: TextFormField(
                                                  controller: dateController,
                                                  cursorColor:
                                                  ColorManager.black,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: FontSize.s12,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                    ColorManager.mediumgrey,
                                                  ),
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 1),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                    ),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 1),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                    ),
                                                    hintText: 'mm-dd-yyyy',
                                                    hintStyle:
                                                    GoogleFonts.firaSans(
                                                      fontSize: FontSize.s12,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      color: ColorManager
                                                          .mediumgrey,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: ColorManager
                                                              .fmediumgrey),
                                                    ),
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                    suffixIcon: Icon(
                                                      Icons
                                                          .calendar_month_outlined,
                                                      color: ColorManager
                                                          .blueprime,
                                                    ),
                                                    errorText: field.errorText,
                                                  ),
                                                  onTap: () async {
                                                    DateTime? pickedDate =
                                                    await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                      DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(2101),
                                                    );
                                                    if (pickedDate != null) {
                                                      dateController
                                                          .text = DateFormat(
                                                          'MM-dd-yyyy')
                                                          .format(pickedDate);
                                                    }
                                                  },
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'please select birth date';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              );
                                            },
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
                      )
                          :
                          ///Performance
                      CustomIconButtonConst(
                        width: 170,
                        text: 'Add Document',
                        onPressed: () async {
                          idDocController.clear();
                          nameDocController.clear();
                          dateController.clear();
                          expiryType = "";
                          String? selectedDocType;
                          String? selectedExpiryType = expiryType;
                          int docMetaId = 0;
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
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return EmpDocEditPopup(
                                    title: 'Add Document',
                                    idOfDocController: idDocController,
                                    nameDocController: nameDocController,
                                    calenderController: dateController,
                                    loadingDuration: _isLoading,
                                    onSavePredded: () async {
                                      String expiryTypeToSend =
                                      selectedExpiryType == "Not Applicable"
                                          ? "Not Applicable"
                                          : dateController.text;
                                      await addEmployeeDocSetup(context,
                                          AppConfig.performanceDocId,
                                          nameDocController.text,
                                          expiryTypeToSend,
                                          selectedExpiryType.toString(),
                                          idDocController.text);
                                      Navigator.pop(context);
                                      nameDocController.clear();
                                      dateController.clear();
                                      print('$AppConfig.performanceDocId');
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
                                            'Performance',
                                            style: CustomTextStylesCommon.commonStyle(
                                              fontWeight: FontWeightManager.medium,
                                              fontSize: FontSize.s12,
                                              color: ColorManager.mediumgrey,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.transparent,
                                            // color: ColorManager.mediumgrey,
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
                                      visible: selectedExpiryType ==
                                          "Scheduled" ||
                                          selectedExpiryType == "Issuer Expiry",
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Expiry Date",
                                            style: GoogleFonts.firaSans(
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorManager.mediumgrey,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          SizedBox(height: AppSize.s5,),
                                          FormField<String>(
                                            builder:
                                                (FormFieldState<String> field) {
                                              return SizedBox(
                                                width: 354,
                                                height: 30,
                                                child: TextFormField(
                                                  controller: dateController,
                                                  cursorColor:
                                                  ColorManager.black,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: FontSize.s12,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                    ColorManager.mediumgrey,
                                                  ),
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 1),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                    ),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 1),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                    ),
                                                    hintText: 'mm-dd-yyyy',
                                                    hintStyle:
                                                    GoogleFonts.firaSans(
                                                      fontSize: FontSize.s12,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      color: ColorManager
                                                          .mediumgrey,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: ColorManager
                                                              .fmediumgrey),
                                                    ),
                                                    contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                    suffixIcon: Icon(
                                                      Icons
                                                          .calendar_month_outlined,
                                                      color: ColorManager
                                                          .blueprime,
                                                    ),
                                                    errorText: field.errorText,
                                                  ),
                                                  onTap: () async {
                                                    DateTime? pickedDate =
                                                    await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                      DateTime.now(),
                                                      // firstDate: DateTime(2000),
                                                      // lastDate: DateTime(3101),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(2101),
                                                    );
                                                    if (pickedDate != null) {
                                                      dateController
                                                          .text = DateFormat(
                                                          'MM-dd-yyyy')
                                                          .format(pickedDate);
                                                    }
                                                  },
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'please select birth date';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              );
                                            },
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
                      )

                    ],
                  ),
                ),




///////////////////////// tab bar
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
          const SizedBox(
            height: 30,
          ),
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
