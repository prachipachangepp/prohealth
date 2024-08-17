import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/manage_insurance_manager/insurance_vendor_contract_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/ci_insurance_contract.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/ci_insurance_vendor.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import '../../../../../../../data/api_data/establishment_data/ci_manage_button/manage_insurance_data.dart';
import '../../../../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../company_identity_screen.dart';
import '../../ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'contract_add_dialog.dart';
import 'custome_dialog.dart';

class CIInsurance extends StatefulWidget {
  final String officeId;
  final int docID;
  final int subDocID;
  final int companyID;
  const CIInsurance({super.key, required this.officeId, required this.docID, required this.subDocID, required this.companyID,});

  @override
  State<CIInsurance> createState() => _CiOrgDocumentState();
}

class _CiOrgDocumentState extends State<CIInsurance> {
  final PageController _tabPageController = PageController();
  TextEditingController vendorNameController = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController workemailController = TextEditingController();
  TextEditingController workphoneController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController contractNameController = TextEditingController();
  TextEditingController contractIdController = TextEditingController();

  int _selectedIndex = 0;
  int zoneId=1;
  String? selectedZoneName;
  String? selectedCityName;
  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _tabPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _selectedIndex == 0
                    ? SizedBox(
                        width: 354,
                      )
                    : FutureBuilder<List<ManageVendorData>>(
                        future: companyVendorGet(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 350,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: ColorManager.faintGrey,
                                      borderRadius: BorderRadius.circular(10)),
                                ));
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
                            List dropDown = [];
                            String docType = 'vendor name';
                            List<DropdownMenuItem<String>> dropDownMenuItems = [];
                            for (var i in snapshot.data!) {
                              dropDownMenuItems.add(
                                DropdownMenuItem<String>(
                                  child: Text(i.vendorName!),
                                  value: i.vendorName,
                                ),
                              );
                            }
                            return CICCDropdown(
                                initialValue: 'Vendor Contract',
                                onChange: (val) {
                                  for (var a in snapshot.data!) {
                                    if (a.vendorName == val) {
                                      docType = a.vendorName!;
                                      //DepartmentId = docType;
                                    }
                                  }
      
                                  print(":::${docType}");
                                  //print(":::<>${DepartmentId}");
                                },
                                items: dropDownMenuItems);
                          } else {
                            return SizedBox();
                          }
                        }),
                ///tabbar
                Padding(
                  padding: const EdgeInsets.only(right: 250),
                  child: Container(
                    //color: Colors.greenAccent,
                    width: MediaQuery.of(context).size.width / 7,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => _selectButton(0),
                          child: Container(
                            height: 40,
                            width: 80,
                            child: Column(
                              children: [
                                Text(
                                  "Vendor",
                                  style: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    fontWeight: _selectedIndex == 0
                                        ? FontWeightManager.bold
                                        : FontWeightManager.regular,
                                    color: _selectedIndex == 0
                                        ? ColorManager.blueprime
                                        : ColorManager.mediumgrey,
                                  ),
                                ),
                                _selectedIndex == 0
                                    ? Divider(
                                        color: ColorManager.blueprime,
                                        thickness: 2,
                                      )
                                    : Offstage()
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => _selectButton(1),
                          child: Container(
                            height: 40,
                            width: 80,
                            child: Column(
                              children: [
                                Text(
                                  "Contract",
                                  style: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    fontWeight: _selectedIndex == 1
                                        ? FontWeightManager.bold
                                        : FontWeightManager.regular,
                                    color: _selectedIndex == 1
                                        ? ColorManager.blueprime
                                        : ColorManager.mediumgrey,
                                  ),
                                ),
                                _selectedIndex == 1
                                    ? Divider(
                                        color: ColorManager.blueprime,
                                        thickness: 2,
                                      )
                                    : Offstage()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      
                ///button
                _selectedIndex == 0
                    ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CustomIconButtonConst(
                                        width: 79,
                          icon: Icons.add,
                          text: "Add",
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomPopup(
                                    title: 'Add Vendor',
                                    namecontroller: vendorNameController,
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
                                    onPressed: () async {
                                      await addVendors(
                                        context,
                                        widget.officeId,
                                        vendorNameController.text,
                                        addresscontroller.text,
                                        selectedZoneName!,
                                        emailController.text,
                                        phoneController.text,
                                        workemailController.text,
                                        workphoneController.text,
                                        selectedZoneName!,
                                      );
                                    },
                                  );
                                });
                          }),
                    )
                    : CustomIconButtonConst(
                        width: 130,
                        icon: Icons.add,
                        text: "Add Doctype",
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ContractAddDialog(
                                  contractNmaeController: contractNameController,
                                  onSubmitPressed: () {},
                                  contractIdController: contractIdController,
                                  title: 'Add Contract',
                                );
                              });
                        }),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 40),
              child: NonScrollablePageView(
                controller: _tabPageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: [
                  // Page 1
                  CiInsuranceVendor(officeId: widget.officeId,),
                  CiInsuranceContract(docID: widget.docID, subDocID: widget.subDocID, companyID: widget.companyID, officeId: widget.officeId,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
