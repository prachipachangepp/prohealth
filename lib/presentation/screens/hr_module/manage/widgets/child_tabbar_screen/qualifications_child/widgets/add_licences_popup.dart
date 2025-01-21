import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/new_org_doc/new_org_doc.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/qulification_licenses_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/qualification_bar_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/new_org_doc.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';
import 'package:prohealth/presentation/widgets/error_popups/failed_popup.dart';
import 'package:prohealth/presentation/widgets/error_popups/four_not_four_popup.dart';

import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';


class AddLicencesPopup extends StatefulWidget {
  final String title;
  //final Widget child;
  final int employeeId;
  final VoidCallback onpressedClose;

  AddLicencesPopup({
    super.key,
    required this.onpressedClose,
    required this.title,
   // required this.child,
    required this.employeeId,
  });

  @override
  State<AddLicencesPopup> createState() => _AddLicencesPopupState();
}

class _AddLicencesPopupState extends State<AddLicencesPopup> {
  final DateTime _selectedIssueDate = DateTime.now();
  final DateTime _selectedExpDate = DateTime.now();
  TextEditingController livensureController = TextEditingController();
  TextEditingController issueDateController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController issuingOrganizationController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController numberIDController = TextEditingController();
  dynamic pickedFile;
  String? pickedFileName;
  bool isLoading = false;
  bool isFilePicked = false;
  String docName ='Select';
  String docNameadd ='Select';

