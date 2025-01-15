import 'package:flutter/material.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/health.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/emp_doc_popup_const.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:provider/provider.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';

class ManageEmployDocumentProvider with ChangeNotifier {
  final PageController _managePageController = PageController();
  int _selectedIndex = 1;

  PageController get managePageController => _managePageController;

  int get selectedIndex => _selectedIndex;

  void selectButton(int index) {
    _selectedIndex = index;
    _managePageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _managePageController.dispose();
    super.dispose();
  }
}

class ManageEmployDocument extends StatelessWidget {
  const ManageEmployDocument({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ManageEmployDocumentProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => ManageEmpDocProvider(),
      child: ManageEmpDocWidget(
        managePageController: provider.managePageController,
       // selectedIndex: provider.selectedIndex,
        selectButton: provider.selectButton,
      ),
    );
  }
}

///tabbar
class ManageEmpDocProvider with ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  String? _expiryType;
  String? get expiryType => _expiryType;

  int _metaDocID = 0;
  int get metaDocID => _metaDocID;

  void selectButton(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void setExpiryType(String? type) {
    _expiryType = type;
    notifyListeners();
  }

  void setMetaDocID(int id) {
    _metaDocID = id;
    notifyListeners();
  }

  void _fetchEmployeeDocs(BuildContext context, int metaDocID) async {
    try {
      final data = await getEmployeeDoc(context, metaDocID, 1, 20);
      // Add the new data to your stream or state management solution here
    } catch (error) {
      // Handle errors appropriately
      print('Error fetching documents: $error');
    }
  }

}

class ManageEmpDocWidget extends StatelessWidget {
  final PageController managePageController;
  final Function(int) selectButton;

