import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final StreamController<List<CiVisit>> _visitController = StreamController<List<CiVisit>>();
  late List<Color> hrcontainerColors;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 6;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    hrcontainerColors = List.generate(20, (index) => Color(0xffE8A87D));
    _loadColors();
    getVisit(context).then((data) {
      _visitController.add(data);

    }).catchError((error) {
      // Handle error
    });
  }
//   @override
//   void dispose() {
//     docNameController.dispose();
//     docIdController.dispose();
//     _visitController.close();
//     super.dispose();
//   }
// }

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
  String _selectedItem = 'Option 1';
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
                        return AddVisitPopup(
                          nameOfDocumentController: docNamecontroller,
                          idOfDocumentController: docIdController,

                          onSavePressed: () async {
                            print(":::::${_selectedItem}");
                           await addVisitPost(context,
                               docNamecontroller.text,
                               _selectedItem
                            );
                           setState(() async {
                           await  getVisit(context).then((data) {
                               _visitController.add(data);
                             }).catchError((error) {
                               // Handle error
                             });
                           Navigator.pop(context);
                           });
                          },
                          child: CICCDropdown(
                            initialValue: _selectedItem,
                            onChange: _onDropdownItemSelected,
                            items: [
                              DropdownMenuItem(
                                  value: 'Select',
                                  child: Text('Policies & Procedures')),
                              DropdownMenuItem(
                                  value: 'HCO Number 254612',
                                  child: Text('HCO Number 254612')),
                              DropdownMenuItem(
                                  value: 'Medicare ID MPID123',
                                  child: Text('Medicare ID MPID123')),
                              DropdownMenuItem(
                                  value: 'NPI Number 1234567890',
                                  child: Text('NPI Number 1234567890')),
                            ],
                          ),
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
                                                snapshot.data![index].eligibleClinician.toString(),
                                            style: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
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
                                                snapshot.data![index].eligibleClinician.toString(),
                                            style: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
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
                                                    return AddVisitPopup(
                                                      nameOfDocumentController:
                                                          docNamecontroller,
                                                      idOfDocumentController:
                                                          docIdController,
                                                      onSavePressed: () {},
                                                      child: CICCDropdown(
                                                        initialValue: 'Select',
                                                        items: [
                                                          DropdownMenuItem(
                                                              value: 'Select',
                                                              child: Text(
                                                                  'Policies & Procedures')),
                                                          DropdownMenuItem(
                                                              value:
                                                                  'HCO Number      254612',
                                                              child: Text(
                                                                  'HCO Number  254612')),
                                                          DropdownMenuItem(
                                                              value:
                                                                  'Medicare ID      MPID123',
                                                              child: Text(
                                                                  'Medicare ID  MPID123')),
                                                          DropdownMenuItem(
                                                              value:
                                                                  'NPI Number     1234567890',
                                                              child: Text(
                                                                  'NPI Number 1234567890')),
                                                        ],
                                                      ),
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
                                        Icon(
                                          Icons.delete_outline_outlined,
                                          size: 20,
                                          color: Color(0xffF6928A),
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
      //   currentPage: currentPage,
      //   items: items,
      //   itemsPerPage: itemsPerPage,
      //   onPreviousPagePressed: () {
      //     /// Handle previous page button press
      //     setState(() {
      //       currentPage = currentPage > 1 ? currentPage - 1 : 1;
      //     });
      //   },
      //   onPageNumberPressed: (pageNumber) {
      //     /// Handle page number tap
      //     setState(() {
      //       currentPage = pageNumber;
      //     });
      //   },
      //   onNextPagePressed: () {
      //     /// Handle next page button press
      //     setState(() {
      //       currentPage = currentPage < (items.length / itemsPerPage).ceil()
      //           ? currentPage + 1
      //           : (items.length / itemsPerPage).ceil();
      //     });
      //   },
      // ),
          ]);
     }
}
