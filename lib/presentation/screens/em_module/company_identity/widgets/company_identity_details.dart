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



// Add Service:  /company-office-service/add
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
  late Future<ManageDetails> _companyDetailsFuture;

  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  bool checkboxValue3 = false;
  bool checkboxValue4 = false;

  List<String> dropdownItems1 = [
    'Home Health',
    'HCO Number 254612',
    'Medicare ID MPID123',
    'NPI Number 1234567890',
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
    _companyDetailsFuture = companyDetailGetAll(context, widget.officeId);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<ManageDetails>(
        future: _companyDetailsFuture,
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
          if (snapshot.hasData) {
            nameController = TextEditingController(text: snapshot.data!.officeName.toString());
            primNumController = TextEditingController(text: snapshot.data!.priNumber.toString());
            secNumberController = TextEditingController(text: snapshot.data!.secNumber.toString());
            altNumController = TextEditingController(text: snapshot.data!.alternateNumber.toString());
            addressController = TextEditingController(text: snapshot.data!.address.toString());
            emailController = TextEditingController(text: snapshot.data!.email.toString());
            primeFaxController = TextEditingController(text: snapshot.data!.primaryFax.toString());
            secFaxController = TextEditingController(text: snapshot.data!.secondaryFax.toString());
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
                              // TextEditingController(
                              //     text: snapshot.data!.officeName.toString()),
                              keyboardType: TextInputType.text,
                              text: AppStringEM.officename,
                            ),
                            const SizedBox(height: AppSize.s10),
                            SMTextFConst(
                              controller: secNumberController,
                              // TextEditingController(
                              //     text: snapshot.data!.secNumber.toString()),
                              keyboardType: TextInputType.number,
                              text: AppStringEM.secNum,
                            ),
                            const SizedBox(height: AppSize.s10),
                            SMTextFConst(
                              controller: addressController,
                              // TextEditingController(
                              //     text: snapshot.data!.address.toString()),
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
                              // TextEditingController(
                              //     text: snapshot.data!.priNumber.toString()),
                              keyboardType: TextInputType.number,
                              text: AppStringEM.primNum,
                            ),
                            const SizedBox(height: AppSize.s10),
                            SMTextFConst(
                              controller: altNumController,
                              // TextEditingController(
                              //     text: snapshot.data!.alternateNumber.toString()),
                              keyboardType: TextInputType.number,
                              text: AppStringEM.alternatephone,
                            ),
                            const SizedBox(height: AppSize.s10),
                            SMTextFConst(
                              controller: emailController,
                              // TextEditingController(
                              //     text: snapshot.data!.email.toString()),
                              keyboardType: TextInputType.text,
                              text: AppStringEM.primarymail,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  ///service
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          'Services',
                          style: CompanyIdentityManageHeadings.customTextStyle(context),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: AppSize.s181,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 2,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomElevatedButton(
                        width: AppSize.s105,
                        height: AppSize.s30,
                        text: AppStringEM.save, onPressed: () {
                       patchCompanyOffice(context,
                           widget.companyOfficeid,
                           widget.officeId,
                           primNumController.text,
                           secNumberController.text,
                        primeFaxController.text,
                           secFaxController.text,
                           altNumController.text,
                           emailController.text,
                           nameController.text,
                           addressController.text);
                      },
                      )
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
