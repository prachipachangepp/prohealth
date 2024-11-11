import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_general_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/onlink_general_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/onlink_general/onlink_general_data.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../app/services/api/managers/establishment_manager/google_aotopromt_api_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/employeement_manager.dart';
import '../../../../../../../app/services/token/token_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../../manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';
import '../../../taxtfield_constant.dart';

class generalForm extends StatefulWidget {
  final int employeeID;
  //final int userId;
  final Function onSave;
  //final Function onBack;
  generalForm({
    super.key,
    required this.context,
    required this.employeeID, required this.onSave,
    //required this.onBack,
  });

  final BuildContext context;

  @override
  State<generalForm> createState() => _generalFormState();
}

class _generalFormState extends State<generalForm> {
  double textFieldWidth = 430;
  double textFieldHeight = 38;

  TextEditingController dobcontroller = TextEditingController();
  TextEditingController dobcontrollervv = TextEditingController();

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController ssecuritynumber = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController personalemail = TextEditingController();
  TextEditingController driverlicensenumb = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController spalicity = TextEditingController();

  // Current step in the stepper
  int _currentStep = 0;
  bool isChecked = false;
  String? specialityName;
  String? clinicialName;
  bool get isFirstStep => _currentStep == 0;
  bool isCompleted = false;
  String? _selectedCountry;
  String? _selectedClinician;
  String? _selectedSpeciality;
  String? _selectedDegree;
  late bool _passwordVisible = false;
  String? gendertype;
  int? generalId;
  bool isLoading = false;
  String? racetype;

  String? _fileNames;
  bool _loading = false;
  bool _documentUploaded = true;
  var fileName;
  var fileName1;
  dynamic filePath;
  File? xfileToFile;
  var finalPath;
  String? signatureUrl;
  void initState() {
    super.initState();
    _initializeFormWithPrefilledData();
   // address.addListener(_onCountyNameChanged);
  }



  var fetchedData;
  Future<void> _initializeFormWithPrefilledData() async {
    try {
      OnlinkGeneralData onlinkGeneralData = await getGeneralIdPrefill(context, widget.employeeID);
      // if (onlinkGeneralData) {
      fetchedData = onlinkGeneralData;
      var data = onlinkGeneralData; // Assuming index matches the data list
      setState(() {
        print("Inside function");
       dobcontroller.text = data.dateOfBirth ?? '';
        firstname.text = data.firstName ?? '';
        lastname.text = data.lastName ?? '';
        ssecuritynumber.text = data.SSNNbr ?? '';
        phonenumber.text = data.secondryPhoneNbr ?? '';
        personalemail.text = data.personalEmail ?? '';
        driverlicensenumb.text = data.driverLicenceNbr ?? '';
        address.text = data.finalAddress ?? '';
        spalicity.text = data.expertise ?? '';
        racetype = data.race ?? "";
        //isChecked = data.endDate == null;
        gendertype = data.gender ?? "";
        generalId = data.employeeId ?? 0;
        signatureUrl = data.signatureURL ?? "";
        fileName = data.imgurl.split("/").last??"";
      });
      //}
    } catch (e) {
      print('Failed to load prefilled data: $e');
    }
  }
////
  Future<WebFile> saveFileFromBytes(dynamic bytes, String fileName) async {
    // Get the directory to save the file.
    final blob = html.Blob(bytes);
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create the file.
    //final anchor = html.AnchorElement(href: url)..setAttribute("download", fileName)..click();
    final file = html.File([blob], fileName);
    // Write the bytes to the file.
    print(file.toString());
    return WebFile(file, url);
  }

  Future<XFile> convertBytesToXFile(Uint8List bytes, String fileName) async {
    // Create a Blob from the bytes
    final blob = html.Blob([bytes]);

    // Create an object URL from the Blob
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create a File from the Blob
    final file = html.File([blob], fileName);

    print("XFILE ${url}");

    // Return the XFile created from the object URL
    return XFile(url);
  }

