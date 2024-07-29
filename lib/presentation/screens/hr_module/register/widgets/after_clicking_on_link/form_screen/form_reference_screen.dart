import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_reference_manager.dart';

import '../../../../../../../app/resources/const_string.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';
import '../../../taxtfield_constant.dart';

class ReferencesScreen extends StatefulWidget {
  const ReferencesScreen({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<ReferencesScreen> createState() => _ReferencesScreenState();
}

class _ReferencesScreenState extends State<ReferencesScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController titleposition = TextEditingController();
  TextEditingController companyorganization = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController knowthisperson = TextEditingController();
  TextEditingController lengthofassociation = TextEditingController();


  List<GlobalKey<_ReferencesFormState>> referenceFormKeys = [];

  @override
  void initState() {
    super.initState();
    addEducationForm();
  }

  void addEducationForm() {
    setState(() {
      referenceFormKeys.add(GlobalKey<_ReferencesFormState>());
    });
  }

  void removeEduacationForm(GlobalKey<_ReferencesFormState> key) {
    setState(() {
      referenceFormKeys.remove(key);
    });
  }


  Future<void> postreferencescreendata(
      BuildContext context,
      String association,
      String comment,
      String company,
      String email,
      int employeeId,
      String mob,
      String name,
      String references,
      String title) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Reference data saved")),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            AppString.references,
            style: GoogleFonts.firaSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xff50B5E5)),
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
                  Expanded(
                    child: Text(
                      'Please provide the names and contact information of three professional references who can speak to your work experience and qualifications. For each\n reference, Kindly include the following information:',
                      style: GoogleFonts.firaSans(
                        color: Color(0xFF686464),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                ],
              ),

            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 20),
        Column(
          children: referenceFormKeys.asMap().entries.map((entry) {
            int index = entry.key;
            GlobalKey<_ReferencesFormState> key = entry.value;
            return ReferencesForm(
              key: key,
              index: index + 1,
              onRemove: () => removeEduacationForm(key),
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
                onPressed: addEducationForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff50B5E5),
                  // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                  'Add Reference',
                  style: GoogleFonts.firaSans(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
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
              style: TextStyle(
                fontFamily: 'FiraSans',
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              borderRadius: 12,
              onPressed: () async {
                // Loop through each form and extract data to post
                for (var key in referenceFormKeys) {
                  final st = key.currentState!;
                  await postreferencescreen(
                      context,
                      st.lengthofassociation.text,
                      "__",
                      st.companyorganization.text,
                      st.email.text,
                      15,
                      st.mobilenumber.text,
                     st.name.text,
                      st.knowthisperson.text,
                      st.titleposition.text);
                }
                lengthofassociation.clear();
                companyorganization.clear();
                email.clear();
                mobilenumber.clear();
                name.clear();
                knowthisperson.clear();
                titleposition.clear();
              },
              child: Text(
                'Save',
                style: GoogleFonts.firaSans(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),

      ],
    );
  }
}

class ReferencesForm extends StatefulWidget {
  final VoidCallback onRemove;
  final int index;
  const ReferencesForm({Key? key, required this.onRemove, required this.index}):super (key:key);

  @override
  _ReferencesFormState createState() => _ReferencesFormState();
}

class _ReferencesFormState extends State<ReferencesForm> {
  TextEditingController name = TextEditingController();
  TextEditingController titleposition = TextEditingController();
  TextEditingController companyorganization = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController knowthisperson = TextEditingController();
  TextEditingController lengthofassociation = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 160.0, right: 160),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'References #${widget.index}',
                style: GoogleFonts.firaSans(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff686464)),
              ),
              IconButton(
                icon: Icon(Icons.remove_circle, color: Colors.red),
                onPressed: widget.onRemove,
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.name,
                      style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: name,
                      hintText: 'Enter Text',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B),
                      ),
                      height: 32,
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height / 40),
                    Text(
                      AppString.title_position,
                      style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: titleposition,
                      hintText: 'Enter Text',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B),
                      ),
                      height: 32,
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height / 30),
                    Text(
                      AppString.company_organization,
                      style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: companyorganization,
                      hintText: 'Enter Text',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B),
                      ),
                      height: 32,
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height / 30),
                    Text(
                      AppString.mobile_number,
                      style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: mobilenumber,
                      hintText: 'Enter Text',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B),
                      ),
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
                    Text(
                      AppString.email,
                      style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: email,
                      hintText: 'Enter Text',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B),
                      ),
                      height: 32,
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height / 60),
                    Text(
                      AppString.how_do_you_know_this_person,
                      style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: knowthisperson,
                      hintText: 'Enter Text',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B),
                      ),
                      height: 32,
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height / 60),
                    Text(
                      AppString.length_of_association,
                      style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: lengthofassociation,
                      hintText: 'Enter Text',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B),
                      ),
                      height: 32,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Text(
            'Please ensure that the references you provide are professional contacts who can provide insight into \n your skills, work ethic, and character ',
            style: GoogleFonts.firaSans(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: Color(0xff686464)),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          const Divider(color: Colors.grey,thickness: 2,)

        ],
      ),
    );
  }
}


///class


//save
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// ElevatedButton(
// style: ElevatedButton.styleFrom(
// backgroundColor: Color(0xff1696C8),
// foregroundColor: Colors.white,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// ),
// onPressed: () async {
// await postreferencescreen(
// context,
// lengthofassociation.text,
// "__",
// companyorganization.text,
// email.text,
// 0,
// mobilenumber.text,
// name.text,
// knowthisperson.text,
// titleposition.text);
// },
// child: Text(
// 'Save',
// style: GoogleFonts.firaSans(
// fontSize: 14.0,
// fontWeight: FontWeight.w700,
// color: Colors.white,
// ),
// ),
// ),
// ],
// ),
