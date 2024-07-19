import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/add_employee/clinical.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../em_module/widgets/button_constant.dart';
import '../../manage/widgets/custom_icon_button_constant.dart';
import 'dateprovider.dart';
import 'mcq_widget_add-employee.dart';

///prachi todo
class ClinicalTab extends StatefulWidget {
  @override
  State<ClinicalTab> createState() => _ClinicalTabState();
}

class _ClinicalTabState extends State<ClinicalTab> {
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
  final StreamController<List<AEClinicalDiscipline>> _hrdisciplineController =
      StreamController<List<AEClinicalDiscipline>>();
  final StreamController<List<AEClinicalCity>> _hrCityController =
      StreamController<List<AEClinicalCity>>();
  final StreamController<List<AEClinicalReportingOffice>>
      _hrReportingOfficeController =
      StreamController<List<AEClinicalReportingOffice>>();
  final StreamController<List<AEClinicalZone>> _hrZoneController =
      StreamController<List<AEClinicalZone>>();
  final StreamController<List<HRAddEmployeeGet>> _hrAEgetController =
      StreamController<List<HRAddEmployeeGet>>();

  String _selectedOption = 'Option 1';

  late int currentPage;

  late int itemsPerPage;

  late List<String> items;
  late bool isAdded;
  int? _selectedItemIndex;
  late DateTime _selectedDate;
  int docZoneId = 0;
  int docAddVisitTypeId = 0;
  int docVisitTypeId = 0;
  int empTypeId = 0;
  String? _fileName;

  DateTime? selectedDate;
  List<String> _dropDownList = [];
  List<String> _socialSecurityNumbers = [];
  late Future<List<HRAddEmployeeGet>> _futureData;
  String? _selectedDiscipline;
  late Future<List<AEClinicalCity>> _futureCities;

  String? _selectedCity;

