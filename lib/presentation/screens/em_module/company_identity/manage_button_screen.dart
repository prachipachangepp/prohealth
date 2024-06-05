import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/ci_insurance_vendor.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/dme.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/leasas_services.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/md.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/misc.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/snf.dart';

import 'widgets/ci_insurance/ci_insurance_contract.dart';
import 'widgets/ci_insurance/ci_insurance_pageview.dart';
import 'widgets/policies_procedures/policies_procedures.dart';

class ManagePopUpScreen extends StatefulWidget {
  const ManagePopUpScreen({Key? key}) : super(key: key);

  @override
  State<ManagePopUpScreen> createState() => _ManagePopUpScreenState();
}

class _ManagePopUpScreenState extends State<ManagePopUpScreen> {
  final PageController _managePageController = PageController();
  int _selectedIndex = 0;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _managePageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ManageWidget(
      managePageController: _managePageController,
      selectedIndex: _selectedIndex,
      selectButton: _selectButton,
    );
  }
}

class ManageWidget extends StatefulWidget {
  final PageController managePageController;
  final int selectedIndex;
  final Function(int) selectButton;

  ManageWidget({
    Key? key,
    required this.managePageController,
    required this.selectedIndex,
    required this.selectButton,
  }) : super(key: key);

  @override
  State<ManageWidget> createState() => _ManageWidgetState();
}

class _ManageWidgetState extends State<ManageWidget> {
  final List<String> _categories = [
    'Detail',
    'Zone',
    'Corporate & Compliance document',
    'Insurance',
    'Vendor Contract',
    'Policies & Procedure',
    'Templates'
  ];

  final PageController _managePageController = PageController();

  int _selectedIndex = 0;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _managePageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 28,
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff50B5E5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _categories
                      .asMap()
                      .entries
                      .map(
                        (entry) => InkWell(
                          child: Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width / 10,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: widget.selectedIndex == entry.key
                                  ? Colors.white
                                  : null,
                            ),
                            child: Text(
                              entry.value,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: widget.selectedIndex == entry.key
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                          onTap: () => widget.selectButton(entry.key),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 60),
              child: PageView(
                  controller: widget.managePageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      color: Colors.yellow,
                    ),
                    Container(
                      color: Colors.green,
                    ),
                    Container(
                      color: Colors.yellow,
                    ),
                    CiPageview(
                      managePageController: _managePageController,
                      selectedIndex: _selectedIndex,
                      selectButton: _selectButton,
                      mediaQueryWidth: 3,
                      nameList: ['Vendor', 'Contract'],
                      screenList: [CiInsuranceVendor(), CiInsuranceContract()],
                    ),
                    CiPageview(
                      managePageController: _managePageController,
                      selectedIndex: _selectedIndex,
                      selectButton: _selectButton,
                      mediaQueryWidth: 2,
                      nameList: ['Leases & Services', 'SNF','DME','MD','MISC'],
                      screenList: [CiLeasesAndServices(),CiSnf(),CiDme(),CiMd(),CiMisc()],
                    ),
                    CiPoliciesAndProcedures(),
                    Container(
                      color: Colors.green,
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
