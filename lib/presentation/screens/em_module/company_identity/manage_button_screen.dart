import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_details.dart';

import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
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

class ManageWidget extends StatelessWidget {
  final PageController managePageController;
  final int selectedIndex;
  final Function(int) selectButton;

  ManageWidget({
    Key? key,
    required this.managePageController,
    required this.selectedIndex,
    required this.selectButton,
  }) : super(key: key);

  final List<String> _categories = [
    'Detail',
    'Zone',
    'Corporate & Compliance document',
    'Insurance',
    'Vendor Contract',
    'Policies & Procedure',
    'Templates'
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p150,vertical: AppPadding.p16),
            child: Expanded(
              flex: 1,
              child: Row(
                children: [
                  Text('ProHealth San Jose',
                    style: CompanyIdentityManageHeadings.customTextStyle(context),),
                ],
              ),
            ),
          ),
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 28,
              width: MediaQuery.of(context).size.width / 1.24,
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
                      width: MediaQuery.of(context).size.width / 8.7,
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: selectedIndex == entry.key
                            ? Colors.white
                            : null,
                      ),
                      child: Text(
                        entry.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: FontSize.s10,
                          fontWeight: FontWeightManager.semiBold,
                          color: selectedIndex == entry.key
                              ? Color(0xff686464)
                              : Colors.white,
                        ),
                      ),
                    ),
                    onTap: () => selectButton(entry.key),
                  ),
                )
                    .toList(),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 11,vertical: AppPadding.p8),
              child: PageView(
                controller: managePageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  CIDetailsScreen(),
                  Container(color: Colors.green,),
                  Container(color: Colors.yellow,),
                  Container(color: Colors.green,),
                  Container(color: Colors.yellow,),
                  Container(color: Colors.green,),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}


