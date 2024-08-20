import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/manage_details_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/ci_manage_button/manage_details_data.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../widgets/button_constant.dart';
import 'checkbox_constant.dart';

class CIDetailsScreen extends StatefulWidget {
   CIDetailsScreen({super.key, required this.officeId, required this.docTD, required this.companyId, required int companyID, required this.companyOfficeid});
  final int companyId;
  final int docTD;
  final int companyOfficeid;
  final String officeId;

  @override
  State<CIDetailsScreen> createState() => _CIDetailsScreenState();
}

class _CIDetailsScreenState extends State<CIDetailsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController secNumberController = TextEditingController();
  TextEditingController primNumController = TextEditingController();
  TextEditingController altNumController = TextEditingController();
  TextEditingController primeFaxController = TextEditingController();
  TextEditingController secFaxController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController hcoNumController = TextEditingController();
  TextEditingController medicareController = TextEditingController();
  TextEditingController npiNumController = TextEditingController();
  late final Future<ManageDetails> _companyDetailsFuture;
  //  final StreamController<List<ManageDetails>> _companyDetailsFuture =
  //  StreamController<List<ManageDetails>>();
//List<bool> checkboxValues = [];
  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  bool checkboxValue3 = false;
  bool checkboxValue4 = false;

  List<String> dropdownItems1 = [
    'Home Health',
    'HCO Number: 254612',
    'Medicare ID: MPID123',
    'NPI Number: 1234567890',
  ];

  List<String> dropdownItems2 = [
    'Home Care',
    'HCO Number 254612',
    'Medicare ID MPID123',
    'NPI Number 1234567890',
  ];

  List<String> dropdownItems3 = [
    'Hospice',
    'HCO Number 254612',
    'Medicare ID MPID123',
    'NPI Number 1234567890',
  ];

  List<String> dropdownItems4 = [
    'Palliative Care',
    'HCO Number 254612',
    'Medicare ID MPID123',
    'NPI Number 1234567890',
  ];
  void updateDropdownItems1() {
    setState(() {
      dropdownItems1 = [
        'Home Health',
        'HCO Number ${hcoNumController.text}',
        'Medicare ID ${medicareController.text}',
        'NPI Number ${npiNumController.text}',
      ];
    });
  }

  void updateDropdownItems2() {
    setState(() {
      dropdownItems2 = [
        'Home Care',
        'HCO Number ${hcoNumController.text}',
        'Medicare ID ${medicareController.text}',
        'NPI Number ${npiNumController.text}',
      ];
    });
  }

  void updateDropdownItems3() {
    setState(() {
      dropdownItems3 = [
        'Hospice',
        'HCO Number ${hcoNumController.text}',
        'Medicare ID ${medicareController.text}',
        'NPI Number ${npiNumController.text}',
      ];
    });
  }

  void updateDropdownItems4() {
    setState(() {
      dropdownItems4 = [
        'Palliative Care',
        'HCO Number ${hcoNumController.text}',
        'Medicare ID ${medicareController.text}',
        'NPI Number ${npiNumController.text}',
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    print(":::::OFFICE ID ${widget.officeId} + ${widget.companyId}");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<ManageDetails?>(
        future: companyDetailGetAll(context, widget.officeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: CircularProgressIndicator(
                  color: ColorManager.blueprime,
                ),
              ),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            // Initializing controllers with fetched data
            // if (checkboxValues.isEmpty) {
            //   checkboxValues = List.filled(snapshot.data!.serviceDetails!.length, false);
            // }
            nameController = TextEditingController(text: snapshot.data!.officeName);
            primNumController = TextEditingController(text: snapshot.data!.priNumber);
            secNumberController = TextEditingController(text: snapshot.data!.secNumber);
            altNumController = TextEditingController(text: snapshot.data!.alternateNumber);
            addressController = TextEditingController(text: snapshot.data!.address);
            emailController = TextEditingController(text: snapshot.data!.email);
            primeFaxController = TextEditingController(text: snapshot.data!.primaryFax);
            secFaxController = TextEditingController(text: snapshot.data!.secondaryFax);


            return Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 12.4,
                right: MediaQuery.of(context).size.width / 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
                    child: Row(
                      children: [
                        Text(
                          AppStringEM.details,
                          style: CompanyIdentityManageHeadings.customTextStyle(context),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: AppSize.s250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 2,
                        color: ColorManager.black.withOpacity(0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.black.withOpacity(0.15),
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                      color: ColorManager.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SMTextFConst(
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              text: AppStringEM.officename,
                            ),
                            const SizedBox(height: AppSize.s10),
                            SMTextFConst(
                              controller: secNumberController,
                              keyboardType: TextInputType.number,
                              text: AppStringEM.secNum,
                            ),
                            const SizedBox(height: AppSize.s10),
                            SMTextFConst(
                              controller: addressController,
                              keyboardType: TextInputType.text,
                              text: AppStringEM.address,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SMTextFConst(
                              controller: primNumController,
                              keyboardType: TextInputType.number,
                              text: AppStringEM.primNum,
                            ),
                            const SizedBox(height: AppSize.s10),
                            SMTextFConst(
                              controller: altNumController,
                              keyboardType: TextInputType.number,
                              text: AppStringEM.alternatephone,
                            ),
                            const SizedBox(height: AppSize.s10),
                            SMTextFConst(
                              controller: emailController,
                              keyboardType: TextInputType.text,
                              text: AppStringEM.primarymail,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// Service List
                  if (snapshot.data!.serviceDetails != null && snapshot.data!.serviceDetails!.isNotEmpty)
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Services',
                            style: CompanyIdentityManageHeadings.customTextStyle(context),
                          ),
                          const SizedBox(height: AppSize.s10),
                          Container(
                            height: AppSize.s181,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                width: 2,
                                color: ColorManager.black.withOpacity(0.2),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorManager.black.withOpacity(0.15),
                                  offset: const Offset(0, 4),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: ListView.builder(
                              itemCount: snapshot.data!.serviceDetails!.length,
                              itemBuilder: (context, index) {
                                npiNumController = TextEditingController(text: snapshot.data!.serviceDetails![index].npiNum);
                                hcoNumController = TextEditingController(text: snapshot.data!.serviceDetails![index].hcoNum);
                                medicareController = TextEditingController(text: snapshot.data!.serviceDetails![index].medicareNum);

                                // dropdownItems1 = [
                                //   snapshot.data!.serviceDetails![index].serviceName,
                                //   'HCO Number: ${snapshot.data!.serviceDetails![index].hcoNum}',
                                //   'Medicare ID: ${snapshot.data!.serviceDetails![index].medicareNum}',
                                //   'NPI Number: ${snapshot.data!.serviceDetails![index].npiNum}',
                                // ];

                                return  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ///home health
                                        Row(
                                          children: [
                                            CheckboxConstant(
                                              value: checkboxValue1,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  checkboxValue1 = newValue!;
                                                });
                                              },
                                              text: '',
                                            ),
                                            const SizedBox(width: 5),
                                            CIDetailsDropdown(
                                              initialValue: 'Home Health',
                                              items: dropdownItems1.map((item) {
                                                return DropdownMenuItem(
                                                  value: item,
                                                  child: Text(item),
                                                );
                                              }).toList(),
                                              onEditIconTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return CIDetailsDropdownPopup(
                                                      onSavePressed: updateDropdownItems1,
                                                      hcoNumController: hcoNumController,
                                                      medicareController: medicareController,
                                                      npiNumController: npiNumController,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        ///home care
                                        Row(
                                          children: [
                                            CheckboxConstant(
                                              value: checkboxValue2,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  checkboxValue2 = newValue!;
                                                });
                                              },
                                              text: '',
                                            ),
                                            const SizedBox(width: 5),
                                            CIDetailsDropdown(
                                              initialValue: 'Home Care',
                                              items: dropdownItems2.map((item) {
                                                return DropdownMenuItem(
                                                  value: item,
                                                  child: Text(item),
                                                );
                                              }).toList(),
                                              onEditIconTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return CIDetailsDropdownPopup(
                                                      onSavePressed: updateDropdownItems2,
                                                      hcoNumController: hcoNumController,
                                                      medicareController: medicareController,
                                                      npiNumController: npiNumController,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ///hospic
                                        Row(
                                          children: [
                                            CheckboxConstant(
                                              value: checkboxValue3,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  checkboxValue3 = newValue!;
                                                });
                                              },
                                              text: '',
                                            ),
                                            const SizedBox(width: 5),
                                            CIDetailsDropdown(
                                              initialValue: 'Hospice',
                                              items: dropdownItems3.map((item) {
                                                return DropdownMenuItem(
                                                  value: item,
                                                  child: Text(item),
                                                );
                                              }).toList(),
                                              onEditIconTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return CIDetailsDropdownPopup(
                                                      onSavePressed: updateDropdownItems3,
                                                      hcoNumController: hcoNumController,
                                                      medicareController: medicareController,
                                                      npiNumController: npiNumController,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            CheckboxConstant(
                                              value: checkboxValue4,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  checkboxValue4 = newValue!;
                                                });
                                              },
                                              text: '',
                                            ),
                                            const SizedBox(width: 5),
                                            CIDetailsDropdown(
                                              initialValue: 'Palliative Care',
                                              items: dropdownItems4.map((item) {
                                                return DropdownMenuItem(
                                                  value: item,
                                                  child: Text(item),
                                                );
                                              }).toList(),
                                              onEditIconTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return CIDetailsDropdownPopup(
                                                      onSavePressed: updateDropdownItems4,
                                                      hcoNumController: hcoNumController,
                                                      medicareController: medicareController,
                                                      npiNumController: npiNumController,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                                //   Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                //     CheckboxConstant(
                                //       value: checkboxValues[index],
                                //       onChanged: (newValue) {
                                //         setState(() {
                                //           checkboxValues[index] = newValue!;
                                //         });
                                //       },
                                //       text: '',
                                //     ),
                                //     const SizedBox(width: 5),
                                //     CIDetailsDropdown(
                                //       initialValue: snapshot.data!.serviceDetails![index].serviceName, // Replace with actual data
                                //       items: dropdownItems1.map((item) {
                                //         return DropdownMenuItem(
                                //           value: item,
                                //           child: Text(item),
                                //         );
                                //       }).toList(),
                                //       onEditIconTap: () {
                                //         hcoNumController.clear();
                                //         medicareController.clear();
                                //         npiNumController.clear();
                                //         showDialog(
                                //           context: context,
                                //           builder: (context) {
                                //             return CIDetailsDropdownPopup(
                                //               onSavePressed: updateDropdownItems1,
                                //               hcoNumController: hcoNumController,
                                //               medicareController: medicareController,
                                //               npiNumController: npiNumController,
                                //             );
                                //           },
                                //         );
                                //       },
                                //     ),
                                //   ],
                                // );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: AppSize.s10),

                  /// Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomElevatedButton(
                        width: AppSize.s105,
                        height: AppSize.s30,
                        text: AppStringEM.save,
                        onPressed: () async {
                        await patchCompanyOffice(context,
                            widget.companyOfficeid,
                            widget.officeId,
                            primNumController.text,
                            secNumberController.text,
                            primeFaxController.text,
                            secFaxController.text,
                            altNumController.text,
                            emailController.text,
                            nameController.text,
                            addressController.text,
                          );
                        // for (int i = 0; i < snapshot.data!.serviceDetails!.length; i++) {
                        // if (checkboxValues[i]) {
                        // var serviceDetail = snapshot.data!.serviceDetails![i];
                        // await patchCompanyOfficeService(context,
                        // widget.companyOfficeid,
                        // widget.officeId,
                        // serviceDetail.serviceName,
                        // serviceDetail.serviceId,
                        // serviceDetail.npiNum,
                        // serviceDetail.medicareNum,
                        // serviceDetail.hcoNum);
                        // }
                        // }
                        }
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

}
