import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_visit_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_visit_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/visit_constants.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import '../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../../hr_module/manage/controller/controller.dart';
import '../ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import '../policies_procedures/widgets/add_policies_popup.dart';

class CiVisitScreen extends StatefulWidget {
  const CiVisitScreen({super.key});

  @override
  State<CiVisitScreen> createState() => _CiVisitScreenState();
}

class _CiVisitScreenState extends State<CiVisitScreen> {
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  String? selectedValue;
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController eligibleClinicalController = TextEditingController();
  final StreamController<List<CiVisit>> _visitController =
      StreamController<List<CiVisit>>();
  late List<Color> hrcontainerColors;
  // FocusNode _focusNode = FocusNode();
  // bool _showList = false;
  int empTypeId = 0;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 20;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    hrcontainerColors = List.generate(20, (index) => Color(0xffE8A87D));
    _loadColors();
    getVisit(context, 1, 1, 20).then((data) {
      _visitController.add(data);
    }).catchError((error) {
      // Handle error
    });
  }

  List<Widget> selectedChips = [];
  List<Widget> chipsList = [];
  List<int> selectedChipsId = [];
  List<Widget> selectedEditChips = [];
  List<int> selectedEditChipsId = [];
  String chips = "";
  bool _isLoading = false;
  bool _isDarkColor(Color color) {
    double perceivedBrightness = color.red * 0.299 + color.green * 0.587 + color.blue * 0.114;
    return perceivedBrightness < 128; // If perceived brightness is less than 128, color is considered dark
  }
  void addChip(
    String chip,
      int chipId
  ) {
    // setState(() {


     // chipsList = selectedChips;
    // });
  }

  void deleteChip(
    String chip,
      int chipId
  ) {
    //setState(() {
      selectedChips.remove(chip);
      selectedChipsId.remove(chipId);
      //selectedChipsEmpId.remove(chipEmpId);
   // });
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
 // List<> eligibalClinical =[];
  @override
  Widget build(BuildContext context) {
    List<String> currentPageItems = items.sublist(
      (currentPage - 1) * itemsPerPage,
      min(currentPage * itemsPerPage, items.length),
    );
    final RegisterController _controller = Get.put(RegisterController());
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: AppSize.s150,
            margin: EdgeInsets.only(right: AppMargin.m30),
            child: CustomIconButtonConst(
                // heightContainer: 30,
                //   widthContainer: 120,
                text: AppString.addnewvisit,
                icon: Icons.add,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function()) setState) {
                            List<Widget> listWidget = selectedChips;
                            return AddVisitPopup(
                              title: 'Add New Visit',
                              nameOfDocumentController: docNamecontroller,
                              idOfDocumentController: docIdController,
                              onSavePressed: () async {
                                print(":::::${_selectedItem}");
                                await addVisitPost(
                                    context, docNamecontroller.text, 1,selectedChipsId);
                                getVisit(context, 1, 1, 15).then((data) {
                                  _visitController.add(data);
                                }).catchError((error) {
                                  // Handle error
                                });
                                selectedChipsId.clear();
                                selectedChips.clear();
                                docNamecontroller.clear();
                              },
                              child1: Wrap(spacing: 8.0,
                                  children: listWidget),
                              child: FutureBuilder<List<HRClinical>>(
                                  future: companyAllHrClinicApi(context),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            width: 354,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: ColorManager.faintGrey,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ));
                                    }
                                    if (snapshot.data!.isEmpty) {
                                      return Center(
                                        child: Text(
                                          AppString.dataNotFound,
                                          style: CustomTextStylesCommon
                                              .commonStyle(
                                            fontWeight:
                                                FontWeightManager.medium,
                                            fontSize: FontSize.s12,
                                            color: ColorManager.mediumgrey,
                                          ),
                                        ),
                                      );
                                    }
                                    if (snapshot.hasData) {
                                      int docType = 0;
                                      List<DropdownMenuItem<String>>
                                          dropDownTypesList = [];
                                      for (var i in snapshot.data!) {
                                        dropDownTypesList.add(
                                          DropdownMenuItem<String>(
                                            child: Text(i.abbrivation!),
                                            value: i.abbrivation,
                                          ),
                                        );
                                      }
                                      return CICCDropdown(
                                          initialValue:
                                              dropDownTypesList[0].value,
                                          onChange: (val) {
                                            for (var a in snapshot.data!) {
                                              if (a.abbrivation == val) {
                                                docType = a.employeeTypesId;
                                                empTypeId = docType;
                                                setState(() {
                                                  if (val.isNotEmpty) {

                                                    selectedChips.add(Chip(
                                                      backgroundColor: ColorManager.white,
                                                      shape: StadiumBorder(
                                                          side: BorderSide(
                                                              color: ColorManager.blueprime)),
                                                      deleteIcon: Icon(
                                                        Icons.close,
                                                        color: ColorManager.blueprime,
                                                        size: 17,
                                                      ),
                                                      label: Text(
                                                        val,
                                                        style: CustomTextStylesCommon.commonStyle(
                                                            fontWeight: FontWeightManager.medium,
                                                            fontSize: FontSize.s10,
                                                            color: ColorManager.mediumgrey),
                                                      ),

                                                      onDeleted: () {
                                                        setState(() {
                                                          deleteChip(val,docType);
                                                          selectedChips.clear();
                                                          selectedChipsId.clear();
                                                          print(":::Chips name ${selectedChips}");
                                                          print(":::: Chips Id ${selectedChipsId}");
                                                        });
                                                      },
                                                    ),);
                                                    selectedChipsId.add(docType);
                                                    print("::${selectedChipsId}");
                                                    print("::${selectedChips}");
                                                  }
                                                });
                                              }
                                            }
                                            print(":::${docType}");
                                            print(":::<>${empTypeId}");
                                          },
                                          items: dropDownTypesList);
                                    }
                                    return SizedBox();
                                  }),
                            );
                          },
                        );
                      });
                }),
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      ///headings
      Container(
        height: AppSize.s30,
        margin: EdgeInsets.symmetric(horizontal: AppMargin.m35),
        decoration: BoxDecoration(
          color: ColorManager.fmediumgrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Expanded(flex: 2, child: Container()),
            Padding(
              padding:  const EdgeInsets.only(left: 50),
              child: Text(
                AppString.srNo,
                textAlign: TextAlign.center,
                // style: RegisterTableHead.customTextStyle(context),
                style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.white
                    // color: isSelected ? Colors.white : Colors.black,
                    ),
              ),
            ),
            ///visit
            Padding(
              padding: const EdgeInsets.only(left: 110),
              child: Text(
                AppString.visit,
                textAlign: TextAlign.center,
                style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.white
                    // color: isSelected ? Colors.white : Colors.black,
                    ),
              ),
            ),
            ///EL clinician
            Padding(
              padding:  const EdgeInsets.only(right: 270),
              child: Text(
                AppString.eligibleClinician,
                textAlign: TextAlign.center,
                style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.white
                    // color: isSelected ? Colors.white : Colors.black,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Text(
                AppString.actions,
                textAlign:TextAlign.center,
                style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.white
                    // color: isSelected ? Colors.white : Colors.black,
                    ),
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
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.blueprime,
                  ),
                );
              }
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    AppString.dataNotFound,
                    style: CustomTextStylesCommon.commonStyle(
                      fontWeight: FontWeightManager.medium,
                      fontSize: FontSize.s12,
                      color: ColorManager.mediumgrey,
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                int totalItems = snapshot.data!.length;

                // int totalPages = (totalItems / itemsPerPage).ceil();
                List<CiVisit> currentPageItems = snapshot.data!.sublist(
                  (currentPage - 1) * itemsPerPage,
                  (currentPage * itemsPerPage) > totalItems
                      ? totalItems
                      : (currentPage * itemsPerPage),
                );
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: currentPageItems.length,
                    itemBuilder: (context, index) {
                      print("Length ::: ${snapshot.data![index].eligibleClinician.toString()}");
                      List<Widget> clinical = [];
                      for(var i in snapshot.data![index].eligibleClinician!){
                         var hexColor = i.color.replaceAll("#","");
                        //var = i.color.trim();
                        clinical.add(Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height:30,
                            width: 30,
                            color:hexColor == 'string' ? Colors.white : Color(int.parse('0xFF$hexColor')),
                            child:Center(child: Text(i.eligibleClinician,style: GoogleFonts.firaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: _isDarkColor(hexColor == 'string' ?Colors.white :Color(int.parse('0xFF$hexColor'))) ? ColorManager.white : ColorManager.black,
                              decoration: TextDecoration.none,
                            ),))
                          ),
                        ));
                      }
                      int serialNumber =
                          index + 1 + (currentPage - 1) * itemsPerPage;
                      String formattedSerialNumber =
                          serialNumber.toString().padLeft(2, '0');
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(children: [

                          Container(
                              padding: EdgeInsets.only(bottom: AppPadding.p5),
                              margin:
                                  EdgeInsets.symmetric(horizontal: AppMargin.m50),
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
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                 // Expanded(flex: 2, child: Container()),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      formattedSerialNumber,
                                      style: GoogleFonts.firaSans(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff686464)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                 // Expanded(flex: 1, child: Container()),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      snapshot.data![index].typeofVisit
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.firaSans(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff686464)),
                                    ),
                                  ),
                                 // Expanded(flex: 1, child: Container()),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:clinical
                                    ),
                                  ),
                                 // Expanded(flex: 2, child: Container()),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return FutureBuilder<VisitListDataPrefill>(
                                                            future: getVisitListPrefill(context, snapshot.data![index].visitId),
                                                            builder: (context,snapshotPrefill) {
                                                              if(snapshotPrefill.connectionState == ConnectionState.waiting){
                                                                return Center(child: CircularProgressIndicator(color: ColorManager.blueprime,));
                                                              }
                                                              var visitName = snapshotPrefill.data!.visitType;
                                                              docNamecontroller = TextEditingController(text: snapshotPrefill.data!.visitType.toString());
                                                              return StatefulBuilder(
                                                                builder: (BuildContext context, void Function(void Function()) setState) {
                                                                  return AddVisitPopup(
                                                                    nameOfDocumentController:
                                                                    docNamecontroller,
                                                                    idOfDocumentController:
                                                                    docIdController,
                                                                    onSavePressed:
                                                                        () async {
                                                                      await updateVisitPatch(
                                                                          context,
                                                                          snapshot
                                                                              .data![index]
                                                                              .visitId,
                                                                          visitName == docNamecontroller
                                                                              .text ? visitName.toString() : docNamecontroller.text,
                                                                          1,
                                                                          selectedEditChipsId);

                                                                      getVisit(context, 1,
                                                                          1, 10)
                                                                          .then((data) {
                                                                        _visitController
                                                                            .add(data);
                                                                      }).catchError(
                                                                              (error) {
                                                                            // Handle error
                                                                          });
                                                                      selectedEditChipsId.clear();
                                                                      selectedEditChips.clear();
                                                                      docNamecontroller
                                                                          .clear();
                                                                      _selectedItem =
                                                                      "Select";
                                                                    },
                                                                    child1: Wrap(
                                                                        spacing: 8.0,
                                                                        children: selectedEditChips),
                                                                    title: 'Edit Visit',
                                                                    child: FutureBuilder<
                                                                        List<
                                                                            HRClinical>>(
                                                                        future:
                                                                        companyAllHrClinicApi(
                                                                            context),
                                                                        builder: (context,
                                                                            snapshot) {
                                                                          if (snapshot
                                                                              .connectionState ==
                                                                              ConnectionState
                                                                                  .waiting) {
                                                                            return Shimmer
                                                                                .fromColors(
                                                                                baseColor:
                                                                                Colors.grey[
                                                                                300]!,
                                                                                highlightColor:
                                                                                Colors.grey[
                                                                                100]!,
                                                                                child:
                                                                                Container(
                                                                                  width:
                                                                                  354,
                                                                                  height:
                                                                                  30,
                                                                                  decoration: BoxDecoration(
                                                                                      color: ColorManager.faintGrey,
                                                                                      borderRadius: BorderRadius.circular(10)),
                                                                                ));
                                                                          }
                                                                          if (snapshot.data!
                                                                              .isEmpty) {
                                                                            return Center(
                                                                              child: Text(
                                                                                AppString
                                                                                    .dataNotFound,
                                                                                style: CustomTextStylesCommon
                                                                                    .commonStyle(
                                                                                  fontWeight:
                                                                                  FontWeightManager
                                                                                      .medium,
                                                                                  fontSize:
                                                                                  FontSize
                                                                                      .s12,
                                                                                  color: ColorManager
                                                                                      .mediumgrey,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            int docType = 0;
                                                                            List<
                                                                                DropdownMenuItem<
                                                                                    String>>
                                                                            dropDownTypesList =
                                                                            [];
                                                                            for (var i
                                                                            in snapshot
                                                                                .data!) {
                                                                              dropDownTypesList
                                                                                  .add(
                                                                                DropdownMenuItem<
                                                                                    String>(
                                                                                  child: Text(
                                                                                      i.abbrivation!),
                                                                                  value: i
                                                                                      .abbrivation,
                                                                                ),
                                                                              );
                                                                            }
                                                                            return CICCDropdown(
                                                                                initialValue:
                                                                                dropDownTypesList[0]
                                                                                    .value,
                                                                                onChange:
                                                                                    (val) {
                                                                                  for (var a
                                                                                  in snapshot
                                                                                      .data!) {
                                                                                    if (a.abbrivation ==
                                                                                        val) {
                                                                                      docType =
                                                                                          a.employeeTypesId;
                                                                                      empTypeId =
                                                                                          docType;
                                                                                      setState(
                                                                                              () {
                                                                                            if (val.isNotEmpty) {
                                                                                              selectedEditChips.add(Chip(
                                                                                                shape: StadiumBorder(
                                                                                                    side: BorderSide(
                                                                                                        color: ColorManager.blueprime)),
                                                                                                //side: BorderSide(color: ColorManager.blueprime),
                                                                                                deleteIcon: Icon(
                                                                                                  Icons.close,
                                                                                                  color: ColorManager.blueprime,
                                                                                                  size: 17,
                                                                                                ),
                                                                                                label: Text(
                                                                                                  val,
                                                                                                  style: CustomTextStylesCommon.commonStyle(
                                                                                                      fontWeight: FontWeightManager.medium,
                                                                                                      fontSize: FontSize.s10,
                                                                                                      color: ColorManager.mediumgrey),
                                                                                                ),

                                                                                                onDeleted: () {
                                                                                                  setState(() {
                                                                                                   // deleteChip(val,docType);
                                                                                                    selectedEditChips.clear();
                                                                                                    selectedEditChipsId.clear();
                                                                                                    print(":::Chips name ${selectedChips}");
                                                                                                    print(":::: Chips Id ${selectedChipsId}");
                                                                                                  });
                                                                                                },
                                                                                              ),);
                                                                                              //addChip(val.trim(),docType);
                                                                                              selectedEditChipsId.add(docType);
                                                                                              print("chipsID:::${selectedChipsId}");

                                                                                            }
                                                                                          });
                                                                                    }
                                                                                  }
                                                                                  print(
                                                                                      ":::${docType}");
                                                                                  print(
                                                                                      ":::<>${empTypeId}");
                                                                                },
                                                                                items:
                                                                                dropDownTypesList);
                                                                          }
                                                                          return SizedBox();
                                                                        }),
                                                                  );
                                                                },

                                                              );
                                                            }
                                                          );

                                                    });
                                              },
                                              icon: Icon(
                                                Icons.edit_outlined,
                                                size: 20,
                                                color: ColorManager.bluebottom,
                                              )),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              showDialog(context: context,
                                                  builder: (context) => StatefulBuilder(
                                                    builder: (BuildContext context, void Function(void Function()) setState) {
                                                      return  DeletePopup(
                                                          loadingDuration: _isLoading,
                                                          onCancel: (){
                                                            Navigator.pop(context);
                                                          }, onDelete: () async{
                                                        setState(() {
                                                          _isLoading = true;
                                                        });
                                                        try {
                                                          await deleteVisitPatch(context,
                                                              snapshot.data![index].visitId);
                                                          setState(() async {
                                                            await getVisit(context, 1, 1, 20)
                                                                .then((data) {
                                                              _visitController.add(data);
                                                            }).catchError((error) {
                                                              // Handle error
                                                            });
                                                            Navigator.pop(context);
                                                          });
                                                        } finally {
                                                          setState(() {
                                                            _isLoading = false;
                                                          });
                                                        }

                                                      });
                                                    },

                                                  ));

                                              //
                                            },
                                            icon: Icon(
                                                Icons.delete_outline_outlined,
                                                size: 20,
                                                color: Color(0xffF6928A)),
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
                    });
              }
              return Offstage();
            }),
      ),
      //       PaginationControlsWidget(
    ]);
  }
}
