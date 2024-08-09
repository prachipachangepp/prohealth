import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/ci_insurance_contract.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/ci_insurance_vendor.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../../../../../../data/api_data/establishment_data/ci_manage_button/manage_insurance_data.dart';
import '../../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../company_identity_screen.dart';
import '../../ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'contract_add_dialog.dart';
import 'custome_dialog.dart';

class CIInsurance extends StatefulWidget {
  const CIInsurance({super.key});

  @override
  State<CIInsurance> createState() => _CiOrgDocumentState();
}

class _CiOrgDocumentState extends State<CIInsurance> {
  final PageController _tabPageController = PageController();
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController countynameController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController mapController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController vendorName = TextEditingController();
  TextEditingController contractNameController = TextEditingController();
  TextEditingController contractIdController = TextEditingController();

  int _selectedIndex = 0;

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
    return Column(
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
                  :  FutureBuilder<List<ManageInsuranceVendorData>>(
                  future: companyVendorGet(context),
                  builder: (context,snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 350,
                            height: 30,
                            decoration: BoxDecoration(color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
                          )
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
                    if(snapshot.hasData){
                      List dropDown = [];
                      String docType = 'vendor name';
                      List<DropdownMenuItem<String>> dropDownMenuItems = [];
                      for(var i in snapshot.data!){
                        dropDownMenuItems.add(
                          DropdownMenuItem<String>(
                            child: Text(i.vendorName!),
                            value: i.vendorName,
                          ),
                        );
                      }
                      return CICCDropdown(
                          initialValue: 'Vendor Contract',
                          onChange: (val){
                            for(var a in snapshot.data!){
                              if(a.vendorName == val){
                                docType = a.vendorName!;
                                //DepartmentId = docType;

                              }
                            }

                            print(":::${docType}");
                            //print(":::<>${DepartmentId}");
                          },
                          items:dropDownMenuItems
                      );
                    }else{
                      return SizedBox();
                    }
                  }
              ),
              // Container(
              //         height: 30,
              //         width: 354,
              //         // margin: EdgeInsets.symmetric(horizontal: 20),
              //         padding:
              //             EdgeInsets.symmetric(vertical: 3, horizontal: 15),
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           border: Border.all(
              //               color: Color(0xff686464).withOpacity(0.5),
              //               width: 1), // Black border
              //           borderRadius:
              //               BorderRadius.circular(8), // Rounded corners
              //         ),
              //         child: DropdownButtonFormField<String>(
              //           focusColor: Colors.transparent,
              //           icon: Icon(
              //             Icons.arrow_drop_down_sharp,
              //             color: Color(0xff686464),
              //           ),
              //           decoration: InputDecoration.collapsed(hintText: ''),
              //           items: <String>[
              //             'Sample Vendor',
              //             'Option 1',
              //             'Option 2',
              //             'Option 3',
              //             'Option 4'
              //           ].map<DropdownMenuItem<String>>((String value) {
              //             return DropdownMenuItem<String>(
              //               value: value,
              //               child: Text(value),
              //             );
              //           }).toList(),
              //           onChanged: (String? newValue) {},
              //           value: 'Sample Vendor',
              //           style: GoogleFonts.firaSans(
              //             fontSize: 12,
              //             fontWeight: FontWeight.w600,
              //             color: Color(0xff686464),
              //             decoration: TextDecoration.none,
              //           ),
              //         ),
              //       ),

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
                  ? CustomIconButtonConst(
                      icon: Icons.add,
                      text: "Add",
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomPopup(
                                controller: vendorName,
                                onPressed: () {}, title: 'Add Vendor',
                              );
                            });
                      })
                  : CustomIconButtonConst(
                      icon: Icons.add,
                      text: "Add Doctype",
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ContractAddDialog(
                                contractNmaeController: contractNameController,
                                onSubmitPressed: () {},
                                contractIdController: contractIdController, title: 'Add Contract',
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
                horizontal: MediaQuery.of(context).size.width / 50),
            child: NonScrollablePageView(
              controller: _tabPageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                // Page 1
                CiInsuranceVendor(),
                CiInsuranceContract(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
