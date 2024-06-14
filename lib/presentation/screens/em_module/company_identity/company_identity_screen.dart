import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/ci_role_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/ci_visit.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/company_identity.dart';

import '../../../../../../app/services/api_sm/company_identity/add_doc_company_manager.dart';

class CompanyIdentityScreen extends StatefulWidget {
  final VoidCallback? onWhitelabellingPressed;
  const CompanyIdentityScreen({super.key, this.onWhitelabellingPressed});
  @override
  State<CompanyIdentityScreen> createState() => _CompanyIdentityScreenState();
}

class _CompanyIdentityScreenState extends State<CompanyIdentityScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobNumController = TextEditingController();
  TextEditingController secNumController = TextEditingController();
  TextEditingController OptionalController = TextEditingController();
  late CompanyIdentityManager _companyManager;
  final PageController _tabPageController = PageController();
  // late int currentPage;
  // late int itemsPerPage;
  late List<String> items;


  int _selectedIndex = 0;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _tabPageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
  @override
  void initState() {
    super.initState();
    // currentPage = 1;
    // itemsPerPage = 5;
    // items = List.generate(20, (index) => 'Item ${index + 1}');
   // getOrgDocfetch(context, _selectedIndex,1,1,1,15);
    _companyManager = CompanyIdentityManager();
    // companyAllApi(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          /// visit , org , Document tab bar
          Container(
            height: 30,
            width: 500,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // FutureBuilder<List<IdentityData>>(
                //   future:getOrgDocfetch(context, companyId, docTypeID, docSubTypeID, pageNo, rowsNO),
                //   builder: (context,snapshot) {
                     InkWell(
                      onTap: () => _selectButton(0),
                      child: Column(
                        children: [
                          Text(
                            "Company Identity",
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _selectedIndex == 0
                                  ? ColorManager.blueprime
                                  : const Color(0xff686464),
                              // color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          Container(
                            height: 2,
                            width: 120,
                            color: _selectedIndex == 0
                                ? ColorManager.blueprime
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                //   }
                // ),
                InkWell(
                  onTap: () => _selectButton(1),
                  child: Column(
                    children: [
                      Text(
                        "Visits",
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _selectedIndex == 1
                              ? ColorManager.blueprime
                              : const Color(0xff686464),
                          // color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      Container(
                        height: 2,
                        width: 40,
                        color: _selectedIndex == 1
                            ? ColorManager.blueprime
                            : Colors.transparent,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => _selectButton(2),
                  child: Column(
                    children: [
                      Text(
                        "Org Documents",
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _selectedIndex == 2
                              ? ColorManager.blueprime
                              : const Color(0xff686464),
                        ),
                      ),
                      Container(
                        height: 2,
                        width: 100,
                        color: _selectedIndex == 2
                            ? ColorManager.blueprime
                            : Colors.transparent,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => _selectButton(3),
                  child: Column(
                    children: [
                      Text(
                        "Role Manager",
                        style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: _selectedIndex == 3
                                ? ColorManager.blueprime
                                : const Color(0xff686464)),
                      ),
                      Container(
                        height: 2,
                        width: 90,
                        color: _selectedIndex == 3
                            ? ColorManager.blueprime
                            : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: NonScrollablePageView(
              controller: _tabPageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                  documentTypeGet(context);
                });
              },
              children: const [
                CompanyIdentity(),
                // Page 1
                CiVisitScreen(),
                // Page 2
                CiOrgDocument(),
                // Page 3
                CiRoleManager()
              ],
            ),
          ),

          ///Company Identity screen data code
          ///API integarted code do not delete
        ]));
  }
}

///

class NonScrollablePageView extends StatelessWidget {
  final PageController controller;
  final ValueChanged<int> onPageChanged;
  final List<Widget> children;
  const NonScrollablePageView({
    Key? key,
    required this.controller,
    required this.onPageChanged,
    required this.children,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) => true,
      child: PageView(
        controller: controller,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(), // Disables scrolling
        children: children,
      ),
    );
  }
}
