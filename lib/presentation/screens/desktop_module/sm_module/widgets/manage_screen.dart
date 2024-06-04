import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:flutter/material.dart';

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
                          color: selectedIndex == entry.key
                              ? Colors.white
                              : null,
                        ),
                        child: Text(
                          entry.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: selectedIndex == entry.key
                                ? Colors.black
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
          ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 60),
              child: PageView(
                controller: managePageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(color: Colors.yellow,),
                  Container(color: Colors.green,),
                  Container(color: Colors.yellow,),
                  Container(color: Colors.green,),
                  Container(color: Colors.yellow,),
                  Container(color: Colors.green,),
                ]
                // List.generate(
                //   _categories.length,
                //       (index) => Container(
                //     color: index % 2 == 0 ? Colors.green : Colors.yellow,
                //   ),
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


