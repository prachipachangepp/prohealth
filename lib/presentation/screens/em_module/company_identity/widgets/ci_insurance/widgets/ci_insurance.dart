import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/manage_insurance_manager/insurance_vendor_contract_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/ci_insurance_contract.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/ci_insurance_vendor.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import '../../../../../../../data/api_data/establishment_data/ci_manage_button/manage_insurance_data.dart';
import '../../../../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../company_identity_screen.dart';
import '../../ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'contract_add_dialog.dart';
import 'custome_dialog.dart';

class CIInsurance extends StatefulWidget {
  final String officeId;
  final int docID;
  final int subDocID;
  final int companyID;

  const CIInsurance({
    super.key,
    required this.officeId,
    required this.docID,
    required this.subDocID,
    required this.companyID,
  });

  @override
  State<CIInsurance> createState() => _CiOrgDocumentState();
}

class _CiOrgDocumentState extends State<CIInsurance> {
  final PageController _tabPageController = PageController();
  TextEditingController vendorNameController = TextEditingController();
  TextEditingController contractNameController = TextEditingController();
  TextEditingController contractIdController = TextEditingController();

  int _selectedIndex = 0;
  int selectedVendorId = 0;
  String? selectedVendorName;
  String? selectedExpiryType;

  bool isAddButtonEnabled = false;

  void _selectButton(int index,[bool? selected]) {
    setState(() {
      _selectedIndex = index;
      selected = false;
    });
    _tabPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  String? expiryType;
  String? selectedValue;

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
                    ? SizedBox(width: 354)
                    : FutureBuilder<List<ManageVendorData>>(
                  future: companyVendorGet(context, widget.officeId, 1, 20),
                  builder: (context, snapshotZone) {
                    if (snapshotZone.connectionState == ConnectionState.waiting &&
                        selectedValue == null) {
                      return Container(
                        width: 300,
                        child: Text(
                          "Loading...",
                          style: CustomTextStylesCommon.commonStyle(
                            fontWeight: FontWeightManager.medium,
                            fontSize: FontSize.s12,
                            color: ColorManager.mediumgrey,
                          ),
                        ),
                      );
                    }

                    if (snapshotZone.hasError || snapshotZone.data == null) {
                      return Container(
                        height: 30,
                        width: 354,
                        child: Text(
                          "Loading data",
                          style: CustomTextStylesCommon.commonStyle(
                            fontWeight: FontWeightManager.medium,
                            fontSize: FontSize.s12,
                            color: ColorManager.mediumgrey,
                          ),
                        ),
                      );
                    }

                    if (snapshotZone.data!.isEmpty) {
                      return Container(
                        height: 30,
                        width: 354,
                        child: Center(
                          child: Text(
                            AppString.dataNotFound,
                            style: CustomTextStylesCommon.commonStyle(
                              fontWeight: FontWeightManager.medium,
                              fontSize: FontSize.s12,
                              color: ColorManager.mediumgrey,
                            ),
                          ),
                        ),
                      );
                    }

                    if (snapshotZone.hasData) {
                      List<DropdownMenuItem<String>> dropDownTypesList = [];
                      for (var i in snapshotZone.data!) {
                        dropDownTypesList.add(
                          DropdownMenuItem<String>(
                            value: i.vendorName,
                            child: Text(i.vendorName),
                          ),
                        );
                      }

                      // Initialize selectedValue if not already selected
                      if (selectedValue == null && dropDownTypesList.isNotEmpty) {
                        selectedValue = dropDownTypesList[0].value;
                      }

                      return CICCDropdown(
                        initialValue: selectedValue,
                        onChange: (val) {
                          setState(() {
                            selectedValue = val;
                            for (var a in snapshotZone.data!) {
                              if (a.vendorName == val) {
                                int docType = a.insuranceVendorId;
                                print("Insurance vendor id :: ${a.insuranceVendorId}");
                                selectedVendorId = docType;
                                isAddButtonEnabled = true;
                                _selectButton(1);
                                break;
                              }
                            }
                          });
                        },
                        items: dropDownTypesList,
                      );
                    }

                    return const SizedBox();
                  },
                ),


                ///tabbar
                Padding(
                  padding: const EdgeInsets.only(right: 250),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 7,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => _selectButton(0,isAddButtonEnabled),
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
                                    onPressed: () async {
                                      await addVendors(
                                        context,
                                        widget.officeId,
                                        vendorNameController.text,
                                      );
                                    },
                                    buttontxt: AppStringEM.Add,
                                    successpopuptext: 'Added Successfully',
                                  );
                                },
                              );
                            }),
                      )
                    : CustomIconButtonConst(
                        width: 130,
                        icon: Icons.add,
                        text: "Add Doctype",
                        onPressed:
                        isAddButtonEnabled?  () {
                                //selectedExpiryType = expiryType;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context, void Function(void Function()) setState) {
                                        return ContractAddDialog(
                                          contractNmaeController: contractNameController,
                                          radiobutton:Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Expiry Type',
                                                style: GoogleFonts.firaSans(
                                                  fontSize: FontSize.s12,
                                                  fontWeight: FontWeight.w700,
                                                  color: ColorManager.mediumgrey,
                                                ),
                                              ),
                                              CustomRadioListTile(
                                                value: "Not Applicable",
                                                groupValue: selectedExpiryType,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedExpiryType = value!;
                                                  });
                                                },
                                                title: "Not Applicable",
                                              ),
                                              CustomRadioListTile(
                                                value: 'Scheduled',
                                                groupValue: selectedExpiryType,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedExpiryType = value!;
                                                  });
                                                },
                                                title: 'Scheduled',
                                              ),
                                              CustomRadioListTile(
                                                value: 'Issuer Expiry',
                                                groupValue: selectedExpiryType,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedExpiryType = value!;
                                                  });
                                                },
                                                title: 'Issuer Expiry',
                                              ),
                                            ],
                                          ),
                                          onSubmitPressed: () async {
                                            //if (selectedVendorId == 0) {
                                            await addVendorContract(
                                              context,
                                              selectedVendorId,
                                              contractNameController.text,
                                              selectedExpiryType!,
                                              widget.officeId,
                                              contractIdController.text,
                                            );
                                            // } else {
                                            //   ScaffoldMessenger.of(context).showSnackBar(
                                            //     SnackBar(content: Text("Please select a vendor")),
                                            //   );
                                            // }
                                          },
                                          contractIdController:
                                          contractIdController,
                                          title: 'Add Contract',
                                        );
                                      },
                                    );
                                  },
                                );
                              }
                            : () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Please select a vendor")),
                                );
                              },
                        enabled: isAddButtonEnabled,
                      ),
              ],
            ),
          ),
          SizedBox(height: 30),
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
                  CiInsuranceVendor(
                    officeId: widget.officeId,
                  ),
                  CiInsuranceContract(
                    insuranceVendorId: selectedVendorId,
                    officeId: widget.officeId,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

