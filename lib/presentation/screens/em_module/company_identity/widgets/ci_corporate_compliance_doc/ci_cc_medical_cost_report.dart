import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import '../../../../../../data/api_data/establishment_data/company_identity/ci_org_document.dart';
import '../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';

class CICCMedicalCR extends StatefulWidget {
  const CICCMedicalCR({super.key});

  @override
  State<CICCMedicalCR> createState() => _CICCMedicalCRState();
}

class _CICCMedicalCRState extends State<CICCMedicalCR> {
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 6;
    items = List.generate(60, (index) => 'Item ${index + 1}');
    orgDocumentGet(context, 1, 1, 1, 2, 3);
  }

  @override
  Widget build(BuildContext context) {
    List<String> currentPageItems = items.sublist(
      (currentPage - 1) * itemsPerPage,
      min(currentPage * itemsPerPage, items.length),
    );
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
        CustomIconButtonConst(
            icon: Icons.add,
            text: "Add Doctype", onPressed: (){
          showDialog(context: context, builder: (context){
            return CCScreensAddPopup(
              countynameController: docNamecontroller,
              zipcodeController: docIdController,
              onSavePressed: () {  },
              child:  CICCDropdown(
                initialValue: 'Corporate & Compliance Documents',
                items: [
                  DropdownMenuItem(value: 'Corporate & Compliance Documents', child: Text('Corporate & Compliance Documents')),
                  DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                  DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                  DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                ],),
              child1:  CICCDropdown(
                initialValue: 'Medical Cost Reports',
                items: [
                  DropdownMenuItem(value: 'Medical Cost Reports', child: Text('Medical Cost Reports')),
                  DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                  DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                  DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                ],),);
          });
        }),
        SizedBox(height: 5,),
        Expanded(
          child:
          FutureBuilder<List<CiOrgDocumentCC>>(
              future: orgDocumentGet(context, 1, 1, 1, 2, 3),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.blueprime,
                    ),
                  );
                }
                if(snapshot.hasData){
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // int serialNumber =
                        //     index + 1 + (currentPage - 1) * itemsPerPage;
                        // String formattedSerialNumber =
                        // serialNumber.toString().padLeft(2, '0');
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff000000).withOpacity(0.25),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                              },
                                              child: Image.asset(
                                                'images/eye.png',
                                                height: 15,
                                                width: 22,
                                              ),
                                            ),
                                            //IconButton(onPressed: (){}, icon: Icon(Icons.remove_red_eye_outlined,size:20,color: ColorManager.blueprime,)),
                                            SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  snapshot.data![index].createdAt.toString(),textAlign:TextAlign.center,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff686464),
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data![index].name.toString(),textAlign:TextAlign.center,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff686464),
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            IconButton(onPressed: (){}, icon: Icon(Icons.history,size:18,color: ColorManager.bluebottom,)),
                                            IconButton(onPressed: (){}, icon: Icon(Icons.print_outlined,size:18,color: ColorManager.bluebottom,)),
                                            IconButton(onPressed: (){}, icon: Icon(Icons.file_download_outlined,size:18,color: ColorManager.bluebottom,)),
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
                                            }, icon: Icon(Icons.edit_outlined,size:18,color: ColorManager.bluebottom,)),
                                            IconButton(onPressed: (){
                                              showDialog(context: context, builder: (context) => DeletePopup(onCancel: (){
                                                Navigator.pop(context);
                                              }, onDelete: (){}));
                                            }, icon: Icon(Icons.delete_outline,size:18,color: ColorManager.red,)),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        );
                      });
                }
                return Offstage();
              }
          ),
        ),
        SizedBox(
          height: 10,
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
      ],),
    );
  }
}
