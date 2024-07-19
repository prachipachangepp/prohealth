import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import '../../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../manage/widgets/custom_icon_button_constant.dart';
import 'clinical.dart';
import 'mcq_widget_add-employee.dart';

///prachi
class SalesTab extends StatefulWidget {
  @override
  State<SalesTab> createState() => _SalesTabState();
}

class _SalesTabState extends State<SalesTab> {
  final TextEditingController _sale1Controller = TextEditingController();
  final TextEditingController _workemailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _personalnoController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _worknoController = TextEditingController();
  final TextEditingController _dateofbirthController = TextEditingController();
  final TextEditingController _personalemailController =
      TextEditingController();
  final TextEditingController ctlrfirstName = TextEditingController();
  final TextEditingController ctlrlastName = TextEditingController();
  final TextEditingController ctlrSocialSecurity = TextEditingController();
  final TextEditingController ctlrprimeNo = TextEditingController();
  final TextEditingController ctlrsecNo = TextEditingController();
  final TextEditingController ctlrworkNo = TextEditingController();
  final TextEditingController ctlrCountry = TextEditingController();
  final TextEditingController ctlrPersonalEmail = TextEditingController();
  final TextEditingController ctlrWorkEmail = TextEditingController();
  final TextEditingController ctlrAddress = TextEditingController();
  final TextEditingController ctlrEmContact = TextEditingController();
  final TextEditingController ctlrDob = TextEditingController();

  int? _selectedItemIndex;

