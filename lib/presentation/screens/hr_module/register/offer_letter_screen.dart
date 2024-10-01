import 'dart:async';
import 'dart:ui';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/pay_rates_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/profile_mnager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/register_manager/register_manager.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/zone_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/pay_rates/pay_rates_finance_data.dart';
import 'package:prohealth/data/api_data/establishment_data/zone/zone_model_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/profile_editor/profile_editor.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/register/confirmation_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/offer_letter_constant.dart';
import '../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../app/resources/theme_manager.dart';
import '../../../widgets/widgets/constant_textfield/const_textfield.dart';
class OfferLetterScreen extends StatefulWidget {
  final String email;
  final int userId;
  final String role;
  final String status;
  final String firstName;
  final String lastName;
  final String position;
  final String phone;
  final String reportingOffice;
  final String services;
  final String employement;
  final String soecalityName;
  final String clinicalName;
  final int employeeId;
  final ApiData? apiData;

  const OfferLetterScreen(
      {super.key,
        required this.email,
        required this.userId,
        required this.role,
        required this.status,
        required this.firstName,
        required this.lastName,
        required this.position,
        required this.phone,
        required this.reportingOffice,
        required this.services,
        required this.employement,
        required this.soecalityName,
        required this.clinicalName,
        required this.employeeId,
         this.apiData
      });

  @override
  State<OfferLetterScreen> createState() => _OfferLetterScreenState();
}

class _OfferLetterScreenState extends State<OfferLetterScreen> {
  TextEditingController issueDateController = TextEditingController();
  TextEditingController lastDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController verbalAcceptanceController = TextEditingController();
  TextEditingController patientsController = TextEditingController();
  final StreamController<List<ZipcodeByCountyIdAndZoneIdData>> _countyStreamController = StreamController<List<ZipcodeByCountyIdAndZoneIdData>>.broadcast();

  String selectedDropdownValue = 'Per day';
  String dropdownValue = 'Salaried';
  late List<Map<String, dynamic>> checkboxStates;
  late List<Map<String, dynamic>> checkboxStatesCity;

  String _salary = "";
  String generatedURL = '';
   List<ApiAddCovrageData> addCovrage = [];


