import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/app/services/api_sm/company_identity/add_doc_company_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/pagination_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ClinicalVerificationEmpDoc extends StatefulWidget {
  const ClinicalVerificationEmpDoc({super.key});

  @override
  State<ClinicalVerificationEmpDoc> createState() => _ClinicalVerificationEmpDocState();
}

class _ClinicalVerificationEmpDocState extends State<ClinicalVerificationEmpDoc> {
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  final StreamController<List<CiOrgDocumentCC>> _controller = StreamController<List<CiOrgDocumentCC>>();

  String? selectedValue;
  late List<Color> hrcontainerColors;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 6;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    hrcontainerColors = List.generate(20, (index) => Color(0xffE8A87D));
    orgSubDocumentGet(context, 1, 1, 1, 2, 3).then((data) {
      _controller.add(data);
    }).catchError((error) {
      // Handle error
    });
    _loadColors();
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: AppSize.s30,
            margin: EdgeInsets.symmetric(horizontal: 40),
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
                        style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.white
                        )
                      // style: RegisterTableHead.customTextStyle(context),
                    )),
                Center(
                    child: Text(
                        AppString.name,
                        style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.white
                        )
                      // style: RegisterTableHead.customTextStyle(context),
                    )),
                Center(
                    child: Text(
                        AppString.expiry,
                        style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.white
                        )
                      // style: RegisterTableHead.customTextStyle(context),
                    )),
                // Expanded(
                //     child: SizedBox(width: AppSize.s16,
                //     )),
                Center(
                    child: Text(
                        AppString.reminderthershold,
                        style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.white
                        )
                      // style: RegisterTableHead.customTextStyle(context),
                    )),
                // Center(child:
                // Text(AppString.eligibleClinician,style: RegisterTableHead.customTextStyle(context),),),
                Center(
                    child: Text(
                        AppString.actions,
                        style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.white
                        )
                      // style: RegisterTableHead.customTextStyle(context),
                    )),
              ],
            ),
          ),
          SizedBox(height: AppSize.s10,),
          Expanded(
            child: StreamBuilder<List<CiOrgDocumentCC>>(
                stream: _controller.stream,
                builder: (context, snapshot) {
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
                  if(snapshot.hasData){
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        int serialNumber =
                            index + 1 + (currentPage - 1) * itemsPerPage;
                        String formattedSerialNumber =
                        serialNumber.toString().padLeft(2, '0');
                        return Column(
                          children: [
                            SizedBox(height: AppSize.s5),
                            Container(
                              padding: EdgeInsets.only(bottom: AppPadding.p5),
                              margin: EdgeInsets.symmetric(horizontal: AppMargin.m50),
                              decoration: BoxDecoration(
                                color:ColorManager.white,
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
                                  Center(
                                      child: Text(
                                        snapshot.data![index].docId.toString(),
                                        style: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff686464)
                                          // color: isSelected ? Colors.white : Colors.black,
                                        ),
                                        textAlign: TextAlign.start,
                                      )),
                                  Center(
                                      child: Text(
                                        snapshot.data![index].name.toString(),
                                        style: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff686464)
                                          // color: isSelected ? Colors.white : Colors.black,
                                        ),
                                      )),
                                  Center(
                                      child: Text(
                                        snapshot.data![index].expiry.toString(),
                                        style: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff686464)
                                          // color: isSelected ? Colors.white : Colors.black,
                                        ),
                                      )),
                                  Center(
                                      child: Text(
                                        snapshot.data![index].reminderThreshold.toString(),
                                        style: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff686464)
                                          // color: isSelected ? Colors.white : Colors.black,
                                        ),
                                      )),
                                  Center(
                                    child: Row(
                                      children: [
                                        IconButton(onPressed: (){
                                          showDialog(context: context, builder: (context){
                                            return CCScreenEditPopup(
                                              idDocController: docIdController,
                                              nameDocController: docNamecontroller,
                                              onSavePressed: (){},
                                              child:  CICCDropdown(
                                                initialValue: 'Corporate & Compliance Documents',
                                                items: [
                                                  DropdownMenuItem(value: 'Corporate & Compliance Documents', child: Text('Corporate & Compliance Documents')),
                                                  DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                                                  DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                                                  DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                                                ],),
                                              child1:   CICCDropdown(
                                                initialValue: 'Licenses',
                                                items: [
                                                  DropdownMenuItem(value: 'Licenses', child: Text('Licenses')),
                                                  DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                                                  DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                                                  DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                                                ],),);
                                          });
                                        }, icon: Icon(Icons.edit_outlined,color: ColorManager.bluebottom,)),
                                        SizedBox(width: 3,),
                                        InkWell(
                                            onTap: (){
                                              setState(() async{
                                                await deleteDocument(
                                                    context,
                                                    snapshot.data![index].docId!);
                                                orgSubDocumentGet(context, 1, 1, 1, 2, 3).then((data) {
                                                  _controller.add(data);
                                                }).catchError((error) {
                                                  // Handle error
                                                });
                                              });
                                            },
                                            child: Icon(Icons.delete_outline_outlined, size:20,color: Color(0xffF6928A),)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return Offstage();
                }
            ),
          ),
          PaginationControlsWidget(
            currentPage: currentPage,
            items: items,
            itemsPerPage: itemsPerPage,
            onPreviousPagePressed: () {
              /// Handle previous page button press
              setState(() {
                currentPage = currentPage > 1 ? currentPage - 1 : 1;
              });
            },
            onPageNumberPressed: (pageNumber) {
              /// Handle page number tap
              setState(() {
                currentPage = pageNumber;
              });
            },
            onNextPagePressed: () {
              /// Handle next page button press
              setState(() {
                currentPage = currentPage < (items.length / itemsPerPage).ceil()
                    ? currentPage + 1
                    : (items.length / itemsPerPage).ceil();
              });
            },
          ),
        ],
      ),
    );
  }
}
