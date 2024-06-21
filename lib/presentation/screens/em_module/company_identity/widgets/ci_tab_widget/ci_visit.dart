import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_visit_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_visit_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/visit_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final StreamController<List<CiVisit>> _visitController = StreamController<List<CiVisit>>();
  late List<Color> hrcontainerColors;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 10;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    hrcontainerColors = List.generate(20, (index) => Color(0xffE8A87D));
    _loadColors();
    getVisit(context,1,15).then((data) {
      _visitController.add(data);

    }).catchError((error) {
      // Handle error
    });
  }
  List<String> selectedChips = [];
  String chips="";

  void addChip(String chip) {
    setState(() {
      selectedChips.add(chip);
      eligibleClinicalController.clear();
      //chips = selectedChips;
    });
  }

  void deleteChip(String chip) {
    setState(() {
      selectedChips.remove(chip);
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
                          builder: (BuildContext context, void Function(void Function()) setState) {
                            return  AddVisitPopup(
                              nameOfDocumentController: docNamecontroller,
                              idOfDocumentController: docIdController,
                              onSavePressed: () async {
                                print(":::::${_selectedItem}");
                                await addVisitPost(context,
                                    docNamecontroller.text,
                                    [_selectedItem]
                                );
                                getVisit(context,1,15).then((data) {
                                  _visitController.add(data);
                                }).catchError((error) {
                                  // Handle error
                                });
                                Navigator.pop(context);

                              },
                              child1:  Wrap(
                                  spacing: 8.0,
                                  children:[
                                    // List.generate(selectedChips.length, (index){
                                    for(String chip in selectedChips)
                                      Chip(
                                        shape:StadiumBorder(side:BorderSide(color: ColorManager.blueprime) ),
                                        //side: BorderSide(color: ColorManager.blueprime),
                                        deleteIcon: Icon(Icons.close,color: ColorManager.blueprime,size: 17,),
                                        label: Text(chip,style: CustomTextStylesCommon.commonStyle(
                                            fontWeight: FontWeightManager.medium,
                                            fontSize: FontSize.s10,
                                            color: ColorManager.mediumgrey
                                        ),),
                                        onDeleted: () {
                                          setState(() {
                                            deleteChip(chip);
                                          });

                                        },
                                      ),
                                  ]
                                // })
                                //for (String chip in selectedChips)
                                //print(":::CHIPS FOR${chip}"),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 354,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xFFB1B1B1), width: 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child:TextField(
                                      controller: eligibleClinicalController,
                                      keyboardType: TextInputType.text,
                                      cursorHeight: 17,
                                      cursorColor: Colors.black,
                                      style: CustomTextStylesCommon.commonStyle(
                                          fontWeight: FontWeightManager.medium,
                                          fontSize: FontSize.s12,
                                          color: ColorManager.mediumgrey
                                      ),
                                      onSubmitted: (value) {
                                        setState(() {
                                          if (value.isNotEmpty) {
                                            addChip(value.trim());
                                          }
                                        });

                                        print(":::CHIPS${selectedChips}");
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Enter text to add as chip',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(bottom: AppPadding.p18,left: AppPadding.p15),
                                          suffixIcon: Icon(Icons.add,color:ColorManager.blueprime,size: 18,)
                                      ),
                                    ),
                                  ),
                                  //SizedBox(height: 10.0),

                                ],
                              ),
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
            Center(
                child: Text(
              AppString.srNo,
              // style: RegisterTableHead.customTextStyle(context),
              style: GoogleFonts.firaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.white
                  // color: isSelected ? Colors.white : Colors.black,
                  ),
            )),
           ///visit
            Center(
                child: Text(
              AppString.visit,
              style: GoogleFonts.firaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.white
                  // color: isSelected ? Colors.white : Colors.black,
                  ),
              // style: RegisterTableHead.customTextStyle(context),
            )),
            ///EL clinician
            Center(
              child: Text(
                AppString.eligibleClinician,
                style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.white
                    // color: isSelected ? Colors.white : Colors.black,
                    ),
              ),
            ),
            // style: RegisterTableHead.customTextStyle(context),),),
            Center(
                child: Text(
              AppString.actions,
              style: GoogleFonts.firaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.white
                  // color: isSelected ? Colors.white : Colors.black,
                  ),
              // style: RegisterTableHead.customTextStyle(context),
            )),
          ],
        ),
      ),
      SizedBox(
        height: AppSize.s10,
      ),
      Expanded(
          child: StreamBuilder<List<CiVisit>>(
              stream:  _visitController.stream,
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
                  List<CiVisit> currentPageItems =
                      snapshot.data!.sublist(
                    (currentPage - 1) * itemsPerPage,
                    (currentPage * itemsPerPage) > totalItems
                        ? totalItems
                        : (currentPage * itemsPerPage),
                  );

                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: currentPageItems.length,
                      itemBuilder: (context, index) {
                        List<List?> listData = [];
                        for(var i in snapshot.data!){
                          listData.add([snapshot.data![index].eligibleClinician!]);
                        }
                        int serialNumber =
                            index + 1 + (currentPage - 1) * itemsPerPage;
                        String formattedSerialNumber =
                            serialNumber.toString().padLeft(2, '0');
                        return Column(children: [
                          SizedBox(height: AppSize.s5),
                          Container(
                              padding: EdgeInsets.only(bottom: AppPadding.p5),
                              margin: EdgeInsets.symmetric(
                                  horizontal: AppMargin.m50),
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
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Center(
                                      child: Text(
                                    formattedSerialNumber,
                                    style: GoogleFonts.firaSans(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff686464)
                                        // color: isSelected ? Colors.white : Colors.black,
                                        ),
                                    // style: ThemeManagerDark.customTextStyle(context),
                                    textAlign: TextAlign.start,
                                  )),
                                  Center(
                                      child: Text(
                                        snapshot.data![index].typeofVisit.toString(),
                                    style: GoogleFonts.firaSans(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff686464)
                                        // color: isSelected ? Colors.white : Colors.black,
                                        ),
                                    // style: ThemeManagerDark.customTextStyle(context),
                                  )),
                                  Center(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 30,
                                          color: Color(0xffF37F81),
                                          child: Center(
                                              child: Text(
                                                //'HO',
                                                snapshot.data![index].eligibleClinician![0].eligibleClinician,
                                               // listData.first.toString().substring(1,3),
                                            style: GoogleFonts.firaSans(
                                                fontSize: 9,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff686464)
                                                // color: isSelected ? Colors.white : Colors.black,
                                                ),
                                          )),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          color: Color(0xfFE7E8E6),
                                          child: Center(
                                              child: Text(
                                                "PT",
                                           // snapshot.data![index].eligibleClinician![index] == 0 ? "" :"2",
                                            style: GoogleFonts.firaSans(
                                                fontSize: 9,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff686464)
                                                // color: isSelected ? Colors.white : Colors.black,
                                                ),
                                          )),
                                        )
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return StatefulBuilder(
                                                      builder: (BuildContext context, void Function(void Function()) setState) {
                                                        return AddVisitPopup(
                                                          nameOfDocumentController: docNamecontroller,
                                                          idOfDocumentController:
                                                          docIdController,
                                                          onSavePressed: () async{
                                                            await updateVisitPatch(context,
                                                                snapshot.data![index].typeofVisit,
                                                                docNamecontroller.text,[_selectedItem]);
                                                            getVisit(context,1,10).then((data) {
                                                              _visitController.add(data);

                                                            }).catchError((error) {
                                                              // Handle error
                                                            });
                                                            docNamecontroller.clear();
                                                            _selectedItem="Select";
                                                          },
                                                          child1:  Wrap(
                                                            spacing: 8.0,
                                                            children: [
                                                              for(String chip in selectedChips)
                                                               Chip(
                                                                 shape:StadiumBorder(side:BorderSide(color: ColorManager.blueprime) ),
                                                                 //side: BorderSide(color: ColorManager.blueprime),
                                                                 deleteIcon: Icon(Icons.close,color: ColorManager.blueprime,size: 17,),
                                                                 label: Text(chip,style: CustomTextStylesCommon.commonStyle(
                                                                     fontWeight: FontWeightManager.medium,
                                                                     fontSize: FontSize.s10,
                                                                     color: ColorManager.mediumgrey
                                                                 ),),
                                                                onDeleted: () {
                                                                  setState(() {
                                                                    deleteChip(chip);
                                                                  });
                                                                },
                                                              ),
                                                            ]
                                                          ),
                                                          child:  Column(
                                                            children: [
                                                              Container(
                                                                width: 354,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(color: Color(0xFFB1B1B1), width: 1),
                                                                  borderRadius: BorderRadius.circular(8),
                                                                ),
                                                                child:TextField(
                                                                  controller: eligibleClinicalController,
                                                                  keyboardType: TextInputType.text,
                                                                  cursorHeight: 17,
                                                                  cursorColor: Colors.black,
                                                                  style: CustomTextStylesCommon.commonStyle(
                                                                      fontWeight: FontWeightManager.medium,
                                                                      fontSize: FontSize.s12,
                                                                      color: ColorManager.mediumgrey
                                                                  ),
                                                                  onSubmitted: (value) {
                                                                    setState(() {
                                                                      if (value.isNotEmpty) {
                                                                        addChip(value.trim());
                                                                      }
                                                                    });

                                                                    print(":::CHIPS${selectedChips}");
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    hintText: 'Enter text to add as chip',
                                                                    border: InputBorder.none,
                                                                    contentPadding: EdgeInsets.only(bottom: AppPadding.p18,left: AppPadding.p15),
                                                                    suffixIcon: InkWell(
                                                                      onTap: selectedChips.isEmpty ? null :(){
                                                                        setState((){
                                                                          if (eligibleClinicalController.toString().isNotEmpty) {
                                                                            addChip(eligibleClinicalController.toString().trim());
                                                                            eligibleClinicalController.clear();
                                                                          }
                                                                        });
                                                                      },
                                                                        child: selectedChips.isEmpty ? Text("") :Icon(Icons.add,color:ColorManager.blueprime,size: 18,))
                                                                  ),
                                                                ),
                                                              ),
                                                              //SizedBox(height: 10.0),

                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  });
                                            },
                                            icon: Icon(
                                              Icons.edit_outlined,
                                              color: ColorManager.bluebottom,
                                            )),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        IconButton(
                                          onPressed: () async{
                                            await deleteVisitPatch(context, snapshot.data![index].visitId!);
                                            getVisit(context,1,10).then((data) {
                                              _visitController.add(data);
                                            }).catchError((error) {
                                              // Handle error
                                            });
                                          },
                                          icon: Icon( Icons.delete_outline_outlined,size: 20, color: Color(0xffF6928A)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ))
                        ]);
                      });
                   }
                  return Offstage();
                 }
              ),
             ),
           //       PaginationControlsWidget(
          ]);
     }
}
