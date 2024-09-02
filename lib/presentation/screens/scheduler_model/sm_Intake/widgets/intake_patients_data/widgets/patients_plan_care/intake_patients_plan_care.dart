import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_plan_care/plane_container_box.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_plan_care/planer_notifier.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import '../../../../../../../../app/services/api/managers/establishment_manager/ci_visit_manager.dart';
import '../../../../../../../../data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import '../../../../../../../../data/api_data/establishment_data/company_identity/ci_visit_data.dart';
import '../patients_compliance/widget/compliance_add_popup.dart';
import 'package:provider/provider.dart';

// class IntakePlanCareScreen extends StatefulWidget {
//   final int patientId;
//
//   const IntakePlanCareScreen({super.key, required this.patientId});
//   @override
//   State<IntakePlanCareScreen> createState() => _IntakePlanCareScreenState();
// }
//
// class _IntakePlanCareScreenState extends State<IntakePlanCareScreen> {
//   List<String> containerData = [];
//   String? _selectedClinician;
//
//   List<Map<String, String>> weeks = [];
//
//   void addWeek() {
//     setState(() {
//       weeks.add({'week': 'Week ${weeks.length + 1}', 'visits': ''});
//     });
//   }
//   @override
//   void initState() {
//     super.initState();
//     _loadContainerData();
//     addWeek();
//   }
//   List<String> clinicians = [];
//   void addClinician(String name) {
//     setState(() {
//       clinicians.add(name);
//     });
//   }
//   Future<void> _loadContainerData() async {
//     List<String> data = await loadContainers();
//     setState(() {
//       containerData = data;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> containerWidgets =
//         Provider.of<ContainerProvider>(context).containers;
//
//     List<List<Widget>> chunkedContainers = [];
//     for (int i = 0; i < containerWidgets.length; i += 4) {
//       chunkedContainers.add(containerWidgets.sublist(i,
//           i + 4 > containerWidgets.length ? containerWidgets.length : i + 4));
//     }
//     return Scaffold(
//       backgroundColor: ColorManager.white,
//       body: Consumer<ContainerProvider>(
//         builder: (context, containerProvider, child) {
//           return SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 40.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         'Completed',
//                         style: GoogleFonts.firaSans(
//                           decoration: TextDecoration.none,
//                           fontSize: AppSize.s12,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xff008000),
//                         ),
//                       ),
//                       SizedBox(width: MediaQuery.of(context).size.width / 60),
//                   Container(
//                     height: 32,
//                     width: 128,
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             int deptId = AppConfig.clinicalId;
//                             return StatefulBuilder(
//                               builder:
//                                   (BuildContext context, void Function(void Function()) setState) {
//                                 return AddClinicianPopup(
//                                   title: 'Add Clinician',
//                                   child: FutureBuilder<List<HRAllData>>(
//                                     future: getAllHrDeptWise(context, deptId),
//                                     builder: (context, snapshot) {
//                                       if (snapshot.connectionState == ConnectionState.waiting) {
//                                         return CustomDropDown(
//                                           labelText: 'Select Clinician',
//                                           labelStyle: GoogleFonts.firaSans(
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black,
//                                           ),
//                                           items: ['Loading...'],
//                                         );
//                                       } else if (snapshot.hasError) {
//                                         return Text('Error: ${snapshot.error}');
//                                       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                                         return Text('No data available');
//                                       } else {
//                                         List<HRAllData> hrAllDataList = snapshot.data!;
//                                         List<String> abbreviations = hrAllDataList
//                                             .map((data) => data.abbrivation)
//                                             .where((abbr) => abbr != null)
//                                             .cast<String>()
//                                             .toSet()
//                                             .toList();
//                                         return CustomDropDown(
//                                           labelText: 'Select Clinician',
//                                           labelStyle: GoogleFonts.firaSans(
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black,
//                                           ),
//                                           items: abbreviations,
//                                           onChanged: (value) {
//                                             setState(() {
//                                               _selectedClinician = value;
//                                             });
//                                           },
//                                         );
//                                       }
//                                     },
//                                   ),
//                                   buttonTitle: 'Submit',
//                                   onPressed: () {
//                                     setState(() {
//                                       final containerProvider =
//                                       Provider.of<ContainerProvider>(context, listen: false);
//                                       containerProvider.addContainer(
//                                         Padding(
//                                           padding: const EdgeInsets.only(left: 20.0),
//                                           child: Row(
//                                             children: [
//                                               Container(
//                                                 height: 246,
//                                                 width: 295,
//                                                 padding: EdgeInsets.all(20),
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   borderRadius: BorderRadius.circular(10),
//                                                   boxShadow: [
//                                                     BoxShadow(
//                                                       color: Colors.grey.withOpacity(0.5),
//                                                       spreadRadius: 0,
//                                                       blurRadius: 10,
//                                                       offset: Offset(0, 5),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 child: Column(
//                                                   children: [
//                                                     Row(
//                                                       children: [
//                                                         Text(
//                                                           _selectedClinician ??
//                                                               'Select a Clinician',
//                                                           style: TextStyle(
//                                                             fontSize: 12,
//                                                             fontWeight: FontWeight.w600,
//                                                             color: Color(0xff686464),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     SizedBox(height: 20),
//                                                     Expanded(
//                                                       child: ListView.builder(
//                                                         itemCount: weeks.length,
//                                                         itemBuilder: (context, index) {
//                                                           final week = weeks[index];
//                                                           return Column(
//                                                             crossAxisAlignment:
//                                                             CrossAxisAlignment.start,
//                                                             children: [
//                                                               Row(
//                                                                 children: [
//                                                                   Text(
//                                                                     week['week']!,
//                                                                     style: TextStyle(
//                                                                       fontSize: 10,
//                                                                       fontWeight: FontWeight.w600,
//                                                                       color: Color(0xff686464),
//                                                                     ),
//                                                                   ),
//                                                                   SizedBox(width: 50),
//                                                                   Flexible(
//                                                                     child: PlanOfCareTextField(
//                                                                       labelText: 'Visits',
//                                                                       initialValue:
//                                                                       week['visits']!,
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                               SizedBox(height: 20),
//                                                             ],
//                                                           );
//                                                         },
//                                                       ),
//                                                     ),
//                                                     SizedBox(height: 20),
//                                                     Row(
//                                                       mainAxisAlignment: MainAxisAlignment.center,
//                                                       children: [
//                                                         Container(
//                                                           height: 32,
//                                                           width: 112,
//                                                           child: ElevatedButton.icon(
//                                                             onPressed: () {
//                                                               setState(() {
//                                                                 weeks.add({
//                                                                   'week': 'Week ${weeks.length + 1}',
//                                                                   'visits': '',
//                                                                 });
//                                                               });
//                                                             },
//                                                             icon: Icon(Icons.add,
//                                                                 color: Colors.white, size: 20),
//                                                             label: Text(
//                                                               'Add Week',
//                                                               style: GoogleFonts.firaSans(
//                                                                 color: Colors.white,
//                                                                 fontSize: 12,
//                                                                 fontWeight: FontWeight.w700,
//                                                               ),
//                                                             ),
//                                                             style: ElevatedButton.styleFrom(
//                                                               backgroundColor: Color(0xFF50B5E5),
//                                                               shape: RoundedRectangleBorder(
//                                                                 borderRadius:
//                                                                 BorderRadius.circular(12),
//                                                               ),
//                                                               padding: EdgeInsets.symmetric(
//                                                                   horizontal: 12, vertical: 8),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     SizedBox(width: 20),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     });
//                                     Navigator.pop(context);
//                                   },
//                                 );
//                               },
//                             );
//                           },
//                         );
//                       },
//                       icon: Icon(Icons.add, color: Colors.white, size: 20),
//                       label: Text(
//                         'Add Clinician',
//                         style: GoogleFonts.firaSans(
//                           color: Colors.white,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFF50B5E5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                       ),
//                     ),
//                   )
//
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 SingleChildScrollView(
//                   child: Column(
//                     children: chunkedContainers.map((row) {
//                       return Padding(
//                         padding:
//                             const EdgeInsets.only(left: 20.0, bottom: 20.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: row,
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
class IntakePlanCareScreen extends StatefulWidget {
  final int patientId;

  const IntakePlanCareScreen({super.key, required this.patientId});

  @override
  State<IntakePlanCareScreen> createState() => _IntakePlanCareScreenState();
}

class _IntakePlanCareScreenState extends State<IntakePlanCareScreen> {
  List<Map<String, dynamic>> containers = [];
  String? _selectedClinician;

  @override
  void initState() {
    super.initState();
    addInitialWeek();
  }

  void addInitialWeek() {
    setState(() {
      containers.add({
        'clinician': '',
        'weeks': [{'week': 'Week 1', 'visits': ''}],
      });
    });
  }

  void addWeek(int index) {
    setState(() {
      containers[index]['weeks'].add({
        'week': 'Week ${containers[index]['weeks'].length + 1}',
        'visits': '',
      });
    });
  }

  Future<void> _showAddClinicianDialog() async {
    final deptId = AppConfig.clinicalId;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AddClinicianPopup(
              title: 'Add Clinician',
              child: FutureBuilder<List<HRAllData>>(
                future: getAllHrDeptWise(context, deptId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CustomDropDown(
                      labelText: 'Select Clinician',
                      labelStyle: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      items: ['Loading...'],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No data available');
                  } else {
                    List<String> abbreviations = snapshot.data!
                        .map((data) => data.abbrivation)
                        .where((abbr) => abbr != null)
                        .cast<String>()
                        .toSet()
                        .toList();
                    return CustomDropDown(
                      labelText: 'Select Clinician',
                      labelStyle: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      items: abbreviations,
                      onChanged: (value) {
                        setState(() {
                          _selectedClinician = value;
                        });
                      },
                    );
                  }
                },
              ),
              buttonTitle: 'Submit',
              onPressed: () {
                if (_selectedClinician != null) {
                  setState(() {
                    containers.add({
                      'clinician': _selectedClinician!,
                      'weeks': [{'week': 'Week 1', 'visits': ''}],
                    });
                  });
                  Navigator.pop(context);
                }
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Consumer<ContainerProvider>(
        builder: (context, containerProvider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Completed',
                        style: GoogleFonts.firaSans(
                          decoration: TextDecoration.none,
                          fontSize: AppSize.s12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff008000),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 60),
                      Container(
                        height: 32,
                        width: 128,
                        child: ElevatedButton.icon(
                          onPressed: _showAddClinicianDialog,
                          icon: Icon(Icons.add, color: Colors.white, size: 20),
                          label: Text(
                            'Add Clinician',
                            style: GoogleFonts.firaSans(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF50B5E5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  children: containers.asMap().entries.map((entry) {
                    int index = entry.key;
                    var container = entry.value;
                    return Container(
                      width: 240,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: ContainerWidget(
                          clinician: container['clinician'],
                          weeks: container['weeks'],
                          onAddWeek: () => addWeek(index),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  final String? clinician;
  final List<Map<String, String>> weeks;
  final VoidCallback onAddWeek;

  const ContainerWidget({
    Key? key,
    required this.clinician,
    required this.weeks,
    required this.onAddWeek,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 246,
      width: 295,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                clinician ?? 'Select a Clinician',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff686464),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: weeks.length,
              itemBuilder: (context, index) {
                final week = weeks[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          week['week']!,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff686464),
                          ),
                        ),
                        SizedBox(width: 50),
                        Flexible(
                          child: PlanOfCareTextField(
                            labelText: 'Visits',
                            initialValue: week['visits']!,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 32,
                width: 112,
                child: ElevatedButton.icon(
                  onPressed: onAddWeek,
                  icon: Icon(Icons.add, color: Colors.white, size: 20),
                  label: Text(
                    'Add Week',
                    style: GoogleFonts.firaSans(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF50B5E5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class Week {
  final String weekNumber;
  String initialValue;

  Week({
    required this.weekNumber,
    required this.initialValue,
  });
}

class PlanOfCareTextField extends StatelessWidget {
  final String labelText;
  final String initialValue;

  PlanOfCareTextField({
    super.key,
    required    this.labelText,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.38,
      width: 118,
      child: TextFormField(
        initialValue: initialValue,
        style: GoogleFonts.firaSans(
          fontSize: AppSize.s12,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.firaSans(
            fontSize: AppSize.s10,
            color: ColorManager.greylight,
          ),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0XFFB1B1B1)), //  border color
          ),
        ),
      ),
    );
  }
}
///// visit API eligible clinician
//                   Container(
//                     height: 32,
//                     width: 128,
//                     child: ElevatedButton.icon(
//                       onPressed: () async {
//                         // Define page number and number of rows as needed
//                         int pageNo = 1; // You can change this dynamically
//                         int noOfRows = 10; // You can change this dynamically
//
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return StatefulBuilder(
//                               builder: (BuildContext context,
//                                   void Function(void Function()) setState) {
//                                 return FutureBuilder<List<CiVisit>>(
//                                   future: getVisit(context, pageNo, noOfRows),
//                                   builder: (context, snapshot) {
//                                     if (snapshot.connectionState ==
//                                         ConnectionState.waiting) {
//                                       return Material(
//                                         child: CustomDropDown(
//                                           labelText: 'Select Clinician',
//                                           labelStyle: GoogleFonts.firaSans(
//                                             fontSize: FontSize.s12,
//                                             fontWeight: FontWeightManager.bold,
//                                             color: ColorManager.textPrimaryColor,
//                                           ),
//                                           items: ['PT', 'OT'],
//                                         ),
//                                       );
//                                     } else if (snapshot.hasError) {
//                                       return Text('Error: ${snapshot.error}');
//                                     } else if (!snapshot.hasData ||
//                                         snapshot.data!.isEmpty) {
//                                       return Text('No data available');
//                                     } else {
//                                       List<CiVisit> visits = snapshot.data!;
//                                       List<String> eligibleClinicians = [];
//
//                                       // Extract eligible clinicians
//                                       for (var visit in visits) {
//                                         for (var clinician
//                                             in visit.eligibleClinician ?? []) {
//                                           eligibleClinicians
//                                               .add(clinician.eligibleClinician);
//                                         }
//                                       }
//
//                                       return AddClinicianPopup(
//                                         title: 'Add Clinician',
//                                         onPressed: () {},
//                                         child: CustomDropDown(
//                                           labelText:
//                                               'Select Eligible Clinician',
//                                           labelStyle: GoogleFonts.firaSans(
//                                             fontSize: FontSize.s12,
//                                             fontWeight: FontWeightManager.bold,
//                                             color:
//                                                 ColorManager.textPrimaryColor,
//                                           ),
//                                           items: eligibleClinicians,
//                                         ),
//                                       );
//                                     }
//                                   },
//                                 );
//                               },
//                             );
//                           },
//                         );
//                       },
//                       icon: Icon(Icons.add,
//                           color: Colors.white, size: AppSize.s20),
//                       label: Text(
//                         'Add Clinician',
//                         style: GoogleFonts.firaSans(
//                           color: Colors.white,
//                           fontSize: AppSize.s12,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFF50B5E5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                       ),
//                     ),
//                   )
// Container(
//                     height: 246,
//                     width: 295,
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 0,
//                           blurRadius: 10,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               'OT',
//                               style: TextStyle(
//                                   fontSize: AppSize.s12,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xff686464)),
//                             )
//                           ],
//                         ),
//                         SizedBox(height: 20),
//                         Row(
//                           children: [
//                             Text(
//                               'Week 1',
//                               style: TextStyle(
//                                   fontSize: AppSize.s10,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xff686464)),
//                             ),
//                             SizedBox(width: 50),
//                             Flexible(
//                                 child: PlanOfCareTextField(
//                               labelText: 'Visits',
//                               initialValue: '2',
//                             )),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 80,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               height: 32,
//                               width: 112,
//                               child: ElevatedButton.icon(
//                                 onPressed: () {},
//                                 icon: Icon(Icons.add,
//                                     color: Colors.white, size: AppSize.s20),
//                                 label: Text(
//                                   'Add Week',
//                                   style: GoogleFonts.firaSans(
//                                     color: Colors.white,
//                                     fontSize: AppSize.s12,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Color(0xFF50B5E5),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 8),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
///
///    // Padding(
//             //   padding: const EdgeInsets.only(left: 20.0),
//             //   child: Row(
//             //     children: [
//             //       containers,
//             //       ///create container dynamically
//             //       // Container(
//             //       //   height: 246,
//             //       //   width: 295,
//             //       //   padding: EdgeInsets.all(20),
//             //       //   decoration: BoxDecoration(
//             //       //     color: Colors.white,
//             //       //     borderRadius: BorderRadius.circular(10),
//             //       //     boxShadow: [
//             //       //       BoxShadow(
//             //       //         color: Colors.grey.withOpacity(0.5),
//             //       //         spreadRadius: 0,
//             //       //         blurRadius: 10,
//             //       //         offset: Offset(0, 5),
//             //       //       ),
//             //       //     ],
//             //       //   ),
//             //       //   child: Column(
//             //       //     children: [
//             //       //       Row(
//             //       //         children: [
//             //       //           Text(
//             //       //             'PT',
//             //       //             style: TextStyle(
//             //       //                 fontSize: AppSize.s12,
//             //       //                 fontWeight: FontWeight.w600,
//             //       //                 color: Color(0xff686464)),
//             //       //           )
//             //       //         ],
//             //       //       ),
//             //       //       SizedBox(
//             //       //         height: 20,
//             //       //       ),
//             //       //       Row(
//             //       //         children: [
//             //       //           Text(
//             //       //             'Week 1',
//             //       //             style: TextStyle(
//             //       //                 fontSize: AppSize.s10,
//             //       //                 fontWeight: FontWeight.w600,
//             //       //                 color: Color(0xff686464)),
//             //       //           ),
//             //       //           SizedBox(width: 50),
//             //       //           Flexible(
//             //       //               child: PlanOfCareTextField(
//             //       //             labelText: 'Visits',
//             //       //             initialValue: '2',
//             //       //           )),
//             //       //         ],
//             //       //       ),
//             //       //       SizedBox(height: 20),
//             //       //       Row(
//             //       //         children: [
//             //       //           Text(
//             //       //             'Week 2',
//             //       //             style: TextStyle(
//             //       //                 fontSize: AppSize.s10,
//             //       //                 fontWeight: FontWeight.w600,
//             //       //                 color: Color(0xff686464)),
//             //       //           ),
//             //       //           SizedBox(width: 50),
//             //       //           Flexible(
//             //       //               child: PlanOfCareTextField(
//             //       //             labelText: 'Visits',
//             //       //             initialValue: '3',
//             //       //           )),
//             //       //         ],
//             //       //       ),
//             //       //       SizedBox(
//             //       //         height: 40,
//             //       //       ),
//             //       //       Row(
//             //       //         mainAxisAlignment: MainAxisAlignment.center,
//             //       //         children: [
//             //       //           Container(
//             //       //             height: 32,
//             //       //             width: 112,
//             //       //             child: ElevatedButton.icon(
//             //       //               onPressed: () {},
//             //       //               icon: Icon(Icons.add,
//             //       //                   color: Colors.white, size: AppSize.s20),
//             //       //               label: Text(
//             //       //                 'Add Week',
//             //       //                 style: GoogleFonts.firaSans(
//             //       //                   color: Colors.white,
//             //       //                   fontSize: AppSize.s12,
//             //       //                   fontWeight: FontWeight.w700,
//             //       //                 ),
//             //       //               ),
//             //       //               style: ElevatedButton.styleFrom(
//             //       //                 backgroundColor: Color(0xFF50B5E5),
//             //       //                 shape: RoundedRectangleBorder(
//             //       //                   borderRadius: BorderRadius.circular(12),
//             //       //                 ),
//             //       //                 padding: EdgeInsets.symmetric(
//             //       //                     horizontal: 12, vertical: 8),
//             //       //               ),
//             //       //             ),
//             //       //           ),
//             //       //         ],
//             //       //       )
//             //       //     ],
//             //       //   ),
//             //       // ),
//             //       SizedBox(
//             //         width: 20,
//             //       ),
//             //
//             //     ],
//             //   ),
//             // )
///old code
// class IntakePlanCareScreen extends StatefulWidget {
//   const IntakePlanCareScreen({super.key});
//
//   @override
//   State<IntakePlanCareScreen> createState() => _IntakePlanCareScreenState();
// }
//
// class _IntakePlanCareScreenState extends State<IntakePlanCareScreen> {
//   List<Widget> containers = [];
//   void _addContainer() {
//     setState(() {
//       containers.add(
//         Padding(
//           padding: const EdgeInsets.only(left: 20.0),
//           child: Row(
//             children: [
//               Container(
//                 height: 246,
//                 width: 295,
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 0,
//                       blurRadius: 10,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           'PT',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xff686464)),
//                         )
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Text(
//                           'Week 1',
//                           style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xff686464)),
//                         ),
//                         SizedBox(width: 50),
//                         Flexible(
//                             child: PlanOfCareTextField(
//                               labelText: 'Visits',
//                               initialValue: '2',
//                             )),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Text(
//                           'Week 2',
//                           style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xff686464)),
//                         ),
//                         SizedBox(width: 50),
//                         Flexible(
//                             child: PlanOfCareTextField(
//                               labelText: 'Visits',
//                               initialValue: '3',
//                             )),
//                       ],
//                     ),
//                     SizedBox(height: 40),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 32,
//                           width: 112,
//                           child: ElevatedButton.icon(
//                             onPressed: () {},
//                             icon: Icon(Icons.add, color: Colors.white, size: 20),
//                             label: Text(
//                               'Add Week',
//                               style: GoogleFonts.firaSans(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xFF50B5E5),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(width: 20),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorManager.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.only(right: 40.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(
//                     'Completed',
//                     style: GoogleFonts.firaSans(
//                         decoration: TextDecoration.none,
//                         fontSize: AppSize.s12,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xff008000)),
//                   ),
//                   SizedBox(width: MediaQuery.of(context).size.width / 60),
//                   ///popup submit
//                   Container(
//                     height: 32,
//                     width: 128,
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             int deptId = AppConfig.clinicalId;
//                             return StatefulBuilder(
//                               builder: (BuildContext context, void Function(void Function()) setState) {
//                                 return AddClinicianPopup(
//                                   title: 'Add Clinician',
//                                   child: FutureBuilder<List<HRAllData>>(
//                                     future: getAllHrDeptWise(context, deptId),
//                                     builder: (context, snapshot) {
//                                       if (snapshot.connectionState == ConnectionState.waiting) {
//                                         return CustomDropDown(
//                                           labelText: 'Select Clinician',
//                                           labelStyle: GoogleFonts.firaSans(
//                                             fontSize: FontSize.s12,
//                                             fontWeight: FontWeightManager.bold,
//                                             color: ColorManager.textPrimaryColor,
//                                           ),
//                                           items: ['Loading...'], // Placeholder text for loading state
//                                         );
//                                       } else if (snapshot.hasError) {
//                                         return Text('Error: ${snapshot.error}');
//                                       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                                         return Text('No data available');
//                                       } else {
//                                         List<HRAllData> hrAllDataList = snapshot.data!;
//                                         List<String> abbreviations = hrAllDataList
//                                             .map((data) => data.abbrivation)
//                                             .where((abbr) => abbr != null)
//                                             .cast<String>()
//                                             .toList();
//                                         return CustomDropDown(
//                                           labelText: 'Select Clinician',
//                                           labelStyle: GoogleFonts.firaSans(
//                                             fontSize: FontSize.s12,
//                                             fontWeight: FontWeightManager.bold,
//                                             color: ColorManager.textPrimaryColor,
//                                           ),
//                                           items: abbreviations,
//                                         );
//                                       }
//                                     },
//                                   ),
//                                     buttonTitle: 'Submit',
//                                     onPressed: () {
//                                       _addContainer();
//                                       Navigator.pop(context);
//                                       // widget.onPressed();
//                                     },
//                                 );
//                               },
//                             );
//                           },
//                         );
//                       },
//                       icon: Icon(Icons.add, color: Colors.white, size: AppSize.s20),
//                       label: Text(
//                         'Add Clinician',
//                         style: GoogleFonts.firaSans(
//                           color: Colors.white,
//                           fontSize: AppSize.s12,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFF50B5E5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                       ),
//                         ),
//                       ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0),
//               child: Wrap(
//                 spacing: 20.0, // Horizontal spacing between containers
//                 runSpacing: 20.0, // Vertical spacing between rows
//                 children: containers,
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
///add clinician button old
//     Container(
//       height: 32,
//       width: 128,
//       child: ElevatedButton.icon(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               int deptId = AppConfig.clinicalId;
//               return StatefulBuilder(
//                 builder: (BuildContext context,
//                     void Function(void Function()) setState) {
//                   return AddClinicianPopup(
//                     title: 'Add Clinician',
//                     child: FutureBuilder<List<HRAllData>>(
//                       future:
//                           getAllHrDeptWise(context, deptId),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return CustomDropDown(
//                             labelText: 'Select Clinician',
//                             labelStyle: GoogleFonts.firaSans(
//                               fontSize: FontSize.s12,
//                               fontWeight:
//                                   FontWeightManager.bold,
//                               color: ColorManager
//                                   .textPrimaryColor,
//                             ),
//                             items: ['Loading...'],
//                           );
//                         } else if (snapshot.hasError) {
//                           return Text(
//                               'Error: ${snapshot.error}');
//                         } else if (!snapshot.hasData ||
//                             snapshot.data!.isEmpty) {
//                           return Text('No data available');
//                         } else {
//                           List<HRAllData> hrAllDataList =
//                               snapshot.data!;
//                           List<String> abbreviations =
//                               hrAllDataList
//                                   .map((data) =>
//                                       data.abbrivation)
//                                   .where(
//                                       (abbr) => abbr != null)
//                                   .cast<String>()
//                                   .toSet()
//                                   .toList();
//                           if (_selectedClinician != null &&
//                               !abbreviations.contains(
//                                   _selectedClinician)) {
//                             _selectedClinician =
//                                 null;
//                           }
//                           return CustomDropDown(
//                             labelText: 'Select Clinician',
//                             labelStyle: GoogleFonts.firaSans(
//                               fontSize: FontSize.s12,
//                               fontWeight:
//                                   FontWeightManager.bold,
//                               color: ColorManager
//                                   .textPrimaryColor,
//                             ),
//                             items: abbreviations,
//                             value: _selectedClinician,
//                             onChanged: (value) {
//                               setState(() {
//                                 _selectedClinician = value;
//                               });
//                             },
//                           );
//                         }
//                       },
//                     ),
//
//                     // FutureBuilder<List<HRAllData>>(
//                     //   future:
//                     //       getAllHrDeptWise(context, deptId),
//                     //   builder: (context, snapshot) {
//                     //     if (snapshot.connectionState ==
//                     //         ConnectionState.waiting) {
//                     //       return CustomDropDown(
//                     //         labelText: 'Select Clinician',
//                     //         labelStyle: GoogleFonts.firaSans(
//                     //           fontSize: FontSize.s12,
//                     //           fontWeight:
//                     //               FontWeightManager.bold,
//                     //           color: ColorManager
//                     //               .textPrimaryColor,
//                     //         ),
//                     //         items: [
//                     //           'Loading...'
//                     //         ], // Placeholder text for loading state
//                     //       );
//                     //     } else if (snapshot.hasError) {
//                     //       return Text(
//                     //           'Error: ${snapshot.error}');
//                     //     } else if (!snapshot.hasData ||
//                     //         snapshot.data!.isEmpty) {
//                     //       return Text('No data available');
//                     //     } else {
//                     //       List<HRAllData> hrAllDataList =
//                     //           snapshot.data!;
//                     //       List<String> abbreviations =
//                     //           hrAllDataList
//                     //               .map((data) =>
//                     //                   data.abbrivation)
//                     //               .where(
//                     //                   (abbr) => abbr != null)
//                     //               .cast<String>()
//                     //               .toList();
//                     //       return CustomDropDown(
//                     //         labelText: 'Select Clinician',
//                     //         labelStyle: GoogleFonts.firaSans(
//                     //           fontSize: FontSize.s12,
//                     //           fontWeight:
//                     //               FontWeightManager.bold,
//                     //           color: ColorManager
//                     //               .textPrimaryColor,
//                     //         ),
//                     //         items: abbreviations,
//                     //         onChanged: (value) {
//                     //           setState(() {
//                     //             _selectedClinician = value;
//                     //           });
//                     //         },
//                     //       );
//                     //     }
//                     //   },
//                     // ),
//                     buttonTitle: 'Submit',
//                     onPressed: () {
//                       final containerProvider =
//                           Provider.of<ContainerProvider>(
//                               context,
//                               listen: false);
//                       containerProvider.addContainer(Padding(
//                           padding: const EdgeInsets.only(
//                               left: 20.0),
//                           child: Row(children: [
//                             Container(
//                               height: 246,
//                               width: 295,
//                               padding: EdgeInsets.all(20),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius:
//                                     BorderRadius.circular(10),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey
//                                         .withOpacity(0.5),
//                                     spreadRadius: 0,
//                                     blurRadius: 10,
//                                     offset: Offset(0, 5),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(
//                                         _selectedClinician ??
//                                             'Select a Clinician',
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight:
//                                               FontWeight.w600,
//                                           color: Color(
//                                               0xff686464),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 20),
//                                   Expanded(
//                                     child: ListView.builder(
//                                       itemCount: weeks.length,
//                                       itemBuilder:
//                                           (context, index) {
//                                         final week =
//                                             weeks[index];
//                                         return Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment
//                                                   .start,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   week[
//                                                       'week']!,
//                                                   style:
//                                                       TextStyle(
//                                                     fontSize:
//                                                         10,
//                                                     fontWeight:
//                                                         FontWeight
//                                                             .w600,
//                                                     color: Color(
//                                                         0xff686464),
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                     width:
//                                                         50),
//                                                 Flexible(
//                                                   child:
//                                                       PlanOfCareTextField(
//                                                     labelText:
//                                                         'Visits',
//                                                     initialValue:
//                                                         week[
//                                                             'visits']!,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(
//                                                 height: 20),
//                                           ],
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                   SizedBox(height: 20),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment
//                                             .center,
//                                     children: [
//                                       Container(
//                                         height: 32,
//                                         width: 112,
//                                         child: ElevatedButton
//                                             .icon(
//                                           onPressed: addWeek,
//                                           icon: Icon(
//                                               Icons.add,
//                                               color: Colors
//                                                   .white,
//                                               size: 20),
//                                           label: Text(
//                                             'Add Week',
//                                             style: GoogleFonts
//                                                 .firaSans(
//                                               color: Colors
//                                                   .white,
//                                               fontSize: 12,
//                                               fontWeight:
//                                                   FontWeight
//                                                       .w700,
//                                             ),
//                                           ),
//                                           style:
//                                               ElevatedButton
//                                                   .styleFrom(
//                                             backgroundColor:
//                                                 Color(
//                                                     0xFF50B5E5),
//                                             shape:
//                                                 RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius
//                                                       .circular(
//                                                           12),
//                                             ),
//                                             padding: EdgeInsets
//                                                 .symmetric(
//                                                     horizontal:
//                                                         12,
//                                                     vertical:
//                                                         8),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(width: 20),
//                                 ],
//                               ),
//                             ),
//                           ])));
//                       Navigator.pop(context);
//                     },
//                   );
//                 },
//               );
//             },
//           );
//         },
//         icon: Icon(Icons.add,
//             color: Colors.white, size: AppSize.s20),
//         label: Text(
//           'Add Clinician',
//           style: GoogleFonts.firaSans(
//             color: Colors.white,
//             fontSize: AppSize.s12,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Color(0xFF50B5E5),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           padding: EdgeInsets.symmetric(
//               horizontal: 12, vertical: 8),
//         ),
//       ),
//     ),