  String? _fileName;
  DateTime? selectedDate;
  late DateTime _selectedDate;
  List<DateTime?> dobList = [];
  List<String> _personalEmails = [];
  bool _isLoading = true;
  late Future<List<HRAddEmployeeGet>> _futureData;


  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        ctlrDob.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }
  List<String> _socialSecurityNumbers = [];
  ///ssnbr
  Future<void> _saveSSNBrData() async {
    try {
      final data = await _futureData;
      setState(() {
        _socialSecurityNumbers = data
            .map((e) => e.ssnnBr)
            .where((number) => number != null)
            .cast<String>()
            .toList();
      });
    } catch (e) {
      // Handle error
      print("Error fetching data: $e");
    }
  }
  @override
  void initState() {
    super.initState();
    _fetchData();
    _futureData = HrAddEmployeeget(context);
  }

  Future<void> _fetchData() async {
    try {
      List<HRAddEmployeeGet> data = await HrAddEmployeeget(context);
      setState(() {
        _personalEmails = data
            .map((e) => e.personalEmail)
            .where((email) => email != null)
            .cast<String>()
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    double containerHeight1 = MediaQuery.of(context).size.height * 0.32;
    // double containerHeight2 = 100;
    // MediaQuery.of(context).size.height * 0.2;
    double textFieldWidth = 200;
    double textFieldHeight = 38;
    FocusNode _focusNode = FocusNode();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: 700,
        width: 400,
        child: Column(
          children: [
            ///upload photo button
            Expanded(
              child: Container(
                // color: Colors.pink,
                // height: 40,
                width: MediaQuery.of(context).size.width / 1,
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_fileName != null)
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text(
                          _fileName!,
                          style: TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.image,
                          allowMultiple: false,
                        );

                        if (result != null) {
                          PlatformFile file = result.files.first;
                          setState(() {
                            _fileName = file.name;
                          });
                          print('File path: ${file.path}');
                        }
                      },
                      icon: Icon(
                        Icons.file_upload_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Upload Photo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'FiraSans',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1696C8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ),

            ///first container
            Expanded(
              flex: 2,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  // height: 200,
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: Color(0xffB7B7B7),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ///position
                          FutureBuilder<List<AEClinicalDiscipline>>(
                            future: HrAddEmplyClinicalDisciplinApi(context,1),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                    child: Container(
                                      width: AppSize.s250,
                                      height: AppSize.s40,
                                      decoration: BoxDecoration(
                                          color: ColorManager.faintGrey),
                                    ),
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                List<String> dropDownList = [];
                                for (var i in snapshot.data!) {
                                  dropDownList.add(i.empType!);
                                }
                                return CustomDropdownTextField(
                                  labelText: 'Position',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 10,
                                  items: dropDownList,
                                  onChanged: (newValue) {
                                    for (var a in snapshot.data!) {
                                      if (a.empType == newValue) {
                                        // int docType = a.employeeTypesId;
                                        // Do something with docType
                                      }
                                    }
                                  },
                                );
                              } else {
                                return const Offstage();
                              }
                            },
                          ),

                          ///social security
                          FutureBuilder<List<HRAddEmployeeGet>>(
                            future: _futureData,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7),
                                    child: Container(
                                      width: AppSize.s250,
                                      height: AppSize.s40,
                                      decoration: BoxDecoration(
                                          color: ColorManager.faintGrey),
                                    ),
                                  ),
                                );
                              }

                              if (snapshot.hasData) {
                                if (_socialSecurityNumbers.isEmpty) {
                                  _saveSSNBrData();
                                  print("ssNBR");
                                }

                                return Autocomplete<String>(
                                  optionsBuilder:
                                      (TextEditingValue textEditingValue) {
                                    if (textEditingValue.text.isEmpty) {
                                      return const Iterable<String>.empty();
                                    } else {
                                      return _socialSecurityNumbers
                                          .where((String option) {
                                        return option
                                            .contains(textEditingValue.text);
                                      });
                                    }
                                  },
                                  optionsViewBuilder: (BuildContext context,
                                      AutocompleteOnSelected<String> onSelected,
                                      Iterable<String> options) {
                                    return Align(
                                      alignment: Alignment.topLeft,
                                      child: Material(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(4.0)),
                                        ),
                                        child: Container(
                                          width: textFieldWidth,
                                          constraints:
                                          BoxConstraints(maxHeight: 200.0),
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount: options.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final String option =
                                              options.elementAt(index);
                                              return ListTile(
                                                title: Text(
                                                  option,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 12,
                                                    color: Color(0xff575757),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                onTap: () {
                                                  onSelected(option);
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  fieldViewBuilder: (BuildContext context,
                                      TextEditingController ctlrSocialSecurity,
                                      FocusNode focusNode,
                                      VoidCallback onFieldSubmitted) {
                                    return CustomTextField(
                                      width: textFieldWidth,
                                      height: textFieldHeight,
                                      cursorHeight: 20,
                                      labelText: 'Social Security No',
                                      labelStyle: GoogleFonts.firaSans(
                                        fontSize: 12,
                                        color: Color(0xff575757),
                                        fontWeight: FontWeight.w400,
                                      ),
                                      controller: ctlrSocialSecurity,
                                      suffixIcon: Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: Colors.blue,
                                        size: 14,
                                      ),
                                      focusNode: focusNode,
                                      labelFontSize: 12,
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else {
                                return const Offstage();
                              }
                            },
                          ),




                          ///work email
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 22,
                            labelText: 'Work Email',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 12,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: ctlrWorkEmail,
                            labelFontSize: 12,
                          ),
                          ///work email
                          // FutureBuilder<List<HRAddEmployeeGet>>(
                          //   future: HrAddEmployeeget(context),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding:
                          //               const EdgeInsets.symmetric(horizontal: 7),
                          //           child: Container(
                          //             width: AppSize.s250,
                          //             height: AppSize.s40,
                          //             decoration: BoxDecoration(
                          //                 color: ColorManager.faintGrey),
                          //           ),
                          //         ),
                          //       );
                          //     }
                          //
                          //     if (snapshot.hasData) {
                          //       List<String> personalEmail = snapshot.data!
                          //           .map(
                          //             (e) => e.personalEmail,
                          //           )
                          //           .where((email) => email != null)
                          //           .cast<String>()
                          //           .toList();
                          //       print("Personal Emails: $personalEmail,");
                          //
                          //       return Autocomplete<String>(
                          //         optionsBuilder:
                          //             (TextEditingValue textEditingValue) {
                          //           if (textEditingValue.text.isEmpty) {
                          //             return const Iterable<String>.empty();
                          //           } else {
                          //             return personalEmail.where((String option) {
                          //               return option
                          //                   .contains(textEditingValue.text);
                          //             });
                          //           }
                          //         },
                          //         optionsViewBuilder: (BuildContext context,
                          //             AutocompleteOnSelected<String> onSelected,
                          //             Iterable<String> options) {
                          //           return Align(
                          //             alignment: Alignment.topLeft,
                          //             child: Material(
                          //               shape: const RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.vertical(
                          //                     bottom: Radius.circular(4.0)),
                          //               ),
                          //               child: Container(
                          //                 width: 300,
                          //                 constraints:
                          //                     BoxConstraints(maxHeight: 200.0),
                          //                 child: ListView.builder(
                          //                   padding: EdgeInsets.zero,
                          //                   itemCount: options.length,
                          //                   itemBuilder: (BuildContext context,
                          //                       int index) {
                          //                     final String option =
                          //                         options.elementAt(index);
                          //                     return ListTile(
                          //                       title: Text(
                          //                         option,
                          //                         style: GoogleFonts.firaSans(
                          //                           fontSize: 12,
                          //                           color: Color(0xff575757),
                          //                           fontWeight: FontWeight.w400,
                          //                         ),
                          //                       ),
                          //                       onTap: () {
                          //                         onSelected(option);
                          //                       },
                          //                     );
                          //                   },
                          //                 ),
                          //               ),
                          //             ),
                          //           );
                          //         },
                          //         fieldViewBuilder: (BuildContext context,
                          //             TextEditingController ctlrWorkEmail,
                          //             FocusNode focusNode,
                          //             VoidCallback onFieldSubmitted) {
                          //           return CustomTextField(
                          //             width: textFieldWidth,
                          //             height: textFieldHeight,
                          //             cursorHeight: 22,
                          //             labelText: 'Work Email',
                          //             labelStyle: GoogleFonts.firaSans(
                          //               fontSize: 12,
                          //               color: Color(0xff575757),
                          //               fontWeight: FontWeight.w400,
                          //             ),
                          //             controller: ctlrWorkEmail,
                          //             focusNode: focusNode,
                          //             labelFontSize: 12,
                          //           );
                          //         },
                          //       );
                          //     } else {
                          //       return const Offstage();
                          //     }
                          //   },
                          // ),

                        ],
                      )),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ///first name
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 20,
                            labelText: 'First Name',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 12,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: ctlrfirstName,
                            labelFontSize: 12,
                          ),

                          ///
                          // ///first name
                          // FutureBuilder<List<HRAddEmployeeGet>>(
                          //   future: HrAddEmployeeget(context),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding:
                          //               const EdgeInsets.symmetric(horizontal: 7),
                          //           child: Container(
                          //             width: AppSize.s250,
                          //             height: AppSize.s40,
                          //             decoration: BoxDecoration(
                          //                 color: ColorManager.faintGrey),
                          //           ),
                          //         ),
                          //       );
                          //     }
                          //     if (snapshot.hasData) {
                          //       List<String> firstNames = snapshot.data!
                          //           .map((e) => e.firstName)
                          //           .where((name) => name != null)
                          //           .cast<String>()
                          //           .toList();
                          //       return Autocomplete<String>(
                          //         optionsBuilder:
                          //             (TextEditingValue textEditingValue) {
                          //           if (textEditingValue.text.isEmpty) {
                          //             return const Iterable<String>.empty();
                          //           } else {
                          //             return firstNames.where((String option) {
                          //               return option.toLowerCase().contains(
                          //                   textEditingValue.text.toLowerCase());
                          //             });
                          //           }
                          //         },
                          //         optionsViewBuilder: (BuildContext context,
                          //             AutocompleteOnSelected<String> onSelected,
                          //             Iterable<String> options) {
                          //           return Align(
                          //             alignment: Alignment.topLeft,
                          //             child: Material(
                          //               shape: const RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.vertical(
                          //                     bottom: Radius.circular(4.0)),
                          //               ),
                          //               child: Container(
                          //                 width: textFieldWidth,
                          //                 constraints:
                          //                     BoxConstraints(maxHeight: 200.0),
                          //                 child: ListView.builder(
                          //                   padding: EdgeInsets.zero,
                          //                   itemCount: options.length,
                          //                   itemBuilder: (BuildContext context,
                          //                       int index) {
                          //                     final String option =
                          //                         options.elementAt(index);
                          //                     return ListTile(
                          //                       title: Text(
                          //                         option,
                          //                         style: GoogleFonts.firaSans(
                          //                           fontSize: 12,
                          //                           color: Color(0xff575757),
                          //                           fontWeight: FontWeight.w400,
                          //                         ),
                          //                       ),
                          //                       onTap: () {
                          //                         onSelected(option);
                          //                       },
                          //                     );
                          //                   },
                          //                 ),
                          //               ),
                          //             ),
                          //           );
                          //         },
                          //         fieldViewBuilder: (BuildContext context,
                          //             TextEditingController ctlrfirstName,
                          //             FocusNode focusNode,
                          //             VoidCallback onFieldSubmitted) {
                          //           return CustomTextField(
                          //             width: textFieldWidth,
                          //             height: textFieldHeight,
                          //             cursorHeight: 20,
                          //             labelText: 'First Name',
                          //             labelStyle: GoogleFonts.firaSans(
                          //               fontSize: 12,
                          //               color: Color(0xff575757),
                          //               fontWeight: FontWeight.w400,
                          //             ),
                          //             controller: ctlrfirstName,
                          //             focusNode: focusNode,
                          //             labelFontSize: 12,
                          //           );
                          //         },
                          //       );
                          //     } else {
                          //       return const Offstage();
                          //     }
                          //   },
                          // ),



                          ///primary phone no
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 22,
                            labelText: 'Primary Phone No',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 12,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: ctlrprimeNo,
                            labelFontSize: 12,
                          ),
                          // ///personal phone no
                          // FutureBuilder<List<HRAddEmployeeGet>>(
                          //   future: HrAddEmployeeget(context),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding:
                          //               const EdgeInsets.symmetric(horizontal: 7),
                          //           child: Container(
                          //             width: AppSize.s250,
                          //             height: AppSize.s40,
                          //             decoration: BoxDecoration(
                          //                 color: ColorManager.faintGrey),
                          //           ),
                          //         ),
                          //       );
                          //     }
                          //
                          //     if (snapshot.hasData) {
                          //       List<String> primeNo = snapshot.data!
                          //           .map((e) => e.primeNo)
                          //           .where((number) => number != null)
                          //           .cast<String>()
                          //           .toList();
                          //       print("Personal Phone No: $primeNo");
                          //
                          //       return Autocomplete<String>(
                          //         optionsBuilder:
                          //             (TextEditingValue textEditingValue) {
                          //           if (textEditingValue.text.isEmpty) {
                          //             return const Iterable<String>.empty();
                          //           } else {
                          //             return primeNo.where((String option) {
                          //               return option
                          //                   .contains(textEditingValue.text);
                          //             });
                          //           }
                          //         },
                          //         optionsViewBuilder: (BuildContext context,
                          //             AutocompleteOnSelected<String> onSelected,
                          //             Iterable<String> options) {
                          //           return Align(
                          //             alignment: Alignment.topLeft,
                          //             child: Material(
                          //               shape: const RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.vertical(
                          //                     bottom: Radius.circular(4.0)),
                          //               ),
                          //               child: Container(
                          //                 width: textFieldWidth,
                          //                 constraints:
                          //                     BoxConstraints(maxHeight: 200.0),
                          //                 child: ListView.builder(
                          //                   padding: EdgeInsets.zero,
                          //                   itemCount: options.length,
                          //                   itemBuilder: (BuildContext context,
                          //                       int index) {
                          //                     final String option =
                          //                         options.elementAt(index);
                          //                     return ListTile(
                          //                       title: Text(
                          //                         option,
                          //                         style: GoogleFonts.firaSans(
                          //                           fontSize: 12,
                          //                           color: Color(0xff575757),
                          //                           fontWeight: FontWeight.w400,
                          //                         ),
                          //                       ),
                          //                       onTap: () {
                          //                         onSelected(option);
                          //                       },
                          //                     );
                          //                   },
                          //                 ),
                          //               ),
                          //             ),
                          //           );
                          //         },
                          //         fieldViewBuilder: (BuildContext context,
                          //             TextEditingController ctlrprimeNo,
                          //             FocusNode focusNode,
                          //             VoidCallback onFieldSubmitted) {
                          //           return CustomTextField(
                          //             width: textFieldWidth,
                          //             height: textFieldHeight,
                          //             cursorHeight: 22,
                          //             labelText: 'Personal Phone No',
                          //             labelStyle: GoogleFonts.firaSans(
                          //               fontSize: 12,
                          //               color: Color(0xff575757),
                          //               fontWeight: FontWeight.w400,
                          //             ),
                          //             controller: ctlrprimeNo,
                          //             focusNode: focusNode,
                          //             labelFontSize: 12,
                          //           );
                          //         },
                          //       );
                          //     } else {
                          //       return const Offstage();
                          //     }
                          //   },
                          // ),


                          ///address
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 22,
                            labelText: 'Address',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 12,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: ctlrAddress,
                            labelFontSize: 12,
                          ),
                          ///address
                          // FutureBuilder<List<HRAddEmployeeGet>>(
                          //   future: HrAddEmployeeget(context),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding:
                          //               const EdgeInsets.symmetric(horizontal: 7),
                          //           child: Container(
                          //             width: AppSize.s250,
                          //             height: AppSize.s40,
                          //             decoration: BoxDecoration(
                          //                 color: ColorManager.faintGrey),
                          //           ),
                          //         ),
                          //       );
                          //     }
                          //
                          //     if (snapshot.hasData) {
                          //       List<String> address = snapshot.data!
                          //           .map((e) => e.address)
                          //           .where((address) => address != null)
                          //           .cast<String>()
                          //           .toList();
                          //       print("Addresses: $address");
                          //       return Autocomplete<String>(
                          //         optionsBuilder:
                          //             (TextEditingValue textEditingValue) {
                          //           if (textEditingValue.text.isEmpty) {
                          //             return const Iterable<String>.empty();
                          //           } else {
                          //             return address.where((String option) {
                          //               return option.toLowerCase().contains(
                          //                   textEditingValue.text.toLowerCase());
                          //             });
                          //           }
                          //         },
                          //         optionsViewBuilder: (BuildContext context,
                          //             AutocompleteOnSelected<String> onSelected,
                          //             Iterable<String> options) {
                          //           return Align(
                          //             alignment: Alignment.topLeft,
                          //             child: Material(
                          //               shape: const RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.vertical(
                          //                     bottom: Radius.circular(4.0)),
                          //               ),
                          //               child: Container(
                          //                 width: 300,
                          //                 constraints:
                          //                     BoxConstraints(maxHeight: 200.0),
                          //                 child: ListView.builder(
                          //                   padding: EdgeInsets.zero,
                          //                   itemCount: options.length,
                          //                   itemBuilder: (BuildContext context,
                          //                       int index) {
                          //                     final String option =
                          //                         options.elementAt(index);
                          //                     return ListTile(
                          //                       title: Text(
                          //                         option,
                          //                         style: GoogleFonts.firaSans(
                          //                           fontSize: 12,
                          //                           color: Color(0xff575757),
                          //                           fontWeight: FontWeight.w400,
                          //                         ),
                          //                       ),
                          //                       onTap: () {
                          //                         onSelected(option);
                          //                       },
                          //                     );
                          //                   },
                          //                 ),
                          //               ),
                          //             ),
                          //           );
                          //         },
                          //         fieldViewBuilder: (BuildContext context,
                          //             TextEditingController ctlraddress,
                          //             FocusNode focusNode,
                          //             VoidCallback onFieldSubmitted) {
                          //           return CustomTextField(
                          //             width: textFieldWidth,
                          //             height: textFieldHeight,
                          //             cursorHeight: 22,
                          //             labelText: 'Address',
                          //             labelStyle: GoogleFonts.firaSans(
                          //               fontSize: 12,
                          //               color: Color(0xff575757),
                          //               fontWeight: FontWeight.w400,
                          //             ),
                          //             controller: ctlrAddress,
                          //             focusNode: focusNode,
                          //             labelFontSize: 12,
                          //           );
                          //         },
                          //       );
                          //     } else {
                          //       return const Offstage();
                          //     }
                          //   },
                          // ),
                        ],
                      )),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          ///last name
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 20,
                            labelText: 'Last Name',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 12,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: ctlrlastName,
                            labelFontSize: 12,
                          ),
                          // ///last name
                          // FutureBuilder<List<HRAddEmployeeGet>>(
                          //   future: HrAddEmployeeget(context),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding:
                          //               const EdgeInsets.symmetric(horizontal: 7),
                          //           child: Container(
                          //             width: AppSize.s250,
                          //             height: AppSize.s40,
                          //             decoration: BoxDecoration(
                          //                 color: ColorManager.faintGrey),
                          //           ),
                          //         ),
                          //       );
                          //     }
                          //
                          //     if (snapshot.hasData) {
                          //       List<String> lastName = snapshot.data!
                          //           .map((e) => e.lastName)
                          //           .where((name) => name != null)
                          //           .cast<String>()
                          //           .toList();
                          //
                          //       return Autocomplete<String>(
                          //         optionsBuilder:
                          //             (TextEditingValue textEditingValue) {
                          //           if (textEditingValue.text.isEmpty) {
                          //             return const Iterable<String>.empty();
                          //           } else {
                          //             return lastName.where((String option) {
                          //               return option.toLowerCase().contains(
                          //                   textEditingValue.text.toLowerCase());
                          //             });
                          //           }
                          //         },
                          //         optionsViewBuilder: (BuildContext context,
                          //             AutocompleteOnSelected<String> onSelected,
                          //             Iterable<String> options) {
                          //           return Align(
                          //             alignment: Alignment.topLeft,
                          //             child: Material(
                          //               shape: const RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.vertical(
                          //                     bottom: Radius.circular(4.0)),
                          //               ),
                          //               child: Container(
                          //                 width: textFieldWidth,
                          //                 constraints:
                          //                     BoxConstraints(maxHeight: 200.0),
                          //                 child: ListView.builder(
                          //                   padding: EdgeInsets.zero,
                          //                   itemCount: options.length,
                          //                   itemBuilder: (BuildContext context,
                          //                       int index) {
                          //                     final String option =
                          //                         options.elementAt(index);
                          //                     return ListTile(
                          //                       title: Text(
                          //                         option,
                          //                         style: GoogleFonts.firaSans(
                          //                           fontSize: 12,
                          //                           color: Color(0xff575757),
                          //                           fontWeight: FontWeight.w400,
                          //                         ),
                          //                       ),
                          //                       onTap: () {
                          //                         onSelected(option);
                          //                       },
                          //                     );
                          //                   },
                          //                 ),
                          //               ),
                          //             ),
                          //           );
                          //         },
                          //         fieldViewBuilder: (BuildContext context,
                          //             TextEditingController ctlrlastName,
                          //             FocusNode focusNode,
                          //             VoidCallback onFieldSubmitted) {
                          //           return CustomTextField(
                          //             width: textFieldWidth,
                          //             height: textFieldHeight,
                          //             cursorHeight: 20,
                          //             labelText: 'Last Name',
                          //             labelStyle: GoogleFonts.firaSans(
                          //               fontSize: 12,
                          //               color: Color(0xff575757),
                          //               fontWeight: FontWeight.w400,
                          //             ),
                          //             controller: ctlrlastName,
                          //             focusNode: focusNode,
                          //             labelFontSize: 12,
                          //           );
                          //         },
                          //       );
                          //     } else {
                          //       return const Offstage();
                          //     }
                          //   },
                          // ),

                          ///work no
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 22,
                            labelText: 'Work Phone No',
                            labelStyle: TextStyle(
                              fontSize: 12,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: ctlrworkNo,
                            labelFontSize: 12,
                          ),
                          // /// work phone no
                          // FutureBuilder<List<HRAddEmployeeGet>>(
                          //   future: HrAddEmployeeget(context),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding:
                          //               const EdgeInsets.symmetric(horizontal: 7),
                          //           child: Container(
                          //             width: AppSize.s250,
                          //             height: AppSize.s40,
                          //             decoration: BoxDecoration(
                          //                 color: ColorManager.faintGrey),
                          //           ),
                          //         ),
                          //       );
                          //     }
                          //
                          //     if (snapshot.hasData) {
                          //       List<String> workNo = snapshot.data!
                          //           .map((e) => e.workNo)
                          //           .where((number) => number != null)
                          //           .cast<String>()
                          //           .toList();
                          //
                          //       print("Primary Phone Numbers: $workNo");
                          //
                          //       return Autocomplete<String>(
                          //         optionsBuilder:
                          //             (TextEditingValue textEditingValue) {
                          //           if (textEditingValue.text.isEmpty) {
                          //             return const Iterable<String>.empty();
                          //           } else {
                          //             return workNo.where((String option) {
                          //               return option
                          //                   .contains(textEditingValue.text);
                          //             });
                          //           }
                          //         },
                          //         optionsViewBuilder: (BuildContext context,
                          //             AutocompleteOnSelected<String> onSelected,
                          //             Iterable<String> options) {
                          //           return Align(
                          //             alignment: Alignment.topLeft,
                          //             child: Material(
                          //               shape: const RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.vertical(
                          //                     bottom: Radius.circular(4.0)),
                          //               ),
                          //               child: Container(
                          //                 width: textFieldWidth,
                          //                 constraints:
                          //                     BoxConstraints(maxHeight: 200.0),
                          //                 child: ListView.builder(
                          //                   padding: EdgeInsets.zero,
                          //                   itemCount: options.length,
                          //                   itemBuilder: (BuildContext context,
                          //                       int index) {
                          //                     final String option =
                          //                         options.elementAt(index);
                          //                     return ListTile(
                          //                       title: Text(
                          //                         option,
                          //                         style: GoogleFonts.firaSans(
                          //                           fontSize: 12,
                          //                           color: Color(0xff575757),
                          //                           fontWeight: FontWeight.w400,
                          //                         ),
                          //                       ),
                          //                       onTap: () {
                          //                         onSelected(option);
                          //                       },
                          //                     );
                          //                   },
                          //                 ),
                          //               ),
                          //             ),
                          //           );
                          //         },
                          //         fieldViewBuilder: (BuildContext context,
                          //             TextEditingController ctlrsecNo,
                          //             FocusNode focusNode,
                          //             VoidCallback onFieldSubmitted) {
                          //           return CustomTextField(
                          //             width: textFieldWidth,
                          //             height: textFieldHeight,
                          //             cursorHeight: 22,
                          //             labelText: 'Secondary Phone No',
                          //             labelStyle: GoogleFonts.firaSans(
                          //               fontSize: 12,
                          //               color: Color(0xff575757),
                          //               fontWeight: FontWeight.w400,
                          //             ),
                          //             controller: ctlrsecNo,
                          //             focusNode: focusNode,
                          //             labelFontSize: 12,
                          //           );
                          //         },
                          //       );
                          //     } else {
                          //       return const Offstage();
                          //     }
                          //   },
                          // ),

                          ///date
                          SizedBox(
                            width: AppSize.s250,
                            height: AppSize.s40,
                            child: Padding(
                              padding: const EdgeInsets.all(AppPadding.p5),
                              child: TextFormField(
                                controller: ctlrDob,
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Date of Birth',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      bottom: 8, top: 10, left: 8),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.calendar_month_outlined,
                                      size: 13,
                                    ),
                                    onPressed: () async {
                                      final selectedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                      );
                                      if (selectedDate != null) {
                                        setState(() {
                                          this.selectedDate = selectedDate;
                                          ctlrDob.text = DateFormat('yyyy-MM-dd')
                                              .format(selectedDate);
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ///home office
                          FutureBuilder<List<AEClinicalDiscipline>>(
                            future: HrAddEmplyClinicalDisciplinApi(context, 1),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 7),
                                    child: Container(
                                      width: AppSize.s250,
                                      height: AppSize.s40,
                                      decoration: BoxDecoration(
                                          color: ColorManager.faintGrey),
                                    ),
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                List<String> dropDownList = [];
                                for (var i in snapshot.data!) {
                                  dropDownList.add(i.empType!);
                                }
                                return CustomDropdownTextField(
                                  labelText: 'Home Office',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 10,
                                  items: dropDownList,
                                  onChanged: (newValue) {
                                    for (var a in snapshot.data!) {
                                      if (a.empType == newValue) {
                                        // int docType = a.employeeTypesId;
                                        // Do something with docType
                                      }
                                    }
                                  },
                                );
                              } else {
                                return const Offstage();
                              }
                            },
                          ),

                          ///personal email
                          ///personal email
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 22,
                            labelText: 'Personal Email',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 12,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: ctlrPersonalEmail,
                            labelFontSize: 12,
                          ),
                          // ///personal email
                          // FutureBuilder<List<HRAddEmployeeGet>>(
                          //   future: HrAddEmployeeget(context),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding:
                          //               const EdgeInsets.symmetric(horizontal: 7),
                          //           child: Container(
                          //             width: AppSize.s250,
                          //             height: AppSize.s40,
                          //             decoration: BoxDecoration(
                          //                 color: ColorManager.faintGrey),
                          //           ),
                          //         ),
                          //       );
                          //     }
                          //
                          //     if (snapshot.hasData) {
                          //       List<String> personalEmail = snapshot.data!
                          //           .map(
                          //             (e) => e.personalEmail,
                          //           )
                          //           .where((email) => email != null)
                          //           .cast<String>()
                          //           .toList();
                          //       print("Personal Emails: $personalEmail,");
                          //
                          //       return Autocomplete<String>(
                          //         optionsBuilder:
                          //             (TextEditingValue textEditingValue) {
                          //           if (textEditingValue.text.isEmpty) {
                          //             return const Iterable<String>.empty();
                          //           } else {
                          //             return personalEmail.where((String option) {
                          //               return option
                          //                   .contains(textEditingValue.text);
                          //             });
                          //           }
                          //         },
                          //         optionsViewBuilder: (BuildContext context,
                          //             AutocompleteOnSelected<String> onSelected,
                          //             Iterable<String> options) {
                          //           return Align(
                          //             alignment: Alignment.topLeft,
                          //             child: Material(
                          //               shape: const RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.vertical(
                          //                     bottom: Radius.circular(4.0)),
                          //               ),
                          //               child: Container(
                          //                 width: 300,
                          //                 constraints:
                          //                     BoxConstraints(maxHeight: 200.0),
                          //                 child: ListView.builder(
                          //                   padding: EdgeInsets.zero,
                          //                   itemCount: options.length,
                          //                   itemBuilder: (BuildContext context,
                          //                       int index) {
                          //                     final String option =
                          //                         options.elementAt(index);
                          //                     return ListTile(
                          //                       title: Text(
                          //                         option,
                          //                         style: GoogleFonts.firaSans(
                          //                           fontSize: 12,
                          //                           color: Color(0xff575757),
                          //                           fontWeight: FontWeight.w400,
                          //                         ),
                          //                       ),
                          //                       onTap: () {
                          //                         onSelected(option);
                          //                       },
                          //                     );
                          //                   },
                          //                 ),
                          //               ),
                          //             ),
                          //           );
                          //         },
                          //         fieldViewBuilder: (BuildContext context,
                          //             TextEditingController ctlrWorkEmail,
                          //             FocusNode focusNode,
                          //             VoidCallback onFieldSubmitted) {
                          //           return CustomTextField(
                          //             width: textFieldWidth,
                          //             height: textFieldHeight,
                          //             cursorHeight: 22,
                          //             labelText: 'Work Email',
                          //             labelStyle: GoogleFonts.firaSans(
                          //               fontSize: 12,
                          //               color: Color(0xff575757),
                          //               fontWeight: FontWeight.w400,
                          //             ),
                          //             controller: ctlrWorkEmail,
                          //             focusNode: focusNode,
                          //             labelFontSize: 12,
                          //           );
                          //         },
                          //       );
                          //     } else {
                          //       return const Offstage();
                          //     }
                          //   },
                          // ),

                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 22,
                            labelText: 'Emergency Phone No',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 12,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: ctlrEmContact,
                            labelFontSize: 12,
                          )
                          // ///emergancy contact no
                          // FutureBuilder<List<HRAddEmployeeGet>>(
                          //   future: HrAddEmployeeget(context),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding:
                          //               const EdgeInsets.symmetric(horizontal: 7),
                          //           child: Container(
                          //             width: AppSize.s250,
                          //             height: AppSize.s40,
                          //             decoration: BoxDecoration(
                          //                 color: ColorManager.faintGrey),
                          //           ),
                          //         ),
                          //       );
                          //     }
                          //
                          //     if (snapshot.hasData) {
                          //       List<String> emgContact = snapshot.data!
                          //           .map((e) => e.emgContact)
                          //           .where((number) => number != null)
                          //           .cast<String>()
                          //           .toList();
                          //       print("Primary Phone Numbers: $emgContact");
                          //       return Autocomplete<String>(
                          //         optionsBuilder:
                          //             (TextEditingValue textEditingValue) {
                          //           if (textEditingValue.text.isEmpty) {
                          //             return const Iterable<String>.empty();
                          //           } else {
                          //             return emgContact.where((String option) {
                          //               return option
                          //                   .contains(textEditingValue.text);
                          //             });
                          //           }
                          //         },
                          //         optionsViewBuilder: (BuildContext context,
                          //             AutocompleteOnSelected<String> onSelected,
                          //             Iterable<String> options) {
                          //           return Align(
                          //             alignment: Alignment.topLeft,
                          //             child: Material(
                          //               shape: const RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.vertical(
                          //                     bottom: Radius.circular(4.0)),
                          //               ),
                          //               child: Container(
                          //                 width:
                          //                     textFieldWidth, // Adjust the width as needed
                          //                 constraints: BoxConstraints(
                          //                     maxHeight:
                          //                         200.0), // Optional: Adjust the max height
                          //                 child: ListView.builder(
                          //                   padding: EdgeInsets.zero,
                          //                   itemCount: options.length,
                          //                   itemBuilder: (BuildContext context,
                          //                       int index) {
                          //                     final String option =
                          //                         options.elementAt(index);
                          //                     return ListTile(
                          //                       title: Text(
                          //                         option,
                          //                         style: GoogleFonts.firaSans(
                          //                           fontSize: 12,
                          //                           color: Color(0xff575757),
                          //                           fontWeight: FontWeight.w400,
                          //                         ),
                          //                       ),
                          //                       onTap: () {
                          //                         onSelected(option);
                          //                       },
                          //                     );
                          //                   },
                          //                 ),
                          //               ),
                          //             ),
                          //           );
                          //         },
                          //         fieldViewBuilder: (BuildContext context,
                          //             TextEditingController controller6,
                          //             FocusNode focusNode,
                          //             VoidCallback onFieldSubmitted) {
                          //           return CustomTextField(
                          //             width: textFieldWidth,
                          //             height: textFieldHeight,
                          //             cursorHeight: 22,
                          //             labelText: 'Emergency Contact No',
                          //             labelStyle: GoogleFonts.firaSans(
                          //               fontSize: 12,
                          //               color: Color(0xff575757),
                          //               fontWeight: FontWeight.w400,
                          //             ),
                          //             controller: controller6,
                          //             focusNode: focusNode,
                          //             labelFontSize: 12,
                          //           );
                          //         },
                          //       );
                          //     } else {
                          //       return const Offstage();
                          //     }
                          //   },
                          // ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ///second container
            Expanded(
              flex: 1,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    // height: 200,
                    width: MediaQuery.of(context).size.width / 1,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Color(0xffB7B7B7),
                      ),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          McqWidget(
                            title: 'Employment',
                            items: [
                              'Full Time',
                              'Contract',
                              'Part Time',
                              'Per Diem'
                            ],
                            onChanged: (selectedIndex) {
                              print('Selected index: $selectedIndex');
                              _selectedItemIndex = selectedIndex;
                            },
                          ),
                          McqWidget(
                            title: 'Gender',
                            items: [
                              'Male',
                              'Female',
                              'Other',
                            ],
                            onChanged: (int) {},
                          ),
                          McqWidget(
                            title: 'Status',
                            items: ['Active', 'Trainee', 'Inactive'],
                            onChanged: (int) {},
                          ),
                        ])),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            ///add button
            Expanded(
              flex: 1,
              child: Container(
                // color: Colors.pink,
                // height: 50,
                width: MediaQuery.of(context).size.width / 1,
                child: Center(
                  child: CustomButton(
                    width: 125,
                    height: 33,
                    text: 'Add Employee',
                    style: TextStyle(
                      fontFamily: 'FiraSans',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    borderRadius: 12,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmPopup(
                            title: 'Confirm Add Employee',
                            onCancel: () {
                              Navigator.pop(context);
                            },
                            onConfirm: () async {
                              Navigator.pop(context);
                              await addEmployeeClinical(
                                context,
                                1,
                                'E067',
                                68,
                                ctlrfirstName.text,
                                ctlrlastName.text,
                                1,
                                1,
                                'Expertise',
                                1,
                                1,
                                1,
                                'SSN123',
                                ctlrSocialSecurity.text,
                                ctlrprimeNo.text,
                                ctlrsecNo.text,
                                ctlrworkNo.text,
                                ctlrWorkEmail.text,
                                ctlrPersonalEmail.text,
                                ctlrAddress.text,
                                '2024-01-01',
                                ctlrEmContact.text,
                                'Coverage',
                                'Employment',
                                'Male',
                                'Active',
                                'Service',
                                'imgurl.com',
                                'resumeurl.com',
                                1,
                                true,
                                true,
                                'Onboarding',
                                'DL123',
                                '2024-01-01',
                                '2024-01-01',
                                '2024-01-01',
                                'Yes',
                                'Position',
                                '123 Final St',
                                '2024-01-01',
                                1,
                                'Type',
                                'Reason',
                                1,
                                1000,
                                'Method',
                                'Material',
                                'Race',
                              );
                              print("Employee Added");
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

    //
    //       /// first container
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Expanded(
    //             child: Padding(
    //               padding: EdgeInsets.symmetric(
    //                   horizontal: MediaQuery.of(context).size.height / 70,
    //                   vertical: 20
    //               ),
    //               child: Material(
    //                 elevation: 4,
    //                 borderRadius: BorderRadius.circular(20),
    //                 child: Container(
    //                   // width: containerWidth,
    //                   height: containerHeight1,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(20),
    //                     border: Border.all(
    //                       width: 1,
    //                       color: Color(0xffB7B7B7),
    //                     ),
    //                     color: Colors.white,
    //                   ),
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     // crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       Row(
    //                         children: [
    //                           Expanded(
    //                             flex: 1,
    //                             child: CustomDropdownTextField(
    //                               labelText: 'Position',
    //                               labelStyle: TextStyle(),
    //                               labelFontSize:
    //                                   MediaQuery.of(context).size.width / 99,
    //                               items: ['A', 'B', 'C', 'D'],
    //                             ),
    //                           ),
    //                           Expanded(
    //                             flex: 1,
    //                             child: CustomTextField(
    //                               width: textFieldWidth,
    //                               height: textFieldHeight,
    //                               cursorHeight: 22,
    //                               labelText: 'First Name',
    //                               labelStyle: TextStyle(),
    //                               controller: _addressController,
    //                               focusNode: FocusNode(),
    //                               labelFontSize:
    //                                   MediaQuery.of(context).size.width / 99,
    //                             ),
    //                           ),
    //                           Expanded(
    //                             flex: 1,
    //                             child: CustomTextField(
    //                               width: textFieldWidth,
    //                               height: textFieldHeight,
    //                               cursorHeight: 22,
    //                               labelText: 'Last Name',
    //                               labelStyle: TextStyle(),
    //                               controller: _dateofbirthController,
    //                               focusNode: FocusNode(),
    //                               labelFontSize:
    //                                   MediaQuery.of(context).size.width / 99,
    //                             ),
    //                           ),
    //                           Expanded(
    //                             flex: 1,
    //                             child: CustomDropdownTextField(
    //                               labelText: 'Home Office',
    //                               labelStyle: TextStyle(),
    //                               labelFontSize:
    //                                   MediaQuery.of(context).size.width / 99,
    //                               items: ['A', 'B', 'C', 'D'],
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                       Row(
    //                         children: [
    //                           Expanded(
    //                             flex: 1,
    //                             child: CustomTextField(
    //                               width: textFieldWidth,
    //                               height: textFieldHeight,
    //                               cursorHeight: 22,
    //                               labelText: 'Social Security Number',
    //                               labelStyle: TextStyle(),
    //                               suffixIcon: Icon(
    //                                 Icons.remove_red_eye_sharp,
    //                                 color: Color(0xff50B5E5),
    //                                 size:
    //                                     MediaQuery.of(context).size.width / 99,
    //                               ),
    //                               controller: _sale1Controller,
    //                               focusNode: FocusNode(),
    //                               labelFontSize:
    //                                   MediaQuery.of(context).size.width / 99,
    //                             ),
    //                           ),
    //                           Expanded(
    //                             flex: 1,
    //                             child: CustomTextField(
    //                               width: textFieldWidth,
    //                               height: textFieldHeight,
    //                               cursorHeight: 22,
    //                               labelText: 'Personal Phone Number',
    //                               labelStyle: TextStyle(),
    //                               controller: _firstnameController,
    //                               focusNode: FocusNode(),
    //                               labelFontSize:
    //                                   MediaQuery.of(context).size.width / 99,
    //                             ),
    //                           ),
    //                           Expanded(
    //                             flex: 1,
    //                             child: CustomDropdownTextField(
    //                               labelText: 'Work Phone No.',
    //                               labelStyle: TextStyle(),
    //                               labelFontSize:
    //                                   MediaQuery.of(context).size.width / 99,
    //                               items: ['A', 'B', 'C', 'D'],
    //                             ),
    //                           ),
    //                           Expanded(
    //                             flex: 1,
    //                             child: CustomTextField(
    //                               width: textFieldWidth,
    //                               height: textFieldHeight,
    //                               cursorHeight: 22,
    //                               labelText: 'Personal Email',
    //                               labelStyle: TextStyle(),
    //                               controller: _lastnameController,
    //                               focusNode: FocusNode(),
    //                               labelFontSize:
    //                                   MediaQuery.of(context).size.width / 99,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                       Row(
    //                         children: [
    //                           CustomTextField(
    //                             width: textFieldWidth,
    //                             height: textFieldHeight,
    //                             cursorHeight: 22,
    //                             labelText: 'Work Email',
    //                             labelStyle: TextStyle(),
    //                             controller: _workemailController,
    //                             focusNode: FocusNode(),
    //                             labelFontSize:
    //                                 MediaQuery.of(context).size.width / 99,
    //                           ),
    //                           CustomTextField(
    //                               width: textFieldWidth,
    //                               height: textFieldHeight,
    //                               cursorHeight: 22,
    //                               labelText: 'Address',
    //                               labelStyle: TextStyle(),
    //                               controller: _personalnoController,
    //                               focusNode: FocusNode(),
    //                               labelFontSize:
    //                                   MediaQuery.of(context).size.width / 99),
    //                           CustomTextField(
    //                             width: textFieldWidth,
    //                             height: textFieldHeight,
    //                             cursorHeight: 22,
    //                             labelText: 'Date of Birth',
    //                             labelStyle: TextStyle(),
    //                             controller: _personalemailController,
    //                             focusNode: FocusNode(),
    //                             labelFontSize:
    //                                 MediaQuery.of(context).size.width / 99,
    //                           ),
    //                           CustomTextField(
    //                             width: textFieldWidth,
    //                             height: textFieldHeight,
    //                             cursorHeight: 22,
    //                             labelText: 'Emergency Contact No.',
    //                             labelStyle: TextStyle(),
    //                             controller: _worknoController,
    //                             focusNode: FocusNode(),
    //                             labelFontSize:
    //                                 MediaQuery.of(context).size.width / 99,
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       SizedBox(height: 10),
    //       /// second Container
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Expanded(
    //             child: Padding(
    //               padding: EdgeInsets.symmetric(
    //                   horizontal: MediaQuery.of(context).size.height / 70),
    //               child: Material(
    //                 elevation: 4,
    //                 borderRadius: BorderRadius.circular(20),
    //                 child: Container(
    //                   // width: containerWidth,
    //                   height: 100,
    //                   // containerHeight2,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(20),
    //                     border: Border.all(
    //                       width: 1,
    //                       color: Color(0xffB7B7B7),
    //                     ),
    //                     color: Colors.white,
    //                   ),
    //                   child: Row(
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       Padding(
    //                         padding: const EdgeInsets.only(top: 25.0),
    //                         child: McqWidget(
    //                           title: 'Employment',
    //                           items: [
    //                             'Full Time',
    //                             'Contract',
    //                             'Part Time',
    //                             'Per Diem'
    //                           ],
    //                           onChanged: (selectedIndex) {
    //                             print('Selected index: $selectedIndex');
    //                             _selectedItemIndex = selectedIndex;
    //                           },
    //                         ),
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.only(top: 25.0),
    //                         child: McqWidget(
    //                           title: 'Gender',
    //                           items: [
    //                             'Male',
    //                             'Female',
    //                             'Other',
    //                           ],
    //                           onChanged: (int) {},
    //                         ),
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.only(top: 25.0),
    //                         child: McqWidget(
    //                           title: 'Status',
    //                           items: ['Active', 'Trainee', 'Inactive'],
    //                           onChanged: (int) {},
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             CustomButton(
    //                 width: 125,
    //                 height: 33,
    //                 text: 'Add Employee',
    //                 style: TextStyle(
    //                     fontFamily: 'FiraSans',
    //                     fontSize: 12,
    //                     fontWeight: FontWeight.w700),
    //                 borderRadius: 12,
    //                 onPressed: () {})
    //           ],
    //         ),
    //       ),
    //     ]),
    //   ),
    // );
  }
}
