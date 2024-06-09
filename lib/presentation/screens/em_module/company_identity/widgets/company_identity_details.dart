import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import 'checkbox_constant.dart';

class CIDetailsScreen extends StatefulWidget {
  const CIDetailsScreen({super.key});

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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 12.4,
        right: MediaQuery.of(context).size.width / 15),
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
                    offset: Offset(0, 4),
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
                      SizedBox(height: AppSize.s10),
                      SMTextFConst(
                        controller: secNumberController,
                        keyboardType: TextInputType.number,
                        text: AppStringEM.secNum,
                      ),
                      SizedBox(height: AppSize.s10),
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
                      SizedBox(height: AppSize.s10),
                      SMTextFConst(
                        controller: altNumController,
                        keyboardType: TextInputType.number,
                        text: AppStringEM.alternatephone,
                      ),
                      SizedBox(height: AppSize.s10),
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

            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
              child: Row(
                children: [
                  Text(
                    AppStringEM.services,
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
                  color: ColorManager.black.withOpacity(0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withOpacity(0.15),
                    offset: Offset(0, 4),
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
                          CIDetailsDropdown(
                            initialValue: 'Home Health',
                              items: [
                            DropdownMenuItem(value: 'Home Health', child: Text('Home Health')),
                            DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                            DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                            DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                          ], onEditIconTap: (){
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CIDetailsDropdownPopup(
                                    onSavePressed: (){},
                                    hcoNumController: hcoNumController,
                                    medicareController: medicareController,
                                    npiNumController: npiNumController);
                              },
                            );
                          })
                        ],
                      ),
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
                          CIDetailsDropdown(
                            initialValue: 'Home Care',
                              items: [
                            DropdownMenuItem(value: 'Home Care', child: Text('Home Care')),
                            DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                            DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                            DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                          ], onEditIconTap: (){
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CIDetailsDropdownPopup(
                                    onSavePressed: (){},
                                    hcoNumController: hcoNumController,
                                    medicareController: medicareController,
                                    npiNumController: npiNumController);
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
                            value: checkboxValue1,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxValue1 = newValue!;
                              });
                            },
                            text: '',
                          ),
                          CIDetailsDropdown(
                            initialValue: 'Hospice',
                              items: [
                            DropdownMenuItem(value: 'Hospice', child: Text('Hospice')),
                            DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                            DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                            DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                          ], onEditIconTap: (){
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CIDetailsDropdownPopup(
                                    onSavePressed: (){},
                                    hcoNumController: hcoNumController,
                                    medicareController: medicareController,
                                    npiNumController: npiNumController);
                              },
                            );
                          })
                        ],
                      ),
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
                          CIDetailsDropdown(
                            initialValue: 'Palliative Care',
                              items: [
                            DropdownMenuItem(value: 'Palliative Care', child: Text('Palliative Care')),
                            DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                            DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                            DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                          ], onEditIconTap: (){
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CIDetailsDropdownPopup(
                                    onSavePressed: (){},
                                    hcoNumController: hcoNumController,
                                    medicareController: medicareController,
                                    npiNumController: npiNumController);
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
      ),
    );
  }
}
