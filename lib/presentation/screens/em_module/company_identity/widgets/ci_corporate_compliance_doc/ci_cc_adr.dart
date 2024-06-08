import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';

class CICCADR extends StatefulWidget {
  const CICCADR({super.key});

  @override
  State<CICCADR> createState() => _CICCADRState();
}

class _CICCADRState extends State<CICCADR> {
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
                initialValue: 'ADR',
                items: [
                  DropdownMenuItem(value: 'ADR', child: Text('ADR')),
                  DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                  DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                  DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                ],),);
          });
        }),
        SizedBox(height: 5,),
        Expanded(
          child:
          ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: currentPageItems.length,
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
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "ID:248d1eb1-9020-4d8d-8168-43a3ef90a261",textAlign:TextAlign.center,
                                          style: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff686464),
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                        Text(
                                          "NanDoc",textAlign:TextAlign.center,
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
                                            initialValue: 'ADR',
                                            items: [
                                              DropdownMenuItem(value: 'ADR', child: Text('Licenses')),
                                              DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                                              DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                                              DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                                            ],),);
                                      });
                                    }, icon: Icon(Icons.edit_outlined,size:18,color: ColorManager.bluebottom,)),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline,size:18,color: ColorManager.red,)),
                                  ],
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                );
              }),
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
