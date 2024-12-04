import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/new_org_doc/new_org_doc.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/zone_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_licenses_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/new_org_doc.dart';
import 'package:prohealth/data/api_data/establishment_data/zone/zone_model_data.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/employeement_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import '../../../../../../../data/api_data/api_data.dart';
import '../../../../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../../../../../data/api_data/hr_module_data/progress_form_data/form_licenses_data.dart';
import '../../../../../../widgets/error_popups/failed_popup.dart';
import '../../../../../../widgets/error_popups/four_not_four_popup.dart';
import '../../../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';
import '../../../taxtfield_constant.dart';

class LicensesScreen extends StatefulWidget {
  final int employeeID;
  final Function onSave;
  final Function onBack;
  const LicensesScreen({
    super.key,
    required this.context,
    required this.employeeID, required this.onSave, required this.onBack,
  });

  final BuildContext context;

  @override
  State<LicensesScreen> createState() => _LicensesScreenState();
}

class _LicensesScreenState extends State<LicensesScreen> {
  List<GlobalKey<_licensesFormState>> licenseFormKeys = [];
  bool isVisible = false;

  bool isLoading =false;
  Future<void> perfFormLinsence({
    required BuildContext context,
    required String country,
    required int employeeId,
    required String expDate,
    required String issueDate,
    required String licenseUrl,
    required String licensure,
    required String licenseNumber,
    required String org,
    required String documentType,
    //required String documentType,
    //required String employeeId,
    required dynamic documentFile,
    required String documentName,
  }) async {
    ApiDataRegister response = await postlicensesscreenData(
        context,
        country,
        employeeId,
        expDate,
        issueDate,
        licenseUrl,
        licensure,
        licenseNumber,
        org,
        documentType);
    // setState(() {
    //   _isLoading = false;
    // });
    print('LicenseId :: ${response.licenses!}');
    await uploadlinceses(
      context: context,
      employeeid: employeeId,
      documentFile: documentFile,
      documentName: documentName,
      licensedId: response.licenses!,
    );


    if (response.statusCode == 200 || response.statusCode == 201) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddSuccessPopup(
            message: 'Licenses Document Saved',
          );
        },
      );
      widget.onSave();
      _loadLicensesData();
    }
    else if(response.statusCode == 400 || response.statusCode == 404){
      // Navigator.pop(context);
      await showDialog(
        context: context,
        builder: (BuildContext context) => const FourNotFourPopup(),
      );
    }
    else {
      // Navigator.pop(context);
      await showDialog(
        context: context,
        builder: (BuildContext context) => FailedPopup(text: response.message),
      );
    }
    // else {
    //   await showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AddFailePopup(
    //         message: 'Failed to Save Licenses Document',
    //       );
    //     },
    //   );
    // }

  }

  double textFieldWidth = 430;
  double textFieldHeight = 38;

  TextEditingController firstName = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadLicensesData();
  }
  Future<void> _loadLicensesData() async {
    try {
      List<LicensesDataForm> prefilledData = await getLicensesForm(context, widget.employeeID);
      if(prefilledData.isEmpty){
        addLicensesForm();
      }
      else{
        setState(() {
          licenseFormKeys = List.generate(
            prefilledData.length,
                (index) => GlobalKey<_licensesFormState>(),
          );
        });

      }

    } catch (e) {
      print('Error loading Licenses data: $e');
    }
  }

  void addLicensesForm() {
    setState(() {
      licenseFormKeys.add(GlobalKey<_licensesFormState>());
    });
  }

  void removeLicensesForm(GlobalKey<_licensesFormState> key) {
    setState(() {
      licenseFormKeys.remove(key);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Licenses',
            style: FormHeading.customTextStyle(context)
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 60),
        Container(
          width: 952,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Color(0xFFE6F7FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: DefineWorkWeekStyle.customTextStyle(context),
                  ),
                  Expanded(
                    child: Text(
                      'Please fill all the current and relevant licensure / certification below. If you are applying for a clinical or attorney position which is lists licensure in the requirements, your information will be required to proceed through the requirements process.',
                      textAlign: TextAlign.center,
                      style:ZoneDataStyle.customTextStyle(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '• Please note, MSW and Chaplains do not need a License. Rather , they need academic credentials.',
                      textAlign: TextAlign.center,
                      style:ZoneDataStyle.customTextStyle(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '• Clinical Staff MUST fill this section out. ',
                      textAlign: TextAlign.center,
                      style:ZoneDataStyle.customTextStyle(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 20),
        Column(
          children: licenseFormKeys.asMap().entries.map((entry) {
            int index = entry.key;
            GlobalKey<_licensesFormState> key = entry.value;
            return licensesForm(
              key: key,
              index: index + 1,
              onRemove: () => removeLicensesForm(key),
              employeeID: widget.employeeID, isVisible: isVisible,
            );
          }).toList(),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 20),
        Padding(
          padding: const EdgeInsets.only(left: 160),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isVisible = true;
                    addLicensesForm();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff50B5E5),
                  // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                  'Add Licenses',
                  style: BlueButtonTextConst.customTextStyle(context),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              //color: Colors.white,
              width: 117,
              height: 30,
              child: ElevatedButton(
                onPressed: (){
                  widget.onBack();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: ColorManager.bluebottom,
                      width: 1,
                    ),
                  ),),
                child: Text('Previous',
                  style: TransparentButtonTextConst.customTextStyle(context),
                ),),
            ),
            const SizedBox(
              width: 30,
            ),
            isLoading
                ? SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                color: ColorManager.blueprime,
              ),
            )
                :CustomButton(
              width: 117,
              height: 30,
              text: 'Save',
              style: BlueButtonTextConst.customTextStyle(context),
              borderRadius: 12,
              onPressed: () async {


                // Flag to check if a document is selected

                for (var key in licenseFormKeys) {
                  try {
                    final st = key.currentState!;

                    if (st.isPrefill == false) {
                      // Check if documentFile is selected
                      if (st.finalPath == null || st.finalPath.isEmpty) {
                        // If no document is selected, show a message and stop further execution
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return VendorSelectNoti(
                              message: 'Please Select A File',
                            );
                          },
                        );
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text('Please select a file.')),
                        // );

                        return; // Exit the loop and method early
                      }
                      if (st.fileAbove20Mb) {

                        setState(() {
                          isLoading = true; // Start loading
                        });
                        await perfFormLinsence(
                          context: context,
                          licenseNumber: st.licensurenumber.text,
                          country: st.selectedCountry.toString(),
                          employeeId: widget.employeeID,
                          expDate: st.controllerExpirationDate.text,
                          issueDate: st.controllerIssueDate.text,
                          licenseUrl: 'NA',
                          licensure: st.licensure.text,
                          org: st.org.text,
                          documentType: st.documentTypeName!,
                          documentFile: st.finalPath,
                          documentName: st.fileName,
                        );
                        setState(() {
                          isLoading = false; // Stop loading
                        });

                      }
                      else{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddErrorPopup(
                              message: 'File is too large!',
                            );
                          },
                        );
                      }
                    }
                  } catch (e) {
                    print(e);
                  }
                }

                // If a document is selected and everything goes fine, complete the process

              },
              child: Text(
                'Save',
                style: BlueButtonTextConst.customTextStyle(context),
              ),
            ),

            //     :CustomButton(
            //   width: 117,
            //   height: 30,
            //   text:  'Save',
            //   style:BlueButtonTextConst.customTextStyle(context),
            //   borderRadius: 12,
            //   onPressed: () async {
            //
            //
            //     // Loop through each form and extract data to post
            //
            //     setState(() {
            //       isLoading = true; // Start loading
            //     });
            //     for (var key in licenseFormKeys) {
            //       try{
            //
            //         final st = key.currentState!;
            //         if(st.isPrefill ==false){
            //
            //           await perfFormLinsence(
            //               context: context,
            //               licenseNumber: st.licensurenumber.text,
            //               country: st.selectedCountry.toString(),
            //               // country: st.controllercountry.text.toString(),
            //               employeeId: widget.employeeID,
            //               expDate: st.controllerExpirationDate.text,
            //               issueDate: st.controllerIssueDate.text,
            //               licenseUrl: 'NA',
            //               licensure: st.licensure.text,
            //               org: st.org.text,
            //               documentType: st.documentTypeName!,
            //               documentFile: st.finalPath,
            //               documentName: st.fileName);
            //         }
            //
            //
            //       }catch(e){
            //        print(e);
            //       }
            //
            //     }
            //     setState(() {
            //       isLoading = false; // End loading
            //     });
            //     //licensure.clear();
            //     widget.onSave();
            //     _loadLicensesData();
            //   },
            //   child: Text(
            //     'Save',
            //     style: BlueButtonTextConst.customTextStyle(context),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}

