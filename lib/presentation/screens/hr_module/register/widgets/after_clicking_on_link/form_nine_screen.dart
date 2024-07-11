import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/bottom_row.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/thank_you_screen.dart';

import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../manage/widgets/top_row.dart';
import '../../taxtfield_constant.dart';
import 'certificate_screen.dart';
import 'offer_letter_description_screen.dart';

class FormNineScreen extends StatefulWidget {
  const FormNineScreen({Key? key}) : super(key: key);

  @override
  State<FormNineScreen> createState() => _FormNineScreenState();
}

class _FormNineScreenState extends State<FormNineScreen> {
  TextEditingController lastName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController middleInitial = TextEditingController();
  TextEditingController otherLastNames = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController aptNumber = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController ssn = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController cityTown = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController alienRegistrationNumber = TextEditingController();
  TextEditingController workAuthorizationExpirationDate =
  TextEditingController();
  TextEditingController uscisNumber = TextEditingController();
  TextEditingController formI94AdmissionNumber = TextEditingController();
  TextEditingController foreignPassportNumber = TextEditingController();
  TextEditingController countryOfIssuance = TextEditingController();

  Widget _buildLabeledTextField(String label, TextEditingController controller,
      String hintText, TextInputType keyboardType,
      {bool isRequired = true, Widget? suffixIcon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Text(
            label,
            style: GoogleFonts.firaSans(
              fontSize: 12,
              color: Color(0xFF686464).withOpacity(0.50),
              fontWeight: FontWeight.w400,
            ),
          ),
        SizedBox(height: 4),
        CustomTextFieldRegister(
          height: AppSize.s30,
          width: MediaQuery.of(context).size.width / 2.5,
          controller: controller,
          hintText: hintText,
          keyboardType: keyboardType,
          padding: EdgeInsets.only(left: 10, bottom: AppPadding.p10),
          onChanged: (value) {},
          validator: (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return AppString.enterText;
            }
            return null;
          },
          suffixIcon: suffixIcon,
        ),
      ],
    );
  }

  Widget _buildCheckboxItem(String text) {
    return Row(
      children: [
        Checkbox(
          value: false,
          onChanged: (bool? value) {
            // Handle checkbox state
          },
        ),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.firaSans(
              fontSize: 12,
              color: Color(0xFF686464).withOpacity(0.50),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TopRowConstant(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Form i - 9',
                style: GoogleFonts.firaSans(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: _buildLabeledTextField(
                      "Last Name (Family Name)",
                      lastName,
                      "Ex-John",
                      TextInputType.text),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: _buildLabeledTextField(
                      "U.S. Social Security Number",
                      ssn,
                      "Enter Text",
                      TextInputType.number),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildLabeledTextField(
                      "First Name (Given Name)",
                      firstName,
                      "Ex.Adams",
                      TextInputType.text),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: _buildLabeledTextField(
                      "Employee's Email",
                      email,
                      "Enter Text",
                      TextInputType.emailAddress),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildLabeledTextField(
                      "Middle Initial",
                      middleInitial,
                      "Enter Text",
                      TextInputType.text,
                      isRequired: false),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: _buildLabeledTextField(
                      "Employee's Phone Number",
                      phoneNumber,
                      "Enter Text",
                      TextInputType.phone),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildLabeledTextField(
                      "Other Last Names Used (if any)",
                      otherLastNames,
                      "Enter Text",
                      TextInputType.text,
                      isRequired: false),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: _buildLabeledTextField(
                      "City or Town",
                      cityTown,
                      "Enter Text",
                      TextInputType.text),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildLabeledTextField(
                      "Address (Street Number & Name)",
                      address,
                      "Enter Text",
                      TextInputType.streetAddress),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: _buildLabeledTextField(
                      "State", state, "Enter Text", TextInputType.text),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildLabeledTextField(
                      "Apt. Number",
                      aptNumber,
                      "Enter Text",
                      TextInputType.text,
                      isRequired: false),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: _buildLabeledTextField(
                      "Zip Code", zipCode, "Enter Text", TextInputType.number),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildLabeledTextField(
                    "DOB",
                    dob,
                    "dd-mm-yyyy",
                    TextInputType.datetime,
                    suffixIcon: Icon(Icons.calendar_today)),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'I attest, under penalty of perjury, that I am (Check one of the following boxes.):',
              style: GoogleFonts.firaSans(
                fontSize: 12,
                color: Color(0xFF686464),
                fontWeight: FontWeight.w400,
              ),
            ),
            _buildCheckboxItem('A citizen of the United States'),
            _buildCheckboxItem('A noncitizen national of the United States'),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildCheckboxItem(
                      'A lawful permanent resident (Alien Registration Number/USCIS Number):'),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: _buildLabeledTextField(
                    '',
                    alienRegistrationNumber,
                    'Enter Text',
                    TextInputType.text,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildCheckboxItem(
                      'An alien authorized to work until (expiration date, if applicable, mm/dd/yyyy):'),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: _buildLabeledTextField(
                    '',
                    workAuthorizationExpirationDate,
                    'Enter Text',
                    TextInputType.text,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Aliens authorized to work must provide only one of the following document numbers to complete Form I-9:',
              style: GoogleFonts.firaSans(
                fontSize: 12,
                color: Color(0xFF686464),
                fontWeight: FontWeight.w400,
              ),
            ),
           SizedBox(height: 20),
           Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
              'Alien Registration Number or USCIS Number:',
              style: GoogleFonts.firaSans(
                fontSize: 12,
                color: Color(0xFF686464).withOpacity(0.50),
                fontWeight: FontWeight.w400,
              ),
            ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: _buildLabeledTextField(
                '',
                uscisNumber,
                'Enter Text',
                TextInputType.text,
              ),
            ),
          ],
        ),
            SizedBox(height: 20),
            Padding(
              padding:  EdgeInsets.only(left: 280),
              child: Text(
                'Or',
                style: GoogleFonts.firaSans(
                  fontSize: 12,
                  color: Color(0xFF686464).withOpacity(0.50),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Form I-94 Admission Number:',
                    style: GoogleFonts.firaSans(
                      fontSize: 12,
                      color: Color(0xFF686464).withOpacity(0.50),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: _buildLabeledTextField(
                    '',
                    formI94AdmissionNumber,
                    'Enter Text',
                    TextInputType.text,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 280),
              child: Text(
                'Or',
                style: GoogleFonts.firaSans(
                  fontSize: 12,
                  color: Color(0xFF686464).withOpacity(0.50),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Foreign Passport Number:',
                    style: GoogleFonts.firaSans(
                      fontSize: 12,
                      color: Color(0xFF686464).withOpacity(0.50),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: _buildLabeledTextField(
                    '',
                    foreignPassportNumber,
                    'Enter Text',
                    TextInputType.text,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Country of Issuance:',
                    style: GoogleFonts.firaSans(
                      fontSize: 12,
                      color: Color(0xFF686464).withOpacity(0.50),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: _buildLabeledTextField(
                    '',
                    countryOfIssuance,
                    'Enter Text',
                    TextInputType.text,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OfferLetterDescriptionScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Color((0xFF50B5E5)),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Cancel',
                        style: GoogleFonts.firaSans(
                          color: Color((0xFF50B5E5)),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CertificateOfCompletion()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF50B5E5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Continue',
                        style: GoogleFonts.firaSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                BottomBarRow()
              ],
            )
          ],
        ),
      ),
    );
  }
}