  final List<Map<String, String>> data = [
    {'zipCode': '10001', 'city': 'New York'},
    {'zipCode': '20001', 'city': 'Washington, D.C.'},
    {'zipCode': '30301', 'city': 'Atlanta'},
    {'zipCode': '94101', 'city': 'San Francisco'},
    // Add more data as needed
  ];

  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  void _goToPage(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void popNavigation(){
    setState((){
     Navigator.pop(context);
    });
  }
  @override
  void initState() {
    super.initState();
    addContainer();
    _initAppLinks();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.toInt();
      });
    });
  }

  // void handleDropdownChange(String? newValue) {
  //   setState(() {
  //     dropdownValue = newValue ?? 'Salaried';
  //   });
  // }

  List<Widget> _buildCheckboxes() {
    return checkboxStates.map((data) {
      return CheckboxListTile(
        title: Text(
          data['title'],
          style:
          DocumentTypeDataStyle.customTextStyle(context),
        ),
        value: data['value'],
        onChanged: (bool? value) {
          setState(() {
            data['value'] = value ?? false;
          });
        },
      );
    }).toList();
  }

  List<Widget> _buildCheckboxesCity() {
    return checkboxStatesCity.map((data) {
      return CheckboxListTile(
        title: Text(
          data['title'],
          style:
          DocumentTypeDataStyle.customTextStyle(context),
        ),
        value: data['value'],
        onChanged: (bool? value) {
          setState(() {
            data['value'] = value ?? false;
          });
        },
      );
    }).toList();
  }

  ///container code
  ///

  List<GlobalKey<_DynamciContainerState>> containerKeys = [];





  void addContainer() {
    setState(() {
      containerKeys.add(GlobalKey<_DynamciContainerState>());
    });
  }

  void removecontainer(GlobalKey<_DynamciContainerState> key) {
    setState(() {
      containerKeys.remove(key);
    });
  }



  AppLinks? _appLinks;

  void _initAppLinks() async {
    _appLinks = AppLinks();
  }
  Future<String> _generateUrlLink(String email, String Id) async {
    final String user = email;
    final String id = Id;
    final String url = 'https://staging.symmetry.care/$id';
    generatedURL = url;
    print('Generated URL: $generatedURL');
    return url;
  }
  final StreamController<List<CountyWiseZoneModal>> _zoneController =
  StreamController<List<CountyWiseZoneModal>>.broadcast();
  int selectedZoneId = 0;
  int selectedCountyId = 0;
  int selectedCityId = 0;
  String? selectedCounty;
  // int? selectedCountyId;
  bool _isLoading = false;
  Map<String, bool> checkedZipCodes = {};
  Map<String, bool> checkedCityName = {};
  //List<String> selectedZipCodes = [];
  List<String> selectedCityName = [];
  String selectedZipCodesString = '';
  String selectedCityString = '';
  List<DropdownMenuItem<String>> dropDownList = [];
  int countyId = 0;
  String? selectedZipCodeZone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Offer Letter',
                    style: FormHeading.customTextStyle(context)
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextFieldOfferScreen(
                      height: 36,
                      controller: issueDateController,
                      labelText: 'Issue Date'),
                  //SizedBox(width: MediaQuery.of(context).size.width / 80),
                  CustomTextFieldOfferScreen(
                    height: 36,
                    controller: lastDateController,
                    labelText: 'Last Date',
                  ),
                  // SizedBox(width: MediaQuery.of(context).size.width / 80),
                  CustomTextFieldOfferScreen(
                    height: 36,
                    controller: startDateController,
                    labelText: 'Anticipated Start Date',
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              ///blue container
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextFieldOfferScreen(
                    height: 36,
                    controller: verbalAcceptanceController,
                    labelText: 'Verbal Acceptance',
                  ),
                  //SizedBox(width: MediaQuery.of(context).size.width / 80),
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 5,
                    child: StatefulBuilder(
                      builder: (BuildContext context, void Function(void Function()) setState) {
                        return TextField(
                          cursorColor: Colors.black,
                          controller: patientsController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffB1B1B1), width: 1.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffB1B1B1), width: 1.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffB1B1B1), width: 1.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'No. of Patients',
                            labelStyle:  DocumentTypeDataStyle.customTextStyle(context),
                            suffixIcon: DropdownButton<String>(
                              value: selectedDropdownValue,
                              items: ['Per day', 'Per week', 'Per month']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Text(
                                      value,
                                      style: const TextStyle(fontSize: 12.0),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                if (value != null) {
                                  setState(() {
                                    selectedDropdownValue = value;
                                  });
                                }
                              },
                              underline: const SizedBox(),
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Colors.blue),
                            ),
                            contentPadding:
                            const EdgeInsets.only(left: 20, bottom: 5),
                          ),
                          style: DocumentTypeDataStyle.customTextStyle(context),);
                      },
                    ),
                  ),
                  //SizedBox(width: MediaQuery.of(context).size.width / 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Divider(
                  color: ColorManager.cream,
                  thickness: 4,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Column(
                children: containerKeys.asMap().entries.map((entry) {
                  int index = entry.key;
                  GlobalKey<_DynamciContainerState> key =entry.value;
                  return DynamciContainer(
                    key: key,
                    index: index + 1,
                    onRemove: () => removecontainer(key),
                  );


                }).toList(),

              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Row(crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                  onPressed:addContainer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1696C8),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Add New Coverage',
                    style: BlueButtonTextConst.customTextStyle(context),
                  ),
                ),],),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: StatefulBuilder(

                  builder: (BuildContext context, void Function(void Function()) setState) {
                    return  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          width: 300,
                          child: CustomDropdownFormField(
                              hintText: 'Salaried',
                              items: ['Salaried', 'Per Visit'],
                              value: dropdownValue,
                              onChanged: (newValue){
                                setState(() {
                                  dropdownValue = newValue! ?? 'Salaried';
                                  print('dropDownValue ${dropdownValue}');
                                });
                              }),
                        ),
                        SizedBox(width: 30,),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        titlePadding: EdgeInsets.zero,
                                        title: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              bottomLeft: Radius.circular(12),
                                              bottomRight: Radius.circular(12),
                                              topRight: Radius.circular(12),
                                            ),
                                          ),
                                          width: 302,
                                          height: 230,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 35,
                                                width: double.infinity,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xff1696C8),
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(12.0),
                                                    topRight: Radius.circular(12.0),
                                                  ),
                                                ),
                                                padding: EdgeInsets.only(right: 5,bottom: 5),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(Icons.close,
                                                          color: Colors.white),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 15.0, horizontal: 16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    dropdownValue == 'Salaried' ?  Text(
                                                      'Salary',
                                                      style:AllPopupHeadings.customTextStyle(context),
                                                    ) : Text(
                                                      'Per Visit',
                                                      style: AllPopupHeadings.customTextStyle(context),
                                                    ),
                                                    SizedBox(
                                                      height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                          30,
                                                    ),
                                                    Container(
                                                      height: 30,
                                                      child: TextFormField(
                                                        cursorColor: Colors.black,
                                                        style: DocumentTypeDataStyle.customTextStyle(context),
                                                        decoration: InputDecoration(
                                                          prefix:Text("\$ "),
                                                          hintText: '0.00',
                                                          hintStyle:  DocumentTypeDataStyle.customTextStyle(context),
                                                          enabledBorder:
                                                          OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                8.0),
                                                            borderSide: const BorderSide(
                                                              color: Color(0xff51B5E6),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          focusedBorder:
                                                          OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                8.0),
                                                            borderSide: const BorderSide(
                                                              color: Color(0xff51B5E6),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          border: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                8.0),
                                                            borderSide: const BorderSide(
                                                              color: Color(0xff51B5E6),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          contentPadding:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 16.0,
                                                              vertical: 12.0),
                                                        ),
                                                        keyboardType:
                                                        TextInputType.number,
                                                        onChanged: (value) {
                                                          setState((){
                                                            _salary = value;
                                                          });
                                                          print("Salary:: ${_salary}");
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                            20),
                                                    Center(
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          // Handle the submit action
                                                          Navigator.of(context).pop();
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                          const Color(0xff1696C8),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                12),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 24.0,
                                                              vertical: 8.0),
                                                          child: Text(
                                                            'Submit',
                                                            style: BlueButtonTextConst.customTextStyle(context),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff1696C8),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: dropdownValue == 'Salaried' ? Text(
                                  'Add',
                                  style: BlueButtonTextConst.customTextStyle(context),
                                ) : Text(
                                  'Add Visit',
                                  style: BlueButtonTextConst.customTextStyle(context),
                                )
                            ),
                            SizedBox(width: 10,),
                            if (_salary.isNotEmpty)
                              Text(
                                "\$ ${_salary}",
                                style:  AllPopupHeadings.customTextStyle(context)
                              ),
                            SizedBox(width: 15),

                          ],
                        ),

                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xff1696C8),
                      side: const BorderSide(color: Color(0xff1696C8)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Back',
                      style: TransparentButtonTextConst.customTextStyle(context)
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 75),
                  ElevatedButton(
                    onPressed: ()  async{
                      for (var key in containerKeys){
                        final st = key.currentState!;

                        print('County ID: ${st.selectedCountyId}');
                        print('Zone ID:::::::::=>> ${st.docZoneId}');
                        print('Zip Codes: ${st.selectedZipCodes}');
addCovrage.add(await ApiAddCovrageData(city: '',
    countyId:st.selectedCountyId ,
    zoneId: st.docZoneId,
    zipCodes:st.selectedZipCodes

));

                      }

                      print("Added covrage:::::::::::::>>>>>>>>>>> ${addCovrage}");
                      await _generateUrlLink(widget.email, widget.userId.toString());


                      // print("Widget employeeId ${widget.apiData!.employeeId!}");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmationPopup(
                            // loadingDuration: _isLoading,
                            onCancel: () {
                              Navigator.pop(context);
                            },
                            onConfirm: ()  async{
                              print('selected county id : ${selectedCountyId}');
                             //  print('selected zone id : ${st.docZoneId}');
                             // print('selected zipCode : ${st.selectedZipCodes}');
                              print('selected city : ${selectedCityName}');
                              print('Salari ${_salary}');
                              print('Salari Type ${dropdownValue}');
                              print('PatianCount ${patientsController.text}');
                              try {

                                var empEnrollOfferResponse = await addEmpEnrollOffers(
                                  context,
                                  widget.apiData!.employeeEnrollId!,
                                  widget.apiData!.employeeId!,
                                  int.parse(patientsController.text),
                                  issueDateController.text,
                                  lastDateController.text,
                                  startDateController.text,
                                  verbalAcceptanceController.text,
                                );
                                print('County id : ${selectedCountyId}');
                                print('Zone id : ${selectedZoneId}');
                                await addEmpEnrollAddCoverage(
                                  context,
                                  widget.apiData!.employeeEnrollId!,
                                  widget.apiData!.employeeId!,
                                  addCovrage
                                  // selectedCityString,
                                  // selectedCountyId,
                                  // selectedZoneId,
                                );

                                await addEmpEnrollAddCompensation(
                                  context,
                                  widget.apiData!.employeeEnrollId!,
                                  widget.apiData!.employeeId!,
                                  dropdownValue.toString(),
                                  int.parse(_salary),
                                );
                                // Clear controllers
                                issueDateController.clear();
                                lastDateController.clear();
                                startDateController.clear();
                                verbalAcceptanceController.clear();

                                if(empEnrollOfferResponse.statusCode == 200 || empEnrollOfferResponse.statusCode == 201){
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      Future.delayed(Duration(seconds: 2), () {
                                        if (Navigator.of(context).canPop()) {
                                          Navigator.of(context).pop();
                                          popNavigation();
                                        }
                                      });
                                      return AddSuccessPopup(message: 'Employee Enrolled Successfully',);
                                    },
                                  );
                                }
                              } catch (e) {
                                print("Error during enrollment: $e");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Enrollment failed: $e')),
                                );
                              } finally {
                                // setState(() {
                                //   _isLoading = false;
                                // });
                              }
                            },
                            title: 'Confirm Enrollment',
                            containerText: 'Do you really want to enroll?',
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1696C8),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Enroll',
                      style: BlueButtonTextConst.customTextStyle(context)
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class CheckBoxTileConst extends StatelessWidget {
  final String text;
  bool value;
  ValueChanged<bool?> onChanged;

  CheckBoxTileConst({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 50,
      child: CheckboxListTile(
        title: Text(
          text,
          style: DocumentTypeDataStyle.customTextStyle(context),
        ),
        value: value,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading, // Checkbox first, then text
      ),
    );
  }
}