  ManageEmpDocWidget({
    Key? key,
    required this.managePageController,
    required this.selectButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ManageEmpDocProvider>(
      builder: (context, provider, child) {
        return Material(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p75, vertical: AppPadding.p20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomIconButtonConst(
                      width: AppSize.s170,
                      text: AppStringEM.adddoctype,
                      onPressed: () async {
                        provider.setExpiryType(null);
                        provider.setMetaDocID(0);
                        int subDocId = _getSubDocId(provider.selectedIndex);

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: (BuildContext context,
                                  void Function(void Function()) setState) {
                                return ChangeNotifierProvider(
                                  create: (_) => EmpDocADDPopupProvider(),
                                  child: EmpDocADDPopup(
                                    title: AddPopupString.addDocument,
                                    Subdocid: subDocId,
                                    onSave: () {
                                      provider._fetchEmployeeDocs(context, subDocId);
                                      getEmployeeDoc(context, subDocId, 1, 20);
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      icon: Icons.add,
                    ),
                  ],
                ),
              ),

              /// Tab bar
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p15),
                child: Container(
                  height: AppSize.s30,
                  width: MediaQuery.of(context).size.width / 1.2025,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: ColorManager.blueprime,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(7, (index) {
                      return InkWell(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          provider.selectButton(index);
                          // Jump directly to the selected page without animation
                          managePageController.jumpToPage(index);
                        },
                        child: Container(
                          height: AppSize.s30,
                          width: MediaQuery.of(context).size.width / 8.422,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: provider.selectedIndex == index
                                ? ColorManager.white
                                : Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              _getTabLabel(index),
                              textAlign: TextAlign.center,
                              style: BlueBgTabbar.customTextStyle(index, provider.selectedIndex),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),


              const SizedBox(height: AppSize.s30),
              Expanded(
                flex: 10,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F9FC),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.faintGrey,
                            blurRadius: 2,
                            spreadRadius: -2,
                            offset: Offset(0, -4),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: AppPadding.p20,
                          right: AppPadding.p20,
                          top: AppPadding.p20),
                      child: PageView(
                        controller: managePageController,
                        onPageChanged: (index) {
                          provider.selectButton(index);
                        },
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(7, (index) {
                          return ChangeNotifierProvider(
                              create: (_) => HealthEmpDocProvider(metaDocID: _getDocIdForTab(index)),
                              child: HealthEmpDoc(metaDocID: _getDocIdForTab(index)));
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getTabLabel(int index) {
    switch (index) {
      case 0:
        return AppStringEM.health;
      case 1:
        return AppStringEM.certifications;
      case 2:
        return AppStringEM.employment;
      case 3:
        return AppStringEM.clinicalVerify;
      case 4:
        return AppStringEM.acknowledgement;
      case 5:
        return AppStringEM.compensation;
      case 6:
        return AppStringEM.performance;
      default:
        return '';
    }
  }

  int _getSubDocId(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return AppConfig.healthDocId;
      case 1:
        return AppConfig.certificationDocId;
      case 2:
        return AppConfig.employmentDocId;
      case 3:
        return AppConfig.clinicalVerificationDocId;
      case 4:
        return AppConfig.acknowledgementDocId;
      case 5:
        return AppConfig.compensationDocId;
      case 6:
        return AppConfig.performanceDocId;
      default:
        return AppConfig.healthDocId;
    }
  }

  int _getDocIdForTab(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return AppConfig.healthDocId;
      case 1:
        return AppConfig.certificationDocId;
      case 2:
        return AppConfig.employmentDocId;
      case 3:
        return AppConfig.clinicalVerificationDocId;
      case 4:
        return AppConfig.acknowledgementDocId;
      case 5:
        return AppConfig.compensationDocId;
      case 6:
        return AppConfig.performanceDocId;
      default:
        return AppConfig.healthDocId;
    }
  }
}

// class ManageEmpDocWidget extends StatefulWidget {
//   final PageController managePageController;
//   final int selectedIndex;
//   final Function(int) selectButton;
//   ManageEmpDocWidget({
//     Key? key,
//     required this.managePageController,
//     required this.selectedIndex,
//     required this.selectButton,
//   }) : super(key: key);
//
//   @override
//   State<ManageEmpDocWidget> createState() => _ManageEmpDocWidgetState();
// }
//
// class _ManageEmpDocWidgetState extends State<ManageEmpDocWidget> {
//   TextEditingController nameDocController = TextEditingController();
//   TextEditingController idDocController = TextEditingController();
//   TextEditingController dateController = TextEditingController();
//   TextEditingController daysController = TextEditingController(text: "1");
//   final PageController _managePageController = PageController();
//   String? selectedYear;
//
//   int _selectedIndex = 0;
//   void _selectButton(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//
//     _managePageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.ease,
//     );
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getEmployeeDocTab(context);
//   }
//
//   String selectType = "Health";
//   void onChange(String select) {
//     setState(() {
//       selectType = select;
//     });
//   }
//
//   var metaDocID = AppConfig.healthDocId;
//   String? expiryType;
//   bool _isLoading = false;
//   int docMetaId = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.white,
//       child: Column(
//         children: [
//           Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: AppPadding.p75,
//                       vertical: AppPadding.p20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       CustomIconButtonConst(
//                         width: AppSize.s170,
//                         text: AppStringEM.adddoctype,
//                         onPressed: () async {
//                           idDocController.clear();
//                           nameDocController.clear();
//                           dateController.clear();
//                           String? selectedExpiryType = expiryType;
//                           selectedExpiryType = "";
//                           String? selectedDocType;
//                           selectedYear = AppConfig.year;
//                           daysController.text = "1";
//
//                           int docMetaId = 0;
//
//                           int subDocId = _selectedIndex == 0
//                               ? AppConfig.healthDocId
//                               : _selectedIndex == 1
//                               ? AppConfig.certificationDocId
//                               : _selectedIndex == 2
//                               ? AppConfig.employmentDocId
//                               : _selectedIndex == 3
//                               ? AppConfig.clinicalVerificationDocId
//                               : _selectedIndex == 4
//                               ? AppConfig.acknowledgementDocId
//                               : _selectedIndex == 5
//                               ? AppConfig.compensationDocId
//                               : AppConfig.performanceDocId;
//
//                           String NewText = _selectedIndex == 0
//                               ? AppStringEM.health
//                               : _selectedIndex == 1
//                               ? AppStringEM.certifications
//                               : _selectedIndex == 2
//                               ? AppStringEM.employment
//                               : _selectedIndex == 3
//                               ? AppStringEM.clinicalVerify
//                               : _selectedIndex == 4
//                               ? AppStringEM.acknowledgement
//                               : _selectedIndex == 5
//                               ? AppStringEM.compensation
//                               : AppStringEM.performance;
//
//                           List<DropdownMenuItem<String>> dropDownMenuItems = [];
//                           final docTypes = await getEmployeeDocTab(context);
//                           if (docTypes.isNotEmpty) {
//                             for (var i in docTypes) {
//                               dropDownMenuItems.add(
//                                 DropdownMenuItem<String>(
//                                   child: Text(i.employeeDocType),
//                                   value: i.employeeDocType,
//                                 ),
//                               );
//                             }
//                             selectedDocType = dropDownMenuItems[0].value;
//                             docMetaId = docTypes[0].employeeDocMetaDataId;
//                           }
//
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return StatefulBuilder(
//                                 builder: (BuildContext context, void Function(void Function()) setState) {
//                                   return EmpDocADDPopup(
//                                     title: AddPopupString.addDocument,
//                                    Subdocid:subDocId,
//                                   );
//                                 },
//                               );
//                             },
//                           );
//                         },
//                         icon: Icons.add,
//                       ),
//                     ],
//                   ),
//                 ),
//
//
//           /// tab bar
//           Padding(
//             padding: const EdgeInsets.only(left: AppPadding.p15),
//             child: Container(
//               height: AppSize.s30,
//               width: MediaQuery.of(context).size.width / 1.2025,
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: ColorManager.black.withOpacity(0.25),
//                     spreadRadius: 0,
//                     blurRadius: 4,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//                 borderRadius: BorderRadius.circular(20),
//                 color: ColorManager.blueprime,
//                 // color: Colors.yellow,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   InkWell(
//                       splashColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                       hoverColor: Colors.transparent,
//                       child: Container(
//                         height: AppSize.s30,
//                         width: MediaQuery.of(context).size.width / 8.422,
//                         padding: const EdgeInsets.symmetric(vertical: AppPadding.p6),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: _selectedIndex == 0
//                               ? ColorManager.white
//                               : Colors.transparent,
//                         ),
//                         child: Text(
//                          AppStringEM.health,
//                           textAlign: TextAlign.center,
//                           style:  BlueBgTabbar.customTextStyle(0, _selectedIndex),
//                         ),
//                       ),
//                       onTap: () {
//                         _selectButton(0);
//                         // metaDocID = snapshot.data![index].employeeDocMetaDataId;
//                       }),
//                   InkWell(
//                       child: Container(
//                         height: AppSize.s30,
//                         width: MediaQuery.of(context).size.width / 8.421,
//                         padding: const EdgeInsets.symmetric(vertical: AppPadding.p6),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: _selectedIndex == 1
//                               ? ColorManager.white
//                               : Colors.transparent,
//                         ),
//                         child: Text(
//                           AppStringEM.certifications,
//                           textAlign: TextAlign.center,
//                           style: BlueBgTabbar.customTextStyle(1, _selectedIndex),
//                         ),
//                       ),
//                       onTap: () {
//                         _selectButton(1);
//                         // metaDocID = snapshot.data![index].employeeDocMetaDataId;
//                       }),
//                   InkWell(
//                       child: Container(
//                         height: AppSize.s30,
//                         width: MediaQuery.of(context).size.width / 8.421,
//                         padding: const EdgeInsets.symmetric(vertical: AppPadding.p6),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: _selectedIndex == 2
//                               ? ColorManager.white
//                               : Colors.transparent,
//                         ),
//                         child: Text(
//                           AppStringEM.employment,
//                           textAlign: TextAlign.center,
//                           style:  BlueBgTabbar.customTextStyle(2, _selectedIndex),
//                         ),
//                       ),
//                       onTap: () {
//                         _selectButton(2);
//                         // metaDocID = snapshot.data![index].employeeDocMetaDataId;
//                       }),
//                   InkWell(
//                       child: Container(
//                         height: AppSize.s30,
//                         width: MediaQuery.of(context).size.width / 8.421,
//                         padding: const EdgeInsets.symmetric(vertical: AppPadding.p6),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: _selectedIndex == 3
//                               ? ColorManager.white
//                               : Colors.transparent,
//                         ),
//                         child: Text(
//                           AppStringEM.clinicalVerify,
//                           textAlign: TextAlign.center,
//                           style:  BlueBgTabbar.customTextStyle(3, _selectedIndex),
//                         ),
//                       ),
//                       onTap: () {
//                         _selectButton(3);
//                         // metaDocID = snapshot.data![index].employeeDocMetaDataId;
//                       }),
//                   InkWell(
//                       child: Container(
//                         height: AppSize.s30,
//                         width: MediaQuery.of(context).size.width / 8.421,
//                         padding: const EdgeInsets.symmetric(vertical: AppPadding.p6),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: _selectedIndex == 4
//                               ? ColorManager.white
//                               : Colors.transparent,
//                         ),
//                         child: Text(
//                          AppStringEM.acknowledgement,
//                           textAlign: TextAlign.center,
//                           style:  BlueBgTabbar.customTextStyle(4, _selectedIndex),
//                         ),
//                       ),
//                       onTap: () {
//                         _selectButton(4);
//                         // metaDocID = snapshot.data![index].employeeDocMetaDataId;
//                       }),
//                   InkWell(
//                       child: Container(
//                         height: AppSize.s30,
//                         width: MediaQuery.of(context).size.width / 8.421,
//                         padding: const EdgeInsets.symmetric(vertical: AppPadding.p6),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: _selectedIndex == 5
//                               ? ColorManager.white
//                               : Colors.transparent,
//                         ),
//                         child: Text(
//                           AppStringEM.compensation,
//                           textAlign: TextAlign.center,
//                           style:  BlueBgTabbar.customTextStyle(5, _selectedIndex),
//                         ),
//                       ),
//                       onTap: () {
//                         _selectButton(5);
//                         // metaDocID = snapshot.data![index].employeeDocMetaDataId;
//                       }),
//                   InkWell(
//                       splashColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                       hoverColor: Colors.transparent,
//                       child: Container(
//                         height: AppSize.s30,
//                         width: MediaQuery.of(context).size.width / 8.421,
//                         padding: const EdgeInsets.symmetric(vertical: AppPadding.p6),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: _selectedIndex == 6
//                               ? ColorManager.white
//                               : Colors.transparent,
//                         ),
//                         child: Text(
//                           AppStringEM.performance,
//                           textAlign: TextAlign.center,
//                           style:  BlueBgTabbar.customTextStyle(6, _selectedIndex),
//                         ),
//                       ),
//                       onTap: () {
//                         _selectButton(6);
//                         // metaDocID = snapshot.data![index].employeeDocMetaDataId;
//                       }),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: AppSize.s30,),
//           Expanded(
//             flex: 10,
//             child: Stack(children: [
//               Container(
//                 //height: MediaQuery.of(context).size.height / 3,
//                 decoration: BoxDecoration(
//                     color: Color(0xFFF2F9FC),
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: ColorManager.faintGrey,
//                         blurRadius: 2,
//                         spreadRadius: -2,
//                         offset: Offset(0, -4),
//                       ),
//                     ]),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                     left: MediaQuery.of(context).size.width / 45,
//                     right: MediaQuery.of(context).size.width / 45,
//                     top: MediaQuery.of(context).size.width / 45),
//                 child: PageView(
//                     controller: _managePageController,
//                     onPageChanged: (index) {
//                       setState(() {
//                         _selectedIndex = index;
//                       });
//                     },
//                     physics: const NeverScrollableScrollPhysics(),
//                     children: [
//                       HealthEmpDoc(metaDocID: AppConfig.healthDocId),
//                       HealthEmpDoc(metaDocID: AppConfig.certificationDocId),
//                       HealthEmpDoc(metaDocID: AppConfig.employmentDocId),
//                       HealthEmpDoc(metaDocID: AppConfig.clinicalVerificationDocId),
//                       HealthEmpDoc(metaDocID: AppConfig.acknowledgementDocId),
//                       HealthEmpDoc(metaDocID: AppConfig.compensationDocId),
//                       HealthEmpDoc(metaDocID: AppConfig.performanceDocId),
//                     ]),
//               ),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }
// }