  // Error states for validations
  Map<String, bool> errorStates = {
    'Livensure': false,
    'issueDate': false,
    'expiryDate': false,
    'issuingOrganization': false,
    'country': false,
    'numberID': false,
  };

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.7,
        height: 480,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              height:AppSize.s50,
              decoration:  BoxDecoration(
                color: ColorManager.blueprime,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 21),
                      child: Text(
                          widget.title,
                          style: PopupHeadingStyle.customTextStyle(context)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        icon: Icon(
                            Icons.close,
                            color: IconColorManager.white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text:'Select Document', // Main text
                          style: AllPopupHeadings.customTextStyle(context), // Main style
                          children: [
                            TextSpan(
                              text: ' *', // Asterisk
                              style: AllPopupHeadings.customTextStyle(context).copyWith(
                                color: ColorManager.red, // Asterisk color
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4,),
                      StatefulBuilder(
                        builder: (BuildContext context, void Function(void Function()) setState) {
                          return FutureBuilder<List<NewOrgDocument>>(
                              future: getNewOrgDocfetch(context, AppConfig.corporateAndCompliance, AppConfig.subDocId1Licenses, 1, 200),
                              builder: (context,snapshot) {
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return Container(
                                    // width: 200,
                                    height: 30,
                                    width: MediaQuery.of(context).size.width / 6,
                                    decoration: BoxDecoration(color: ColorManager.white,borderRadius: BorderRadius.circular(10)),
                                  );

                                }
                                if (snapshot.data!.isEmpty) {
                                  return Container(
                                    width: 200,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(child: Text("No licenses available",style: DocumentTypeDataStyle.customTextStyle(context),)),
                                  );
                                }
                                if(snapshot.hasData){
                                  List dropDown = [];
                                  String docType = '';
                                  List<DropdownMenuItem<String>> dropDownMenuItems = [];
                                  for(var i in snapshot.data!){
                                    dropDownMenuItems.add(
                                      DropdownMenuItem<String>(
                                        child: Text(i.docName),
                                        value: i.docName,
                                      ),
                                    );
                                  }
                                  docNameadd = snapshot.data![0].docName;
                                  return CICCDropdown(
                                    // width: 200,
                                      width: MediaQuery.of(context).size.width / 6,
                                      // initialValue: dropDownMenuItems[0].value,
                                      onChange: (val){
                                        for(var a in snapshot.data!){
                                          if(a.docName == val){
                                            docType = a.docName;
                                            docNameadd = docType;
                                            //docMetaId = docType;
                                          }
                                        }
                                        print(":::${docType}");
                                        // print(":::<>${docMetaId}");
                                      },
                                      items:dropDownMenuItems
                                  );
                                }else{
                                  return SizedBox();
                                }
                              }
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(
                    width: 20,
                  ),
                  ///upload
                  CustomIconButton(
                    icon: Icons.file_upload_outlined,
                    text: 'Upload License',
                    onPressed: () async {
                      FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );
                      if (result != null) {
                        setState(() {
                          pickedFileName = result.files.first.name;
                          pickedFile = result.files.first.bytes;
                          isFilePicked = true;
                        });

                        print('File picked: $pickedFileName');
                      } else {
                        // User canceled the picker
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            pickedFileName == null
                ? const SizedBox(height:11)
                : Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  pickedFileName!,
                  style: CustomTextStylesCommon.commonStyle(
                      fontSize: FontSize.s10,
                      color: ColorManager.mediumgrey),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTextField(
                  capitalIsSelect: true,
                  controller:livensureController,
                  labelText: "Licensure / certification",
                  errorKey: 'Livensure', hintText: 'Enter certification',
                ),
                _buildDateField(
                  controller: issueDateController,
                  labelText: "Issue Date",
                  errorKey: 'issueDate',
                  initialDate: _selectedIssueDate, hintText: 'yyyy-mm-dd',
                ),
                _buildDateField(
                  controller: expiryDateController,
                  labelText: "Expiry Date",
                  errorKey: 'expiryDate',
                  initialDate: _selectedExpDate, hintText: 'yyyy-mm-dd',
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTextField(
                  capitalIsSelect:true,
                  controller: issuingOrganizationController,
                  labelText: "Issuing Organization",
                  errorKey: 'issuingOrganization', hintText: 'Enter Issuing Organization',
                ),
                _buildTextField(
                  capitalIsSelect: true,
                  controller: countryController,
                  labelText: "Country",
                  errorKey: 'country', hintText: 'Enter Country',
                ),
                _buildTextField(
                  capitalIsSelect:false,
                  controller: numberIDController,
                  labelText: "Number/ID",
                  errorKey: 'numberID', hintText: 'Enter Number',
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 10),
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonTransparent(
                      text: AppString.cancel,
                      onPressed: () async {
                        widget.onpressedClose();
                      }),
                  const SizedBox(
                    width:  AppSize.s10,
                  ),
                  isLoading
                      ? SizedBox(
                      width:  AppSize.s25,
                      height:  AppSize.s25,
                      child: CircularProgressIndicator(
                        color: ColorManager.blueprime,
                      ))
                      : CustomElevatedButton(
                    width: AppSize.s100,
                    text: AppString.save,
                    onPressed: () async {
                      setState(() {
                        _validateFields();
                      });

                      if (!_hasErrors()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          var response = await addLicensePost(context,
                              countryController.text,
                              widget.employeeId,
                              expiryDateController.text,
                              issueDateController.text,
                              'url',
                              livensureController.text,
                              numberIDController.text,
                              issuingOrganizationController.text,
                              docNameadd.toString());
                          var licenseResponse =  await approveOnboardQualifyLicensePatch(
                              context,
                              response.licenseId!);

                          if(licenseResponse.statusCode == 200 || licenseResponse.statusCode == 201){
                            if(isFilePicked){
                              var docResponse = await attachLicenseDocument(context, response.licenseId!,pickedFile,pickedFileName!);
                              if(docResponse.statusCode == 200 || docResponse.statusCode == 201){
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddSuccessPopup(
                                      message: 'Licenses Added Successfully',
                                    );
                                  },
                                );
                              }
                            }
                          }else if(response.statusCode == 400 || response.statusCode == 404){
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => const FourNotFourPopup(),
                            );
                          }
                          else {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => FailedPopup(text: response.message),
                            );
                          }

                         // await widget.onpressedSave();
                          _clearControllers();
                        } finally {
                          setState(() {
                            isLoading = false;
                          });

                        }
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required String errorKey,
    required bool capitalIsSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: labelText, // Main text
            style: AllPopupHeadings.customTextStyle(context), // Main style
            children: [
              TextSpan(
                text: ' *', // Asterisk
                style: AllPopupHeadings.customTextStyle(context).copyWith(
                  color: ColorManager.red, // Asterisk color
                ),
              ),
            ],
          ),
        ),
       // Text(labelText,style: AllPopupHeadings.customTextStyle(context),),
        SizedBox(height: 4,),
        CustomTextFieldRegister(
          capitalIsSelect: capitalIsSelect,
          height: AppSize.s30,
          width: MediaQuery.of(context).size.width / 6,
          controller: controller,
hintText:hintText ,
          keyboardType: TextInputType.text,
          padding: const EdgeInsets.only(
              bottom: AppPadding.p5, left: AppPadding.p20),
          onChanged: (value) {
            setState(() {
              errorStates[errorKey] = value.isEmpty;
            });
          },
        ),
        errorStates[errorKey]!?
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Text(
              'Please Enter $labelText',
              style: TextStyle(
                color: ColorManager.red,
                fontSize: FontSize.s10,
              ),
            ),
          ):SizedBox(height: 13,)
      ],
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required String errorKey,
    required DateTime initialDate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text:labelText, // Main text
            style: AllPopupHeadings.customTextStyle(context), // Main style
            children: [
              TextSpan(
                text: ' *', // Asterisk
                style: AllPopupHeadings.customTextStyle(context).copyWith(
                  color: ColorManager.red, // Asterisk color
                ),
              ),
            ],
          ),
        ),
       // Text(labelText,style: AllPopupHeadings.customTextStyle(context),),
        SizedBox(height: 4,),
        CustomTextFieldRegister(
          height: AppSize.s30,
          width: MediaQuery.of(context).size.width / 6,
          controller: controller,
          hintText:hintText,
          keyboardType: TextInputType.text,
          suffixIcon: Icon(
            Icons.calendar_month_outlined,
            color: ColorManager.blueprime,
          ),
          padding: const EdgeInsets.only(
              bottom: AppPadding.p5, left: AppPadding.p20),
          onTap: () async {
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime(1900),
              lastDate: DateTime(2101),
            );
            if (date != null) {
              String formattedDate = DateFormat('yyyy-MM-dd').format(date);
              setState(() {
                controller.text = formattedDate;
                errorStates[errorKey] = controller.text.isEmpty;
              });
            }
          },
          onChanged: (value) {
            setState(() {
              errorStates[errorKey] = value.isEmpty;
            });
          },
        ),
        errorStates[errorKey]! ?
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Text(
              'Please select a valid $labelText',
              style: TextStyle(
                color: ColorManager.red,
                fontSize: FontSize.s10,
              ),
            ),
          ):SizedBox(height:13)
      ],
    );
  }

  void _validateFields() {
    errorStates.forEach((key, value) {
      setState(() {
        if (key == 'Livensure' && livensureController.text.isEmpty) {
          errorStates[key] = true;
        }
        if (key == 'issueDate' && issueDateController.text.isEmpty) {
          errorStates[key] = true;
        }
        if (key == 'expiryDate' && expiryDateController.text.isEmpty) {
          errorStates[key] = true;
        }
        if (key == 'issuingOrganization' &&
            issuingOrganizationController.text.isEmpty) {
          errorStates[key] = true;
        }
        if (key == 'country' && countryController.text.isEmpty) {
          errorStates[key] = true;
        }
        if (key == 'numberID' && numberIDController.text.isEmpty) {
          errorStates[key] = true;
        }
      });
    });
  }

  bool _hasErrors() {
    return errorStates.containsValue(true);
  }

  void _clearControllers() {
    livensureController.clear();
    issuingOrganizationController.clear();
    issueDateController.clear();
    expiryDateController.clear();
    countryController.clear();
    numberIDController.clear();
    setState(() {
      pickedFileName = null;
      errorStates.updateAll((key, value) => false);
    });
  }
}






