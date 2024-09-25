import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_visit_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/manage_details_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import 'package:prohealth/data/api_data/establishment_data/ci_manage_button/manage_details_data.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_visit_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/visit_constants.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';

class CiVisitScreen extends StatefulWidget {
  const CiVisitScreen({super.key});

  @override
  State<CiVisitScreen> createState() => _CiVisitScreenState();
}

class _CiVisitScreenState extends State<CiVisitScreen> {
  String? selectedValue;
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController eligibleClinicalController = TextEditingController();
  final StreamController<List<CiVisit>> _visitController =
  StreamController<List<CiVisit>>();
  late List<Color> hrcontainerColors;
  int empTypeId = 0;
  @override
  void initState() {
    super.initState();
    hrcontainerColors = List.generate(20, (index) => Color(0xffE8A87D));
    _loadColors();
    getVisit(context, 1, 30).then((data) {
      _visitController.add(data);
    }).catchError((error) {
      // Handle error
    });
  }
  String? selectedServiceName;
  String? serviceId;
  List<Widget> selectedChips = [];
  List<Widget> chipsList = [];
  List<String> editChipValues = [];
  List<int> selectedChipsId = [];
  List<Widget> selectedEditChips = [];
  List<int> selectedEditChipsId = [];
  List<String> chipValues = [];
  String chips = "";
  bool _isLoading = false;
  bool _isDarkColor(Color color) {
    double perceivedBrightness =
        color.red * 0.299 + color.green * 0.587 + color.blue * 0.114;
    return perceivedBrightness <
        128;
  }

  void deleteChip(String chip, int chipId) {
    setState(() {
      selectedChips.remove(chip);
      selectedChipsId.remove(chipId);
      //selectedChipsEmpId.remove(chipEmpId);
    });
  }

