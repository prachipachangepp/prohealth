import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/employee_doc_repository.dart';
import 'package:prohealth/app/services/api_sm/company_identity/add_doc_company_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/data/api_data/establishment_data/employee_doc/employee_doc_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/emp_doc_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/pagination_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';


class HealthEmpDoc extends StatefulWidget {
  final metaDocID;
  const HealthEmpDoc({super.key, required this.metaDocID});

  @override
  State<HealthEmpDoc> createState() => _HealthEmpDocState();
}

class _HealthEmpDocState extends State<HealthEmpDoc> {
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();

  final StreamController<List<EmployeeDocumentModal>> _controller = StreamController<List<EmployeeDocumentModal>>();
  TextEditingController idDocController = TextEditingController();
  TextEditingController nameDocController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    idDocController.dispose();
    nameDocController.dispose();
    dateController.dispose();
    super.dispose();
  }
  String? selectedValue;
  late List<Color> hrcontainerColors;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 6;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    hrcontainerColors = List.generate(20, (index) => Color(0xffE8A87D));
    // orgSubDocumentGet(context, 1, 1, 1, 2, 3).then((data) {
    //   _controller.add(data);
    // }).catchError((error) {
    //   // Handle error
    // });
    getEmployeeDoc(context, widget.metaDocID,1,10).then((data) {
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
  String? expiryType;
  int docMetaId = 0;
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
                Text(
                    AppString.srNo,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white
                    )
                  // style: RegisterTableHead.customTextStyle(context),
                ),
                Text(
                    AppString.name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white
                    )
                  // style: RegisterTableHead.customTextStyle(context),
                ),
                Text(
                    AppString.expiry,
                    style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white
                    )
                  // style: RegisterTableHead.customTextStyle(context),
                ),
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
            child: StreamBuilder<List<EmployeeDocumentModal>>(
                stream: _controller.stream,
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
                                        formattedSerialNumber,
                                        // snapshot.data![index].name.toString(),
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
                                        snapshot.data![index].docName,
                                        style: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff686464)
                                          // color: isSelected ? Colors.white : Colors.black,
                                        ),
                                      )),
                                  Center(
                                      child: Text(
                                        snapshot.data![index].expiry,
                                        style: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff686464)
                                          // color: isSelected ? Colors.white : Colors.black,
                                        ),
                                      )),
                                  Center(
                                      child: Text(
                                        snapshot.data![index].reminderThreshold,
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
                                            return EmpDocEditPopup(
                                              expiryType: expiryType,
                                              idDocController: idDocController,
                                              nameDocController: docNamecontroller,
                                              calenderController: dateController,
                                              onSavePredded: () async{
                                                await editEmployeeDocTypeSetupId(context,
                                                      docNamecontroller.text,
                                                      expiryType.toString(),
                                                      dateController.text,
                                                      snapshot.data![index].employeeDocTypesetupId!,
                                                      docMetaId,
                                                    );
                                                // await addEmployeeDocSetup(context,
                                                //     docMetaId,
                                                //     nameDocController.text,
                                                //     expiryType.toString(),
                                                //     dateController.text);
                                                Navigator.pop(context);
                                                nameDocController.clear();
                                                dateController.clear();
                                              },
                                              radioButton: StatefulBuilder(
                                                builder: (BuildContext context, void Function(void Function()) setState) {
                                                  return Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      CustomRadioListTile(
                                                        value: "Not Applicable",
                                                        groupValue: expiryType.toString(),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            expiryType = value!;
                                                          });
                                                        },
                                                        title: "Not Applicable",
                                                      ),
                                                      CustomRadioListTile(
                                                        value: 'Scheduled',
                                                        groupValue: expiryType.toString(),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            expiryType = value!;
                                                          });
                                                        },
                                                        title: 'Scheduled',
                                                      ),
                                                      CustomRadioListTile(
                                                        value: 'Issuer Expiry',
                                                        groupValue: expiryType.toString(),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            expiryType = value!;
                                                          });
                                                        },
                                                        title: 'Issuer Expiry',
                                                      ),
                                                    ],
                                                  );
                                                },

                                              ),
                                              child:  FutureBuilder<List<EmployeeDocTabModal>>(
                                                  future: getEmployeeDocTab(context),
                                                  builder: (context,snapshot) {
                                                    if(snapshot.connectionState == ConnectionState.waiting){
                                                      return Shimmer.fromColors(
                                                          baseColor: Colors.grey[300]!,
                                                          highlightColor: Colors.grey[100]!,
                                                          child: Container(
                                                            width: 350,
                                                            height: 30,
                                                            decoration: BoxDecoration( color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
                                                          )
                                                      );
                                                    }
                                                    if(snapshot.hasData){
                                                      List dropDown = [];
                                                      int docType = 0;
                                                      List<DropdownMenuItem<String>> dropDownMenuItems = [];
                                                      for(var i in snapshot.data!){
                                                        dropDownMenuItems.add(
                                                          DropdownMenuItem<String>(
                                                            child: Text(i.employeeDocType),
                                                            value: i.employeeDocType,
                                                          ),
                                                        );
                                                      }
                                                      return CICCDropdown(
                                                          initialValue: dropDownMenuItems[0].value,
                                                          onChange: (val){
                                                            for(var a in snapshot.data!){
                                                              if(a.employeeDocType == val){
                                                                docType = a.employeeDocMetaDataId;
                                                                docMetaId = docType;
                                                              }
                                                            }
                                                            print(":::${docType}");
                                                            print(":::<>${docMetaId}");
                                                          },
                                                          items:dropDownMenuItems
                                                        // dropDownMenuItems.map<DropdownMenuItem<String>>((value) {
                                                        //   return dropDownMenuItems;
                                                        // }).toList(),
                                                        // DropdownMenuItem(value: 'Health', child: Text('Health')),
                                                        // [
                                                        //   DropdownMenuItem(value: 'Health', child: Text('Health')),
                                                        //   DropdownMenuItem(value: 'Certification', child: Text('Certification')),
                                                        //   DropdownMenuItem(value: 'Employment', child: Text('Employment')),
                                                        //   DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                                                        // ],
                                                      );
                                                    }else{
                                                      return SizedBox();
                                                    }
                                                  }
                                              ),);
                                              });
                                             },
                                                icon: Icon(
                                                Icons.edit_outlined,
                                                size: 18,
                                                color: ColorManager.bluebottom,)),
                                        SizedBox(width: 3,),
                                        IconButton(
                                          onPressed: () async {
                                          await showDialog(context: context,
                                                builder: (context) => DeletePopup(
                                                    onCancel: (){
                                                  Navigator.pop(context);
                                                }, onDelete: (){
                                                  setState(() async{
                                                    await employeedoctypeSetupIdDelete(
                                                        context,
                                                        snapshot.data![index].employeeDocTypesetupId!);
                                                    getEmployeeDoc(context, widget.metaDocID,1,10).then((data) {
                                                      _controller.add(data);
                                                    }).catchError((error) {
                                                      // Handle error
                                                    });
                                                    Navigator.pop(context);
                                                  });
                                                }));
                                          },
                                          icon: Icon(
                                            size: 18,
                                            Icons.delete_outline_outlined,
                                            color: Color(0xffF6928A),
                                          ),
                                        ),
                                        // InkWell(
                                        //   onTap:(){
                                        //
                                        //     setState(() async{
                                        //       await employeedoctypeSetupIdDelete(
                                        //           context,
                                        //           snapshot.data![index].employeeDocTypesetupId!);
                                        //           getEmployeeDoc(context, widget.metaDocID,1,10).then((data) {
                                        //           _controller.add(data);
                                        //       }).catchError((error) {
                                        //         // Handle error
                                        //       });
                                        //     });
                                        //
                                        //   },child: Icon(Icons.delete_outline_outlined,
                                        //   size:20,color: Color(0xffF6928A),
                                        //     )
                                        // ),
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
          // PaginationControlsWidget(
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
        ],
      ),
    );
  }
}
