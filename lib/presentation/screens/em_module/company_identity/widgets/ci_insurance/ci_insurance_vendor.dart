import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/ci_manage_button/manage_insurance_data.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/company_identity_data_.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import 'package:prohealth/app/services/api_sm/company_identity/add_doc_company_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/widgets/custome_dialog.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../app/services/api/managers/establishment_manager/manage_insurance_manager/insurance_vendor_contract_manager.dart';
import '../../../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import '../../../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';

class CiInsuranceVendor extends StatefulWidget {
  final String officeId;
  const CiInsuranceVendor({super.key, required this.officeId,});

  @override
  State<CiInsuranceVendor> createState() => _CiInsuranceVendorState();
}

class _CiInsuranceVendorState extends State<CiInsuranceVendor> {
  TextEditingController vendorNameController = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController workemailController = TextEditingController();
  TextEditingController workphoneController = TextEditingController();
  final StreamController<List<ManageVendorData>> _companyVendor =
      StreamController<List<ManageVendorData>>();
  //late CompanyIdentityManager _companyManager;
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 40;
    items = List.generate(20, (index) => 'Item ${index + 1}');
   // _companyManager = CompanyIdentityManager();
    companyVendorGet(context).then((data) {
      _companyVendor.add(data);
    }).catchError((error) {
      // Handle error
    });
    // companyAllApi(context);
  }
  String? selectedZoneName;
  String? selectedCityName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Text(''),
                  Text(
                    AppString.srNo,
                    style: GoogleFonts.firaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
//SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Text('Name    ',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(AppString.actions,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<List<ManageVendorData>>(
                stream: _companyVendor.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.blueprime,
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
                          color: ColorManager.mediumgrey),
                    ));
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          int serialNumber =
                              index + 1 + (currentPage - 1) * itemsPerPage;
                          String formattedSerialNumber =
                              serialNumber.toString().padLeft(2, '0');
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff000000)
                                              .withOpacity(0.25),
                                          spreadRadius: 0,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            formattedSerialNumber,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff686464),
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          // Text(''),
                                          Text(
                                            snapshot.data![index].vendorName
                                                .toString().capitalizeFirst!,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff686464),
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          //  Text(''),
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return CustomPopup(
                                                            title: 'Edit Vendor',
                                                            namecontroller: nameController,
                                                            addressController: addresscontroller,
                                                            emailController: emailController,
                                                            workemailController: workemailController,
                                                            phoneController: phoneController,
                                                            workPhoneController: workphoneController,
                                                            childZone: FutureBuilder<List<AEClinicalZone>>(
                                                              future: HrAddEmplyClinicalZoneApi(context),
                                                              builder: (context, snapshot) {
                                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                                  return Shimmer.fromColors(
                                                                    baseColor: Colors.grey[300]!,
                                                                    highlightColor: Colors.grey[100]!,
                                                                    child: Container(
                                                                      width: 350,
                                                                      height: 30,
                                                                      decoration: BoxDecoration(
                                                                        color: ColorManager.faintGrey,
                                                                        borderRadius: BorderRadius.circular(10),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }

                                                                if (snapshot.hasData) {
                                                                  List<DropdownMenuItem<String>> dropDownMenuItems = [];
                                                                  for (var i in snapshot.data!) {
                                                                    dropDownMenuItems.add(
                                                                      DropdownMenuItem<String>(
                                                                        child: Text(i.zoneName!),
                                                                        value: i.zoneName,
                                                                      ),
                                                                    );
                                                                  }
                                                                  return CICCDropdown(
                                                                    initialValue: AppString.zone,
                                                                    onChange: (val) {
                                                                      selectedZoneName = val;
                                                                      print("Selected Zone Name: $selectedZoneName");
                                                                    },
                                                                    items: dropDownMenuItems,
                                                                  );
                                                                } else if (snapshot.data!.isEmpty) {
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
                                                                } else {
                                                                  return SizedBox();
                                                                }
                                                              },
                                                            ),
                                                            childCity: FutureBuilder<List<AEClinicalCity>>(
                                                              future: HrAddEmplyClinicalCityApi(context),
                                                              builder: (context, snapshot) {
                                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                                  return Shimmer.fromColors(
                                                                    baseColor: Colors.grey[300]!,
                                                                    highlightColor: Colors.grey[100]!,
                                                                    child: Container(
                                                                      width: 350,
                                                                      height: 30,
                                                                      decoration: BoxDecoration(
                                                                        color: ColorManager.faintGrey,
                                                                        borderRadius: BorderRadius.circular(10),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }

                                                                if (snapshot.hasData) {
                                                                  List<DropdownMenuItem<String>> dropDownMenuItems = [];
                                                                  for (var i in snapshot.data!) {
                                                                    dropDownMenuItems.add(
                                                                      DropdownMenuItem<String>(
                                                                        child: Text(i.cityName!),
                                                                        value: i.cityName,
                                                                      ),
                                                                    );
                                                                  }
                                                                  return CICCDropdown(
                                                                    initialValue: AppString.city,
                                                                    onChange: (val) {
                                                                      selectedCityName = val;
                                                                      print("Selected City Name: $selectedCityName");
                                                                    },
                                                                    items: dropDownMenuItems,
                                                                  );
                                                                } else if (snapshot.data!.isEmpty) {
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
                                                                } else {
                                                                  return SizedBox();
                                                                }
                                                              },
                                                            ),
                                                            onPressed: () async{
                                                              await patchCompanyVendor(context,
                                                                  snapshot.data![index].vendorId!,
                                                                  widget.officeId,
                                                                  nameController.text,
                                                                  addresscontroller.text,
                                                                  selectedCityName ?? '',
                                                                  emailController.text,
                                                                  phoneController.text,
                                                                  workemailController.text,
                                                                  workphoneController.text,
                                                                  selectedZoneName ?? '');
                                                            },
                                                          );
                                                        });
                                                  },
                                                  icon: Icon(
                                                    Icons.edit_outlined,
                                                    color:
                                                        ColorManager.blueprime,
                                                    size: 18,
                                                  )),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.delete_outline,
                                                    color: ColorManager.red,
                                                    size: 18,
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          );
                        });
                  }
                  return Offstage();
                }),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // PaginationControlsWidget(
          //   currentPage: currentPage,
          //   items: items,
          //   itemsPerPage: itemsPerPage,
          //   onPreviousPagePressed: () {
          //     /// Handle previous page button press
          //     setState(() {
          //       currentPage = currentPage > 1 ? currentPage - 1 : 1;
          //     });
          //   },
          //   onPageNumberPressed: (pageNumber) {
          //     /// Handle page number tap
          //     setState(() {
          //       currentPage = pageNumber;
          //     });
          //   },
          //   onNextPagePressed: () {
          //     /// Handle next page button press
          //     setState(() {
          //       currentPage = currentPage < (items.length / itemsPerPage).ceil()
          //           ? currentPage + 1
          //           : (items.length / itemsPerPage).ceil();
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}
