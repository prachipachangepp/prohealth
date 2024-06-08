import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../checkbox_constant.dart';

class CICCLicense extends StatefulWidget {
  const CICCLicense({super.key});

  @override
  State<CICCLicense> createState() => _CICCLicenseState();
}

class _CICCLicenseState extends State<CICCLicense> {
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
                initialValue: 'Licenses',
                items: [
                  DropdownMenuItem(value: 'Licenses', child: Text('Licenses')),
                  DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                  DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                  DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                ],),);
          });
        }),
        SizedBox(
          height: 5,
        ),
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
                                    IconButton(onPressed: (){}, icon: Icon(Icons.remove_red_eye_outlined,size:20,color: ColorManager.blueprime,)),
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
                                    IconButton(onPressed: (){}, icon: Icon(Icons.av_timer,color: ColorManager.bluebottom,)),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.print_outlined,color: ColorManager.bluebottom,)),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.file_download_outlined,color: ColorManager.bluebottom,)),
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
                                    }, icon: Icon(Icons.edit_outlined,color: ColorManager.bluebottom,)),                                    IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline,color: ColorManager.red,)),
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
        Container(
          height: 30,
          // color: Colors.black12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(6.39),
                  border: Border.all(
                    color: ColorManager.grey,
                    width: 0.79,
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.only(bottom: 1.5),
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      currentPage = currentPage > 1 ? currentPage - 1 : 1;
                    });
                  },
                  color: ColorManager.black,
                  iconSize: 20,
                ),
              ),
              SizedBox(width: 3),
              for (var i = 1; i <= (items.length / itemsPerPage).ceil(); i++)
                if (i == 1 ||
                    i == currentPage ||
                    i == (items.length / itemsPerPage).ceil())
                  InkWell(
                    onTap: () {
                      setState(() {
                        currentPage = i;
                      });
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      margin: EdgeInsets.only(left: 5, right: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: currentPage == i
                              ? ColorManager.blueprime
                              : ColorManager.grey,
                          width: currentPage == i ? 2.0 : 1.0,
                        ),
                        color: currentPage == i
                            ? ColorManager.blueprime
                            : Colors.transparent,
                        // border: Border.all(
                        //   color: currentPage == i
                        //       ? Colors.blue
                        //       : Colors.transparent,
                        // ),
                      ),
                      child: Text(
                        '$i',
                        style: TextStyle(
                          color: currentPage == i ? Colors.white : Colors.grey,
                          fontWeight: FontWeightManager.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                else if (i == currentPage - 1 || i == currentPage + 1)
                  Text(
                    '...',
                    style: TextStyle(
                      color: ColorManager.black,
                      fontWeight: FontWeightManager.bold,
                      fontSize: 12,
                    ),
                  ),
              Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.79,
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.only(bottom: 2),
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      currentPage =
                      currentPage < (items.length / itemsPerPage).ceil()
                          ? currentPage + 1
                          : (items.length / itemsPerPage).ceil();
                    });
                  },
                  color: ColorManager.black,
                  iconSize: 20,
                ),
              ),
            ],
          ),
        )
      ],),
    );
  }
}
