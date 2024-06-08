import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api_sm/company_identity/add_doc_company_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/widgets/vendor_add_popup_const.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/pagination_widget.dart';

import 'widgets/ci_vendor_contract_edit_popup_const.dart';

class CiDme extends StatefulWidget {
  const CiDme({super.key});

  @override
  State<CiDme> createState() => _CiDmeState();
}

class _CiDmeState extends State<CiDme> {
  TextEditingController nameOfDocController = TextEditingController();
  TextEditingController idOfDocController = TextEditingController();
  TextEditingController editnameOfDocController = TextEditingController();
  TextEditingController editidOfDocController = TextEditingController();
  late CompanyIdentityManager _companyManager;
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 5;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    _companyManager = CompanyIdentityManager();
    // companyAllApi(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomIconButtonConst(
              icon: Icons.add,
              text: "Add Doctype",
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CiVendorAddPopup(
                        nameOfDocController: nameOfDocController,
                        idOfDocController: idOfDocController,
                        onSavePressed: () {},
                        child: CICCDropdown(
                          initialValue: 'Vendor Contract',
                          items: [
                            DropdownMenuItem(
                                value: 'Vendor Contract',
                                child: Text('Vendor Contract')),
                            DropdownMenuItem(
                                value: 'HCO Number      254612',
                                child: Text('HCO Number  254612')),
                            DropdownMenuItem(
                                value: 'Medicare ID      MPID123',
                                child: Text('Medicare ID  MPID123')),
                            DropdownMenuItem(
                                value: 'NPI Number     1234567890',
                                child: Text('NPI Number 1234567890')),
                          ],
                        ),
                        child1: CICCDropdown(
                          initialValue: 'DME',
                          items: [
                            DropdownMenuItem(value: 'DME', child: Text('DME')),
                            DropdownMenuItem(
                                value: 'HCO Number      254612',
                                child: Text('HCO Number  254612')),
                            DropdownMenuItem(
                                value: 'Medicare ID      MPID123',
                                child: Text('Medicare ID  MPID123')),
                            DropdownMenuItem(
                                value: 'NPI Number     1234567890',
                                child: Text('NPI Number 1234567890')),
                          ],
                        ),
                      );
                    });
              }),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 8,
                itemBuilder: (context, index) {
                  // int serialNumber =
                  //     index + 1 + (currentPage - 1) * itemsPerPage;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff000000).withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            height: 50,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.remove_red_eye_outlined,
                                            color: ColorManager.blueprime,
                                          )),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "ID: 248d1eb1-9020-4d8d-8168-43a3ef90a261",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff686464),
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          Text(
                                            "NanDoc",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff686464),
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  //  Text(''),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.history,
                                            size:18,
                                            color: ColorManager.blueprime,
                                          )),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.print_outlined,
                                            size:18,
                                            color: ColorManager.blueprime,
                                          )),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.file_download_outlined,
                                            size:18,
                                            color: ColorManager.blueprime,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return CCScreenEditPopup(
                                                    idDocController:
                                                        editidOfDocController,
                                                    nameDocController:
                                                        editnameOfDocController,
                                                    onSavePressed: () {},
                                                    child: CICCDropdown(
                                                      initialValue:
                                                          'Vendor Contract',
                                                      items: [
                                                        DropdownMenuItem(
                                                            value:
                                                                'Vendor Contract',
                                                            child: Text(
                                                                'Vendor Contract')),
                                                        DropdownMenuItem(
                                                            value:
                                                                'HCO Number      254612',
                                                            child: Text(
                                                                'HCO Number  254612')),
                                                        DropdownMenuItem(
                                                            value:
                                                                'Medicare ID      MPID123',
                                                            child: Text(
                                                                'Medicare ID  MPID123')),
                                                        DropdownMenuItem(
                                                            value:
                                                                'NPI Number     1234567890',
                                                            child: Text(
                                                                'NPI Number 1234567890')),
                                                      ],
                                                    ),
                                                    child1: CICCDropdown(
                                                      initialValue: 'DME',
                                                      items: [
                                                        DropdownMenuItem(
                                                            value: 'DME',
                                                            child: Text('DME')),
                                                        DropdownMenuItem(
                                                            value:
                                                                'HCO Number      254612',
                                                            child: Text(
                                                                'HCO Number  254612')),
                                                        DropdownMenuItem(
                                                            value:
                                                                'Medicare ID      MPID123',
                                                            child: Text(
                                                                'Medicare ID  MPID123')),
                                                        DropdownMenuItem(
                                                            value:
                                                                'NPI Number     1234567890',
                                                            child: Text(
                                                                'NPI Number 1234567890')),
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          icon: Icon(
                                            Icons.edit_outlined,
                                            size:18,
                                            color: ColorManager.blueprime,
                                          )),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.delete_outline,
                                            size:18,
                                            color: ColorManager.red,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            )),
                      ),
                    ],
                  );
                }),
          ),
          SizedBox(
            height: 10,
          ),
          PaginationControlsWidget(
            currentPage: currentPage,
            items: items,
            itemsPerPage: itemsPerPage,
            onPreviousPagePressed: () {
              /// Handle previous page button press
              setState(() {
                currentPage = currentPage > 1 ? currentPage - 1 : 1;
              });
            },
            onPageNumberPressed: (pageNumber) {
              /// Handle page number tap
              setState(() {
                currentPage = pageNumber;
              });
            },
            onNextPagePressed: () {
              /// Handle next page button press
              setState(() {
                currentPage = currentPage < (items.length / itemsPerPage).ceil()
                    ? currentPage + 1
                    : (items.length / itemsPerPage).ceil();
              });
            },
          ),
        ],
      ),
    );
  }
}