class licensesForm extends StatefulWidget {
  final int employeeID;
  final VoidCallback onRemove;
  final int index;
  final bool isVisible;
  const licensesForm(
      {Key? key,
      required this.onRemove,
      required this.index,
      required this.employeeID, required this.isVisible})
      : super(key: key);

  @override
  _licensesFormState createState() => _licensesFormState();
}

class _licensesFormState extends State<licensesForm> {
  bool isPrefill= true;
  TextEditingController firstName = TextEditingController();
  TextEditingController licensure = TextEditingController();
  TextEditingController org = TextEditingController();
  TextEditingController licensurenumber = TextEditingController();
  TextEditingController controllerIssueDate = TextEditingController();
  TextEditingController controllerExpirationDate = TextEditingController();
  TextEditingController controllercountry= TextEditingController(text: 'United States Of America');

 // String selectedCountry = 'United States Of America';
  int? licenseIdIndex;
  String? licenseUrl;
  int countryId =0;
  String? selectedCountry;
  String? documentTypeName;

  final StreamController<List<AEClinicalReportingOffice>> Countrystream =
      StreamController<List<AEClinicalReportingOffice>>();

  bool fileAbove20Mb = false;
  void initState() {
    super.initState();
    HrAddEmplyClinicalReportingOfficeApi(context, 11).then((data) {
      Countrystream.add(data);
    }).catchError((error) {});
    _initializeFormWithPrefilledData();
  }

