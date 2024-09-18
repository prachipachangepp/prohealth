import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/ci_manage_button/manage_insurance_data.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/widgets/custome_dialog.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/manage_insurance_manager/insurance_vendor_contract_manager.dart';
import '../../../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import '../../../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import '../ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';

class CiInsuranceVendor extends StatefulWidget {
  final String officeId;
  const CiInsuranceVendor({super.key, required this.officeId,});

  @override
  State<CiInsuranceVendor> createState() => _CiInsuranceVendorState();
}

class _CiInsuranceVendorState extends State<CiInsuranceVendor> {
  TextEditingController vendorNameController = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController workemailController = TextEditingController();
  TextEditingController workphoneController = TextEditingController();
  final StreamController<List<ManageVendorData>> _companyVendor =
      StreamController<List<ManageVendorData>>();

  @override
  void initState() {
    super.initState();
    // companyAllApi(context);
  }
  String? selectedZoneName;
  String? selectedCityName;
  bool _isLoading = false;
  int currentPage = 1;
  final int itemsPerPage = 10;
  final int totalPages = 5;

  void onPageNumberPressed(int pageNumber) {
    setState(() {
      currentPage = pageNumber;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Text(''),
                  Text(
                    AppString.srNo,
                    style:AllHRTableHeading.customTextStyle(context),
                  ),
//SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Text('Name    ',
                        textAlign: TextAlign.start,
                      style:AllHRTableHeading.customTextStyle(context),),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(AppString.actions,
                        textAlign: TextAlign.start,
                      style:AllHRTableHeading.customTextStyle(context),),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<List<ManageVendorData>>(
                stream: _companyVendor.stream,
                builder: (context, snapshot) {
                  companyVendorGet(context,widget.officeId,1,20).then((data) {
                    _companyVendor.add(data);
                  }).catchError((error) {
                    // Handle error
                  });
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
                     ErrorMessageString.noVendor,
                      style: CustomTextStylesCommon.commonStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: FontSize.s12,
                          color: ColorManager.mediumgrey),
                    ));
                  }
                  if (snapshot.hasData) {
                    int totalItems = snapshot.data!.length;
                    int totalPages = (totalItems / itemsPerPage).ceil();
                    List<ManageVendorData> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: paginatedData.length,
                              itemBuilder: (context, index) {
                                int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                                String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                                ManageVendorData vendorData = paginatedData[index];
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
                                                color: Color(0xff000000)
                                                    .withOpacity(0.25),
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
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  formattedSerialNumber,
                                                  style:  DocumentTypeDataStyle.customTextStyle(context),
                                                ),
                                                // Text(''),
                                                Text(
                                                  vendorData.vendorName
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style:  DocumentTypeDataStyle.customTextStyle(context),
                                                ),
                                                //  Text(''),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (BuildContext
                                                                  context) {
                                                                return FutureBuilder<ManageVendorPrefill>(
                                                                  future: getPrefillVendor(context,vendorData.insuranceVendorId),
                                                                  builder: (context, snapshotPrefill) {
                                                                    if(snapshotPrefill.connectionState == ConnectionState.waiting){
                                                                      return Center(
                                                                        child: CircularProgressIndicator(color: ColorManager.blueprime,),
                                                                      );
                                                                    }
                                                                    var name = snapshotPrefill.data!.vendorName;
                                                                    nameController = TextEditingController(text: snapshotPrefill.data!.vendorName);
                                                                    return CustomPopup(
                                                                        title: 'Edit Vendor',
                                                                        namecontroller: nameController,
                                                                         onPressed: () async{
                                                                           setState(() {
                                                                             _isLoading = true;
                                                                           });
                                                                           try {
                                                                             //final updatedName = nameController.text.isNotEmpty ? nameController.text : vendorData.vendorName;
                                                                             await patchCompanyVendor(
                                                                              context,
                                                                              vendorData.insuranceVendorId,
                                                                              widget.officeId,
                                                                              name == nameController.text ? name.toString() : nameController.text,
                                                                             );
                                                                           } finally {
                                                                             setState(() {
                                                                               _isLoading = false;
                                                                             });
                                                                             Navigator.pop(context);
                                                                           }
                                                                          }, buttontxt: "Save", successpopuptext: 'Edited Successfully',
                                                                          );

                                                                  }
                                                                );
                                                                      });
                                                                      },
                                                        icon: Icon(Icons.edit_outlined,
                                                          size:IconSize.I18,color: IconColorManager.bluebottom,)),
                                                    IconButton(
                                                        onPressed: () {
                                                          showDialog(context: context,
                                                              builder: (context) => StatefulBuilder(
                                                                builder: (BuildContext context, void Function(void Function()) setState) {
                                                                  return  DeletePopup(
                                                                      title: 'Delete Vendor',
                                                                      loadingDuration: _isLoading,
                                                                      onCancel: (){
                                                                        Navigator.pop(context);
                                                                      }, onDelete: () async{
                                                                    setState(() {
                                                                      _isLoading = true;
                                                                    });
                                                                    try {
                                                                      await deleteVendor(
                                                                          context, vendorData.insuranceVendorId!);
                                                                      setState(() async {
                                                                        companyVendorGet(context,widget.officeId,1,30).then((data) {
                                                                          _companyVendor.add(data);
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
                                                        },
                                                        icon:  Icon(Icons.delete_outline,size:IconSize.I18,color: IconColorManager.red,)),
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
                              currentPage = currentPage < totalPages ? currentPage + 1 : totalPages;
                            });
                          },
                        ),
                      ],
                    );
                  }
                  return Offstage();
                }),
          ),
        ],
      ),
    );
  }
}
