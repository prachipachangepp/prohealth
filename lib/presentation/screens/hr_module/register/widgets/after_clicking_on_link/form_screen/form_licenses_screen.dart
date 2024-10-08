import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/zone_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_licenses_manager.dart';
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
import '../../../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';
import '../../../taxtfield_constant.dart';

class LicensesScreen extends StatefulWidget {
  final int employeeID;
  const LicensesScreen({
    super.key,
    required this.context,
    required this.employeeID,
  });

  final BuildContext context;

  @override
  State<LicensesScreen> createState() => _LicensesScreenState();
}

class _LicensesScreenState extends State<LicensesScreen> {
  List<GlobalKey<_licensesFormState>> licenseFormKeys = [];
  bool isVisible = false;
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
    ApiDataRegister result = await postlicensesscreenData(
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
    print('LicenseId :: ${result.licenses!}');
    await uploadlinceses(
      context: context,
      employeeid: employeeId,
      documentFile: documentFile,
      documentName: documentName,
      licensedId: result.licenses!,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddSuccessPopup(
          message: 'Licenses data saved',
        );
      },
    );

    if (result.success) {
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddSuccessPopup(
            message: 'Failed to update user data',
          );
        },
      );
    }
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
      setState(() {
        licenseFormKeys = List.generate(
          prefilledData.length,
              (index) => GlobalKey<_licensesFormState>(),
        );
      });
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
                      style: DefineWorkWeekStyle.customTextStyle(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: DefineWorkWeekStyle.customTextStyle(context),
                  ),
                  Expanded(
                    child: Text(
                      'Please note, MSW and Chaplains do not need a License. Rather , they need academic credentials.',
                      style: DefineWorkWeekStyle.customTextStyle(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style:DefineWorkWeekStyle.customTextStyle(context),
                  ),
                  Expanded(
                    child: Text(
                      'Clinical Staff MUST fill this section out. ',
                      style:DefineWorkWeekStyle.customTextStyle(context),
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
          padding: const EdgeInsets.only(left: 150),
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
            CustomButton(
              width: 117,
              height: 30,
              text: 'Save',
              style:BlueButtonTextConst.customTextStyle(context),
              borderRadius: 12,
              onPressed: () async {
                for (var key in licenseFormKeys) {
                  try{
                    final st = key.currentState!;
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
                        documentType: 'NA',
                        documentFile: st.finalPath,
                        documentName: st.fileName);
                  }catch(e){
                   print(e);
                  }

                }
                //licensure.clear();
              },
              child: Text(
                'Save',
                style: BlueButtonTextConst.customTextStyle(context),
              ),
            ),
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
  TextEditingController firstName = TextEditingController();
  TextEditingController licensure = TextEditingController();
  TextEditingController org = TextEditingController();
  TextEditingController licensurenumber = TextEditingController();
  TextEditingController controllerIssueDate = TextEditingController();
  TextEditingController controllerExpirationDate = TextEditingController();

  String? selectedCountry;
  int? licenseIdIndex;
  String? licenseUrl;
  int countryId =0;

  final StreamController<List<AEClinicalReportingOffice>> Countrystream =
      StreamController<List<AEClinicalReportingOffice>>();
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
          //selectedCountry = data.country ?? '';
          licenseIdIndex = data.licenseId ?? 0;
          //licenseUrl = data.licenseUrl;
           licenseUrl = data.licenseUrl.split('/').last;
        });
      }
    } catch (e) {
      print('Failed to load prefilled data: $e');
    }
  }
  Future<void> _handleFileUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = result.files.first;
      setState(() {
        fileName = file.name;
        finalPath = file.bytes;
      });
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
                style: DefineWorkWeekStyle.customTextStyle(context),
              ),
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
                      height: 32,
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
                    Container(
                      height: 32,
                      child: buildDropdownButton(context),
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Issue Date',
                      style:AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            100),
                    CustomTextFieldRegister(
                      controller: controllerIssueDate,
                      hintText: 'yyyy-MM-dd',
                      hintStyle:onlyFormDataStyle.customTextStyle(context),
                      height: 32,
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
                            100),
                    Text(
                      'Expiration Date',
                      style: AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            100),
                    CustomTextFieldRegister(
                      controller: controllerExpirationDate,
                      hintText: 'dd-mm-yyyy',
                      hintStyle: onlyFormDataStyle.customTextStyle(context),
                      height: 32,
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
                    SizedBox(height: 150)
                  ],
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
                  style:DefineWorkWeekStyle.customTextStyle(context),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: _handleFileUpload,
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
  Widget buildDropdownButton(BuildContext context) {
    return FutureBuilder<List<CountryGetData>>(
      future: getCountry(context: context),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 7),
            child: Container(
              height: 31,
              width: 250,
              decoration: BoxDecoration(
                  color: ColorManager.white),
            ),
          );

        } else if (snapshot.hasError) {
          return  CustomDropdownTextField(
            //width: MediaQuery.of(context).size.width / 5,
            labelText: 'Country',
            labelStyle: onlyFormDataStyle.customTextStyle(context),
            labelFontSize: 12,
            items: ['Error'],
          );
        } else if (snapshot.hasData) {
          List<DropdownMenuItem<String>> dropDownList = [];
          int degreeID = 0;
          for(var i in snapshot.data!){
            dropDownList.add(DropdownMenuItem<String>(
              child: Text(i.name),
              value: i.name,
            ));
          }
          return Container(
            height: 32,
            // margin: EdgeInsets.symmetric(horizontal: 20),
            padding:
            const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: const Color(0xff686464).withOpacity(0.5),
                  width: 1), // Black border
              borderRadius:
              BorderRadius.circular(6), // Rounded corners
            ),
            child: DropdownButtonFormField<String>(
              focusColor: Colors.transparent,
              icon: const Icon(
                Icons.arrow_drop_down_sharp,
                color: Color(0xff686464),
              ),
              decoration: const InputDecoration.collapsed(hintText: ''),
              items: dropDownList,
              onChanged: (newValue) {
                for(var a in snapshot.data!){
                  if(a.name == newValue){
                    selectedCountry = a.name;
                    countryId = a.countryId;
                    print("country :: ${selectedCountry}");
                    //empTypeId = docType;
                  }
                }
              },
              value: dropDownList[0].value,
              style: onlyFormDataStyle.customTextStyle(context),
            ),
          );
        } else {
          return CustomDropdownTextField(
            // width: MediaQuery.of(context).size.width / 5,
            labelText: 'Country',
            labelStyle: onlyFormDataStyle.customTextStyle(context),
            labelFontSize: 11,
            items: ['No Data'],
          );
        }
      },
    );
  }
}