  ///descipline
  Future<void> _loadDisciplineData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDiscipline = prefs.getString('selectedDiscipline');
    final disciplines = await HrAddEmplyClinicalDisciplinApi(context, 1);
    setState(() {
      _dropDownList = disciplines.map((e) => e.empType!).toList();
      _selectedDiscipline = savedDiscipline;
    });
  }

  ///date
  _loadDate() async {
    final prefs = await SharedPreferences.getInstance();
    final dateStr = prefs.getString('selectedDate');
    if (dateStr != null) {
      setState(() {
        selectedDate = DateTime.parse(dateStr);
        ctlrDob.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
      });
    }
  }

  /// date _savedate
  void _saveDate(DateTime date) {
    final isoDate = DateFormat("yyyy-MM-dd").format(date);
    // api.saveDate(isoDate);
  }

  /// discipline
  Future<void> _saveData(String? discipline) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedDiscipline', discipline ?? '');
  }

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

  /// city
  Future<void> _fetchCities() async {
    try {
      final cities = await _futureCities;
      setState(() {
        _dropDownList = cities
            .map((city) => city.cityName ?? '')
            .where((cityName) => cityName.isNotEmpty)
            .toList();
      });
    } catch (e) {
      // Handle error
      print("Error fetching cities: $e");
    }
  }

  ///work email
  late Stream<List<HRAddEmployeeGet>> _emailStream;
  List<String> _workEmails = [];
  String? _selectedEmail;
  late Stream<List<HRAddEmployeeGet>> _emergencyContactStream;
  List<String> _emgContact = [];
  @override
  void initState() {
    super.initState();
    HrAddEmployeeget(context);
    selectedDate = DateTime.now();
    ctlrDob.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
    _loadDate();
    _loadDisciplineData();
    _futureData = HrAddEmployeeget(context);
    _socialSecurityNumbers = [];
    _futureCities = HrAddEmplyClinicalCityApi(context);
    _dropDownList = [];
    _fetchCities();
    _emailStream = Stream.fromFuture(HrAddEmployeeget(context));
    _emergencyContactStream = HrAddEmployeeget(context).asStream();
  }

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DateProvider>(context);
    double textFieldWidth = 200;
    double textFieldHeight = 38;
    // FocusNode _focusNode = FocusNode();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: 700,
        width: 400,
        child: Column(
          children: [
            ///upload photo button
            Expanded(
              flex: 1,
              child: Container(
                  // color: Colors.pink,
                  // height: 40,
                  width: MediaQuery.of(context).size.width / 1,
                  child: Row(
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
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
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
                  )),
            ),

            ///first container
            Expanded(
              flex: 6,
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
                          ///descipline
                          CustomDropdownTextField(
                            labelText: 'Disciplines',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 12,
                              // color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            labelFontSize: 12,
                            items: _dropDownList,
                            value: _selectedDiscipline,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedDiscipline = newValue;
                              });
                              _saveData(newValue);
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

                          ///city
                          FutureBuilder<List<AEClinicalCity>>(
                            future: HrAddEmplyClinicalCityApi(context),
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
                                List<String> dropDownList = [];
                                for (var i in snapshot.data!) {
                                  dropDownList.add(i.cityName!);
                                }
                                return CustomDropdownTextField(
                                  labelText: 'City',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
                                  items: dropDownList,
                                );
                              } else {
                                return const Offstage();
                              }
                            },
                          ),

                          ///city
                          // FutureBuilder<List<AEClinicalCity>>(
                          //   future: _futureCities,
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 7),
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
                          //       // Update the dropdown list only if it’s empty
                          //       if (_dropDownList.isEmpty) {
                          //         _fetchCities();
                          //
                          //       }
                          //
                          //       return CustomDropdownTextField(
                          //         labelText: 'City',
                          //         labelStyle: GoogleFonts.firaSans(
                          //           fontSize: 12,
                          //           color: Color(0xff575757),
                          //           fontWeight: FontWeight.w400,
                          //         ),
                          //         labelFontSize: 12,
                          //         items: _dropDownList,
                          //         value: _selectedCity,
                          //         onChanged: (newValue) {
                          //           setState(() {
                          //             _selectedCity = newValue;
                          //           });
                          //         },
                          //       );
                          //     } else if (snapshot.hasError) {
                          //       return Text("Error: ${snapshot.error}");
                          //     } else {
                          //       return const Offstage();
                          //     }
                          //   },
                          // ),
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
                          // StreamBuilder<List<HRAddEmployeeGet>>(
                          //   stream:
                          //       Stream.fromFuture(HrAddEmployeeget(context)),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 7),
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
                          //       List<String> workEmail = snapshot.data!
                          //           .map((e) => e.workEmail)
                          //           .where((number) => number != null)
                          //           .cast<String>()
                          //           .toList();
                          //       print("workEmailt: $workEmail");
                          //
                          //       return Autocomplete<String>(
                          //         optionsBuilder:
                          //             (TextEditingValue textEditingValue) {
                          //           if (textEditingValue.text.isEmpty) {
                          //             return const Iterable<String>.empty();
                          //           } else {
                          //             return workEmail.where((String option) {
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
                          //             labelText: 'Work Email',
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

                          ///Emergency contact
                          // StreamBuilder<List<HRAddEmployeeGet>>(
                          //   stream:
                          //       Stream.fromFuture(HrAddEmployeeget(context)),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         period: Duration(milliseconds: 1000),
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 7),
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
                          //       print("Emerncy Cont: $emgContact");
                          //
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
                          //             labelText: 'Emergency Phone No',
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
                          // StreamBuilder<List<HRAddEmployeeGet>>(
                          //   stream:
                          //       Stream.fromFuture(HrAddEmployeeget(context)),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 7),
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
                          //       print("firstName: $firstNames,");
                          //       return Autocomplete<String>(
                          //         optionsBuilder:
                          //             (TextEditingValue textEditingValue) {
                          //           if (textEditingValue.text.isEmpty) {
                          //             return const Iterable<String>.empty();
                          //           } else {
                          //             return firstNames.where((String option) {
                          //               return option.toLowerCase().contains(
                          //                   textEditingValue.text
                          //                       .toLowerCase());
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
                          // StreamBuilder<List<HRAddEmployeeGet>>(
                          //   stream:
                          //       Stream.fromFuture(HrAddEmployeeget(context)),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 7),
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
                          //       print("Primary Phone Numbers: $primeNo");
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
                          //             labelText: 'Primary Phone No',
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

                          ///country dropdown
                          FutureBuilder<List<AEClinicalReportingOffice>>(
                            future: HrAddEmplyClinicalReportingOfficeApi(
                                context, 11),
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
                                List<String> dropDownList = [];
                                for (var i in snapshot.data!) {
                                  if (i.name != null) {
                                    dropDownList.add(i.name!);
                                    print("Country: $ctlrCountry");
                                  }
                                }
                                return CustomDropdownTextField(
                                  labelText: 'Country',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
                                  items: dropDownList,
                                  onChanged: (newValue) {
                                    for (var a in snapshot.data!) {
                                      if (a.name == newValue) {
                                        // int? docType = a.companyOfficeID;
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
                            controller: ctlrprimeNo,
                            labelFontSize: 12,
                          ),

                          ///personalEmail
                          // FutureBuilder<List<HRAddEmployeeGet>>(
                          //   future:
                          //   HrAddEmployeeget(context),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 7),
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
                          //           .map((e) => e.personalEmail)
                          //           .where((email) => email != null)
                          //           .cast<String>()
                          //           .toList();
                          //       print("personalEmail: $personalEmail,");
                          //
                          //       return Autocomplete<String>(
                          //         optionsBuilder:
                          //             (TextEditingValue textEditingValue) {
                          //           if (textEditingValue.text.isEmpty) {
                          //             return const Iterable<String>.empty();
                          //           } else {
                          //             return personalEmail
                          //                 .where((String option) {
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
                          //             labelText: 'Personal Email',
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

                          ///empty container
                          SizedBox(
                            width: AppSize.s250,
                            height: AppSize.s40,
                          )
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
                          // FutureBuilder<List<HRAddEmployeeGet>>(
                          //   future: HrAddEmployeeget(context),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 7),
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
                          //       print("LastName: $lastName,");
                          //       return Autocomplete<String>(
                          //         optionsBuilder:
                          //             (TextEditingValue textEditingValue) {
                          //           if (textEditingValue.text.isEmpty) {
                          //             return const Iterable<String>.empty();
                          //           } else {
                          //             return lastName.where((String option) {
                          //               return option.toLowerCase().contains(
                          //                   textEditingValue.text
                          //                       .toLowerCase());
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

                          ///work phone no
                          // FutureBuilder<List<HRAddEmployeeGet>>(
                          //   future: HrAddEmployeeget(context),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 7),
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
                          //       print("Work Phone Numbers: $workNo");
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
                          //             TextEditingController ctlrworkNo,
                          //             FocusNode focusNode,
                          //             VoidCallback onFieldSubmitted) {
                          //           return CustomTextField(
                          //             width: textFieldWidth,
                          //             height: textFieldHeight,
                          //             cursorHeight: 22,
                          //             labelText: 'Work Phone No',
                          //             labelStyle: TextStyle(
                          //               fontSize: 12,
                          //               color: Color(0xff575757),
                          //               fontWeight: FontWeight.w400,
                          //             ),
                          //             controller: ctlrworkNo,
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

                          ///zone
                          FutureBuilder<List<AEClinicalZone>>(
                            future: HrAddEmplyClinicalZoneApi(
                              context,
                            ),
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
                                          color: Colors.grey[300]),
                                    ),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return CustomDropdownTextField(
                                  labelText: 'Zone',
                                  labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
                                  items: ['Error'],
                                );
                              } else if (snapshot.hasData) {
                                List<String> dropDownList = snapshot.data!
                                    .map((zone) => zone.zoneName ?? '')
                                    .toList();
                                print("Zone: ");
                                return CustomDropdownTextField(
                                  labelText: 'Zone',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
                                  items: dropDownList,
                                  onChanged: (newValue) {
                                    // Handle onChanged here if needed
                                  },
                                );
                              } else {
                                return CustomDropdownTextField(
                                  labelText: 'Zone',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
                                  items: ['No Data'],
                                );
                              }
                            },
                          ),

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
                          // FutureBuilder<List<HRAddEmployeeGet>>(
                          //   future: HrAddEmployeeget(context),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 7),
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
                          //       List<String> finalAddress = snapshot.data!
                          //           .map((e) => e.finalAddress)
                          //           .where(
                          //               (finalAddress) => finalAddress != null)
                          //           .cast<String>()
                          //           .toList();
                          //       print("Address: $finalAddress");
                          //
                          //       return Autocomplete<String>(
                          //         optionsBuilder:
                          //             (TextEditingValue textEditingValue) {
                          //           if (textEditingValue.text.isEmpty) {
                          //             return const Iterable<String>.empty();
                          //           } else {
                          //             return finalAddress
                          //                 .where((String option) {
                          //               return option.toLowerCase().contains(
                          //                   textEditingValue.text
                          //                       .toLowerCase());
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
                          //             TextEditingController ctlrAddress,
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

                          ///Empty container
                          SizedBox(
                            width: AppSize.s250,
                            height: AppSize.s40,
                          )
                        ],
                      )),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ///speciality
                          FutureBuilder<List<AEClinicalDiscipline>>(
                            future: HrAddEmplyClinicalDisciplinApi(context, 1),
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
                                List<String> dropDownList = [];

                                for (var i in snapshot.data!) {
                                  dropDownList.add(i.empType!);
                                }
                                return CustomDropdownTextField(
                                  labelText: 'Speciality',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
                                  items: dropDownList,
                                  onChanged: (newValue) {
                                    for (var a in snapshot.data!) {
                                      if (a.empType == newValue) {}
                                    }
                                  },
                                );
                              } else {
                                return const Offstage();
                              }
                            },
                          ),