  void _loadColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < hrcontainerColors.length; i++) {
        int? colorValue = prefs.getInt('containerColor$i');
        if (colorValue != null) {
          hrcontainerColors[i] = Color(colorValue);
        }
      }
    });
  }

  String _selectedItem = 'Select';
  void _onDropdownItemSelected(String newValue) {
    setState(() {
      _selectedItem = newValue;
    });
  }

  int currentPage = 1;
  final int itemsPerPage = 10;
  final int totalPages = 5;

  void onPageNumberPressed(int pageNumber) {
    setState(() {
      currentPage = pageNumber;
    });
  }
  TextEditingController dummyCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/25),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: AppSize.s150,
              // margin: EdgeInsets.only(right: AppMargin.m30),
              child: CustomIconButtonConst(
                  text: AppString.addnewvisit,
                  icon: Icons.add,
                  onPressed: () {
                    docIdController.clear();
                    docNamecontroller.clear();
                    selectedChips.clear();
                    selectedServiceName = "";
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (BuildContext context,
                                void Function(void Function()) setState) {
                            //  List<Widget> listWidget = selectedChips;
                              return AddVisitPopup(
                                title: 'Add New Visit',
                                nameOfDocumentController: docNamecontroller,
                                idOfDocumentController: docIdController,
                              );
                            },
                          );
                        });
                  }),
            ),
          ],
        ),
        SizedBox(
          height: AppSize.s10,
        ),
        ///headings
        Container(
          height: AppSize.s30,
          //margin: EdgeInsets.symmetric(horizontal: AppMargin.m35),
          decoration: BoxDecoration(
            color: ColorManager.fmediumgrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Expanded(flex: 2, child: Container()),
              Padding(
                padding: const EdgeInsets.only(left: 80),
                child: Text(
                  AppString.srNo,
                  textAlign: TextAlign.center,
                  // style: RegisterTableHead.customTextStyle(context),
                  style: AllHRTableHeading.customTextStyle(context),
                ),
              ),

              ///visit
              Padding(
                padding: const EdgeInsets.only(left: 150),
                child: Text(
                  AppString.visit,
                  textAlign: TextAlign.center,
                  style: AllHRTableHeading.customTextStyle(context),
                ),
              ),

              ///EL clinician
              Padding(
                padding: const EdgeInsets.only(right: 250),
                child: Text(
                  AppString.eligibleClinician,
                  textAlign: TextAlign.center,
                  style: AllHRTableHeading.customTextStyle(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 75.0),
                child: Text(
                  AppString.actions,
                  textAlign: TextAlign.center,
                  style: AllHRTableHeading.customTextStyle(context),
                  // style: RegisterTableHead.customTextStyle(context),
                ),
              ),
              // Expanded(flex: 2, child: Container())
            ],
          ),
        ),
        SizedBox(
          height: AppSize.s5,
        ),
        Expanded(
          child: StreamBuilder<List<CiVisit>>(
              stream: _visitController.stream,
              builder: (context, snapshot) {
                print('1111111');
                getVisit(context, 1, 30).then((data) {
                  _visitController.add(data);
                }).catchError((error) {
                  // Handle error
                });
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 150),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.blueprime,
                      ),
                    ),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                      child: Text(
                        ErrorMessageString.noVisit,
                        //AppString.dataNotFound,
                        style: CustomTextStylesCommon.commonStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: FontSize.s12,
                          color: ColorManager.mediumgrey,
                        ),
                      ),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  int totalItems = snapshot.data!.length;
                  int totalPages = (totalItems / itemsPerPage).ceil();
                  List<CiVisit> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: paginatedData.length,
                            itemBuilder: (context, index) {
                              int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                              String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                              CiVisit visitData = paginatedData[index];
                              print("Length ::: ${snapshot.data![index].eligibleClinician.toString()}");
                              List<Widget> clinical = [];
                              for (var i in visitData.eligibleClinician!) {
                                var hexColor = i.color.replaceAll("#", "");
                                //var = i.color.trim();
                                clinical.add(Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      color: hexColor == 'string'
                                          ? Colors.white
                                          : Color(int.parse('0xFF$hexColor')),
                                      child: Center(
                                          child: Text(
                                            i.eligibleClinician,
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: _isDarkColor(hexColor == 'string'
                                                  ? Colors.white
                                                  : Color(int.parse('0xFF$hexColor')))
                                                  ? ColorManager.white
                                                  : ColorManager.black,
                                              decoration: TextDecoration.none,
                                            ),
                                          ))),
                                ));
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Column(children: [
                                  Container(
                                      padding: EdgeInsets.only(bottom: AppPadding.p5),
                                      decoration: BoxDecoration(
                                        color: ColorManager.white,
                                        borderRadius: BorderRadius.circular(4),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorManager.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      height: AppSize.s56,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // Expanded(flex: 2, child: Container()),
                                          Expanded(
                                            child: Text(
                                              formattedSerialNumber,
                                              style: DocumentTypeDataStyle.customTextStyle(context),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          // Expanded(flex: 1, child: Container()),
                                          Expanded(
                                            child: Text(
                                              visitData.typeofVisit.toString(),
                                              textAlign: TextAlign.center,
                                              style:DocumentTypeDataStyle.customTextStyle(context),
                                            ),
                                          ),
                                          Expanded( child: Container()),
                                          Expanded(
                                            child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: clinical),
                                          ),
                                          // Expanded(flex: 2, child: Container()),
                                          Expanded(
                                          child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                      splashColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      hoverColor: Colors.transparent,
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return FutureBuilder<VisitListDataPrefill>(
                                                              future: getVisitListPrefill(context, visitData.visitId),
                                                              builder: (context, snapshotPrefill) {
                                                                if (snapshotPrefill.connectionState == ConnectionState.waiting) {
                                                                  return Center(
                                                                    child: CircularProgressIndicator(
                                                                      color: ColorManager.blueprime,
                                                                    ),
                                                                  );
                                                                }
                                                                var visitName = snapshotPrefill.data!.visitType;
                                                                docNamecontroller = TextEditingController(
                                                                  text: snapshotPrefill.data!.visitType.toString(),
                                                                );

                                                                return StatefulBuilder(
                                                                  builder: (BuildContext context, setState) {
                                                                    // Initialize the chips only once, when the dialog is first built
                                                                    if (selectedEditChips.isEmpty) {
                                                                      for (var i in snapshotPrefill.data!.eligibleClinicia) {
                                                                        selectedEditChipsId.add(i.employeeTypeId);
                                                                        editChipValues.add(i.eligibleClinician);
                                                                        selectedEditChips.add(
                                                                          Chip(
                                                                            backgroundColor: ColorManager.white,
                                                                            shape: StadiumBorder(
                                                                              side: BorderSide(color: ColorManager.blueprime),
                                                                            ),
                                                                            deleteIcon: Icon(
                                                                              Icons.close,
                                                                              color: ColorManager.blueprime,
                                                                              size: 17,
                                                                            ),
                                                                            label: Text(
                                                                              i.eligibleClinician,
                                                                              style: CustomTextStylesCommon.commonStyle(
                                                                                fontWeight:FontWeight.w500,
                                                                                fontSize: FontSize.s10,
                                                                                color: ColorManager.mediumgrey,
                                                                              ),
                                                                            ),
                                                                            onDeleted: () {
                                                                              setState(() {
                                                                                // Remove chip data
                                                                                editChipValues.remove(i.eligibleClinician);
                                                                                selectedEditChips.removeWhere((chip) {
                                                                                  final chipText = (chip as Chip).label as Text;
                                                                                  return chipText.data == i.eligibleClinician;
                                                                                });
                                                                                selectedEditChipsId.remove(i.employeeTypeId);
                                                                              });
                                                                            },
                                                                          ),
                                                                        );
                                                                      }
                                                                    }
                                                                    return EditVisitPopup(
                                                                      serviceNameSelected: TextEditingController(text:snapshotPrefill.data!.serviceId),
                                                                      enable:false,
                                                                      visitId: snapshotPrefill.data!.visitId,
                                                                      nameOfDocumentController: docNamecontroller,
                                                                      idOfDocumentController: docIdController,
                                                                      prefilledClinicians: snapshotPrefill.data!.eligibleClinicia,

                                                                      // onSavePressed: () async {
                                                                      //   await updateVisitPatch(
                                                                      //     context:context,
                                                                      //     typeVisist: paginatedData[index].visitId,
                                                                      //     visitType: visitName == docNamecontroller.text
                                                                      //         ? visitName.toString()
                                                                      //         : docNamecontroller.text,
                                                                      //     eligibleClinical: selectedEditChipsId,
                                                                      //     serviceId: serviceId!,
                                                                      //   );
                                                                      //   getVisit(context, 1, 50).then((data) {
                                                                      //     _visitController.add(data);
                                                                      //   }).catchError((error) {
                                                                      //     // Handle error
                                                                      //   });
                                                                      //
                                                                      //   // Clear data after save
                                                                      //   editChipValues.clear();
                                                                      //   selectedEditChipsId.clear();
                                                                      //   selectedEditChips.clear();
                                                                      //   docNamecontroller.clear();
                                                                      //   _selectedItem = "Select";
                                                                      // },
                                                                      // dropdownServices:FutureBuilder<List<ServicesMetaData>>(
                                                                      //   future: getServicesMetaData(context),
                                                                      //   builder: (context, snapshot) {
                                                                      //     if (snapshot.connectionState ==
                                                                      //         ConnectionState.waiting) {
                                                                      //       return dummeyTextField(
                                                                      //         width: 354,
                                                                      //         height: 30,
                                                                      //         controller: dummyCtrl,
                                                                      //         labelText: 'Select',
                                                                      //         suffixIcon: Icon(
                                                                      //           Icons.arrow_drop_down,
                                                                      //           color: ColorManager.black,
                                                                      //         ),
                                                                      //       );
                                                                      //     }
                                                                      //     if (snapshot.hasData && snapshot.data!.isEmpty) {
                                                                      //       return Container(
                                                                      //         width:354,
                                                                      //         height: 30,
                                                                      //         decoration: BoxDecoration(
                                                                      //           border: Border.all(
                                                                      //               color: ColorManager.containerBorderGrey, width: AppSize.s1),
                                                                      //           borderRadius: BorderRadius.circular(5),
                                                                      //         ),
                                                                      //         child: Padding(
                                                                      //           padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                                                      //           child: Text(
                                                                      //             ErrorMessageString.noserviceAdded,
                                                                      //             style: AllNoDataAvailable.customTextStyle(context),
                                                                      //           ),
                                                                      //         ),
                                                                      //       );
                                                                      //     }
                                                                      //     if (snapshot.hasData) {
                                                                      //       List<DropdownMenuItem<String>>
                                                                      //       dropDownServiceList = [];
                                                                      //       for (var service in snapshot.data!) {
                                                                      //         dropDownServiceList.add(
                                                                      //           DropdownMenuItem<String>(
                                                                      //             value: service.serviceName,
                                                                      //             child: Text(service.serviceName ?? ''),
                                                                      //           ),
                                                                      //         );
                                                                      //       }
                                                                      //       selectedServiceName = snapshot.data![0].serviceName;
                                                                      //       serviceId = snapshot.data![0].serviceId;
                                                                      //       // Store the service ID of the 0th position
                                                                      //       return StatefulBuilder(
                                                                      //         builder: (BuildContext context, void Function(void Function()) setState) {
                                                                      //           return CICCDropdown(
                                                                      //             initialValue: selectedServiceName,
                                                                      //             onChange: (val) {
                                                                      //               setState(() {
                                                                      //                 selectedServiceName = val;
                                                                      //                 for (var service in snapshot.data!) {
                                                                      //                   if (service.serviceName == val) {
                                                                      //                     serviceId =
                                                                      //                         service.serviceId;
                                                                      //                   }
                                                                      //                 }
                                                                      //               });
                                                                      //             },
                                                                      //             items: dropDownServiceList,
                                                                      //           );
                                                                      //         },
                                                                      //       );
                                                                      //     }
                                                                      //     return const SizedBox();
                                                                      //   },
                                                                      // ),
                                                                      title: 'Edit Visit',
                                                                      // child: Column(
                                                                      //   crossAxisAlignment: CrossAxisAlignment.start,
                                                                      //   children: [
                                                                      //     FutureBuilder<List<HRAllData>>(
                                                                      //       future: getAllHrDeptWise(context, 1),
                                                                      //       builder: (context, snapshot) {
                                                                      //         if (snapshot.connectionState == ConnectionState.waiting) {
                                                                      //           return Shimmer.fromColors(
                                                                      //             baseColor: Colors.grey[300]!,
                                                                      //             highlightColor: Colors.grey[100]!,
                                                                      //             child: Container(
                                                                      //               width: 354,
                                                                      //               height: 30,
                                                                      //               decoration: BoxDecoration(
                                                                      //                 color: ColorManager.faintGrey,
                                                                      //                 borderRadius: BorderRadius.circular(10),
                                                                      //               ),
                                                                      //             ),
                                                                      //           );
                                                                      //         }
                                                                      //         if (snapshot.data!.isEmpty) {
                                                                      //           return Center(
                                                                      //             child: Text(
                                                                      //               AppString.dataNotFound,
                                                                      //               style: AllNoDataAvailable.customTextStyle(context),
                                                                      //             ),
                                                                      //           );
                                                                      //         }
                                                                      //         if (snapshot.hasData) {
                                                                      //           int docType = 0;
                                                                      //           List<DropdownMenuItem<String>> dropDownTypesList = [];
                                                                      //           for (var i in snapshot.data!) {
                                                                      //             dropDownTypesList.add(
                                                                      //               DropdownMenuItem<String>(
                                                                      //                 child: Text(i.abbrivation!),
                                                                      //                 value: i.abbrivation,
                                                                      //               ),
                                                                      //             );
                                                                      //           }
                                                                      //           return CICCDropdown(
                                                                      //             initialValue: dropDownTypesList[0].value,
                                                                      //             onChange: (val) {
                                                                      //               for (var a in snapshot.data!) {
                                                                      //                 if (a.abbrivation == val) {
                                                                      //                   docType = a.employeeTypesId;
                                                                      //                   empTypeId = docType;
                                                                      //                   setState(() {
                                                                      //                     if (val.isNotEmpty) {
                                                                      //                       editChipValues.add(val);
                                                                      //                       selectedEditChips.add(
                                                                      //                         Chip(
                                                                      //                           backgroundColor: ColorManager.white,
                                                                      //                           shape: StadiumBorder(
                                                                      //                             side: BorderSide(
                                                                      //                                 color: ColorManager.blueprime),
                                                                      //                           ),
                                                                      //                           deleteIcon: Icon(
                                                                      //                             Icons.close,
                                                                      //                             color: ColorManager.blueprime,
                                                                      //                             size: IconSize.I16,
                                                                      //                           ),
                                                                      //                           label: Text(
                                                                      //                             val,
                                                                      //                             style: CustomTextStylesCommon.commonStyle(
                                                                      //                               fontWeight: FontWeight.w500,
                                                                      //                               fontSize: FontSize.s10,
                                                                      //                               color: ColorManager.mediumgrey,
                                                                      //                             ),
                                                                      //                           ),
                                                                      //                           onDeleted: () {
                                                                      //                             setState(() {
                                                                      //                               editChipValues.remove(val);
                                                                      //                               selectedEditChips.removeWhere(
                                                                      //                                       (chip) {
                                                                      //                                     final chipText =
                                                                      //                                     (chip as Chip).label as Text;
                                                                      //                                     return chipText.data == val;
                                                                      //                                   });
                                                                      //                               selectedEditChipsId.remove(docType);
                                                                      //                             });
                                                                      //                           },
                                                                      //                         ),
                                                                      //                       );
                                                                      //                       selectedEditChipsId.add(docType);
                                                                      //                     }
                                                                      //                   });
                                                                      //                 }
                                                                      //               }
                                                                      //             },
                                                                      //             items: dropDownTypesList,
                                                                      //           );
                                                                      //         }
                                                                      //         return SizedBox();
                                                                      //       },
                                                                      //     ),
                                                                      //     SizedBox(height: AppSize.s5),
                                                                      //     Wrap(
                                                                      //       spacing: 8.0,
                                                                      //       children: selectedEditChips,
                                                                      //     ),
                                                                      //   ],
                                                                      // ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            );
                                                          },
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.edit_outlined,
                                                        size: IconSize.I18,
                                                        color: IconColorManager.bluebottom,
                                                      )),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  IconButton(
                                                    splashColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    onPressed: () {
                                                      showDialog(context: context,
                                                        builder: (context) =>
                                                            StatefulBuilder(
                                                              builder: (BuildContext context, void Function(void Function())
                                                              setState) {
                                                                return
                                                                  DeletePopup(
                                                                      title: 'Delete Visit',
                                                                      loadingDuration: _isLoading,
                                                                      onCancel: (){
                                                                        Navigator.pop(context);
                                                                      },
                                                                      onDelete:
                                                                          () async {
                                                                        setState(() {
                                                                          _isLoading = true;
                                                                        });
                                                                        try {
                                                                          await deleteVisit(context, snapshot.data![index].visitId);
                                                                          getVisit(context, 1, 10).then((data) {
                                                                            _visitController.add(data);
                                                                          }).catchError((error) {
                                                                            // Handle error
                                                                          });

                                                                        } finally {
                                                                          setState(() {
                                                                            _isLoading = false;
                                                                          });
                                                                          Navigator.pop(context);
                                                                        }
                                                                      }

                                                                  );
                                                              },
                                                            ),
                                                      );

                                                    },
                                                    icon: Icon(
                                                      size: IconSize.I18,
                                                      Icons.delete_outline,
                                                      color: IconColorManager.red,
                                                    ),

                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Expanded(flex: 3, child: Container())
                                        ],
                                      ))
                                ]),
                              );
                            }),
                      ),
                      // PaginationControlsWidget(
                      //   currentPage: currentPage,
                      //   items: snapshot.data!,
                      //   itemsPerPage: itemsPerPage,
                      //   onPreviousPagePressed: () {
                      //     setState(() {
                      //       currentPage = currentPage > 1 ? currentPage - 1 : 1;
                      //     });
                      //   },
                      //   onPageNumberPressed: (pageNumber) {
                      //     setState(() {
                      //       currentPage = pageNumber;
                      //     });
                      //   },
                      //   onNextPagePressed: () {
                      //     setState(() {
                      //       currentPage = currentPage < totalPages ? currentPage + 1 : totalPages;
                      //     });
                      //   },
                      // ),
                    ],
                  );
                }
                return Offstage();
              }),
        ),
        //       PaginationControlsWidget(
      ]),
    );
  }
}