  List<String> _fileNames = [];
  bool _loading = false;
  Future<void> _initializeFormWithPrefilledData() async {
    try {
      List<LicensesDataForm> prefilledData = await getLicensesForm(context, widget.employeeID);
      if (prefilledData.isNotEmpty) {
        var data = prefilledData[widget.index - 1]; // Assuming index matches the data list
        setState(() {
          firstName.text = data.documentType ?? '';
          licensure.text = data.licensure ?? '';
          org.text = data.org ?? '';
          licensurenumber.text = data.licenseNumber ?? '';
          controllerIssueDate.text = data.issueDate ?? '';
          controllerExpirationDate.text = data.expDate ?? '';
          selectedCountry = data.country ?? '';
          licenseIdIndex = data.licenseId ?? 0;
          //licenseUrl = data.licenseUrl;
           licenseUrl = data.licenseUrl.split('/').last;
           documentTypeName = data.documentType;
        });
      }
    } catch (e) {
      print('Failed to load prefilled data: $e');
    }
  }


  bool _documentUploaded = true;
  var fileName;
  var fileName1;
  dynamic filePath;
  File? xfileToFile;
  var finalPath;

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.only(left: 166.0, right: 166),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                licenseIdIndex == null ? 'Licensure / Certification #${widget.index}' : 'Licensure / Certification #${licenseIdIndex}',
                style: HeadingFormStyle.customTextStyle(context),
              ),
              if (widget.index > 1)
              IconButton(
                icon:
                Icon(Icons.remove_circle, color: Colors.red),
                onPressed: widget.onRemove,
              ),
            ],
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height / 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Licensure / Certification',
                      style: AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            60),
                    CustomTextFieldRegister(
                      controller: licensure,
                      hintText: 'Enter Licensure / Certification',
                      hintStyle: onlyFormDataStyle.customTextStyle(context),
                      height: 32,onChanged: (value){
                      if(value.isNotEmpty){
                        isPrefill= false;
                      }
                    },
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            40),
                    Text(
                      'Issuing Organization',
                      style: AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            60),
                    CustomTextFieldRegister(
                      controller: org,
                      hintText: 'Enter Organization Name',
                      hintStyle: onlyFormDataStyle.customTextStyle(context),
                      height: 32,
                      onChanged: (value){
                        if(value.isNotEmpty){
                          isPrefill= false;
                        }
                      },
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            30),
                    Text(
                      'Country',
                      style: AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            60),

                    // CustomTextFieldRegister(
                    //   controller: controllercountry,
                    //   height: 32,
                    //
                    // ),
                    StatefulBuilder(
                      builder: (BuildContext context, void Function(void Function()) setState) { return  FutureBuilder<List<CountryGetData>>(
                        future: getCountry(context: context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              child: Container(
                                height: 31,
                                width: 250,
                                decoration: BoxDecoration(color: ColorManager.white),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return CustomDropdownTextField(
                              // width: MediaQuery.of(context).size.width / 5,
                              headText: 'Country',
                              items: ['Error'],
                            );
                          } else if (snapshot.hasData) {
                            List<DropdownMenuItem<String>> dropDownList = [];
                            int countryId = 0;

                            // Populate the dropdown list from the fetched data
                            for (var i in snapshot.data!) {
                              dropDownList.add(DropdownMenuItem<String>(
                                child: Text(i.name),
                                value: i.name,
                              ));
                            }

                            // Use the prefilled country if available, otherwise default to the first item
                            String initialValue = selectedCountry ?? "Select";


                            return CustomDropdownTextFieldwidh(
                              dropDownMenuList: dropDownList,
                              onChanged: (newValue) {
                                isPrefill = false;
                                for (var a in snapshot.data!) {
                                  if (a.name == newValue) {
                                    selectedCountry = a.name;
                                    countryId = a.countryId;
                                    print("Country :: ${selectedCountry}");
                                    print("Country ID :: ${countryId}");
                                  }
                                }
                              },
                              hintText: initialValue,
                           height: 31,
                            );

                            // return Container(
                            //   height: 32,
                            //   padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     border: Border.all(
                            //       color: const Color(0xff686464).withOpacity(0.5),
                            //       width: 1, // Black border
                            //     ),
                            //     borderRadius: BorderRadius.circular(6), // Rounded corners
                            //   ),
                            //   child: DropdownButtonFormField<String>(
                            //     focusColor: Colors.transparent,
                            //     icon: const Icon(
                            //       Icons.arrow_drop_down_sharp,
                            //       color: Color(0xff686464),
                            //     ),
                            //     decoration: const InputDecoration.collapsed(hintText: ''),
                            //     items: dropDownList,
                            //     onChanged: (newValue) {
                            //       isPrefill = false;
                            //       for (var a in snapshot.data!) {
                            //         if (a.name == newValue) {
                            //           selectedCountry = a.name;
                            //           countryId = a.countryId;
                            //           print("Country :: ${selectedCountry}");
                            //           print("Country ID :: ${countryId}");
                            //         }
                            //       }
                            //     },
                            //     value: initialValue, // Use the prefilled value or default to the first item
                            //     style: onlyFormDataStyle.customTextStyle(context),
                            //   ),
                            // );
                          } else {
                            return CustomDropdownTextField(
                              // width: MediaQuery.of(context).size.width / 5,
                              headText: 'Country',
                              items: ['No Data'],
                            );
                          }
                        },
                      ); },

                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            30),
                    Text(
                      'Number / ID',
                      style:AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            60),
                    CustomTextFieldRegister(
                      controller: licensurenumber,
                      hintText: 'Enter Number',
                      hintStyle:onlyFormDataStyle.customTextStyle(context),
                      height: 32,
                      onChanged: (value){
                        if(value.isNotEmpty){
                          isPrefill= false;
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                   // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Issue Date',
                        style:AllPopupHeadings.customTextStyle(context),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height /
                              60),
                      CustomTextFieldRegister(
                        controller: controllerIssueDate,
                        hintText: 'yyyy-mm-dd',
                        hintStyle:onlyFormDataStyle.customTextStyle(context),
                        height: 32,
                        onChanged: (value){
                          if(value.isNotEmpty){
                            isPrefill= false;
                          }
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.calendar_month_outlined,
                            color: Color(0xff50B5E5),
                            size: 16,
                          ),
                          onPressed: () async {
                            DateTime? pickedDate =
                            await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                              DateFormat('yyyy-MM-dd')
                                  .format(pickedDate);
                              controllerIssueDate.text =
                                  formattedDate;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height /
                              100),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'If the licensure / certification will be recieved in future, enter the expected issuing date',
                              style:onlyFormDataStyle.customTextStyle(context),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height /
                              40),
                      Text(
                        'Expiration Date',
                        style: AllPopupHeadings.customTextStyle(context),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height /
                              60),
                      CustomTextFieldRegister(
                        controller: controllerExpirationDate,
                        hintText: 'yyyy-mm-dd',
                        hintStyle: onlyFormDataStyle.customTextStyle(context),
                        height: 32,
                        onChanged: (value){
                          if(value.isNotEmpty){
                            isPrefill= false;
                          }
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.calendar_month_outlined,
                            color: Color(0xff50B5E5),
                            size: 16,
                          ),
                          onPressed: () async {
                            DateTime? pickedDate =
                            await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                              DateFormat('yyyy-MM-dd')
                                  .format(pickedDate);
                              controllerExpirationDate.text =
                                  formattedDate;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height /
                              40),
                      Text(
                        'Document type',
                        style: AllPopupHeadings.customTextStyle(context),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height /
                              60),
                      StatefulBuilder(
                          builder: (BuildContext context, void Function(void Function()) setState) {
                            return FutureBuilder<List<NewOrgDocument>>(
                              future: getNewOrgDocfetch(context, AppConfig.corporateAndCompliance, AppConfig.subDocId1Licenses, 1, 200),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 7),
                                    child: Container(
                                      height: 31,
                                      width: 250,
                                      decoration: BoxDecoration(color: ColorManager.white),
                                    ),
                                  );
                                } else if (snapshot.hasError ||snapshot.data ==null ) {
                                 return Container(
                                   width:  285,
                                   height: 30,
                                   // padding: EdgeInsets.symmetric(horizontal: 20),
                                   decoration: BoxDecoration(
                                     // color: Colors.red,
                                     border: Border.all(
                                         color: ColorManager.containerBorderGrey, width: AppSize.s1),
                                     borderRadius: BorderRadius.circular(4),
                                   ),
                                   child: Center(
                                     child: Text('No Data Available',
                                       style: DocumentTypeDataStyle.customTextStyle(context),),
                                   ),
                                 );
                                } else if (snapshot.hasData) {

                                  List<DropdownMenuItem<String>> dropDownList = [];

                                  // Populate the dropdown list from the fetched data
                                  for (var i in snapshot.data!) {
                                    dropDownList.add(DropdownMenuItem<String>(
                                      child: Text(i.docName),
                                      value: i.docName,
                                    ));
                                  }

                                  // Use the prefilled document type if available, otherwise default to the first item
                                  String initialValue = documentTypeName ?? "Select";
                                  return CustomDropdownTextFieldwidh(
                                    dropDownMenuList: dropDownList,
                                    onChanged: (newValue) {
                                      isPrefill = false;
                                      for (var a in snapshot.data!) {
                                        if (a.docName == newValue) {
                                          documentTypeName = a.docName;
                                          print("Document Type :: ${documentTypeName}");
                                        }
                                      }
                                    },
                                    hintText: initialValue,
                                    height: 31,
                                  );

                                } else {
                                  return CustomDropdownTextField(
                                    // width: MediaQuery.of(context).size.width / 5,
                                    headText: 'Select Document',
                                    items: ['No Data'],
                                  );
                                }
                              },
                            );
                          },
                          ),
                      SizedBox(height: 97)
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height / 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Upload your licensure / certifications as a docx or pdf',
                  style:FileuploadString.customTextStyle(context),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 5),
              StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () async{
                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf']
                          );
                          final fileSize = result?.files.first.size; // File size in bytes
                          final isAbove20MB = fileSize! > (20 * 1024 * 1024);
                          if (result != null) {
                            final file = result.files.first;
                            setState(() {
                              fileName = file.name;
                              finalPath = file.bytes;
                              fileAbove20Mb = !isAbove20MB;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff50B5E5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),

                        ),
                        icon: licenseUrl == "--" ? Icon(Icons.upload, color: Colors.white):null,
                        label:licenseUrl == null ?Text(
                          'Upload File',
                          style: BlueButtonTextConst.customTextStyle(context),
                        ):Text(
                          'Uploaded',
                          style:  BlueButtonTextConst.customTextStyle(context),
                        )
                    ),
                    SizedBox(height: 8,),
                    licenseUrl != null ? AutoSizeText(
                      'Uploaded File: $licenseUrl',
                      style:onlyFormDataStyle.customTextStyle(context),
                    ):
                    fileName != null ?
                    AutoSizeText(
                      'File picked: $fileName',
                      style: onlyFormDataStyle.customTextStyle(context),
                    ) : SizedBox(),
                  ],
                );  },

              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
            thickness: 2,
          ),
        ],
      ),
    );
  }


  // Widget buildDropdownButton(BuildContext context) {
  //   // Store prefilled country value (you can initialize it with null or fetch it dynamically)
  //   String? prefilledCountry;
  //
  //   return FutureBuilder<List<CountryGetData>>(
  //     future: getCountry(context: context),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 7),
  //           child: Container(
  //             height: 31,
  //             width: 250,
  //             decoration: BoxDecoration(color: ColorManager.white),
  //           ),
  //         );
  //       } else if (snapshot.hasError) {
  //         return CustomDropdownTextField(
  //           // width: MediaQuery.of(context).size.width / 5,
  //           headText: 'Country',
  //           items: ['Error'],
  //         );
  //       } else if (snapshot.hasData) {
  //         List<DropdownMenuItem<String>> dropDownList = [];
  //         int countryId = 0;
  //
  //         // Populate the dropdown list from the fetched data
  //         for (var i in snapshot.data!) {
  //           dropDownList.add(DropdownMenuItem<String>(
  //             child: Text(i.name),
  //             value: i.name,
  //           ));
  //         }
  //
  //         // Use the prefilled country if available, otherwise default to the first item
  //         String initialValue = selectedCountry ?? dropDownList[0].value!;
  //
  //         return Container(
  //           height: 32,
  //           padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             border: Border.all(
  //               color: const Color(0xff686464).withOpacity(0.5),
  //               width: 1, // Black border
  //             ),
  //             borderRadius: BorderRadius.circular(6), // Rounded corners
  //           ),
  //           child: DropdownButtonFormField<String>(
  //             focusColor: Colors.transparent,
  //             icon: const Icon(
  //               Icons.arrow_drop_down_sharp,
  //               color: Color(0xff686464),
  //             ),
  //             decoration: const InputDecoration.collapsed(hintText: ''),
  //             items: dropDownList,
  //             onChanged: (newValue) {
  //               isPrefill = false;
  //               for (var a in snapshot.data!) {
  //                 if (a.name == newValue) {
  //                   selectedCountry = a.name;
  //                   countryId = a.countryId;
  //                   print("Country :: ${selectedCountry}");
  //                   print("Country ID :: ${countryId}");
  //                 }
  //               }
  //             },
  //             value: initialValue, // Use the prefilled value or default to the first item
  //             style: onlyFormDataStyle.customTextStyle(context),
  //           ),
  //         );
  //       } else {
  //         return CustomDropdownTextField(
  //           // width: MediaQuery.of(context).size.width / 5,
  //           headText: 'Country',
  //           items: ['No Data'],
  //         );
  //       }
  //     },
  //   );
  // }




  ///