///sec no
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 22,
                            labelText: 'Secondary Phone No',
                            labelStyle: TextStyle(
                              fontSize: 12,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: ctlrsecNo,
                            labelFontSize: 12,
                          ),

                          ///Sec phone no
                          // FutureBuilder<List<HRAddEmployeeGet>>(
                          //   future: HrAddEmployeeget(context),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Shimmer.fromColors(
                          //         baseColor: Colors.grey[300]!,
                          //         highlightColor: Colors.grey[100]!,
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 7),
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
                          //       List<String> secNo = snapshot.data!
                          //           .map((e) => e.secNo)
                          //           .where((secNo) => secNo != null)
                          //           .cast<String>()
                          //           .toList();
                          //       print("Sec Phone No: $secNo");
                          //
                          //       return Autocomplete<String>(
                          //         optionsBuilder:
                          //             (TextEditingValue textEditingValue) {
                          //           if (textEditingValue.text.isEmpty) {
                          //             return const Iterable<String>.empty();
                          //           } else {
                          //             return secNo.where((String option) {
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
                          //             TextEditingController ctlrworkNo,
                          //             FocusNode focusNode,
                          //             VoidCallback onFieldSubmitted) {
                          //           return CustomTextField(
                          //             width: textFieldWidth,
                          //             height: textFieldHeight,
                          //             cursorHeight: 22,
                          //             labelText: 'Secondary Phone No',
                          //             labelStyle: TextStyle(
                          //               fontSize: 12,
                          //               color: Color(0xff575757),
                          //               fontWeight: FontWeight.w400,
                          //             ),
                          //             controller: ctlrworkNo,
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

                          ///reporting office
                          FutureBuilder<List<AEClinicalDiscipline>>(
                            future: HrAddEmplyClinicalDisciplinApi(context, 1),
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
                                List<String> dropDownList = [];
                                for (var i in snapshot.data!) {
                                  dropDownList.add(i.empType!);
                                }
                                return CustomDropdownTextField(
                                  labelText: 'Reporting Office',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
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

                          ///date
                          SizedBox(
                            width: AppSize.s250,
                            height: AppSize.s40,
                            child: Padding(
                              padding: const EdgeInsets.all(AppPadding.p5),
                              child: TextFormField(
                                controller: ctlrDob,
                                readOnly: true,
                                style: GoogleFonts.firaSans(
                                  fontSize: 12,
                                  color: Color(0xff575757),
                                  fontWeight: FontWeight.w400,
                                ),
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
                                      final pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            selectedDate ?? DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                      );
                                      if (pickedDate != null) {
                                        setState(() {
                                          selectedDate = pickedDate;
                                          // Use full ISO 8601 format if needed
                                          ctlrDob.text =
                                              DateFormat("yyyy-MM-dd")
                                                  .format(pickedDate);
                                          _saveDate(pickedDate);
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),

                          ///sizedbox
                          SizedBox(
                            width: AppSize.s250,
                            height: AppSize.s40,
                          )
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
              flex: 5,
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: McqWidget(
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
                                ),
                                Expanded(
                                  flex: 1,
                                  child: McqWidget(
                                    title: 'Status',
                                    items: ['Active', 'Trainee', 'Inactive'],
                                    onChanged: (int) {},
                                  ),
                                ),
                                Expanded(
                                  child: McqWidget(
                                    title: 'Gender',
                                    items: ['Male', 'Female', 'Other'],
                                    onChanged: (int) {},
                                  ),
                                )
                              ],
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: McqWidget(
                                      title: 'Flexible Coverage',
                                      items: [
                                        'Saturday',
                                        'Sunday',
                                        'Holiday',
                                        'On Call'
                                      ],
                                      onChanged: (int) {},
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: FutureBuilder<
                                            List<AEClinicalService>>(
                                        future:
                                            HrAddEmplyClinicalServiceRadioButtonApi(
                                                context, 1),
                                        builder: (context, snap) {
                                          if (snap.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child: SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color:
                                                        ColorManager.blueprime,
                                                  )),
                                            );
                                          }
                                          if (snap.hasData) {
                                            List<String> serviceName = [];
                                            for (var i in snap.data!) {
                                              serviceName.add(i.serviceName!);
                                            }
                                            return McqWidget(
                                              title: 'Service',
                                              items: serviceName,
                                              onChanged: (int) {},
                                            );
                                          }
                                          return SizedBox();
                                        }),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 60,
                                    ),
                                  )
                                ]),
                          ]),
                    )),
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
                                'E063',
                                63,
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
  }
}

