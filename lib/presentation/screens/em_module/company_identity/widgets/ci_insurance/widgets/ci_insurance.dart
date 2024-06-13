import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/ci_insurance_contract.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/ci_insurance_vendor.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../company_identity_screen.dart';
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
        SizedBox(
          height: 10,
        ),
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
                  : Container(
                      height: 30,
                      width: 354,
                      // margin: EdgeInsets.symmetric(horizontal: 20),
                      padding:
                          EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Color(0xff686464).withOpacity(0.5),
                            width: 1), // Black border
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                      child: DropdownButtonFormField<String>(
                        focusColor: Colors.transparent,
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Color(0xff686464),
                        ),
                        decoration: InputDecoration.collapsed(hintText: ''),
                        items: <String>[
                          'Sample Vendor',
                          'Option 1',
                          'Option 2',
                          'Option 3',
                          'Option 4'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {},
                        value: 'Sample Vendor',
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff686464),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),

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
                                onPressed: () {},
                              );
                            });
                      })
                  :  CustomIconButtonConst(
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

    );
    });
    }),
              // Align(
              //     alignment: Alignment.bottomRight,
              //     child: Material(
              //       elevation: 3,
              //       borderRadius: BorderRadius.circular(20),
              //       child: Container(
              //         height: 30,
              //         width: 150,
              //         child: CustomIconButton(
              //             icon: CupertinoIcons.plus,
              //             text: "Add Document",
              //             onPressed: () {
              //               showDialog(
              //                   context: context,
              //                   builder: (context) {
              //                     return AddOrgDocButton(
              //                       idDocController: docIdController,
              //                       nameDocController: docNamecontroller,
              //
              //                       child: CICCDropdown(
              //                         initialValue:
              //                         'Corporate & Compliance Documents',
              //                         items: [
              //                           DropdownMenuItem(
              //                               value:
              //                               'Corporate & Compliance Documents',
              //                               child: Text(
              //                                   'Corporate & Compliance Documents')),
              //                           DropdownMenuItem(
              //                               value: 'HCO Number      254612',
              //                               child: Text('HCO Number  254612')),
              //                           DropdownMenuItem(
              //                               value: 'Medicare ID      MPID123',
              //                               child: Text('Medicare ID  MPID123')),
              //                           DropdownMenuItem(
              //                               value: 'NPI Number     1234567890',
              //                               child: Text('NPI Number 1234567890')),
              //                         ],
              //                       ),
              //                       child1: CICCDropdown(
              //                         initialValue: 'Licenses',
              //                         items: [
              //                           DropdownMenuItem(
              //                               value: 'Licenses',
              //                               child: Text('Licenses')),
              //                           DropdownMenuItem(
              //                               value: 'HCO Number      254612',
              //                               child: Text('HCO Number  254612')),
              //                           DropdownMenuItem(
              //                               value: 'Medicare ID      MPID123',
              //                               child: Text('Medicare ID  MPID123')),
              //                           DropdownMenuItem(
              //                               value: 'NPI Number     1234567890',
              //                               child: Text('NPI Number 1234567890')),
              //                         ],
              //                       ),
              //                     );
              //                   });
              //             }),
              //       ),
              //     )),
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
