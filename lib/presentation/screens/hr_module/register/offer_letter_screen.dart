import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/dropdown_const.dart';
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
  String dropdownValue = 'Salaried';
  late List<Map<String, dynamic>> checkboxStates;
  late List<Map<String, dynamic>> checkboxStatesCity;

  @override
  void initState() {
    super.initState();
    checkboxStates = List.from(checkboxData);
    checkboxStatesCity = List.from(checkboxDataCity);
  }

  void handleDropdownChange(String? newValue) {
    setState(() {
      dropdownValue = newValue ?? 'Salaried';
    });
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
        // dense: true,
        // contentPadding: EdgeInsets.zero,
        // controlAffinity: ListTileControlAffinity.trailing,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        titlePadding: EdgeInsets.zero,
        title: Container(
          width: 1500,
          height: 1029,
          child: Scaffold(
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
                        Container(width: MediaQuery.of(context).size.width/3.33,
                          child: Expanded(
                            child: CustomTextField(
                              controller: verbalAcceptanceController,
                              labelText: 'Verbal Acceptance',
                            ),
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
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'No. of Patients',
                                  labelStyle: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff575757)),
                                  suffixIcon: Container(
                                    // padding: EdgeInsets.only(right: 10),
                                    margin: EdgeInsets.only(right: 10, top: 6, bottom: 6),
                                    height: 5,
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
                                padding:  EdgeInsets.only(left: 71.0),
                                child: Column(
                                  children: [
                                    CustomDropdownFormField(
                                        hintText: 'Select a City',
                                        labelText: 'City',
                                        items: [
                                          'ProHealth San Jose',
                                          'ProHealth Sacramento',
                                          'ProHealth Walnut Creek',
                                          'ProHealth Stockton',],
                                        onChanged: (String) {}
                                    ),
        
                                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                                    CustomDropdownFormField(
                                        hintText: 'Select a Country',
                                        labelText: 'Country',
                                        items: [
                                          'Alameida',
                                          'San Joachim'],
                                        onChanged: (String) {}
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                                    CustomDropdownFormField(
                                        hintText: 'Select a Zone',
                                        labelText: 'Zone',
                                        items: [
                                          '1',
                                          '2',
                                        '3',
                                        '4'],
                                        onChanged: (String) {}
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
                                    Padding(
                                      padding: EdgeInsets.only(left: 170.0, right: 170),
                                      child: TabBar(
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
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 170.0, right: 170.0),
                                        child: TabBarView(
                                          physics: NeverScrollableScrollPhysics(),
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff1696C8),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Add New Coverage',
                            style: GoogleFonts.firaSans(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/30),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropdownFormField(
                              hintText: 'Salaried',
                              items: ['Salaried', 'Per Visit'],
                              value: dropdownValue,
                              onChanged: handleDropdownChange
                          )
                        ),
                      ],
                    ),
        
        
                    SizedBox(height: MediaQuery.of(context).size.height/30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(17.0),
                                        topRight: Radius.circular(17.0),
                                      ),
                                    ),
                                    width: 302,
                                    height: 300,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xff1696C8),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16.0),
                                              topRight: Radius.circular(16.0),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: IconButton(
                                              icon: Icon(Icons.close, color: Colors.white),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Salary',
                                                style: GoogleFonts.firaSans(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff686464)
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height/20,),
                                              TextFormField(
                                                cursorColor: Colors.black,
                                                decoration: InputDecoration(
                                                  hintText: '0.00',
                                                  hintStyle: GoogleFonts.firaSans(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xff686464)
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    borderSide: BorderSide(
                                                      color: Color(0xff51B5E6),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    borderSide: BorderSide(
                                                      color: Color(0xff51B5E6),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    borderSide: BorderSide(
                                                      color: Color(0xff51B5E6),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                                ),
                                                keyboardType: TextInputType.number,
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height/17),
                                              Center(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    // Handle the submit action
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Color(0xff1696C8),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                                    child: Text(
                                                      'Submit',
                                                      style: GoogleFonts.firaSans(
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.white
                                                      ),
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
                            backgroundColor: Color(0xff1696C8),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Add',
                            style: GoogleFonts.firaSans(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
        
                    SizedBox(height: MediaQuery.of(context).size.height/10),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff1696C8),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Compensation',
                          style: GoogleFonts.firaSans(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            'Not Defined',
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600
                        ),)
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/15),
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
                            foregroundColor: Color(0xff1696C8),
                            side: BorderSide(color: Color(0xff1696C8)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Back',
                            style: GoogleFonts.firaSans(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width/75),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff1696C8),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Enroll',
                            style: GoogleFonts.firaSans(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