/// ///


//   Widget buildDropdownButtonDocumentType(BuildContext context) {
//     // Store prefilled document type value (you can initialize it with null or fetch it dynamically)
//    // String? prefilledDocumentType;
//
//     return FutureBuilder<List<NewOrgDocument>>(
//       future: getNewOrgDocfetch(context, AppConfig.corporateAndCompliance, AppConfig.subDocId1Licenses, 1, 200),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 7),
//             child: Container(
//               height: 31,
//               width: 250,
//               decoration: BoxDecoration(color: ColorManager.white),
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return CustomDropdownTextField(
//             // width: MediaQuery.of(context).size.width / 5,
//             headText: 'Select Document',
//             items: ['Error'],
//           );
//         } else if (snapshot.hasData) {
//
//           List<DropdownMenuItem<String>> dropDownList = [];
//
//           // Populate the dropdown list from the fetched data
//           for (var i in snapshot.data!) {
//             dropDownList.add(DropdownMenuItem<String>(
//               child: Text(i.docName),
//               value: i.docName,
//             ));
//           }
//
//           // Use the prefilled document type if available, otherwise default to the first item
//           String initialValue = documentTypeName ?? dropDownList[0].value!;
// return CustomDropdownTextFieldwidh(headText: 'Select Document',
// dropDownMenuList: dropDownList,
//   onChanged: (newValue) {
//     isPrefill = false;
//     for (var a in snapshot.data!) {
//       if (a.docName == newValue) {
//         documentTypeName = a.docName;
//         print("Document Type :: ${documentTypeName}");
//       }
//     }
//   },
// );
//
//         } else {
//           return CustomDropdownTextField(
//             // width: MediaQuery.of(context).size.width / 5,
//             headText: 'Select Document',
//             items: ['No Data'],
//           );
//         }
//       },
//     );
//   }



/// ////////

  ///
  ////
  // Widget buildDropdownButton(BuildContext context) {
  //   return FutureBuilder<List<CountryGetData>>(
  //     future: getCountry(context: context),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState ==
  //           ConnectionState.waiting) {
  //         return Padding(
  //           padding: const EdgeInsets.symmetric(
  //               horizontal: 7),
  //           child: Container(
  //             height: 31,
  //             width: 250,
  //             decoration: BoxDecoration(
  //                 color: ColorManager.white),
  //           ),
  //         );
  //
  //       } else if (snapshot.hasError) {
  //         return  CustomDropdownTextField(
  //           //width: MediaQuery.of(context).size.width / 5,
  //           headText: 'Country',
  //           items: ['Error'],
  //         );
  //       } else if (snapshot.hasData) {
  //         List<DropdownMenuItem<String>> dropDownList = [];
  //         int degreeID = 0;
  //         for(var i in snapshot.data!){
  //           dropDownList.add(DropdownMenuItem<String>(
  //             child: Text(i.name),
  //             value: i.name,
  //           ));
  //         }
  //         return Container(
  //           height: 32,
  //           // margin: EdgeInsets.symmetric(horizontal: 20),
  //           padding:
  //           const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             border: Border.all(
  //                 color: const Color(0xff686464).withOpacity(0.5),
  //                 width: 1), // Black border
  //             borderRadius:
  //             BorderRadius.circular(6), // Rounded corners
  //           ),
  //           child: DropdownButtonFormField<String>(
  //             focusColor: Colors.transparent,
  //             icon: const Icon(
  //               Icons.arrow_drop_down_sharp,
  //               color: Color(0xff686464),
  //             ),
  //             decoration: InputDecoration.collapsed(hintText: ''),
  //             items: dropDownList,
  //             onChanged: (newValue) {
  //               isPrefill =false;
  //               for(var a in snapshot.data!){
  //                 if(a.name == newValue){
  //                   selectedCountry = a.name;
  //                  // selectedCountry = dropDownList[0].value!;
  //                   countryId = a.countryId;
  //                   print("country :: ${selectedCountry}");
  //                   print("country :: ${countryId}");
  //                   //empTypeId = docType;
  //                 }
  //               }
  //             },
  //             value: dropDownList[0].value,
  //             style: onlyFormDataStyle.customTextStyle(context),
  //           ),
  //         );
  //       } else {
  //         return CustomDropdownTextField(
  //           // width: MediaQuery.of(context).size.width / 5,
  //           headText: 'Country',
  //
  //           items: ['No Data'],
  //         );
  //       }
  //     },
  //   );
  // }
  ////////////////
  ///
  // Widget buildDropdownButtonDocumentType(BuildContext context) {
  //   return FutureBuilder<List<NewOrgDocument>>(
  //     future: getNewOrgDocfetch(context, AppConfig.corporateAndCompliance, AppConfig.subDocId1Licenses, 1, 200),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState ==
  //           ConnectionState.waiting) {
  //         return Padding(
  //           padding: const EdgeInsets.symmetric(
  //               horizontal: 7),
  //           child: Container(
  //             height: 31,
  //             width: 250,
  //             decoration: BoxDecoration(
  //                 color: ColorManager.white),
  //           ),
  //         );
  //
  //       } else if (snapshot.hasError) {
  //         return  CustomDropdownTextField(
  //           //width: MediaQuery.of(context).size.width / 5,
  //           headText: 'Select Document',
  //           items: ['Error'],
  //         );
  //       } else if (snapshot.hasData) {
  //         List<DropdownMenuItem<String>> dropDownList = [];
  //
  //         for(var i in snapshot.data!){
  //           dropDownList.add(DropdownMenuItem<String>(
  //             child: Text(i.docName),
  //             value: i.docName,
  //           ));
  //         }
  //         return Container(
  //           height: 32,
  //           // margin: EdgeInsets.symmetric(horizontal: 20),
  //           padding:
  //           const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             border: Border.all(
  //                 color: const Color(0xff686464).withOpacity(0.5),
  //                 width: 1), // Black border
  //             borderRadius:
  //             BorderRadius.circular(6), // Rounded corners
  //           ),
  //           child: DropdownButtonFormField<String>(
  //             focusColor: Colors.transparent,
  //             icon: const Icon(
  //               Icons.arrow_drop_down_sharp,
  //               color: Color(0xff686464),
  //             ),
  //             decoration: InputDecoration.collapsed(hintText: ''),
  //             items: dropDownList,
  //             onChanged: (newValue) {
  //               isPrefill =false;
  //               for(var a in snapshot.data!){
  //                 if(a.docName == newValue){
  //                   documentTypeName = a.docName;
  //                   // selectedCountry = dropDownList[0].value!;
  //                   // countryId = a.countryId;
  //                   print("documentType :: ${documentTypeName}");
  //                   // print("country :: ${countryId}");
  //                   //empTypeId = docType;
  //                 }
  //               }
  //             },
  //             value: dropDownList[0].value,
  //             style: onlyFormDataStyle.customTextStyle(context),
  //           ),
  //         );
  //       } else {
  //         return CustomDropdownTextField(
  //           // width: MediaQuery.of(context).size.width / 5,
  //           headText: 'Select Document',
  //
  //           items: ['No Data'],
  //         );
  //       }
  //     },
  //   );
  // }
}
