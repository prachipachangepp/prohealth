import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import 'all_hr_screens/hr_administrative.dart';
import 'all_hr_screens/hr_clinical.dart';
import 'all_hr_screens/hr_sales.dart';


class HrScreen extends StatefulWidget {
  @override
  _HrScreenState createState() => _HrScreenState();
}

class _HrScreenState extends State<HrScreen> {
  final PageController _hrPageController = PageController();
  int _selectedIndex = 0;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _hrPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return HrWidget(
      hrPageController: _hrPageController,
      selectedIndex: _selectedIndex,
      selectButton: _selectButton,
    );
  }
}

class HrWidget extends StatelessWidget {
  final PageController hrPageController;
  final int selectedIndex;
  final Function(int) selectButton;

  HrWidget({
    required this.hrPageController,
    required this.selectedIndex,
    required this.selectButton,
  });

  final List<String> _categories = ['Clinical', 'Sales', 'Administration'];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p24),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                //  height: MediaQuery.of(context).size.height / 22,
                height: AppSize.s30,
                width: MediaQuery.of(context).size.width / 2.99,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorManager.blueprime,
                  boxShadow: [
                    BoxShadow(
                    color: ColorManager.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
              ],
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
                            width: MediaQuery.of(context).size.width / 9,
                            padding: EdgeInsets.all(5),
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
                                fontSize: 12,
                                fontWeight: selectedIndex == entry.key
                                ? FontWeightManager.bold
                                :FontWeightManager.semiBold,
                                color: selectedIndex == entry.key
                                    ? ColorManager.black
                                    : ColorManager.white,
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
          ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 60),
              child: PageView(
                controller: hrPageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  HrClinicalScreen(),
                  HrSalesScreen(),
                  HrAdministrativeScreen(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
