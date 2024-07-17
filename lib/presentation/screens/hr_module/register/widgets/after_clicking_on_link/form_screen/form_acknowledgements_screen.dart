
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcknowledgementsScreen extends StatefulWidget {
  const AcknowledgementsScreen({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<AcknowledgementsScreen> createState() => _AcknowledgementsScreenState();
}

class _AcknowledgementsScreenState extends State<AcknowledgementsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 166, right: 166),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Acknowledgements',
                  style: GoogleFonts.firaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff50B5E5)),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              Container(
                height: 50,
                width: 940,
                padding:
                EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFE6F7FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Please sign the list of documents required for the recruitment process',
                    style: GoogleFonts.firaSans(
                      color: Color(0xFF686464),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Row(
                children: [
                  Text(
                    'List Of Documents',
                    style: GoogleFonts.firaSans(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff686464),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Canditate Release Form (Background Check)',
                    style: GoogleFonts.firaSans(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff686464),
                    ),
                  ),
                  Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 24.0,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Divider(
                height: 1,
                color: Color(0xFFD1D1D1),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'On - call',
                    style: GoogleFonts.firaSans(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff686464),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // fill info action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff50B5E5),
                      // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Sign',
                      style: GoogleFonts.firaSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Divider(
                height: 1,
                color: Color(0xFFD1D1D1),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Confidentiality Statement HIPAA',
                    style: GoogleFonts.firaSans(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff686464),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // fill info action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff50B5E5),
                      // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Sign',
                      style: GoogleFonts.firaSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Divider(
                height: 1,
                color: Color(0xFFD1D1D1),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Policy Concerning 3 RD Party',
                    style: GoogleFonts.firaSans(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff686464),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // fill info action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff50B5E5),
                      // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Sign',
                      style: GoogleFonts.firaSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Divider(
                height: 1,
                color: Color(0xFFD1D1D1),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Standards Of Conduct',
                    style: GoogleFonts.firaSans(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff686464),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // fill info action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff50B5E5),
                      // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Sign',
                      style: GoogleFonts.firaSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Divider(
                height: 1,
                color: Color(0xFFD1D1D1),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'California Sexual Harassment Training',
                    style: GoogleFonts.firaSans(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff686464),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // fill info action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff50B5E5),
                      // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Sign',
                      style: GoogleFonts.firaSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Divider(
                height: 1,
                color: Color(0xFFD1D1D1),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Prop65',
                    style: GoogleFonts.firaSans(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff686464),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // fill info action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff50B5E5),
                      // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Sign',
                      style: GoogleFonts.firaSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Divider(
                height: 1,
                color: Color(0xFFD1D1D1),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Return Of Company Policy',
                    style: GoogleFonts.firaSans(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff686464),
                    ),
                  ),
                  Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 24.0,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Divider(
                height: 1,
                color: Color(0xFFD1D1D1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}