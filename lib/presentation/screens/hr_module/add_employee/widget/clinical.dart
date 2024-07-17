import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/add_employee/clinical.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../manage/widgets/custom_icon_button_constant.dart';
import 'mcq_widget_add-employee.dart';

///prachi to do
class ClinicalTab extends StatefulWidget {
  @override
  State<ClinicalTab> createState() => _ClinicalTabState();
}

class _ClinicalTabState extends State<ClinicalTab> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();
  final TextEditingController _controller7 = TextEditingController();
  final TextEditingController _controller8 = TextEditingController();
  final TextEditingController _controller9 = TextEditingController();
  final TextEditingController _controller10 = TextEditingController();
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

  int? _selectedItemIndex;

  int docZoneId = 0;

  int docAddVisitTypeId = 0;

  int docVisitTypeId = 0;

  int empTypeId = 0;
  // Country? _selectedCountry;
  String _selectedCountry = ''; // To store selected country

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode:
          false, // optional. Shows phone code before the country name.
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country.displayNameNoCountryCode;
        });
      },
    );
  }
  DateTime? selectedDate; // State variable to hold selected date
  List<DateTime?> dobList = [];
  // late TextEditingController _controller10; // Controller for the text field

  // @override
  // void initState() {
  //   super.initState();
  //   // _controller10 = TextEditingController();
  // }

  // @override
  // void dispose() {
  //   _controller10.dispose();
  //   super.dispose();
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller10 = TextEditingController();
    HrAddEmplyClinicalDisciplinApi(context, 1).then((data) {
      _hrdisciplineController.add(data);
    });
    HrAddEmplyClinicalCityApi(context);
    HrAddEmplyClinicalReportingOfficeApi(context, 11).then((data) {
      _hrReportingOfficeController.add(data);
    });
    HrAddEmplyClinicalZoneApi(
      context,
    ).then((data) {
      _hrZoneController.add(data);
    });
  }

  String? _fileName;
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.9;
    double containerHeight1 = MediaQuery.of(context).size.height * 0.39;
    double containerHeight2 = MediaQuery.of(context).size.height * 0.25;
    double containerWidth2 = MediaQuery.of(context).size.width * 0.8;
    double textFieldWidth = 200;
    double textFieldHeight = 38;
    // FocusNode _focusNode = FocusNode();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
          // color: Colors.green,
          height: 600,
          // MediaQuery.of(context).size.height/3,
          width: 800,
          // MediaQuery.of(context).size.width/,
          child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ///upload photo
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
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
                  ),
                ),
                SizedBox(height: 10),

                /// first container
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: containerWidth,
                            height: containerHeight1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 1,
                                color: Color(0xffB7B7B7),
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: FutureBuilder<List<AEClinicalDiscipline>>(
                                        future: HrAddEmplyClinicalDisciplinApi(
                                            context, 1),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 7),
                                                child: Container(
                                                  width: 180,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: ColorManager
                                                          .faintGrey),
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
                                              labelText: 'Disciplines',
                                              labelStyle: GoogleFonts.firaSans(
                                                fontSize: 10,
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
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      FutureBuilder<List<HRAddEmployeeGet>>(
                                        future: HrAddEmployeeget(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 7),
                                                child: Container(
                                                  width: 180,
                                                  height: 40,
                                                  decoration: BoxDecoration(color: ColorManager.faintGrey),
                                                ),
                                              ),
                                            );
                                          }

                                          if (snapshot.hasData) {
                                            // Filter out null first names and convert to a list of non-null strings
                                            List<String> firstNames = snapshot.data!
                                                .map((e) => e.firstName)
                                                .where((name) => name != null)
                                                .cast<String>()
                                                .toList();

                                            return Autocomplete<String>(
                                              optionsBuilder: (TextEditingValue textEditingValue) {
                                                if (textEditingValue.text.isEmpty) {
                                                  return const Iterable<String>.empty();
                                                } else {
                                                  return firstNames.where((String option) {
                                                    return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                                  });
                                                }
                                              },
                                              optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                                                return Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Material(
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                                    ),
                                                    child: Container(
                                                      width: textFieldWidth, // Adjust the width as needed
                                                      constraints: BoxConstraints(maxHeight: 200.0), // Optional: Adjust the max height
                                                      child: ListView.builder(
                                                        padding: EdgeInsets.zero,
                                                        itemCount: options.length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          final String option = options.elementAt(index);
                                                          return ListTile(
                                                            title: Text(option),
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
                                              fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                                                return CustomTextField(
                                                  width: textFieldWidth,
                                                  height: textFieldHeight,
                                                  cursorHeight: 20,
                                                  labelText: 'First Name',
                                                  labelStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff575757),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  controller: textEditingController,
                                                  focusNode: focusNode,
                                                  labelFontSize: 12,
                                                );
                                              },
                                            );
                                          } else {
                                            return const Offstage();
                                          }
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      FutureBuilder<List<HRAddEmployeeGet>>(
                                        future: HrAddEmployeeget(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 7),
                                                child: Container(
                                                  width: 180,
                                                  height: 40,
                                                  decoration: BoxDecoration(color: ColorManager.faintGrey),
                                                ),
                                              ),
                                            );
                                          }

                                          if (snapshot.hasData) {
                                            // Filter out null first names and convert to a list of non-null strings
                                            List<String> lastName = snapshot.data!
                                                .map((e) => e.lastName)
                                                .where((name) => name != null)
                                                .cast<String>()
                                                .toList();

                                            return Autocomplete<String>(
                                              optionsBuilder: (TextEditingValue textEditingValue) {
                                                if (textEditingValue.text.isEmpty) {
                                                  return const Iterable<String>.empty();
                                                } else {
                                                  return lastName.where((String option) {
                                                    return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                                  });
                                                }
                                              },
                                              optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                                                return Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Material(
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                                    ),
                                                    child: Container(
                                                      width: textFieldWidth, // Adjust the width as needed
                                                      constraints: BoxConstraints(maxHeight: 200.0), // Optional: Adjust the max height
                                                      child: ListView.builder(
                                                        padding: EdgeInsets.zero,
                                                        itemCount: options.length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          final String option = options.elementAt(index);
                                                          return ListTile(
                                                            title: Text(option),
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
                                              fieldViewBuilder: (BuildContext context, TextEditingController _controller2, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                                                return CustomTextField(
                                                  width: textFieldWidth,
                                                  height: textFieldHeight,
                                                  cursorHeight: 20,
                                                  labelText: 'Last Name',
                                                  labelStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff575757),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  controller: _controller2,
                                                  focusNode: focusNode,
                                                  labelFontSize: 12,
                                                );
                                              },
                                            );
                                          } else {
                                            return const Offstage();
                                          }
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: FutureBuilder<List<AEClinicalDiscipline>>(
                                        future: HrAddEmplyClinicalDisciplinApi(
                                            context, 1),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 7),
                                                child: Container(
                                                  width: 180,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: ColorManager
                                                          .faintGrey),
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
                                                fontSize: 10,
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
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child:
                                      FutureBuilder<List<HRAddEmployeeGet>>(
                                        future: HrAddEmployeeget(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 7),
                                                child: Container(
                                                  width: 180,
                                                  height: 40,
                                                  decoration: BoxDecoration(color: ColorManager.faintGrey),
                                                ),
                                              ),
                                            );
                                          }

                                          if (snapshot.hasData) {
                                            // Filter out null social security numbers and convert to a list of non-null strings
                                            List<String> socialSecurityNumbers = snapshot.data!
                                                .map((e) => e.ssnnBr)
                                                .where((number) => number != null)
                                                .cast<String>()
                                                .toList();

                                            return Autocomplete<String>(
                                              optionsBuilder: (TextEditingValue textEditingValue) {
                                                if (textEditingValue.text.isEmpty) {
                                                  return const Iterable<String>.empty();
                                                } else {
                                                  return socialSecurityNumbers.where((String option) {
                                                    return option.contains(textEditingValue.text);
                                                  });
                                                }
                                              },
                                              optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                                                return Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Material(
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                                    ),
                                                    child: Container(
                                                      width: textFieldWidth, // Adjust the width as needed
                                                      constraints: BoxConstraints(maxHeight: 200.0), // Optional: Adjust the max height
                                                      child: ListView.builder(
                                                        padding: EdgeInsets.zero,
                                                        itemCount: options.length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          final String option = options.elementAt(index);
                                                          return ListTile(
                                                            title: Text(option),
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
                                              fieldViewBuilder: (BuildContext context, TextEditingController _controller3, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                                                return CustomTextField(
                                                  width: textFieldWidth,
                                                  height: textFieldHeight,
                                                  cursorHeight: 20,
                                                  labelText: 'Social Security No',
                                                  labelStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff575757),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  controller: _controller3,
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
                                          } else {
                                            return const Offstage();
                                          }
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      FutureBuilder<List<HRAddEmployeeGet>>(
                                        future: HrAddEmployeeget(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 7),
                                                child: Container(
                                                  width: 180,
                                                  height: 40,
                                                  decoration: BoxDecoration(color: ColorManager.faintGrey),
                                                ),
                                              ),
                                            );
                                          }

                                          if (snapshot.hasData) {
                                            // Filter out null primary phone numbers and convert to a list of non-null strings
                                            List<String> primeNo = snapshot.data!
                                                .map((e) => e.primeNo)
                                                .where((number) => number != null)
                                                .cast<String>()
                                                .toList();

                                            // Ensure that the filtered list is printed to verify
                                            print("Primary Phone Numbers: $primeNo");

                                            return Autocomplete<String>(
                                              optionsBuilder: (TextEditingValue textEditingValue) {
                                                if (textEditingValue.text.isEmpty) {
                                                  return const Iterable<String>.empty();
                                                } else {
                                                  return primeNo.where((String option) {
                                                    return option.contains(textEditingValue.text);
                                                  });
                                                }
                                              },
                                              optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                                                return Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Material(
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                                    ),
                                                    child: Container(
                                                      width: textFieldWidth, // Adjust the width as needed
                                                      constraints: BoxConstraints(maxHeight: 200.0), // Optional: Adjust the max height
                                                      child: ListView.builder(
                                                        padding: EdgeInsets.zero,
                                                        itemCount: options.length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          final String option = options.elementAt(index);
                                                          return ListTile(
                                                            title: Text(option),
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
                                              fieldViewBuilder: (BuildContext context, TextEditingController _controller4, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                                                return CustomTextField(
                                                  width: textFieldWidth,
                                                  height: textFieldHeight,
                                                  cursorHeight: 22,
                                                  labelText: 'Primary Phone No',
                                                  labelStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff575757),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  controller: _controller4,
                                                  focusNode: focusNode,
                                                  labelFontSize: 12,
                                                );
                                              },
                                            );
                                          } else {
                                            return const Offstage();
                                          }
                                        },
                                      ),

                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:  FutureBuilder<List<HRAddEmployeeGet>>(
                                        future: HrAddEmployeeget(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 7),
                                                child: Container(
                                                  width: 180,
                                                  height: 40,
                                                  decoration: BoxDecoration(color: ColorManager.faintGrey),
                                                ),
                                              ),
                                            );
                                          }

                                          if (snapshot.hasData) {
                                            // Filter out null primary phone numbers and convert to a list of non-null strings
                                            List<String> secNo = snapshot.data!
                                                .map((e) => e.secNo)
                                                .where((number) => number != null)
                                                .cast<String>()
                                                .toList();

                                            // Ensure that the filtered list is printed to verify
                                            print("Primary Phone Numbers: $secNo");

                                            return Autocomplete<String>(
                                              optionsBuilder: (TextEditingValue textEditingValue) {
                                                if (textEditingValue.text.isEmpty) {
                                                  return const Iterable<String>.empty();
                                                } else {
                                                  return secNo.where((String option) {
                                                    return option.contains(textEditingValue.text);
                                                  });
                                                }
                                              },
                                              optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                                                return Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Material(
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                                    ),
                                                    child: Container(
                                                      width: textFieldWidth, // Adjust the width as needed
                                                      constraints: BoxConstraints(maxHeight: 200.0), // Optional: Adjust the max height
                                                      child: ListView.builder(
                                                        padding: EdgeInsets.zero,
                                                        itemCount: options.length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          final String option = options.elementAt(index);
                                                          return ListTile(
                                                            title: Text(option),
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
                                              fieldViewBuilder: (BuildContext context, TextEditingController _controller5, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                                                return CustomTextField(
                                                  width: textFieldWidth,
                                                  height: textFieldHeight,
                                                  cursorHeight: 22,
                                                  labelText: 'Primary Phone No',
                                                  labelStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff575757),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  controller: _controller5,
                                                  focusNode: focusNode,
                                                  labelFontSize: 12,
                                                );
                                              },
                                            );
                                          } else {
                                            return const Offstage();
                                          }
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      FutureBuilder<List<HRAddEmployeeGet>>(
                                        future: HrAddEmployeeget(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 7),
                                                child: Container(
                                                  width: 180,
                                                  height: 40,
                                                  decoration: BoxDecoration(color: ColorManager.faintGrey),
                                                ),
                                              ),
                                            );
                                          }

                                          if (snapshot.hasData) {
                                            // Filter out null primary phone numbers and convert to a list of non-null strings
                                            List<String> workNo = snapshot.data!
                                                .map((e) => e.workNo)
                                                .where((number) => number != null)
                                                .cast<String>()
                                                .toList();

                                            // Ensure that the filtered list is printed to verify
                                            print("Primary Phone Numbers: $workNo");

                                            return Autocomplete<String>(
                                              optionsBuilder: (TextEditingValue textEditingValue) {
                                                if (textEditingValue.text.isEmpty) {
                                                  return const Iterable<String>.empty();
                                                } else {
                                                  return workNo.where((String option) {
                                                    return option.contains(textEditingValue.text);
                                                  });
                                                }
                                              },
                                              optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                                                return Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Material(
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                                    ),
                                                    child: Container(
                                                      width: textFieldWidth, // Adjust the width as needed
                                                      constraints: BoxConstraints(maxHeight: 200.0), // Optional: Adjust the max height
                                                      child: ListView.builder(
                                                        padding: EdgeInsets.zero,
                                                        itemCount: options.length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          final String option = options.elementAt(index);
                                                          return ListTile(
                                                            title: Text(option),
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
                                              fieldViewBuilder: (BuildContext context, TextEditingController _controller6, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                                                return CustomTextField(
                                                  width: textFieldWidth,
                                                  height: textFieldHeight,
                                                  cursorHeight: 22,
                                                  labelText: 'Primary Phone No',
                                                  labelStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff575757),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  controller: _controller6,
                                                  focusNode: focusNode,
                                                  labelFontSize: 12,
                                                );
                                              },
                                            );
                                          } else {
                                            return const Offstage();
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child:
                                          FutureBuilder<List<AEClinicalCity>>(
                                        future:
                                            HrAddEmplyClinicalCityApi(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 7),
                                                child: Container(
                                                  width: 180,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: ColorManager
                                                          .faintGrey),
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
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: _openCountryPicker,
                                        child: CustomDropdownTextField(
                                          hintText: "Country",
                                          labelText: _selectedCountry,
                                          labelStyle: TextStyle(),
                                          labelFontSize: 12,
                                          items: [],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 7),
                                                child: Container(
                                                  width: 180,
                                                  height: 40,
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
                                            List<String> dropDownList = snapshot
                                                .data!
                                                .map((zone) =>
                                                    zone.zoneName ?? '')
                                                .toList();
                                            return CustomDropdownTextField(
                                              labelText: 'Zone',
                                              labelStyle: TextStyle(
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
                                              labelStyle: TextStyle(
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
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: FutureBuilder<
                                          List<AEClinicalReportingOffice>>(
                                        future:
                                            HrAddEmplyClinicalReportingOfficeApi(
                                                context, 11),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 7),
                                                child: Container(
                                                  width: 180,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: ColorManager
                                                          .faintGrey),
                                                ),
                                              ),
                                            );
                                          }
                                          if (snapshot.hasData) {
                                            List<String> dropDownList = [];
                                            for (var i in snapshot.data!) {
                                              if (i.name != null) {
                                                dropDownList.add(i.name!);
                                              }
                                            }
                                            return CustomDropdownTextField(
                                              labelText: 'Reporting Office',
                                              labelStyle: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                color: Color(0xff575757),
                                                fontWeight: FontWeight.w400,
                                              ),
                                              labelFontSize: 10,
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

                                      ///
                                      // CustomDropdownTextField(
                                      //   labelText: 'Reporting Office',
                                      //   labelStyle: TextStyle(),
                                      //   labelFontSize: 12,
                                      //   items: ['A', 'B', 'C', 'D'],
                                      // ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child:
                                      FutureBuilder<List<HRAddEmployeeGet>>(
                                        future: HrAddEmployeeget(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 7),
                                                child: Container(
                                                  width: 180,
                                                  height: 40,
                                                  decoration: BoxDecoration(color: ColorManager.faintGrey),
                                                ),
                                              ),
                                            );
                                          }

                                          if (snapshot.hasData) {
                                            // Filter out null personal emails and convert to a list of non-null strings
                                            List<String> personalEmail = snapshot.data!
                                                .map((e) => e.personalEmail)
                                                .where((email) => email != null)
                                                .cast<String>()
                                                .toList();

                                            // Ensure that the filtered list is printed to verify
                                            print("Personal Emails: $personalEmail");

                                            return Autocomplete<String>(
                                              optionsBuilder: (TextEditingValue textEditingValue) {
                                                if (textEditingValue.text.isEmpty) {
                                                  return const Iterable<String>.empty();
                                                } else {
                                                  return personalEmail.where((String option) {
                                                    return option.contains(textEditingValue.text);
                                                  });
                                                }
                                              },
                                              optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                                                return Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Material(
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                                    ),
                                                    child: Container(
                                                      width: 300, // Adjust the width as needed
                                                      constraints: BoxConstraints(maxHeight: 200.0), // Optional: Adjust the max height
                                                      child: ListView.builder(
                                                        padding: EdgeInsets.zero,
                                                        itemCount: options.length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          final String option = options.elementAt(index);
                                                          return ListTile(
                                                            title: Text(option),
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
                                              fieldViewBuilder: (BuildContext context, TextEditingController _controller7, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                                                return CustomTextField(
                                                  width: textFieldWidth,
                                                  height: textFieldHeight,
                                                  cursorHeight: 22,
                                                  labelText: 'Personal Email',
                                                  labelStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff575757),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  controller: _controller7,
                                                  focusNode: focusNode,
                                                  labelFontSize: 12,
                                                );
                                              },
                                            );
                                          } else {
                                            return const Offstage();
                                          }
                                        },
                                      ),

                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      FutureBuilder<List<HRAddEmployeeGet>>(
                                        future: HrAddEmployeeget(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 7),
                                                child: Container(
                                                  width: 180,
                                                  height: 40,
                                                  decoration: BoxDecoration(color: ColorManager.faintGrey),
                                                ),
                                              ),
                                            );
                                          }

                                          if (snapshot.hasData) {
                                            // Filter out null personal emails and convert to a list of non-null strings
                                            List<String> workEmail = snapshot.data!
                                                .map((e) => e.workEmail)
                                                .where((email) => email != null)
                                                .cast<String>()
                                                .toList();

                                            // Ensure that the filtered list is printed to verify
                                            print("Personal Emails: $workEmail");

                                            return Autocomplete<String>(
                                              optionsBuilder: (TextEditingValue textEditingValue) {
                                                if (textEditingValue.text.isEmpty) {
                                                  return const Iterable<String>.empty();
                                                } else {
                                                  return workEmail.where((String option) {
                                                    return option.contains(textEditingValue.text);
                                                  });
                                                }
                                              },
                                              optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                                                return Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Material(
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                                    ),
                                                    child: Container(
                                                      width: 300, // Adjust the width as needed
                                                      constraints: BoxConstraints(maxHeight: 200.0), // Optional: Adjust the max height
                                                      child: ListView.builder(
                                                        padding: EdgeInsets.zero,
                                                        itemCount: options.length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          final String option = options.elementAt(index);
                                                          return ListTile(
                                                            title: Text(option),
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
                                              fieldViewBuilder: (BuildContext context, TextEditingController _controller8, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                                                return CustomTextField(
                                                  width: textFieldWidth,
                                                  height: textFieldHeight,
                                                  cursorHeight: 22,
                                                  labelText: 'Work Email',
                                                  labelStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff575757),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  controller: _controller8,
                                                  focusNode: focusNode,
                                                  labelFontSize: 12,
                                                );
                                              },
                                            );
                                          } else {
                                            return const Offstage();
                                          }
                                        },
                                      ),
                                      // CustomTextField(
                                      //   width: textFieldWidth,
                                      //   height: textFieldHeight,
                                      //   cursorHeight: 22,
                                      //   labelText: 'Work Email',
                                      //   labelStyle: TextStyle(
                                      //       fontSize: 12,
                                      //       color: Color(0xff575757),
                                      //       fontWeight: FontWeight.w400),
                                      //   controller: _controller8,
                                      //   focusNode: FocusNode(),
                                      //   labelFontSize: 12,
                                      // ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      FutureBuilder<List<HRAddEmployeeGet>>(
                                        future: HrAddEmployeeget(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 7),
                                                child: Container(
                                                  width: 180,
                                                  height: 40,
                                                  decoration: BoxDecoration(color: ColorManager.faintGrey),
                                                ),
                                              ),
                                            );
                                          }

                                          if (snapshot.hasData) {
                                            // Filter out null addresses and convert to a list of non-null strings
                                            List<String> address = snapshot.data!
                                                .map((e) => e.address)
                                                .where((address) => address != null)
                                                .cast<String>()
                                                .toList();

                                            // Ensure that the filtered list is printed to verify
                                            print("Addresses: $address");

                                            return Autocomplete<String>(
                                              optionsBuilder: (TextEditingValue textEditingValue) {
                                                if (textEditingValue.text.isEmpty) {
                                                  return const Iterable<String>.empty();
                                                } else {
                                                  return address.where((String option) {
                                                    return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                                  });
                                                }
                                              },
                                              optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                                                return Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Material(
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                                    ),
                                                    child: Container(
                                                      width: 300, // Adjust the width as needed
                                                      constraints: BoxConstraints(maxHeight: 200.0), // Optional: Adjust the max height
                                                      child: ListView.builder(
                                                        padding: EdgeInsets.zero,
                                                        itemCount: options.length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          final String option = options.elementAt(index);
                                                          return ListTile(
                                                            title: Text(option),
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
                                              fieldViewBuilder: (BuildContext context, TextEditingController  _controller9, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                                                return CustomTextField(
                                                  width: textFieldWidth,
                                                  height: textFieldHeight,
                                                  cursorHeight: 22,
                                                  labelText: 'Address',
                                                  labelStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff575757),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  controller:  _controller9,
                                                  focusNode: focusNode,
                                                  labelFontSize: 12,
                                                );
                                              },
                                            );
                                          } else {
                                            return const Offstage();
                                          }
                                        },
                                      )
                                      // CustomTextField(
                                      //   width: textFieldWidth,
                                      //   height: textFieldHeight,
                                      //   cursorHeight: 22,
                                      //   labelText: 'Address',
                                      //   labelStyle: TextStyle(
                                      //       fontSize: 12,
                                      //       color: Color(0xff575757),
                                      //       fontWeight: FontWeight.w400),
                                      //   controller: _controller9,
                                      //   focusNode: FocusNode(),
                                      //   labelFontSize: 12,
                                      // ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      FutureBuilder<List<HRAddEmployeeGet>>(
                                        future: HrAddEmployeeget(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return  Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 7),
                                                child: Container(
                                                  width: 180,
                                                  height: 40,
                                                  decoration: BoxDecoration(color: ColorManager.faintGrey),
                                                ),
                                              ),
                                            );
                                          }

                                          if (snapshot.hasData) {
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Autocomplete<DateTime>(
                                                  optionsBuilder: (TextEditingValue textEditingValue) {
                                                    if (textEditingValue.text.isEmpty) {
                                                      return const Iterable<DateTime>.empty();
                                                    } else {
                                                      String searchText = textEditingValue.text.toLowerCase();
                                                      return dobList.where((date) =>
                                                      date != null &&
                                                          DateFormat('yyyy-MM-dd').format(date!).toLowerCase().contains(searchText)
                                                      ).map((date) => date!).toList();
                                                    }
                                                  },
                                                  optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<DateTime> onSelected, Iterable<DateTime> options) {
                                                    return Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Material(
                                                        shape: const RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                                        ),
                                                        child: Container(
                                                          constraints: BoxConstraints(maxHeight: 200.0), // Optional: Adjust the max height
                                                          child: ListView.builder(
                                                            padding: EdgeInsets.zero,
                                                            itemCount: options.length,
                                                            itemBuilder: (BuildContext context, int index) {
                                                              final DateTime option = options.elementAt(index);
                                                              return ListTile(
                                                                title: Text(DateFormat('yyyy-MM-dd').format(option)),
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
                                                  fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                                                    return SizedBox(
                                                      width: 300,
                                                      height: AppSize.s30,
                                                      child: TextFormField(
                                                        controller: _controller10,
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          labelText: 'Date of Birth',
                                                          labelStyle: TextStyle(fontSize: 10, color: Color(0xff575757), fontWeight: FontWeight.w400),
                                                          contentPadding: EdgeInsets.only(bottom: AppPadding.p3, top: AppPadding.p5, left: AppPadding.p2),
                                                          border: OutlineInputBorder(),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(color: ColorManager.black),
                                                          ),
                                                          suffixIcon: IconButton(
                                                            icon: Center(child: Icon(Icons.calendar_today, size: 13,)),
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
                                                                  _controller10.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                                                                });
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Center(child: Text('No data available'));
                                          }
                                        },
                                      ),
///working api
//                                       FutureBuilder<List<HRAddEmployeeGet>>(
//                                         future: HrAddEmployeeget(context),
//                                         builder: (context, snapshot) {
//                                           if (snapshot.connectionState == ConnectionState.waiting) {
//                                             return Shimmer.fromColors(
//                                               baseColor: Colors.grey[300]!,
//                                               highlightColor: Colors.grey[100]!,
//                                               child: Padding(
//                                                 padding:
//                                                 const EdgeInsets.symmetric(
//                                                     horizontal: 7),
//                                                 child: Container(
//                                                   width: 180,
//                                                   height: 40,
//                                                   decoration: BoxDecoration(
//                                                       color: ColorManager
//                                                           .faintGrey),
//                                                 ),
//                                               ),
//                                             );
//                                           }
//
//                                           if (snapshot.hasData) {
//                                             return Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 Autocomplete<DateTime>(
//                                                   optionsBuilder: (TextEditingValue textEditingValue) {
//                                                     if (textEditingValue.text.isEmpty) {
//                                                       return const Iterable<DateTime>.empty();
//                                                     } else {
//                                                       String searchText = textEditingValue.text.toLowerCase();
//                                                       return dobList.where((date) =>
//                                                       date != null &&
//                                                           DateFormat('yyyy-MM-dd').format(date!).toLowerCase().contains(searchText)
//                                                       ).map((date) => date!).toList();
//                                                     }
//                                                   },
//                                                   optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<DateTime> onSelected, Iterable<DateTime> options) {
//                                                     return Align(
//                                                       alignment: Alignment.topLeft,
//                                                       child: Material(
//                                                         shape: const RoundedRectangleBorder(
//                                                           borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
//                                                         ),
//                                                         child: Container(
//                                                           constraints: BoxConstraints(maxHeight: 200.0), // Optional: Adjust the max height
//                                                           child: ListView.builder(
//                                                             padding: EdgeInsets.zero,
//                                                             itemCount: options.length,
//                                                             itemBuilder: (BuildContext context, int index) {
//                                                               final DateTime option = options.elementAt(index);
//                                                               return ListTile(
//                                                                 title: Text(DateFormat('yyyy-MM-dd').format(option)),
//                                                                 onTap: () {
//                                                                   onSelected(option);
//                                                                 },
//                                                               );
//                                                             },
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     );
//                                                   },
//                                                   fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
//                                                     return TextFormField(
//                                                       controller: _controller10,
//                                                       readOnly: true,
//                                                       decoration: InputDecoration(
//                                                         labelText: 'Date of Birth',
//                                                         labelStyle: TextStyle(fontSize: 12, color: Color(0xff575757), fontWeight: FontWeight.w400),
//                                                         suffixIcon: IconButton(
//                                                           icon: Icon(Icons.calendar_today),
//                                                           onPressed: () async {
//                                                             final selectedDate = await showDatePicker(
//                                                               context: context,
//                                                               initialDate: DateTime.now(),
//                                                               firstDate: DateTime(1900),
//                                                               lastDate: DateTime.now(),
//                                                             );
//                                                             if (selectedDate != null) {
//                                                               setState(() {
//                                                                 this.selectedDate = selectedDate;
//                                                                 _controller10.text = DateFormat('yyyy-MM-dd').format(selectedDate); // Format date as needed
//                                                               });
//                                                             }
//                                                           },
//                                                         ),
//                                                       ),
//                                                     );
//                                                   },
//                                                 ),
//                                                 // SizedBox(height: 20),
//                                                 // Text('Selected Date: ${_controller10.text}'),
//                                               ],
//                                             );
//                                           } else {
//                                             return Center(child: Text('No data available'));
//                                           }
//                                         },
//                                       )
                                      // CustomTextField(
                                      //   width: textFieldWidth,
                                      //   height: textFieldHeight,
                                      //   cursorHeight: 22,
                                      //   labelText: 'Date of Birth',
                                      //   labelStyle: TextStyle(
                                      //       fontSize: 12,
                                      //       color: Color(0xff575757),
                                      //       fontWeight: FontWeight.w400),
                                      //   controller: _controller10,
                                      //   suffixIcon: Icon(
                                      //     Icons.calendar_month_outlined,
                                      //     color: Colors.blue,
                                      //     size: 14,
                                      //   ),
                                      //   focusNode: FocusNode(),
                                      //   labelFontSize: 12,
                                      // ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child:
                                      FutureBuilder<List<HRAddEmployeeGet>>(
                                        future: HrAddEmployeeget(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 7),
                                                child: Container(
                                                  width: 180,
                                                  height: 40,
                                                  decoration: BoxDecoration(color: ColorManager.faintGrey),
                                                ),
                                              ),
                                            );
                                          }

                                          if (snapshot.hasData) {
                                            // Filter out null primary phone numbers and convert to a list of non-null strings
                                            List<String> emgContact = snapshot.data!
                                                .map((e) => e.emgContact)
                                                .where((number) => number != null)
                                                .cast<String>()
                                                .toList();

                                            // Ensure that the filtered list is printed to verify
                                            print("Primary Phone Numbers: $emgContact");

                                            return Autocomplete<String>(
                                              optionsBuilder: (TextEditingValue textEditingValue) {
                                                if (textEditingValue.text.isEmpty) {
                                                  return const Iterable<String>.empty();
                                                } else {
                                                  return emgContact.where((String option) {
                                                    return option.contains(textEditingValue.text);
                                                  });
                                                }
                                              },
                                              optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                                                return Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Material(
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                                    ),
                                                    child: Container(
                                                      width: textFieldWidth, // Adjust the width as needed
                                                      constraints: BoxConstraints(maxHeight: 200.0), // Optional: Adjust the max height
                                                      child: ListView.builder(
                                                        padding: EdgeInsets.zero,
                                                        itemCount: options.length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          final String option = options.elementAt(index);
                                                          return ListTile(
                                                            title: Text(option),
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
                                              fieldViewBuilder: (BuildContext context, TextEditingController _controller6, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                                                return CustomTextField(
                                                  width: textFieldWidth,
                                                  height: textFieldHeight,
                                                  cursorHeight: 22,
                                                  labelText: 'Primary Phone No',
                                                  labelStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff575757),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  controller: _controller6,
                                                  focusNode: focusNode,
                                                  labelFontSize: 12,
                                                );
                                              },
                                            );
                                          } else {
                                            return const Offstage();
                                          }
                                        },
                                      ),
                                      // CustomDropdownTextField(
                                      //   labelText: 'Emergency Contact',
                                      //   labelStyle: TextStyle(
                                      //       fontSize: 12,
                                      //       color: Color(0xff575757),
                                      //       fontWeight: FontWeight.w400),
                                      //   labelFontSize: 12,
                                      //   items: ['A', 'B', 'C', 'D'],
                                      // ),
                                    ),
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(flex: 1, child: Container())
                                  ],
                                )
                                // Padding(
                                //   padding: EdgeInsets.only(
                                //       left: MediaQuery.of(context).size.width / 24),
                                //   child: CustomTextField(
                                //     width: textFieldWidth,
                                //     height: textFieldHeight,
                                //     cursorHeight: 22,
                                //     labelText: 'Emergency',
                                //     labelStyle: TextStyle(),
                                //     controller: _controller2,
                                //     focusNode: FocusNode(),
                                //     labelFontSize: 12,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                /// second Container
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10
                            // MediaQuery.of(context).size.height / 70
                            ),
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            // width: containerWidth2,
                            height: containerHeight2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 1,
                                color: Color(0xffB7B7B7),
                              ),
                              color: Colors.white,
                            ),
                            child: Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            print(
                                                'Selected index: $selectedIndex');
                                            _selectedItemIndex = selectedIndex;
                                          },
                                        ),
                                      ),

                                      SizedBox(height: MediaQuery.of(context).size.height/120),
                                      Expanded(
                                        flex: 1,
                                        child: McqWidget(
                                          title: 'Status',
                                          items: [
                                            'Active',
                                            'Trainee',
                                            'Inactive'
                                          ],
                                          onChanged: (int) {},
                                        ),
                                      ),

                                      SizedBox(height: MediaQuery.of(context).size.height/120),
                                      Expanded(
                                        flex: 1,
                                        child: McqWidget(
                                          title: 'Gender',
                                          items: [
                                            'Male',
                                            'Female',
                                            'Other',
                                          ],
                                          onChanged: (int) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                        color: ColorManager
                                                            .blueprime,
                                                      )),
                                                );
                                              }
                                              if (snap.hasData) {
                                                List<String> serviceName = [];
                                                for (var i in snap.data!) {
                                                  serviceName
                                                      .add(i.serviceName!);
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
                                      // Expanded(
                                      //   flex: 2,
                                      //   child:McqWidget(
                                      //     title: 'Gender',
                                      //     items: [
                                      //       'Male',
                                      //       'Female',
                                      //       'Other'
                                      //     ],
                                      //     onChanged: (int) {},
                                      //   ),
                                      // ),
                                    ],
                                  ),

                                  ///
                                  ///
                                  // Column(
                                  //   // crossAxisAlignment: CrossAxisAlignment.start,
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     Expanded(
                                  //        flex: 1,
                                  //       child:McqWidget(
                                  //         title: 'Gender',
                                  //         items: [
                                  //           'Male',
                                  //           'Female',
                                  //           'Other'
                                  //         ],
                                  //         onChanged: (int) {},
                                  //       ),
                                  //     ),
                                  //     // Expanded(flex: 1, child: Container())
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomButton(
                          width: 125,
                          height: 33,
                          text: 'Add Employee',
                          style: TextStyle(
                              fontFamily: 'FiraSans',
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                          borderRadius: 12,
                          onPressed: () {})
                    ],
                  ),
                ),
              ])),
    );
  }
}