/// Edit license
class EditLicencesPopup extends StatefulWidget {
  final TextEditingController LivensureController;
  final TextEditingController issueDateController;
  final TextEditingController expiryDateController;
  final TextEditingController issuingOrganizationController;
  final TextEditingController countryController;
  final TextEditingController numberIDController;
  final String documentName;
  final int licenseId;
  final String title;
  final Widget child;
  final VoidCallback onpressedClose;
  final Future<void> Function() onpressedSave;

  EditLicencesPopup({
    super.key,
    required this.LivensureController,
    required this.issueDateController,
    required this.expiryDateController,
    required this.issuingOrganizationController,
    required this.countryController,
    required this.numberIDController,
    required this.onpressedClose,
    required this.onpressedSave,
    required this.title,
    required this.child, required this.licenseId, required this.documentName,
  });

  @override
  State<EditLicencesPopup> createState() => _EditLicencesPopupState();
}

class _EditLicencesPopupState extends State<EditLicencesPopup> {
  final DateTime _selectedIssueDate = DateTime.now();
  final DateTime _selectedExpDate = DateTime.now();
  dynamic pickedFile;
  String? pickedFileName;
  bool isLoading = false;
  bool isFilePicked = false;

  // Error states for validations
  Map<String, bool> errorStates = {
    'Livensure': false,
    'issueDate': false,
    'expiryDate': false,
    'issuingOrganization': false,
    'country': false,
    'numberID': false,
  };

