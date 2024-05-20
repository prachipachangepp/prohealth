import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';

import '../hr_screens/hr_administrative.dart';
import '../hr_screens/hr_clinical.dart';
import '../hr_screens/hr_sales.dart';

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
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                //  height: MediaQuery.of(context).size.height / 22,
                height: 30,
                width: MediaQuery.of(context).size.width / 2.99,
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
                            width: MediaQuery.of(context).size.width / 9,
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

///main
// class HrScreen extends StatelessWidget {
//   final PageController _hrPageController = PageController();
//   final List<String> _categories = ['Clinical', 'Sales', 'Administration'];
//   int _selectedIndex = 0;
//
//   void _selectButton(BuildContext context, int index) {
//     _selectedIndex = index;
//     _hrPageController.animateToPage(
//       index,
//       duration: Duration(milliseconds: 500),
//       curve: Curves.ease,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: MediaQuery.of(context).size.height / 20,
//               width: MediaQuery.of(context).size.width / 3,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Colors.blue,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: _categories
//                     .asMap()
//                     .entries
//                     .map(
//                       (entry) => InkWell(
//                         child: Container(
//                           height: 30,
//                           width: 80,
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: _selectedIndex == entry.key
//                                 ? Colors.white
//                                 : null,
//                           ),
//                           child: Text(
//                             entry.value,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(fontSize: 8),
//                           ),
//                         ),
//                         onTap: () => _selectButton(context, entry.key),
//                       ),
//                     )
//                     .toList(),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 10,
//             child: PageView(
//               controller: _hrPageController,
//               physics: NeverScrollableScrollPhysics(),
//               children: [
//                 Container(color: Colors.red),
//                 Container(color: Colors.yellow),
//                 Container(color: Colors.brown),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

///
//
// class HrScreen extends StatelessWidget {
//   HrScreen({this.isSelected});
//   final bool? isSelected;
//   final PageController _hrPageController = PageController();
//   final ButtonSelectionController hrController =
//       Get.put(ButtonSelectionController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Container(
//         color: Colors.teal,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 height: MediaQuery.of(context).size.height / 20,
//                 width: MediaQuery.of(context).size.width / 3,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.blue),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     InkWell(
//                       child: Container(
//                         height: 30,
//                         width: 80,
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: Colors.white),
//                         child: Text(
//                           "Clinical",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 8),
//                         ),
//                       ),
//                       onTap: () {
//                         // hrController.selectButton(0);
//                         // _hrPageController.animateToPage(0,
//                         //     duration: Duration(milliseconds: 500),
//                         //     curve: Curves.ease);
//                       },
//                       // isSelected: hrController.selectedIndex.value == 0,
//                     ),
//                     InkWell(
//                       child: Container(
//                         height: 30,
//                         width: 80,
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           "Sales",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 8),
//                         ),
//                       ),
//                       onTap: () {
//                         // hrController.selectButton(1);
//                         // _hrPageController.animateToPage(1,
//                         //     duration: Duration(milliseconds: 500),
//                         //     curve: Curves.ease);
//                       },
//                     ),
//                     InkWell(
//                       child: Container(
//                         height: 30,
//                         width: 80,
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           "Administration",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 8),
//                         ),
//                       ),
//                       onTap: () {
//                         // hrController.selectButton(2);
//                         // _hrPageController.animateToPage(2,
//                         //     duration: Duration(milliseconds: 500),
//                         //     curve: Curves.ease);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 10,
//               child: PageView(
//                 controller: _hrPageController,
//                 physics: NeverScrollableScrollPhysics(),
//                 children: [
//                   Container(color: Colors.red),
//                   Container(
//                     color: Colors.yellow,
//                   ),
//                   Container(color: Colors.brown),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
