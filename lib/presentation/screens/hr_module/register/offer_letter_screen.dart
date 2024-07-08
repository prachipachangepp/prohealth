import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/offer_letter_constant.dart';

 List<Map<String, dynamic>> checkboxData = [
  {'title': '95673', 'value': false},
  {'title': '95673', 'value': false},
  {'title': '95673', 'value': false},
  {'title': '95673', 'value': false},
  {'title': '95673', 'value': false},
  {'title': '56866', 'value': false},
  {'title': '56866', 'value': false},
  {'title': '56866', 'value': false},
  {'title': '56866', 'value': false},
  {'title': '56866', 'value': false},
];

List<Map<String, dynamic>> checkboxDataCity = [
  {'title': 'RioLinda', 'value': false},
  {'title': 'Antelope', 'value': false},
  {'title': 'PleasantGrove', 'value': false},
  {'title': 'Elverta', 'value': false},
  {'title': 'Natomas', 'value': false},
  {'title': 'Nicolaus', 'value': false},
];

class OfferLetterScreen extends StatefulWidget {
  const OfferLetterScreen({super.key});

  @override
  State<OfferLetterScreen> createState() => _OfferLetterScreenState();
}

class _OfferLetterScreenState extends State<OfferLetterScreen> {
  TextEditingController issueDateController = TextEditingController();
  TextEditingController lastDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController verbalAcceptanceController = TextEditingController();
  TextEditingController patientsController = TextEditingController();

  String selectedDropdownValue = 'Per day';
  late List<Map<String, dynamic>> checkboxStates;
  late List<Map<String, dynamic>> checkboxStatesCity;

  @override
  void initState() {
    super.initState();
    checkboxStates = List.from(checkboxData);
    checkboxStatesCity = List.from(checkboxDataCity);
  }


  List<Widget> _buildCheckboxes() {
    return checkboxStates.map((data) {
      return CheckboxListTile(
        title: Text(data['title'],
          style: GoogleFonts.firaSans(
            fontSize: 10.0,
            fontWeight: FontWeight.w500
        ),),
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
        title: Text(data['title'],
          style: GoogleFonts.firaSans(
              fontSize: 10.0,
              fontWeight: FontWeight.w500
          ),),
        value: data['value'],
        onChanged: (bool? value) {
          setState(() {
            data['value'] = value ?? false;
          });
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Offer Letter',
            style: GoogleFonts.firaSans(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Color(0xff1696C8)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                        controller: issueDateController,
                        labelText: 'Issue Date'),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 80),
                  Expanded(
                    child: CustomTextField(
                      controller: lastDateController,
                      labelText: 'Last Date',
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 80),
                  Expanded(
                    child: CustomTextField(
                      controller: startDateController,
                      labelText: 'Anticipated Start Date',
                    ),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: verbalAcceptanceController,
                      labelText: 'Verbal Acceptance',
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 80),
                  Expanded(
                    child: Stack(
                      children: [
                        TextField(
                          cursorColor: Colors.black,
                          controller: patientsController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'No. of Patients',
                            labelStyle: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff575757)),
                            suffixIcon: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: DropdownButton<String>(
                                value: selectedDropdownValue,
                                items: ['Per day', 'Per week', 'Per month']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Text(value),
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
                                underline: SizedBox(),
                                icon: Icon(Icons.arrow_drop_down,
                                    color: ColorManager.blueprime),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 80),
                  SizedBox(width: MediaQuery.of(context).size.width / 3.15),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 30),
              Divider(
                color: ColorManager.cream,
                thickness: 4,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff1696C8)),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 71.0, top: 50),
                          child: Column(
                            children: [
                              DropdownTextFormField(
                                labelText: 'City',
                                hintText: 'Select a City',
                                dropdownItems: [
                                  'ProHealth San Jose',
                                  'ProHealth Sacramento',
                                  'ProHealth Walnut Creek',
                                  'ProHealth Stockton',
                                ],
                                onChanged: (String) {},
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height / 30),
                              DropdownTextFormField(
                                labelText: 'Country',
                                hintText: 'Select a County',
                                dropdownItems: [
                                  'Alameda',
                                  'San Joaquin',
                                ],
                                onChanged: (String) {},
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height / 30),
                              DropdownTextFormField(
                                labelText: 'Zone',
                                hintText: 'Select a Zone',
                                dropdownItems: ['1', '2', '3', '4'],
                                onChanged: (String) {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 10),
                      Expanded(
                        child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              TabBar(
                                indicatorColor: Color(0xff1696C8),
                                labelColor: Color(0xff686464),
                                unselectedLabelColor: Color(0xff686464),
                                labelStyle: GoogleFonts.firaSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                                unselectedLabelStyle: GoogleFonts.firaSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                                tabs: [
                                  Tab(text: 'Zip Codes'),
                                  Tab(text: 'Cities'),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ListView(
                                            children: _buildCheckboxes().sublist(0, 5),
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView(
                                            children: _buildCheckboxes().sublist(5, 10),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Tab 2 content: Cities
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ListView(
                                            children: _buildCheckboxesCity().sublist(0, 3),
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView(
                                            children: _buildCheckboxesCity().sublist(3, 6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