  @override
  void initState() {
    super.initState();
    pickedFileName = widget.documentName;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.7,
        height: 480,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              height:AppSize.s50,
              decoration:  BoxDecoration(
                color: ColorManager.blueprime,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 21),
                      child: Text(
                          widget.title,
                          style: PopupHeadingStyle.customTextStyle(context)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        icon: Icon(
                            Icons.close,
                            color: IconColorManager.white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text:'Select Document', // Main text
                          style: AllPopupHeadings.customTextStyle(context), // Main style
                          children: [
                            TextSpan(
                              text: ' *', // Asterisk
                              style: AllPopupHeadings.customTextStyle(context).copyWith(
                                color: ColorManager.red, // Asterisk color
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4,),
                      widget.child,
                    ],
                  ),

                  const SizedBox(
                    width: 20,
                  ),
                  ///upload
                  CustomIconButton(
                    icon: Icons.file_upload_outlined,
                    text: 'Upload License',
                    onPressed: () async {
                      FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );
                      if (result != null) {
                        setState(() {
                          pickedFileName = result.files.first.name;
                          pickedFile = result.files.first.bytes;
                          isFilePicked = true;
                        });

                        print('File picked: $pickedFileName');
                      } else {
                        // User canceled the picker
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            pickedFileName == null
                ? const SizedBox(height:11)
                : Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  pickedFileName!,
                  style: CustomTextStylesCommon.commonStyle(
                      fontSize: FontSize.s10,
                      color: ColorManager.mediumgrey),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTextField(
                  capitalIsSelect: true,
                  controller: widget.LivensureController,
                  labelText: "Licensure / certification",
                  errorKey: 'Livensure', hintText: 'Enter certification',
                ),
                _buildDateField(
                  controller: widget.issueDateController,
                  labelText: "Issue Date",
                  errorKey: 'issueDate',
                  initialDate: _selectedIssueDate, hintText: 'yyyy-mm-dd',
                ),
                _buildDateField(
                  controller: widget.expiryDateController,
                  labelText: "Expiry Date",
                  errorKey: 'expiryDate',
                  initialDate: _selectedExpDate, hintText: 'yyyy-mm-dd',
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTextField(
                  capitalIsSelect:true,
                  controller: widget.issuingOrganizationController,
                  labelText: "Issuing Organization",
                  errorKey: 'issuingOrganization', hintText: 'Enter Issuing Organization',
                ),
                _buildTextField(
                  capitalIsSelect: true,
                  controller: widget.countryController,
                  labelText: "Country",
                  errorKey: 'country', hintText: 'Enter Country',
                ),
                _buildTextField(
                  capitalIsSelect:false,
                  controller: widget.numberIDController,
                  labelText: "Number/ID",
                  errorKey: 'numberID', hintText: 'Enter Number',
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 10),
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonTransparent(
                      text: AppString.cancel,
                      onPressed: () async {
                        widget.onpressedClose();
                      }),
                  const SizedBox(
                    width:  AppSize.s10,
                  ),
                  isLoading
                      ? SizedBox(
                      width:  AppSize.s25,
                      height:  AppSize.s25,
                      child: CircularProgressIndicator(
                        color: ColorManager.blueprime,
                      ))
                      : CustomElevatedButton(
                    width: AppSize.s100,
                    text: AppString.save,
                    onPressed: () async {
                      setState(() {
                        _validateFields();
                      });

                      if (!_hasErrors()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {

                          if(isFilePicked){
                            var docResponse = await attachLicenseDocument(context,widget.licenseId,pickedFile,pickedFileName!);
                          }
                          await widget.onpressedSave();
                          _clearControllers();
                        } finally {
                          setState(() {
                            isLoading = false;
                          });

                        }
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required String errorKey,
    required bool capitalIsSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: labelText, // Main text
            style: AllPopupHeadings.customTextStyle(context), // Main style
            children: [
              TextSpan(
                text: ' *', // Asterisk
                style: AllPopupHeadings.customTextStyle(context).copyWith(
                  color: ColorManager.red, // Asterisk color
                ),
              ),
            ],
          ),
        ),
        // Text(labelText,style: AllPopupHeadings.customTextStyle(context),),
        SizedBox(height: 4,),
        CustomTextFieldRegister(
          capitalIsSelect: capitalIsSelect,
          height: AppSize.s30,
          width: MediaQuery.of(context).size.width / 6,
          controller: controller,
          hintText:hintText ,
          keyboardType: TextInputType.text,
          padding: const EdgeInsets.only(
              bottom: AppPadding.p5, left: AppPadding.p20),
          onChanged: (value) {
            setState(() {
              errorStates[errorKey] = value.isEmpty;
            });
          },
        ),
        errorStates[errorKey]!?
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Text(
            'Please Enter $labelText',
            style: TextStyle(
              color: ColorManager.red,
              fontSize: FontSize.s10,
            ),
          ),
        ):SizedBox(height: 13,)
      ],
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required String errorKey,
    required DateTime initialDate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text:labelText, // Main text
            style: AllPopupHeadings.customTextStyle(context), // Main style
            children: [
              TextSpan(
                text: ' *', // Asterisk
                style: AllPopupHeadings.customTextStyle(context).copyWith(
                  color: ColorManager.red, // Asterisk color
                ),
              ),
            ],
          ),
        ),
        // Text(labelText,style: AllPopupHeadings.customTextStyle(context),),
        SizedBox(height: 4,),
        CustomTextFieldRegister(
          height: AppSize.s30,
          width: MediaQuery.of(context).size.width / 6,
          controller: controller,
          hintText:hintText,
          keyboardType: TextInputType.text,
          suffixIcon: Icon(
            Icons.calendar_month_outlined,
            color: ColorManager.blueprime,
          ),
          padding: const EdgeInsets.only(
              bottom: AppPadding.p5, left: AppPadding.p20),
          onTap: () async {
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime(1900),
              lastDate: DateTime(2101),
            );
            if (date != null) {
              String formattedDate = DateFormat('yyyy-MM-dd').format(date);
              setState(() {
                controller.text = formattedDate;
                errorStates[errorKey] = controller.text.isEmpty;
              });
            }
          },
          onChanged: (value) {
            setState(() {
              errorStates[errorKey] = value.isEmpty;
            });
          },
        ),
        errorStates[errorKey]! ?
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Text(
            'Please select a valid $labelText',
            style: TextStyle(
              color: ColorManager.red,
              fontSize: FontSize.s10,
            ),
          ),
        ):SizedBox(height:13)
      ],
    );
  }

  void _validateFields() {
    errorStates.forEach((key, value) {
      setState(() {
        if (key == 'Livensure' && widget.LivensureController.text.isEmpty) {
          errorStates[key] = true;
        }
        if (key == 'issueDate' && widget.issueDateController.text.isEmpty) {
          errorStates[key] = true;
        }
        if (key == 'expiryDate' && widget.expiryDateController.text.isEmpty) {
          errorStates[key] = true;
        }
        if (key == 'issuingOrganization' &&
            widget.issuingOrganizationController.text.isEmpty) {
          errorStates[key] = true;
        }
        if (key == 'country' && widget.countryController.text.isEmpty) {
          errorStates[key] = true;
        }
        if (key == 'numberID' && widget.numberIDController.text.isEmpty) {
          errorStates[key] = true;
        }
      });
    });
  }

  bool _hasErrors() {
    return errorStates.containsValue(true);
  }

  void _clearControllers() {
    widget.LivensureController.clear();
    widget.issuingOrganizationController.clear();
    widget.issueDateController.clear();
    widget.expiryDateController.clear();
    widget.countryController.clear();
    widget.numberIDController.clear();
    setState(() {
      pickedFileName = null;
      errorStates.updateAll((key, value) => false);
    });
  }
}