class DynamciContainer extends StatefulWidget {
  final VoidCallback onRemove;
  final int index;
  const DynamciContainer({super.key, required this.onRemove, required this.index});

  @override
  _DynamciContainerState createState() => _DynamciContainerState();
}

class _DynamciContainerState extends State<DynamciContainer> {



  int selectedZoneId = 0;
  int selectedCountyId = 0;
  int selectedCityId = 0;
  String? selectedCounty;
  // int? selectedCountyId;
  bool _isLoading = false;
  Map<String, bool> checkedZipCodes = {};
  Map<String, bool> checkedCityName = {};
  List<int> selectedZipCodes = [];
  List<String> selectedCityName = [];
  String selectedZipCodesString = '';
  String selectedCityString = '';
  List<DropdownMenuItem<String>> dropDownList = [];
  int countyId = 0;
  final StreamController<List<ZipcodeByCountyIdData>> _countyStreamController = StreamController<List<ZipcodeByCountyIdData>>.broadcast();
  List<int> zipCodes = [];
  int? employementIndex;



  final StreamController<List<CountyWiseZoneModal>> _zoneController =
  StreamController<List<CountyWiseZoneModal>>.broadcast();

  String? selectedZipCodeZone;

  int docZoneId = 0;
  List<ApiAddCovrageData> addCovrage = [];

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 10),
      child: Container(
        width: double.infinity, //1030
        height: 330, //MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff1696C8)),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    employementIndex == null ? 'Coverage #${widget.index}' :'Coverage #${employementIndex}',
                    style:  DefineWorkWeekStyle.customTextStyle(context),
                  ),
                  if (widget.index > 1)
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: widget.onRemove,
                    ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  ///county
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'County',
                        style: AllPopupHeadings.customTextStyle(context),
                      ),
                      SizedBox(height: 5),
                      FutureBuilder<List<AllCountyGetList>>(
                        future: getCountyZoneList(context),
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
                            return const CustomDropdownTextField(
                              hintText: 'Select County',
                              labelText: 'County',
                              labelStyle: TextStyle(
                                fontSize: 11,
                                color: Color(0xff575757),
                                fontWeight: FontWeight.w400,
                              ),
                              labelFontSize: 12,
                              items: ['Error'],
                            );
                          } else if (snapshot.hasData) {
                            // Clear dropdown list to avoid duplicates
                            dropDownList.clear();

                            // Add the default "Select" item
                            dropDownList.add(DropdownMenuItem<String>(
                              child: Text('Select County'),
                              value: 'Select County',
                            ));

                            // Populate dropdown list with counties
                            for (var i in snapshot.data!) {
                              dropDownList.add(DropdownMenuItem<String>(
                                child: Text(i.countyName),
                                value: i.countyName,
                              ));
                            }

                            // Set initial selectedCounty if not already set
                            if (selectedCounty == null) {
                              selectedCounty = 'Select County';
                            }

                            return StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return Container(
                                  height: 31,
                                  width: 250,
                                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: const Color(0xff686464).withOpacity(0.5), width: 1),
                                    borderRadius: BorderRadius.circular(6),
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
                                      setState(() {
                                        selectedCounty = newValue;
                                        for (var a in snapshot.data!) {
                                          if (a.countyName == newValue) {
                                            selectedCountyId = a.countyId;
                                            print("County Id :: ${selectedCountyId}");
                                            // Perform other actions if needed
                                          }
                                        }
                                      });
                                    },
                                    value: selectedCounty,
                                    style: DocumentTypeDataStyle.customTextStyle(context),
                                  ),
                                );
                              },
                            );
                          } else {
                            return CustomDropdownTextField(
                              labelText: 'County',
                              labelStyle:DocumentTypeDataStyle.customTextStyle(context),
                              labelFontSize: 12,
                              items: ['No County'],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.height / 15),
                  ///zone api
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Zone',style: AllPopupHeadings.customTextStyle(context),),
                      SizedBox(height:5),

                      StreamBuilder<
                          List<CountyWiseZoneModal>>(
                          stream: _zoneController.stream,
                          builder: (context, snapshotZone) {
                            fetchCountyWiseZone(context, selectedCountyId)
                                .then((data) {
                              _zoneController.add(data);
                            }).catchError((error) {});
                            if (snapshotZone.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                width: 250,
                                height: 31,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorManager
                                          .containerBorderGrey,
                                      width: AppSize.s1),
                                  borderRadius:
                                  BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "",
                                  //AppString.dataNotFound,
                                ),
                              );
                            }
                            if (snapshotZone.data!.isEmpty) {
                              return Container(
                                width: 250,
                                height: 31,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorManager
                                          .containerBorderGrey,
                                      width: AppSize.s1),
                                  borderRadius:
                                  BorderRadius.circular(4),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets
                                        .symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      ErrorMessageString
                                          .noZoneAdded,
                                      //  AppString.dataNotFound,
                                      style:
                                      AllNoDataAvailable.customTextStyle(context),
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (snapshotZone.hasData) {
                              List dropDown = [];
                              int docType = 0;
                              List<DropdownMenuItem<String>>
                              dropDownTypesList = [];

                              for (var i in snapshotZone.data!) {
                                dropDownTypesList.add(
                                  DropdownMenuItem<String>(
                                    value: i.zoneName,
                                    child: Text(i.zoneName),
                                  ),
                                );
                              }
                              if (selectedZipCodeZone == null) {
                                selectedZipCodeZone =
                                    snapshotZone.data![0].zoneName;
                              }
                              docZoneId = snapshotZone.data![0].zone_id;
                              return StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                  return Container(
                                    height: 31,
                                    width: 250,
                                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: const Color(0xff686464).withOpacity(0.5), width: 1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      focusColor: Colors.transparent,
                                      icon: const Icon(
                                        Icons.arrow_drop_down_sharp,
                                        color: Color(0xff686464),
                                      ),
                                      decoration: const InputDecoration.collapsed(hintText: ''),
                                      items: dropDownTypesList,
                                      onChanged: (newValue) {
                                        setState(() {
                                          for (var a
                                                    in snapshotZone.data!) {
                                                      if (a.zoneName == newValue) {
                                                        docType = a.zone_id;
                                                        print(
                                                            "ZONE id :: ${a.zone_id}");
                                                        docZoneId = docType;
                                                      }
                                                    }
                                        });
                                      },
                                     // value: selectedZone,
                                      style: DocumentTypeDataStyle.customTextStyle(context),
                                    ),
                                  );
                                },
                              );

                            }
                            return const SizedBox();
                          }),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20,),
              ///old code tabbar
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Zip Codes',
                          style: AllPopupHeadings.customTextStyle(context),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 100.0),
                        child: StreamBuilder<List<ZipcodeByCountyIdData>>(
                          stream: _countyStreamController.stream,
                          builder: (BuildContext context, snapshot) {
                            getZipcodeByCountyId(context: context, countyId: selectedCountyId).then((data) {
                              _countyStreamController.add(data);
                            }).catchError((error) {
                              // Handle error
                            });

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return SizedBox();
                            }

                            if (selectedCountyId == 0) {
                              return Text(
                                'Select county',
                                style: DocumentTypeDataStyle.customTextStyle(context),
                              );
                            }

                            if (snapshot.data!.isEmpty) {
                              return Text(
                                'No ZipCode Found!',
                                style: DocumentTypeDataStyle.customTextStyle(context),
                              );
                            }

                            return GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Two items per row
                                  childAspectRatio: 10,
                                  crossAxisSpacing: 1,
                                  mainAxisSpacing: 2
                              ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                String zipCode = snapshot.data![index].zipCode;
                                bool isChecked = checkedZipCodes[zipCode] ?? false;

                                return StatefulBuilder(
                                  builder: (BuildContext context, void Function(void Function()) setState) {
                                    return CheckBoxTileConst(
                                      text: zipCode,
                                      value: isChecked,
                                      onChanged: (bool? val) {
                                        setState(() {
                                          print('Clicked check box 1');
                                          checkedZipCodes[zipCode] = val ?? false;

                                          if (val == true) {
                                            selectedZipCodes.add(int.parse(zipCode));
                                          } else {
                                            selectedZipCodes.remove(int.parse(zipCode));
                                          }

                                          selectedZipCodesString = selectedZipCodes.join(', ');
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