class ConfirmPopup extends StatefulWidget {
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final bool? loadingDuration;
  final String title;

  ConfirmPopup({
    Key? key,
    required this.onCancel,
    required this.onConfirm,
    this.loadingDuration,
    required this.title,
  }) : super(key: key);

  @override
  State<ConfirmPopup> createState() => _ConfirmPopupState();
}

class _ConfirmPopupState extends State<ConfirmPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s210,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      widget.title,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: ColorManager.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p20,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: AppSize.s50,
                    width: AppSize.s181,
                    child: Text(
                      'Are you sure you want to add this employee?',
                      // textAlign: TextAlign.center,
                      style: CustomTextStylesCommon.commonStyle(
                        fontWeight: FontWeightManager.regular,
                        fontSize: FontSize.s16,
                        color: ColorManager.mediumgrey,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: AppPadding.p24),
                  child: Center(
                    child: CustomButtonTransparent(
                      text: 'No',
                      onPressed: () {
                        widget.onCancel();
                      },
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(bottom: AppPadding.p24),
                  child: Center(
                    child: widget.loadingDuration == true
                        ? SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: ColorManager.blueprime,
                            ),
                          )
                        : CustomElevatedButton(
                            width: AppSize.s105,
                            height: AppSize.s30,
                            text: 'Yes',
                            onPressed: () {
                              widget.onConfirm();
                            }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//
// class AddEmplyPopUp extends StatefulWidget {
//   final String title;
//   final bool? loadingDuration;
//    final Future<void> Function() onYes;
//   final VoidCallback onCancel;
//   // final VoidCallback onYes;
//   const AddEmplyPopUp({super.key, required this.title,
//     this.loadingDuration,  required this.onCancel, required this.onYes});
//
//   @override
//   State<AddEmplyPopUp> createState() => _AddEmplyPopUpState();
// }
//
// class _AddEmplyPopUpState extends State<AddEmplyPopUp> {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: AppSize.s400,
//         height: AppSize.s210,
//         decoration: BoxDecoration(
//           color: ColorManager.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: ColorManager.bluebottom,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8),
//                   topRight: Radius.circular(8),
//                 ),
//               ),
//               height: 35,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10.0),
//                     child: Text(
//                       widget.title,
//                       style: GoogleFonts.firaSans(
//                         fontSize: FontSize.s12,
//                         fontWeight: FontWeightManager.semiBold,
//                         color: ColorManager.white,
//                         decoration: TextDecoration.none,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(Icons.close,color: ColorManager.white,),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: AppPadding.p20,
//                 horizontal: AppPadding.p20,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//
//                     height: AppSize.s50,
//                     width: AppSize.s150,
//                     child: Text('Are you sure want to add employee ?',textAlign: TextAlign.center,
//                       style:CustomTextStylesCommon.commonStyle(
//                           fontWeight: FontWeightManager.regular,
//                           fontSize: FontSize.s16,
//                           color: ColorManager.mediumgrey
//                       ),),
//                   )
//                 ],
//               ),
//             ),
//             Spacer(),
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: AppPadding.p24),
//                     child: Center(
//                       child: CustomButtonTransparent(
//                         text: 'Yes',
//                         onPressed: () async{
//                          await widget.onYes();
//                           // Navigator.pop(context);
//                         },
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 20,),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: AppPadding.p24),
//                     child: Center(
//                       child: widget.loadingDuration == true
//                           ? SizedBox(
//                         height: 25,
//                         width: 25,
//                         child: CircularProgressIndicator(
//                           color: ColorManager.blueprime,
//                         ),
//                       )
//                           : CustomElevatedButton(
//                         width: AppSize.s105,
//                         height: AppSize.s30,
//                         text: 'No',
//                         onPressed: () {
//
//                           //Navigator.pop(context);
//                         },
//                       ),
//                     ),
//                   ),]
//             ),
//             //
//           ],
//         ),
//       ),
//     );
//   }
// }
///first name
// FutureBuilder<List<HRAddEmployeeGet>>(
//   future: HrAddEmployeeget(context),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState ==
//         ConnectionState.waiting) {
//       return Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 7),
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
//                   textEditingValue.text
//                       .toLowerCase());
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
///work phone no
// FutureBuilder<List<HRAddEmployeeGet>>(
//   future: HrAddEmployeeget(context),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState ==
//         ConnectionState.waiting) {
//       return Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 7),
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
//             return personalEmail
//                 .where((String option) {
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
/// Emergency contact
// FutureBuilder<List<HRAddEmployeeGet>>(
//   future: HrAddEmployeeget(context),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState ==
//         ConnectionState.waiting) {
//       return Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 7),
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
//       // Filter out null primary phone numbers and convert to a list of non-null strings
//       List<String> emgContact = snapshot.data!
//           .map((e) => e.emgContact)
//           .where((number) => number != null)
//           .cast<String>()
//           .toList();
//
//       // Ensure that the filtered list is printed to verify
//       print("Primary Phone Numbers: $emgContact");
//
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
/// last name
// FutureBuilder<List<HRAddEmployeeGet>>(
//   future: HrAddEmployeeget(context),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState ==
//         ConnectionState.waiting) {
//       return Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 7),
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
//                   textEditingValue.text
//                       .toLowerCase());
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
///prime no
// FutureBuilder<List<HRAddEmployeeGet>>(
//   future: HrAddEmployeeget(context),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState ==
//         ConnectionState.waiting) {
//       return Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 7),
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
//       print("Primary Phone Numbers: $primeNo");
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
//             labelText: 'Primary Phone No',
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
/// work email
// FutureBuilder<List<HRAddEmployeeGet>>(
//   future: HrAddEmployeeget(context),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState ==
//         ConnectionState.waiting) {
//       return Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 7),
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
//             return personalEmail
//                 .where((String option) {
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
///sec no
//  FutureBuilder<List<HRAddEmployeeGet>>(
//                             future: HrAddEmployeeget(context),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return Shimmer.fromColors(
//                                   baseColor: Colors.grey[300]!,
//                                   highlightColor: Colors.grey[100]!,
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 7),
//                                     child: Container(
//                                       width: AppSize.s250,
//                                       height: AppSize.s40,
//                                       decoration: BoxDecoration(
//                                           color: ColorManager.faintGrey),
//                                     ),
//                                   ),
//                                 );
//                               }
//
//                               if (snapshot.hasData) {
//                                 // Filter out null primary phone numbers and convert to a list of non-null strings
//                                 List<String> secNo = snapshot.data!
//                                     .map((e) => e.secNo)
//                                     .where((number) => number != null)
//                                     .cast<String>()
//                                     .toList();
//
//                                 // Ensure that the filtered list is printed to verify
//                                 print("Secondary Phone Numbers: $secNo");
//
//                                 return Autocomplete<String>(
//                                   optionsBuilder:
//                                       (TextEditingValue textEditingValue) {
//                                     if (textEditingValue.text.isEmpty) {
//                                       return const Iterable<String>.empty();
//                                     } else {
//                                       return secNo.where((String option) {
//                                         return option
//                                             .contains(textEditingValue.text);
//                                       });
//                                     }
//                                   },
//                                   optionsViewBuilder: (BuildContext context,
//                                       AutocompleteOnSelected<String> onSelected,
//                                       Iterable<String> options) {
//                                     return Align(
//                                       alignment: Alignment.topLeft,
//                                       child: Material(
//                                         shape: const RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.vertical(
//                                               bottom: Radius.circular(4.0)),
//                                         ),
//                                         child: Container(
//                                           width: textFieldWidth,
//                                           constraints:
//                                               BoxConstraints(maxHeight: 200.0),
//                                           child: ListView.builder(
//                                             padding: EdgeInsets.zero,
//                                             itemCount: options.length,
//                                             itemBuilder: (BuildContext context,
//                                                 int index) {
//                                               final String option =
//                                                   options.elementAt(index);
//                                               return ListTile(
//                                                 title: Text(
//                                                   option,
//                                                   style: GoogleFonts.firaSans(
//                                                     fontSize: 12,
//                                                     color: Color(0xff575757),
//                                                     fontWeight: FontWeight.w400,
//                                                   ),
//                                                 ),
//                                                 onTap: () {
//                                                   onSelected(option);
//                                                 },
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   fieldViewBuilder: (BuildContext context,
//                                       TextEditingController ctlrworkNo,
//                                       FocusNode focusNode,
//                                       VoidCallback onFieldSubmitted) {
//                                     return CustomTextField(
//                                       width: textFieldWidth,
//                                       height: textFieldHeight,
//                                       cursorHeight: 22,
//                                       labelText: 'Work Phone No',
//                                       labelStyle: TextStyle(
//                                         fontSize: 12,
//                                         color: Color(0xff575757),
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                       controller: ctlrworkNo,
//                                       focusNode: focusNode,
//                                       labelFontSize: 12,
//                                     );
//                                   },
//                                 );
//                               } else {
//                                 return const Offstage();
//                               }
//                             },
//                           ),
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
//           padding: const EdgeInsets.symmetric(
//               horizontal: 7),
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
//       List<String> finalAddress = snapshot.data!
//           .map((e) => e.finalAddress)
//           .where((address) => address != null)
//           .cast<String>()
//           .toList();
//       print("Addresses: $finalAddress");
//       return Autocomplete<String>(
//         optionsBuilder:
//             (TextEditingValue textEditingValue) {
//           if (textEditingValue.text.isEmpty) {
//             return const Iterable<String>.empty();
//           } else {
//             return finalAddress.where((String option) {
//               return option.toLowerCase().contains(
//                   textEditingValue.text
//                       .toLowerCase());
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
///social security
//   FutureBuilder<List<HRAddEmployeeGet>>(
//                               future: HrAddEmployeeget(context),
//                               builder: (context, snapshot) {
//                                 if (snapshot.connectionState ==
//                                     ConnectionState.waiting) {
//                                   return Shimmer.fromColors(
//                                     baseColor: Colors.grey[300]!,
//                                     highlightColor: Colors.grey[100]!,
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 7),
//                                       child: Container(
//                                         width: AppSize.s250,
//                                         height: AppSize.s40,
//                                         decoration: BoxDecoration(
//                                             color: ColorManager.faintGrey),
//                                       ),
//                                     ),
//                                   );
//                                 }
//
//                                 if (snapshot.hasData) {
//                                   List<String> socialSecurityNumbers = snapshot
//                                       .data!
//                                       .map((e) => e.ssnnBr)
//                                       .where((number) => number != null)
//                                       .cast<String>()
//                                       .toList();
//
//                                   return Autocomplete<String>(
//                                     optionsBuilder:
//                                         (TextEditingValue textEditingValue) {
//                                       if (textEditingValue.text.isEmpty) {
//                                         return const Iterable<String>.empty();
//                                       } else {
//                                         return socialSecurityNumbers
//                                             .where((String option) {
//                                           return option
//                                               .contains(textEditingValue.text);
//                                         });
//                                       }
//                                     },
//                                     optionsViewBuilder: (BuildContext context,
//                                         AutocompleteOnSelected<String>
//                                             onSelected,
//                                         Iterable<String> options) {
//                                       return Align(
//                                         alignment: Alignment.topLeft,
//                                         child: Material(
//                                           shape: const RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.vertical(
//                                                 bottom: Radius.circular(4.0)),
//                                           ),
//                                           child: Container(
//                                             width: textFieldWidth,
//                                             constraints: BoxConstraints(
//                                                 maxHeight: 200.0),
//                                             child: ListView.builder(
//                                               padding: EdgeInsets.zero,
//                                               itemCount: options.length,
//                                               itemBuilder:
//                                                   (BuildContext context,
//                                                       int index) {
//                                                 final String option =
//                                                     options.elementAt(index);
//                                                 return ListTile(
//                                                   title: Text(
//                                                     option,
//                                                     style: GoogleFonts.firaSans(
//                                                       fontSize: 12,
//                                                       color: Color(0xff575757),
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                     ),
//                                                   ),
//                                                   onTap: () {
//                                                     onSelected(option);
//                                                   },
//                                                 );
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     fieldViewBuilder: (BuildContext context,
//                                         TextEditingController
//                                             ctlrSocialSecurity,
//                                         FocusNode focusNode,
//                                         VoidCallback onFieldSubmitted) {
//                                       return CustomTextField(
//                                         width: textFieldWidth,
//                                         height: textFieldHeight,
//                                         cursorHeight: 20,
//                                         labelText: 'Social Security No',
//                                         labelStyle: GoogleFonts.firaSans(
//                                           fontSize: 12,
//                                           color: Color(0xff575757),
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                         controller: ctlrSocialSecurity,
//                                         suffixIcon: Icon(
//                                           Icons.remove_red_eye_outlined,
//                                           color: Colors.blue,
//                                           size: 14,
//                                         ),
//                                         focusNode: focusNode,
//                                         labelFontSize: 12,
//                                       );
//                                     },
//                                   );
//                                 } else {
//                                   return const Offstage();
//                                 }
//                               }),
///city
//  //  FutureBuilder<List<AEClinicalCity>>(
//                           //   future: HrAddEmplyClinicalCityApi(context),
//                           //   builder: (context, snapshot) {
//                           //     if (snapshot.connectionState ==
//                           //         ConnectionState.waiting) {
//                           //       return Shimmer.fromColors(
//                           //         baseColor: Colors.grey[300]!,
//                           //         highlightColor: Colors.grey[100]!,
//                           //         child: Padding(
//                           //           padding: const EdgeInsets.symmetric(
//                           //               horizontal: 7),
//                           //           child: Container(
//                           //             width: AppSize.s250,
//                           //             height: AppSize.s40,
//                           //             decoration: BoxDecoration(
//                           //                 color: ColorManager.faintGrey),
//                           //           ),
//                           //         ),
//                           //       );
//                           //     }
//                           //     if (snapshot.hasData) {
//                           //       List<String> dropDownList = [];
//                           //       for (var i in snapshot.data!) {
//                           //         dropDownList.add(i.cityName!);
//                           //       }
//                           //       return CustomDropdownTextField(
//                           //         labelText: 'City',
//                           //         labelStyle: GoogleFonts.firaSans(
//                           //           fontSize: 12,
//                           //           color: Color(0xff575757),
//                           //           fontWeight: FontWeight.w400,
//                           //         ),
//                           //         labelFontSize: 12,
//                           //         items: dropDownList,
//                           //       );
//                           //     } else {
//                           //       return const Offstage();
//                           //     }
//                           //   },
//                           // ),
///work email
// StreamBuilder<List<HRAddEmployeeGet>>(
//                     stream: Stream.fromFuture(HrAddEmployeeget(context)),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Shimmer.fromColors(
//                           baseColor: Colors.grey[300]!,
//                           highlightColor: Colors.grey[100]!,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 7),
//                             child: Container(
//                               width: AppSize.s250,
//                               height: AppSize.s40,
//                               decoration: BoxDecoration(color: ColorManager.faintGrey),
//                             ),
//                           ),
//                         );
//                       }
//
//                       if (snapshot.hasData) {
//                         List<String> workEmail = snapshot.data!
//                             .map((e) => e.workEmail)
//                             .where((email) => email != null)
//                             .cast<String>()
//                             .toList();
//                         print("Work Emails: $workEmail,");
//
//                         return Autocomplete<String>(
//                           optionsBuilder: (TextEditingValue textEditingValue) {
//                             if (textEditingValue.text.isEmpty) {
//                               return const Iterable<String>.empty();
//                             } else {
//                               return workEmail.where((String option) {
//                                 return option.contains(textEditingValue.text);
//                               });
//                             }
//                           },
//                           optionsViewBuilder: (BuildContext context,
//                               AutocompleteOnSelected<String> onSelected,
//                               Iterable<String> options) {
//                             return Align(
//                               alignment: Alignment.topLeft,
//                               child: Material(
//                                 shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
//                                 ),
//                                 child: Container(
//                                   width: 300,
//                                   constraints: BoxConstraints(maxHeight: 200.0),
//                                   child: ListView.builder(
//                                     padding: EdgeInsets.zero,
//                                     itemCount: options.length,
//                                     itemBuilder: (BuildContext context, int index) {
//                                       final String option = options.elementAt(index);
//                                       return ListTile(
//                                         title: Text(
//                                           option,
//                                           style: GoogleFonts.firaSans(
//                                             fontSize: 12,
//                                             color: Color(0xff575757),
//                                             fontWeight: FontWeight.w400,
//                                           ),
//                                         ),
//                                         onTap: () {
//                                           onSelected(option);
//                                         },
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                           fieldViewBuilder: (BuildContext context,
//                               TextEditingController ctlrWorkEmail,
//                               FocusNode focusNode,
//                               VoidCallback onFieldSubmitted) {
//                             return CustomTextField(
//                               width: textFieldWidth,
//                               height: textFieldHeight,
//                               cursorHeight: 22,
//                               labelText: 'Work Email',
//                               labelStyle: GoogleFonts.firaSans(
//                                 fontSize: 12,
//                                 color: Color(0xff575757),
//                                 fontWeight: FontWeight.w400,
//                               ),
//                               controller: ctlrWorkEmail,
//                               focusNode: focusNode,
//                               labelFontSize: 12,
//                             );
//                           },
//                         );
//                       } else {
//                         return const Offstage();
//                       }
//                     },
//                   ),