  Future<Uint8List> loadFileBytes() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/somefile.txt');
    if (await file.exists()) {
      return await file.readAsBytes();
    } else {
      throw Exception('File not found');
    }
  }








  List<String> _suggestions = [];
  // @override
  // void initState() {
  //   super.initState();
  //   address.addListener(_onCountyNameChanged);
  // }

  @override
  void dispose() {
    super.dispose();
  }

  void _onCountyNameChanged() async {
    if (address.text.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }
    final suggestions = await fetchSuggestions(address.text);
    if (suggestions[0] == address.text) {
      setState(() {
        _suggestions.clear();
      });
    } else if (address.text.isEmpty) {
      setState(() {
        _suggestions = suggestions;
      });
    } else {
      setState(() {
        _suggestions = suggestions;
      });
    }
  }

  String? _addressDocError;
  bool _isFormValid = true;
  String? _validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      _isFormValid = false;
      return "Please Enter $fieldName";
    }
    return null;
  }
  void _validateForm() {
    setState(() {
      _isFormValid = true;
      _addressDocError =
          _validateTextField(address.text, 'Address');
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                  "General",
                  style: FormHeading.customTextStyle(context)
              ),
            ),
          ),
          const SizedBox(
            height: AppSize.s5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [


            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F7FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Please fill all your personal information below. Your personal details will be required to proceed through the recruitment process.',
                    textAlign: TextAlign.center,
                    style:ZoneDataStyle.customTextStyle(context),
                  ),
                ),
              ],
            ),

                // SizedBox(width: 1,),


          ],
          ),
          const SizedBox(
            height: AppSize.s13,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 140, right: 140, top: 50),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                          "Upload Photo",
                          style: AllPopupHeadings.customTextStyle(context)
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
                        return  Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff50B5E5),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {
                                // FilePickerResult? result = await FilePicker.platform.pickFiles(
                                //   allowMultiple: false,
                                // );
                                FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['svg','jpeg','jpg','png']
                                );

                                if (result != null) {
                                  print("Result::: ${result}");

                                  try {
                                    Uint8List? bytes = result.files.first.bytes;
                                    XFile xlfile =
                                    XFile(result.xFiles.first.path);
                                    xfileToFile = File(xlfile.path);

                                    print(
                                        "::::XFile To File ${xfileToFile.toString()}");
                                    XFile xFile = await convertBytesToXFile(
                                        bytes!, result.xFiles.first.name);
                                    // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
                                    // html.File file = webFile.file;
                                    //  print("XFILE ${xFile.path}");
                                    //  //filePath = xfileToFile as XFile?;
                                    //  print("L::::::${filePath}");
                                    // _fileNames.addAll(
                                    //     result.files.map((file) => file.name!));
                                    print('File picked: ${fileName}');
                                    //print(String.fromCharCodes(file));
                                    fileName = result.files.first.name;
                                    finalPath = result.files.first.bytes;
                                    setState(() {
                                      _fileNames;
                                      _documentUploaded = true;
                                    });
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                              }, //_pickFiles,

                              label: Text(
                                "Choose File",
                                style:BlueButtonTextConst.customTextStyle(context),
                              ),
                              icon: const Icon(Icons.file_upload_outlined),
                            ),
                            _loading
                                ? SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                color: ColorManager
                                    .blueprime, // Loader color
                                // Loader size
                              ),
                            )
                                : fileName != null
                                ? Padding(
                              padding:
                              const EdgeInsets.all(8.0),
                              child: Text(
                                  'File picked: $fileName',
                                  style: onlyFormDataStyle.customTextStyle(context)
                              ),
                            )
                                :  SizedBox(height: 40,width: 10,),
                          ],
                        ),

                      );

                        },

                      ),
                      // Display file names if picked

                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 30),
                      Text(
                          'Legal First Name',
                          style: AllPopupHeadings.customTextStyle(context)
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      CustomTextFieldRegister(
                        controller: firstname,
                        hintText: 'Enter First Name',
                        hintStyle: onlyFormDataStyle.customTextStyle(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        height: 32,
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 30),
                      Text(
                        'Legal Last Name',
                        style:  AllPopupHeadings.customTextStyle(context),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      CustomTextFieldRegister(
                        controller: lastname,
                        hintText: 'Enter Last Name',
                        hintStyle: onlyFormDataStyle.customTextStyle(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        height: 32,
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 30),
                      Text(
                        'Social Security Number',
                        style: AllPopupHeadings.customTextStyle(context),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      StatefulBuilder(
                        builder: (BuildContext context, void Function(void Function()) setState) {
                          return CustomTextFieldSSn(
                          controller: ssecuritynumber,
                          hintText: 'Enter Security Number',
                          obscureText: !_passwordVisible,
                          hintStyle: onlyFormDataStyle.customTextStyle(context),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                            icon: Icon(
                              color: const Color(0xff50B5E5),
                              size: 16,
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              //color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          height: 32,
                          keyboardType:  TextInputType.number,
                        ); },

                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 30),
                      Text(
                        'Personal Mobile Number',
                        style:  AllPopupHeadings.customTextStyle(context),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      CustomTextFieldRegisterPhone(
                        controller: phonenumber,
                        keyboardType: TextInputType.name,
                        hintText: 'Enter Mobile Number',
                        hintStyle: onlyFormDataStyle.customTextStyle(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        height: 32,
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 30),
                      Text(
                        'Personal Email',
                        style:  AllPopupHeadings.customTextStyle(context),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      CustomTextFieldForEmail(
                        controller: personalemail,
                        hintText: 'Enter Email',
                        hintStyle:  onlyFormDataStyle.customTextStyle(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        height: 32,
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 30),
                      Text(
                        'Driver’s License Number',
                        style:  AllPopupHeadings.customTextStyle(context),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      CustomTextFieldRegister(
                        controller: driverlicensenumb,
                        hintText: 'Enter License Number',
                        hintStyle:  onlyFormDataStyle.customTextStyle(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        height: 32,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                    // SizedBox(height: 10,),
                      Text(
                        "Gender",
                        style: AllPopupHeadings.customTextStyle(context),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      StatefulBuilder(
                        builder: (BuildContext context, void Function(void Function()) setState) { return  Container(
                          width: 400,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              CustomRadioListTile(
                                title: 'Male',
                                value: 'Male',
                                groupValue: gendertype,
                                onChanged: (value) {
                                  setState(() {
                                    gendertype = value;
                                  });
                                },
                              ),
                              CustomRadioListTile(
                                title: 'Female',
                                value: 'Female',
                                groupValue: gendertype,
                                onChanged: (value) {
                                  setState(() {
                                    gendertype = value;
                                  });
                                },
                              ),
                              CustomRadioListTile(
                                title: 'Other',
                                value: 'Other',
                                groupValue: gendertype,
                                onChanged: (value) {
                                  setState(() {
                                    gendertype = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        );  },

                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 29),
                      Text(
                        'DOB',
                        style: AllPopupHeadings.customTextStyle(context),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      CustomTextFieldRegister(
                        controller: dobcontroller,
                        hintText: 'yyyy-mm-dd',
                        hintStyle: onlyFormDataStyle.customTextStyle(context),
                        height: 32,
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.calendar_month_outlined,
                            color: Color(0xff50B5E5),
                            size: 16,
                          ),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1901),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              dobcontroller.text =
                              "${pickedDate.toLocal()}".split(' ')[0];
                            }
                          },
                        ),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 30),
                      AddressInput(
                        controller: address,
                        onSuggestionSelected: (selectedSuggestion) {
                          // Handle the selected suggestion here
                          print("Selected suggestion: $selectedSuggestion");
                        }, onChanged: (String ) {

                      },
                      ),
                      if (_addressDocError != null) // Display error if any
                        Row(
                          children: [
                            Text(
                              _addressDocError!,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: FontSize.s10,
                              ),
                            ),
                          ],
                        ),
                      // Stack(
                      //   children :[
                      //     Column(
                      //       children: [
                      //         Row(
                      //           children: [
                      //             Text(
                      //               'Address',
                      //               style:AllPopupHeadings.customTextStyle(context),
                      //             ),
                      //           ],
                      //         ),
                      //         SizedBox(
                      //             height:
                      //             MediaQuery.of(context).size.height / 60),
                      //         CustomTextFieldRegister(
                      //           controller: address,
                      //           hintText: 'Enter Address',
                      //           hintStyle: onlyFormDataStyle.customTextStyle(context),
                      //           validator: (value) {
                      //             if (value == null || value.isEmpty) {
                      //               return 'Please enter some text';
                      //             }
                      //             return null;
                      //           },
                      //           height: 32,
                      //         ),
                      //         if (_addressDocError != null) // Display error if any
                      //           Row(
                      //             children: [
                      //               Text(
                      //                 _addressDocError!,
                      //                 style: TextStyle(
                      //                   color: Colors.red,
                      //                   fontSize: FontSize.s10,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //       ],
                      //     ),
                      //   ]
                      // ),
                      // if (_suggestions.isNotEmpty)
                      //   Container(
                      //     height: 100,
                      //     width: 320,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(8),
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.black26,
                      //           blurRadius: 4,
                      //           offset: Offset(0, 2),
                      //         ),
                      //       ],
                      //     ),
                      //     child: ListView.builder(
                      //       shrinkWrap: true,
                      //       itemCount: _suggestions.length,
                      //       itemBuilder: (context, index) {
                      //         return ListTile(
                      //           title: Text(
                      //             _suggestions[index],
                      //             style: onlyFormDataStyle.customTextStyle(context),
                      //           ),
                      //           onTap: () {
                      //             FocusScope.of(context)
                      //                 .unfocus(); // Dismiss the keyboard
                      //             String selectedSuggestion = _suggestions[index];
                      //             address.text = selectedSuggestion;
                      //
                      //             setState(() {
                      //               _suggestions.clear();
                      //               //_suggestions.removeWhere((suggestion) => suggestion == selectedSuggestion);
                      //             });
                      //           },
                      //         );
                      //       },
                      //     ),
                      //   ),

                      ///
                      // SizedBox(
                      //     height:
                      //     MediaQuery.of(context).size.height / 30),
                      // Text(
                      //   'Type of Clinician',
                      //   style: AllPopupHeadings.customTextStyle(context),
                      // ),
                      // SizedBox(
                      //     height:
                      //     MediaQuery.of(context).size.height / 60),
                      //
                      // ///clinician
                      // FutureBuilder<List<AEClinicalDiscipline>>(
                      //   future: HrAddEmplyClinicalDisciplinApi(context, 1),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       return Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 7),
                      //         child: Container(
                      //           width: AppSize.s250,
                      //           height: AppSize.s32,
                      //           decoration: BoxDecoration(
                      //               color: ColorManager.white),
                      //         ),
                      //       );
                      //
                      //     }
                      //     if (snapshot.hasData) {
                      //       List<String> dropDownList = [];
                      //       for (var i in snapshot.data!) {
                      //         dropDownList.add(i.empType!);
                      //       }
                      //       return StatefulBuilder(
                      //         builder: (BuildContext context, void Function(void Function()) setState) {
                      //           return  SizedBox(
                      //             height: 32,
                      //             child: DropdownButtonFormField<String>(
                      //               decoration: InputDecoration(
                      //                 // hintText: 'Select Clinician',
                      //                 hintStyle:onlyFormDataStyle.customTextStyle(context),
                      //                 border: OutlineInputBorder(
                      //                   borderRadius:
                      //                   BorderRadius.circular(4.0),
                      //                   borderSide: const BorderSide(
                      //                       color: Colors.grey),
                      //                 ),
                      //                 contentPadding:
                      //                 const EdgeInsets.symmetric(
                      //                   //   //  vertical: 5,
                      //                     horizontal: 12),
                      //               ),
                      //               // value: selectedCountry,
                      //               icon: Icon(Icons.arrow_drop_down,
                      //                   color: Color(0xff9B9B9B)),
                      //               iconSize: 24,
                      //               elevation: 16,
                      //               style:onlyFormDataStyle.customTextStyle(context),
                      //
                      //               onChanged: (newValue) {
                      //                 for (var a in snapshot.data!) {
                      //                   if (a.empType == newValue) {
                      //                     _selectedClinician = a.empType!;
                      //                     //country = a
                      //                     // int? docType = a.companyOfficeID;
                      //                   }
                      //                 }
                      //               },
                      //               items: dropDownList.map((String value) {
                      //                 return DropdownMenuItem<String>(
                      //                   value: value,
                      //                   child: Text(
                      //                     value,
                      //                     style: onlyFormDataStyle.customTextStyle(context),
                      //                   ),
                      //                 );
                      //               }).toList(),
                      //             ),
                      //           );
                      //         },
                      //
                      //       );
                      //     } else {
                      //       return const Offstage();
                      //     }
                      //   },
                      // ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 30),
                      Text(
                        'Speciality',
                        style: AllPopupHeadings.customTextStyle(context),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      CustomTextFieldRegister(
                   controller: spalicity,
                        hintText: 'Enter Speciality',
                        hintStyle:  onlyFormDataStyle.customTextStyle(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        height: 32,
                      ),


                        //   FutureBuilder<List<AEClinicalDiscipline>>(
                        //   future:
                        //   HrAddEmplyClinicalDisciplinApi(context, 1),
                        //   builder: (context, snapshot) {
                        //     if (snapshot.connectionState ==
                        //         ConnectionState.waiting) {
                        //       return Padding(
                        //         padding: const EdgeInsets.symmetric(
                        //             horizontal: 7),
                        //         child: Container(
                        //           width: AppSize.s250,
                        //           height: AppSize.s32,
                        //           decoration: BoxDecoration(
                        //               color: ColorManager.white),
                        //         ),
                        //       );
                        //
                        //     }
                        //     if (snapshot.hasData) {
                        //       List<String> dropDownList = [];
                        //
                        //       for (var i in snapshot.data!) {
                        //         dropDownList.add(i.empType!);
                        //       }
                        //       return StatefulBuilder(
                        //         builder: (BuildContext context, void Function(void Function()) setState) {
                        //           return SizedBox(
                        //             height: 32,
                        //             child: DropdownButtonFormField<String>(
                        //               decoration: InputDecoration(
                        //                 // hintText: 'Select Clinician',
                        //                 hintStyle: onlyFormDataStyle.customTextStyle(context),
                        //                 border: OutlineInputBorder(
                        //                   borderRadius:
                        //                   BorderRadius.circular(4.0),
                        //                   borderSide: const BorderSide(
                        //                       color: Colors.grey),
                        //                 ),
                        //                 contentPadding:
                        //                 const EdgeInsets.symmetric(
                        //                   //   //  vertical: 5,
                        //                     horizontal: 12),
                        //               ),
                        //               // value: selectedCountry,
                        //               icon: Icon(Icons.arrow_drop_down,
                        //                   color: Color(0xff9B9B9B)),
                        //               iconSize: 24,
                        //               elevation: 16,
                        //               style: onlyFormDataStyle.customTextStyle(context),
                        //
                        //               onChanged: (newValue) {
                        //                 for (var a in snapshot.data!) {
                        //                   if (a.empType == newValue) {
                        //                     _selectedSpeciality = a.empType!;
                        //                     //country = a
                        //                     // int? docType = a.companyOfficeID;
                        //                   }
                        //                 }
                        //               },
                        //               items: dropDownList.map((String value) {
                        //                 return DropdownMenuItem<String>(
                        //                   value: value,
                        //                   child: Text(
                        //                     value,
                        //                     style: onlyFormDataStyle.customTextStyle(context),
                        //                   ),
                        //                 );
                        //               }).toList(),
                        //             ),
                        //           );
                        //         },
                        //
                        //       );
                        //     } else {
                        //       return const Offstage();
                        //     }
                        //   },
                        // ),

                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 30),
                      Text(
                        "Race",
                        style: AllPopupHeadings.customTextStyle(context),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      StatefulBuilder(
                        builder: (BuildContext context, void Function(void Function()) setState) {  return Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      CustomRadioListTile(
                                        title: 'Asian',
                                        value: 'Asian',
                                        groupValue: racetype,
                                        onChanged: (value) {
                                          setState(() {
                                            racetype = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(
                                  //   width: 3,
                                  // ),

                                  Column(
                                    children: [
                                      CustomRadioListTile(
                                        title: 'White',
                                        value: 'White',
                                        groupValue: racetype,
                                        onChanged: (value) {
                                          setState(() {
                                            racetype = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(
                                  //   width: 5,
                                  // ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      CustomRadioListTile(
                                        title: 'Black or African American',
                                        value: 'Black or African American',
                                        groupValue: racetype,
                                        onChanged: (value) {
                                          setState(() {
                                            racetype = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),

                                  Column(
                                    children: [
                                      CustomRadioListTile(
                                        title: 'Other',
                                        value: 'Other',
                                        groupValue: racetype,
                                        onChanged: (value) {
                                          setState(() {
                                            racetype = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(
                                  //   width: 3,
                                  // ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomRadioListTile(
                                    title: 'Hispanic or Latino',
                                    value: 'Hispanic or Latino',
                                    groupValue: racetype,
                                    onChanged: (value) {
                                      setState(() {
                                        racetype = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ); },

                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 30),
                      Container(
                        height: 25,
                      ),
                      Container(
                        height: 25,
                      ),


                    ],
                  ),
                ),
              ],
            ),),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

    //           Container(
    //             width: 117,
    //             height: 30,
    //             child: ElevatedButton(
    //               onPressed: (){
    // widget.onBack();
    // },
    //               style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
    //                 elevation: 5,
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(12),
    //                   side: BorderSide(
    //                     color: ColorManager.bluebottom,
    //                     width: 1,
    //                   ),
    //                 ),),
    //               child: Text('Previous',
    //                 style: TransparentButtonTextConst.customTextStyle(context),
    //               ),),
    //           ),
    //           const SizedBox(
    //             width: 30,
    //           ),

              isLoading
                  ? SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: ColorManager.blueprime,
                ),
              )  :CustomButton(
                width: 117,
                height: 30,
                text: 'Save',
                style: BlueButtonTextConst.customTextStyle(context),
                borderRadius: 12,
                onPressed: () async {

                  String addressText = address.text;
                  if (addressText.isEmpty) {
                    setState(() {
                      _addressDocError = 'Address cannot be empty';
                    });
                  }else {
                    setState(() {
                      _addressDocError = null; // Clear any previous error
                    });
                    // Proceed with form submission or other logic
                    print("Address is valid: $addressText");
                  }

      // Get the company and user IDs
      setState(() {
        isLoading = true; // Start loading
      });


      final companyId = await TokenManager.getCompanyId();
      final userId = await TokenManager.getUserID();

      print("Company ID: $companyId");
      print("User ID: $userId");

      // Print the data being sent
      print("Sending data:");
      print("Employee ID: ${widget.employeeID}");
      print("Code: EMP-C10-U48");
      print("User ID: $userId");
      print("First Name: ${firstname.text}");
      print("Last Name: ${lastname.text}");
      print("Speciality: ${spalicity.text}");
      print("File: ${filePath}");
      print("SSN: ${ssecuritynumber.text}");
      print("Phone Number: ${phonenumber.text}");
      print("Personal Email: ${personalemail.text}");
      print("Address: ${address.text}");
      print("Date of Birth: ${dobcontroller.text}");
      print("Gender: ${gendertype.toString()}");
      print("Driver License Number: ${driverlicensenumb.text}");
      print("Position: position");
      print("Clinician: ${_selectedClinician.toString()}");
      print("Race: ${racetype.toString()}");


      // Call the update function
      var response = await updateOnlinkGeneralPatch(
        context,
        generalId!,
        '',
        userId,
        firstname.text,
        lastname.text,
        1,
        // 1,
        spalicity.text,
        // 1,
        1,
        1,
        // 1,
        ssecuritynumber.text,
        //  '',
        phonenumber.text,
        '',
        // '',
        personalemail.text,
        //  personalemail.text,
        address.text,
        dobcontroller.text,
        '',
        'covreage',
        //'employment',
        gendertype.toString(),
        'Partial',
        // 'service',
        'imgurl',
        'resumeurl',
        companyId,
        'Active',
        driverlicensenumb.text,
        "0000-00-00",
        //'2024-01-01',
        "0000-00-00",
        //'2024-01-01',
        // '',// '2024-01-01',
        'rehirable',
        'position',
        address.text,
        _selectedClinician.toString(),
        'reason',
        1,
        "0000-00-00",
        //'2024-01-01',
        1,
        1,
        'methods',
        'materials',
        racetype.toString(),
        'rating',
        signatureUrl!,
      );
      var uploadResponse = await UploadEmployeePhoto(
          context: context, documentFile: finalPath, employeeId: generalId!);
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.data}");

      if (response.statusCode == 200 ||
          response.statusCode == 201 && uploadResponse.statusCode == 200 ||
          uploadResponse.statusCode == 201) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("User data updated"),backgroundColor: Colors.green,),
        // );
   await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddSuccessPopup(
              message: 'User Data Updated',
            );
          },
        );
        _initializeFormWithPrefilledData();
        widget.onSave();
      } else {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddFailePopup(
              message: 'Failed To Update User Data',
            );
          },
        );
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("Failed to update user data")),
        // );
      }
      setState(() {
        isLoading = false; // End loading
      });

    // Clear fields after saving
    // firstname.clear();
    // lastname.clear();
    // ssecuritynumber.clear();
    // phonenumber.clear();
    // personalemail.clear();
    // driverlicensenumb.clear();
    // address.clear();
    // dobcontroller.clear();

    },

                child: Text(
                  'Save',
                  style: BlueButtonTextConst.customTextStyle(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddressInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onSuggestionSelected;
  final Function(String) onChanged;// Callback to notify parent

  AddressInput({required this.controller, this.onSuggestionSelected, required this.onChanged});

  @override
  _AddressInputState createState() => _AddressInputState();
}

class _AddressInputState extends State<AddressInput> {
  List<String> _suggestions = [];
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onCountyNameChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onCountyNameChanged);
    _removeOverlay();
    super.dispose();
  }

  void _onCountyNameChanged() async {
    final query = widget.controller.text;
    if (query.isEmpty) {
      _suggestions.clear();
      _removeOverlay();
      return;
    }

    final suggestions = await fetchSuggestions(query);
    setState(() {
      _suggestions = suggestions.isNotEmpty && suggestions[0] != query ? suggestions : [];
    });
    _showOverlay();
  }

  void _showOverlay() {
    _removeOverlay();

    if (_suggestions.isEmpty) return;

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy + renderBox.size.height,
        width: 354,
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: _suggestions.length > 5 ? 80.0 : double.infinity,
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _suggestions[index],
                      style: TableSubHeading.customTextStyle(context),
                    ),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      widget.controller.text = _suggestions[index];
                      _suggestions.clear();
                      _removeOverlay();

                      // Call the callback with the selected suggestion
                      if (widget.onSuggestionSelected != null) {
                        widget.onSuggestionSelected!(_suggestions[index]);
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        Row(
          children: [
            Text(
              'Address',
              style:AllPopupHeadings.customTextStyle(context),
            ),
          ],
        ),
        SizedBox(
            height:
            MediaQuery.of(context).size.height / 60),
        CustomTextFieldRegister(
          controller: widget.controller,
          hintText: 'Enter Address',
          hintStyle: onlyFormDataStyle.customTextStyle(context),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          height: 32,
          onChanged: widget.onChanged,
        ),

      ],
    );
  }
}




