import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/manage_insurance_manager/insurance_vendor_contract_manager.dart';
import '../../../../../../data/api_data/establishment_data/ci_manage_button/manage_insurance_data.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'widgets/contract_add_dialog.dart';

class CiInsuranceContract extends StatefulWidget {
  final int insuranceVendorId;
  // final int subDocID;
  // final int companyID;
  final String officeId;

  const CiInsuranceContract({
    super.key,
    required this.insuranceVendorId,
    //required this.subDocID,
    // required this.companyID,
    required this.officeId,
  });

  @override
  State<CiInsuranceContract> createState() => _CiInsuranceContractState();
}

class _CiInsuranceContractState extends State<CiInsuranceContract> {
  TextEditingController contractNameController = TextEditingController();
  TextEditingController contractIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  final StreamController<List<ManageInsuranceContractData>> _controller =
      StreamController<List<ManageInsuranceContractData>>();

  int currentPage = 1;
  final int itemsPerPage = 10;
  String? expiryType;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    //_fetchContracts();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ManageInsuranceContractData>>(
              stream: _controller.stream,
              builder: (context, snapshot) {
                companyContractGetByVendorId(
                  context,
                  widget.officeId,
                  widget.insuranceVendorId,
                  currentPage,
                  itemsPerPage,
                ).then((data) {
                  _controller.add(data);
                }).catchError((error) {
                  // Handle error
                  //_controller.addError(error);
                });
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.blueprime,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Failed to load data',
                      style: CustomTextStylesCommon.commonStyle(
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSize.s12,
                        color: ColorManager.red,
                      ),
                    ),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      ErrorMessageString.noContract,
                      style: CustomTextStylesCommon.commonStyle(
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSize.s12,
                        color: ColorManager.mediumgrey,
                      ),
                    ),
                  );
                }
                if(snapshot.hasData){
                  int totalItems = snapshot.data!.length;
                  int totalPages = (totalItems / itemsPerPage).ceil();
                  List<ManageInsuranceContractData> paginatedData = snapshot.data!
                      .skip((currentPage - 1) * itemsPerPage)
                      .take(itemsPerPage)
                      .toList();

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: paginatedData.length,
                          itemBuilder: (context, index) {
                            int serialNumber =
                                index + 1 + (currentPage - 1) * itemsPerPage;
                            String formattedSerialNumber =
                            serialNumber.toString().padLeft(2, '0');
                            ManageInsuranceContractData contract =
                            paginatedData[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                          Color(0xff000000).withOpacity(0.25),
                                          spreadRadius: 0,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: InkWell(
                                                  onTap: () {
                                                    // Implement the view action
                                                  },
                                                  child: Image.asset(
                                                    'images/eye.png',
                                                    height: 15,
                                                    width: 22,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                   "ID: ${contract.contractId}",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.firaSans(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w400,
                                                      color: Color(0xff686464),
                                                      decoration:
                                                      TextDecoration.none,
                                                    ),
                                                  ),
                                                  SizedBox(height: AppSize.s5,),
                                                  Text(
                                                    contract.contractName
                                                        .toString()
                                                        .capitalizeFirst!,
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.firaSans(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xff686464),
                                                      decoration:
                                                      TextDecoration.none,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              // IconButton(
                                              //   splashColor: Colors.transparent,
                                              //   highlightColor: Colors.transparent,
                                              //   hoverColor: Colors.transparent,onPressed: () {  }, icon: Icon(
                                              //   Icons.save_alt_outlined,
                                              //   size: 18,
                                              //   color:
                                              //   ColorManager.blueprime,
                                              // ),),
                                         ///////////////////////////////
                                              // IconButton(
                                              //   onPressed: () {
                                              //     String? selectedExpiryType =
                                              //         expiryType;
                                              //     showDialog(
                                              //       context: context,
                                              //       builder:
                                              //           (BuildContext context) {
                                              //         return FutureBuilder<ManageContractPrefill>(
                                              //             future: getPrefillContract(context, snapshot.data![index].insuranceVendorContracId),
                                              //             builder: (context, snapshotPrefill) {
                                              //               if (snapshotPrefill.connectionState == ConnectionState.waiting) {
                                              //                 return Center(
                                              //                   child:
                                              //                   CircularProgressIndicator(
                                              //                     color: ColorManager
                                              //                         .blueprime,
                                              //                   ),
                                              //                 );
                                              //               }
                                              //               var contractPrefName = snapshotPrefill.data!.contractName;
                                              //               contractNameController = TextEditingController(text: snapshotPrefill.data!                                                                 .contractName);
                                              //
                                              //               var contractIDPrefName = snapshotPrefill.data!.contractId;
                                              //               contractIdController = TextEditingController(text: snapshotPrefill.data!.contractId);
                                              //
                                              //               var contractPrefexpiryDate = snapshotPrefill.data!.expiryDate;
                                              //               calenderController = TextEditingController(text: snapshotPrefill.data!.expiryDate);
                                              //
                                              //               var contractPrefexpiryType = snapshotPrefill.data!.expiryType;
                                              //               expiryType = snapshotPrefill.data!.expiryType;
                                              //
                                              //               return StatefulBuilder(
                                              //                 builder: (BuildContext
                                              //                 context,
                                              //                     void Function(
                                              //                         void Function())
                                              //                     setState) {
                                              //                   // return ContractAddDialog(
                                              //                   //   title:
                                              //                   //   'Edit Contract',
                                              //                   //   contractNmaeController: contractNameController,
                                              //                   //   contractIdController: contractIdController,
                                              //                   //   onSubmitPressed:
                                              //                   //   () async{
                                              //                   //   setState(() {
                                              //                   //     _isLoading = true;
                                              //                   //   });
                                              //                   //   try {
                                              //                   //     //final updatedName = nameController.text.isNotEmpty ? nameController.text : vendorData.vendorName;
                                              //                   //   setState(() async {
                                              //                   //     print('Contract vendor Id ${snapshot
                                              //                   //         .data![
                                              //                   //     index].insuranceVendorContracId}');
                                              //                   //    var response =  await patchCompanyContract(
                                              //                   //         context, snapshot.data![index].insuranceVendorContracId,
                                              //                   //         widget.officeId,
                                              //                   //         contractPrefName == contractNameController.text ? contractPrefName! : contractNameController.text,
                                              //                   //        contractPrefexpiryType == selectedExpiryType.toString() ? contractPrefexpiryType! : selectedExpiryType.toString(),
                                              //                   //         contractIDPrefName == contractIdController.text ? contractIDPrefName! : contractIdController.text,
                                              //                   //    contractPrefexpiryDate == calenderController.text ? contractPrefexpiryDate! : calenderController.text);
                                              //                   //    if(response.statusCode == 200 || response.statusCode == 201){
                                              //                   //      showDialog(
                                              //                   //        context: context,
                                              //                   //        builder: (BuildContext context) {
                                              //                   //          return AddSuccessPopup(message: 'Edited Successfully',);
                                              //                   //        },
                                              //                   //      );
                                              //                   //    }else{
                                              //                   //
                                              //                   //    }
                                              //                   //     contractNameController.clear();
                                              //                   //     contractIdController.clear();
                                              //                   //     calenderController.clear();
                                              //                   //   });
                                              //                   //     } finally {
                                              //                   //       setState(() {
                                              //                   //         _isLoading = false;
                                              //                   //       });
                                              //                   //     }
                                              //                   //   },
                                              //                   //
                                              //                   // );
                                              //                 },
                                              //               );
                                              //             });
                                              //       },
                                              //     );
                                              //   },
                                              //   icon: Icon(
                                              //     Icons.edit_outlined,
                                              //     size: 18,
                                              //     color: ColorManager.blueprime,
                                              //   ),
                                              //   splashColor: Colors.transparent,
                                              //   highlightColor: Colors.transparent,
                                              //   hoverColor: Colors.transparent,
                                              // ),
                                              IconButton(
                                                  splashColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            DeletePopup(
                                                                title:
                                                                'Delete Contract',
                                                                onCancel: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                onDelete:
                                                                    () async {
                                                                  print(
                                                                      "${contract.insuranceVendorContracId}");
                                                                  await deleteContract(
                                                                      context,
                                                                      contract
                                                                          .insuranceVendorContracId);
                                                                  // companyContractGetByVendorId(
                                                                  //   context,
                                                                  //   widget.officeId,
                                                                  //   widget.insuranceVendorId,
                                                                  //   currentPage,
                                                                  //   itemsPerPage,
                                                                  // ).then((data) {
                                                                  //   _controller.add(data);
                                                                  // }).catchError((error) {
                                                                  //   // Handle error
                                                                  //   _controller.addError(error);
                                                                  // });
                                                                  Navigator.pop(
                                                                      context);
                                                                }));
                                                  },
                                                  icon: Icon(
                                                    Icons.delete_outline,
                                                    size: 18,
                                                    color:
                                                    ColorManager.faintOrange,
                                                  )),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      PaginationControlsWidget(
                        currentPage: currentPage,
                        items: snapshot.data!,
                        itemsPerPage: itemsPerPage,
                        onPreviousPagePressed: () {
                          setState(() {
                            currentPage = currentPage > 1 ? currentPage - 1 : 1;
                          });
                        },
                        onPageNumberPressed: (pageNumber) {
                          setState(() {
                            currentPage = pageNumber;
                          });
                        },
                        onNextPagePressed: () {
                          setState(() {
                            currentPage = currentPage < totalPages
                                ? currentPage + 1
                                : totalPages;
                          });
                        },
                      ),
                    ],
                  );
                }
                else{
                  return SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
