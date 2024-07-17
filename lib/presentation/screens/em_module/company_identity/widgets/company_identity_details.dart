import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/manage_details_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/ci_manage_button/manage_details_data.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import 'checkbox_constant.dart';



// Add Service:  /company-office-service/add
class CIDetailsScreen extends StatefulWidget {
   CIDetailsScreen({super.key, required this.officeId, required this.docTD, required this.companyId, required int companyID});
  final int companyId;
  final int docTD;
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
  TextEditingController emailController = TextEditingController();
  TextEditingController hcoNumController = TextEditingController();
  TextEditingController medicareController = TextEditingController();
  TextEditingController npiNumController = TextEditingController();

  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  bool checkboxValue3 = false;
  bool checkboxValue4 = false;
  @override
  void initState() {
    super.initState();
    print(":::::OFFICE ID ${widget.officeId} + ${widget.companyId}");
    companyDetailGetAll(context, 11, widget.officeId);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<ManageDetails>(
          future: companyDetailGetAll(context, widget.companyId, widget.officeId),
          builder: (context, snapshot) {
            //nameController = snapshot.data?.officeName as TextEditingController;
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
              return Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 12.4,
                    right: MediaQuery.of(context).size.width / 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppPadding.p20),
                      child: Row(
                        children: [
                          Text(
                            AppStringEM.details,
                            style:
                                CompanyIdentityManageHeadings.customTextStyle(
                                    context),
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
                                controller: TextEditingController(
                                    text: snapshot.data!.officeName.toString()),
                                keyboardType: TextInputType.text,
                                text: AppStringEM.officename,
                              ),
                              const SizedBox(height: AppSize.s10),
                              SMTextFConst(
                                controller: TextEditingController(
                                    text: snapshot.data!.secNumber.toString()),
                                keyboardType: TextInputType.number,
                                text: AppStringEM.secNum,
                              ),
                              const SizedBox(height: AppSize.s10),
                              SMTextFConst(
                                controller: TextEditingController(
                                    text: snapshot.data!.address.toString()),
                                keyboardType: TextInputType.text,
                                text: AppStringEM.address,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SMTextFConst(
                                controller: TextEditingController(
                                    text: snapshot.data!.priNumber.toString()),
                                keyboardType: TextInputType.number,
                                text: AppStringEM.primNum,
                              ),
                              const SizedBox(height: AppSize.s10),
                              SMTextFConst(
                                controller: TextEditingController(
                                    text: snapshot.data!.alternateNumber
                                        .toString()),
                                keyboardType: TextInputType.number,
                                text: AppStringEM.alternatephone,
                              ),
                              const SizedBox(height: AppSize.s10),
                              SMTextFConst(
                                controller: TextEditingController(
                                    text: snapshot.data!.email.toString()),
                                keyboardType: TextInputType.text,
                                text: AppStringEM.primarymail,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// Office Services
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppPadding.p20),
                      child: Row(
                        children: [
                          Text(
                            AppStringEM.services,
                            style:
                                CompanyIdentityManageHeadings.customTextStyle(
                                    context),
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
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CIDetailsDropdown(
                                      initialValue: 'Home Health',
                                      items: const [
                                        DropdownMenuItem(
                                            value: 'Home Health',
                                            child: Text('Home Health')),
                                        DropdownMenuItem(
                                            value: 'HCO Number      254612',
                                            child: Text('HCO Number  254612')),
                                        DropdownMenuItem(
                                            value: 'Medicare ID      MPID123',
                                            child:
                                                Text('Medicare ID  MPID123')),
                                        DropdownMenuItem(
                                            value: 'NPI Number     1234567890',
                                            child:
                                                Text('NPI Number 1234567890')),
                                      ],
                                      onEditIconTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CIDetailsDropdownPopup(
                                                onSavePressed: () {},
                                                hcoNumController:
                                                    hcoNumController,
                                                medicareController:
                                                    medicareController,
                                                npiNumController:
                                                    npiNumController);
                                          },
                                        );
                                      })
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
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CIDetailsDropdown(
                                      initialValue: 'Home Care',
                                      items: [
                                        const DropdownMenuItem(
                                            value: 'Home Care',
                                            child: Text('Home Care')),
                                        const DropdownMenuItem(
                                            value: 'HCO Number      254612',
                                            child: Text('HCO Number  254612')),
                                        const DropdownMenuItem(
                                            value: 'Medicare ID      MPID123',
                                            child:
                                                Text('Medicare ID  MPID123')),
                                        const DropdownMenuItem(
                                            value: 'NPI Number     1234567890',
                                            child:
                                                Text('NPI Number 1234567890')),
                                      ],
                                      onEditIconTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CIDetailsDropdownPopup(
                                                onSavePressed: () {},
                                                hcoNumController:
                                                    hcoNumController,
                                                medicareController:
                                                    medicareController,
                                                npiNumController:
                                                    npiNumController);
                                            //   AlertDialog(
                                            //   title: Text('Edit Item'),
                                            //   content: Text('Edit item functionality here'),
                                            //   actions: [
                                            //     TextButton(
                                            //       onPressed: () {
                                            //         Navigator.of(context).pop();
                                            //       },
                                            //       child: Text('Close'),
                                            //     ),
                                            //   ],
                                            // );
                                          },
                                        );
                                      })
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
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CIDetailsDropdown(
                                      initialValue: 'Hospice',
                                      items: [
                                        const DropdownMenuItem(
                                            value: 'Hospice',
                                            child: Text('Hospice')),
                                        const DropdownMenuItem(
                                            value: 'HCO Number      254612',
                                            child: Text('HCO Number  254612')),
                                        const DropdownMenuItem(
                                            value: 'Medicare ID      MPID123',
                                            child:
                                                Text('Medicare ID  MPID123')),
                                        const DropdownMenuItem(
                                            value: 'NPI Number     1234567890',
                                            child:
                                                Text('NPI Number 1234567890')),
                                      ],
                                      onEditIconTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CIDetailsDropdownPopup(
                                                onSavePressed: () {},
                                                hcoNumController:
                                                    hcoNumController,
                                                medicareController:
                                                    medicareController,
                                                npiNumController:
                                                    npiNumController);
                                          },
                                        );
                                      })
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
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CIDetailsDropdown(
                                      initialValue: 'Palliative Care',
                                      items: const [
                                        DropdownMenuItem(
                                            value: 'Palliative Care',
                                            child: Text('Palliative Care')),
                                        DropdownMenuItem(
                                            value: 'HCO Number      254612',
                                            child: Text('HCO Number  254612')),
                                        DropdownMenuItem(
                                            value: 'Medicare ID      MPID123',
                                            child:
                                                Text('Medicare ID  MPID123')),
                                        DropdownMenuItem(
                                            value: 'NPI Number     1234567890',
                                            child:
                                                Text('NPI Number 1234567890')),
                                      ],
                                      onEditIconTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CIDetailsDropdownPopup(
                                                onSavePressed: () {},
                                                hcoNumController:
                                                    hcoNumController,
                                                medicareController:
                                                    medicareController,
                                                npiNumController:
                                                    npiNumController);
                                          },
                                        );
                                      })
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}