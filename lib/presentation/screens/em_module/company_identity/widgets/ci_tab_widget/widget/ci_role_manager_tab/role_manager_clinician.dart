import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_role_manager_tab/widgets/ci_role_container_constant.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import '../../../../../../../../app/services/api/managers/establishment_manager/pay_rates_manager.dart';
import '../../../../../../../../app/services/api/managers/establishment_manager/role_manager.dart';
import '../../../../../../../../data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import '../../../../../../../../data/api_data/establishment_data/pay_rates/pay_rates_finance_data.dart';
import '../../../../../../../../data/api_data/establishment_data/role_manager/role_manager_data.dart';
import '../../../../../widgets/button_constant.dart';

class RoleManagerClinician extends StatefulWidget {
  const RoleManagerClinician({super.key});

  @override
  State<RoleManagerClinician> createState() => _RoleManagerClinicianState();
}

class _RoleManagerClinicianState extends State<RoleManagerClinician> {
  List<bool> selectedContainers = List.generate(15, (_) => false);
  String _selectedOffice = 'Pick Office';
  // Color _employeeTextColor = Colors.grey;
  // Color _employeeBorderColor = ColorManager.black.withOpacity(0.3);
  final StreamController<List<PayRateFinanceData>> _roleMDropDownController =
      StreamController<List<PayRateFinanceData>>();
  final StreamController<List<ModuleMetaData>> roleMetaDataClinicalController =
      StreamController<List<ModuleMetaData>>();
  // bool _officeSelected = false;
  Color _employeeTextColor = ColorManager.black.withOpacity(0.3);
  Color _employeeBorderColor = Colors.grey;

  void toggleSelection(int index) {
    setState(() {
      selectedContainers[index] = !selectedContainers[index];
    });
  }

  void _onOfficeChanged(String? newValue) {
    setState(() {
      _selectedOffice = newValue!;
      _employeeTextColor = Colors.red;
      _employeeBorderColor = Colors.red.withOpacity(0.3);
    });
  }

  @override
  void initState() {
    super.initState();
    payRatesDataGet(context,11,1, 1, 10).then((data) {
      _roleMDropDownController.add(data);
    }).catchError((error) {
      // Handle error
    });
    roleMabagerMetaData(context).then((data) {
      roleMetaDataClinicalController.add(data);
    }).catchError((error) {
      // Handle error
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pick Office',
                      style: GoogleFonts.firaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.mediumgrey,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 4),
                    FutureBuilder<List<RoleManagerData>>(
                      future: roleManagerDataGet(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 300,
                              height: 30,
                              decoration: BoxDecoration(
                                color: ColorManager.faintGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        }
                        if (snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              AppString.dataNotFound,
                              style: CustomTextStylesCommon.commonStyle(
                                fontWeight: FontWeightManager.medium,
                                fontSize: FontSize.s12,
                                color: ColorManager.mediumgrey,
                              ),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          List<String> dropDownList = [];
                          List<String> dropDownAbbreviation = [];
                          for (var i in snapshot.data!) {
                            dropDownList.add(i.deptName);
                            dropDownAbbreviation.add(i.description);
                          }
                          return Row(
                            children: [
                              Container(
                                height: 30,
                                width: 354,
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color(0xff686464).withOpacity(0.5),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButtonFormField<String>(
                                  focusColor: Colors.transparent,
                                  icon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: Color(0xff686464),
                                  ),
                                  decoration:
                                      InputDecoration.collapsed(hintText: ''),
                                  items: dropDownList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value == null ? "1" : value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _employeeTextColor = Color(0xff686464);
                                      _employeeBorderColor = Color(0xff686464);
                                    });
                                  },
                                  value: dropDownList[0],
                                  style: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff686464),
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Offstage();
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pick Employee Type',
                      style: GoogleFonts.firaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _employeeTextColor,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: 4),
                    FutureBuilder<List<HRClinical>>(
                      future: companyAllHrClinicApi(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 300,
                              height: 30,
                              decoration: BoxDecoration(
                                color: ColorManager.faintGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        }
                        if (snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              AppString.dataNotFound,
                              style: CustomTextStylesCommon.commonStyle(
                                fontWeight: FontWeightManager.medium,
                                fontSize: FontSize.s12,
                                color: ColorManager.mediumgrey,
                              ),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          List<String> dropDownList = [];
                          List<String> dropDownAbbreviation = [];
                          for (var i in snapshot.data!) {
                            dropDownList.add(i.empType!);
                            dropDownAbbreviation.add(i.abbrivation!);
                          }
                          return Row(
                            children: [
                              Container(
                                height: 30,
                                width: 354,
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: _employeeBorderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButtonFormField<String>(
                                  focusColor: Colors.transparent,
                                  icon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: Color(0xff686464),
                                  ),
                                  decoration:
                                      InputDecoration.collapsed(hintText: ''),
                                  items: dropDownList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value == null ? "1" : value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {},
                                  value: dropDownList[0],
                                  style: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _employeeTextColor,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Offstage();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            /// row 1
            StreamBuilder<List<ModuleMetaData>>(
                stream: roleMetaDataClinicalController.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1,
                          child: Center(
                            child: Wrap(
                                children: List.generate(10, (index) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 10),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        5.3,
                                    width:
                                        MediaQuery.of(context).size.width / 6.5,
                                    decoration: BoxDecoration(
                                      color: ColorManager.faintGrey,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                    ),
                                  ));
                            })),
                          ),
                        ),
                      ),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        AppString.dataNotFound,
                        style: CustomTextStylesCommon.commonStyle(
                          fontWeight: FontWeightManager.medium,
                          fontSize: FontSize.s12,
                          color: ColorManager.mediumgrey,
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1,
                        child: Center(
                          child: Wrap(
                              children:
                                  List.generate(snapshot.data!.length, (index) {
                            var metaModule = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  toggleSelection(0);
                                },
                                child: CIRoleContainerConstant(
                                  metaModule.mainModule,
                                  AssetImage(metaModule.iconUrl.toString()),
                                  borderColor: selectedContainers[0]
                                      ? ColorManager.blueprime
                                      : Colors.white,
                                ),
                              ),
                            );
                          })),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                }),
            SizedBox(height: 40),

            /// button
            Center(
              child: CustomElevatedButton(
                width: AppSize.s105,
                height: AppSize.s30,
                text: AppStringEM.save,
                onPressed: () {
                  //Navigator.pop(context);
                },
              ),
            ),
          ]),
    ));
  }
}
