import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/app/services/api_sm/company_identity/add_doc_company_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';

import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'widgets/contract_add_dialog.dart';

class CiInsuranceContract extends StatefulWidget {
  const CiInsuranceContract({super.key});

  @override
  State<CiInsuranceContract> createState() => _CiInsuranceContractState();
}

class _CiInsuranceContractState extends State<CiInsuranceContract> {
  TextEditingController contractNameController = TextEditingController();
  TextEditingController contractIdController = TextEditingController();
  final StreamController<List<CiOrgDocumentCC>> _controller = StreamController<List<CiOrgDocumentCC>>();

  late CompanyIdentityManager _companyManager;
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 5;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    orgDocumentGet(context, 1, 1, 1, 2, 3).then((data) {
      _controller.add(data);
    }).catchError((error) {
      // Handle error
    });
    //_companyManager = CompanyIdentityManager();
    // companyAllApi(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //       height: 30,
          //       width: 354,
          //       // margin: EdgeInsets.symmetric(horizontal: 20),
          //       padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         border: Border.all(
          //             color: Color(0xff686464).withOpacity(0.5),
          //             width: 1), // Black border
          //         borderRadius: BorderRadius.circular(8), // Rounded corners
          //       ),
          //       child: DropdownButtonFormField<String>(
          //         focusColor: Colors.transparent,
          //         icon: Icon(
          //           Icons.arrow_drop_down_sharp,
          //           color: Color(0xff686464),
          //         ),
          //         decoration: InputDecoration.collapsed(hintText: ''),
          //         items: <String>[
          //           'Sample Vendor',
          //           'Option 1',
          //           'Option 2',
          //           'Option 3',
          //           'Option 4'
          //         ].map<DropdownMenuItem<String>>((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Text(value),
          //           );
          //         }).toList(),
          //         onChanged: (String? newValue) {},
          //         value: 'Sample Vendor',
          //         style: GoogleFonts.firaSans(
          //           fontSize: 12,
          //           fontWeight: FontWeight.w600,
          //           color: Color(0xff686464),
          //           decoration: TextDecoration.none,
          //         ),
          //       ),
          //     ),
          //     CustomIconButtonConst(
          //         icon: Icons.add,
          //         text: "Add Doctype",
          //         onPressed: () {
          //           showDialog(
          //               context: context,
          //               builder: (BuildContext context) {
          //                 return ContractAddDialog(
          //                   contractNmaeController: contractNameController,
          //                   onSubmitPressed: () {},
          //                   contractIdController: contractIdController,
          //
          //                 );
          //               });
          //         }),
          //   ],
          // ),
          Expanded(
            child: StreamBuilder<List<CiOrgDocumentCC>>(
              stream: _controller.stream,
              builder: (context,snapshot) {
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
                        // int serialNumber =
                        //     index + 1 + (currentPage - 1) * itemsPerPage;
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
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: InkWell(
                                                onTap: () {
                                                },
                                                child: Image.asset(
                                                  'images/eye.png',
                                                  height: 15,
                                                  width: 22,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  snapshot.data![index].createdAt.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff686464),
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data![index].name.toString(),
                                                  textAlign: TextAlign.center,
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

                                        //  Text(''),
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.history,
                                                  size:18,
                                                  color: ColorManager.blueprime,
                                                )),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.print_outlined,
                                                  size:18,
                                                  color: ColorManager.blueprime,
                                                )),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.file_download_outlined,
                                                  size:18,
                                                  color: ColorManager.blueprime,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  // showDialog(context: context, builder: (BuildContext context){
                                                  //   return ContractAddDialog(contractNmaeController: contractNameController, onPressed: () {  }, contractIdController: contractIdController,);
                                                  // });
                                                },
                                                icon: Icon(
                                                  Icons.edit_outlined,
                                                  size:18,
                                                  color: ColorManager.blueprime,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  showDialog(context: context, builder: (context) => DeletePopup(onCancel: (){
                                                    Navigator.pop(context);
                                                  }, onDelete: (){setState(() async{
                                                    await deleteDocument(
                                                        context,
                                                        snapshot.data![index].docId!);
                                                    orgDocumentGet(context, 1, 1, 1, 2, 3).then((data) {
                                                      _controller.add(data);
                                                    }).catchError((error) {
                                                      // Handle error
                                                    });
                                                  });}));

                                                },
                                                icon: Icon(
                                                  Icons.delete_outline,
                                                  size:18,
                                                  color: ColorManager.red,
                                                )),
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
        ],
      ),
    );
  }
}
