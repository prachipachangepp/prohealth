
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/container_constant.dart';

class HealthRecordsScreen extends StatefulWidget {
  const HealthRecordsScreen({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<HealthRecordsScreen> createState() => _HealthRecordsScreenState();
}

class _HealthRecordsScreenState extends State<HealthRecordsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1500,
      width: 1200,
      child: Column(
        children: [
          Center(
            child: Text(
              'Health Records',
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
                    Text(
                      '• ',
                      style: GoogleFonts.firaSans(
                        color: Color(0xFF686464),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Instructions: This section is designed to capture and document your health and immunization records as part of your onboarding process. Please enter the required information accurately.',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF686464),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height / 100),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ',
                      style: GoogleFonts.firaSans(
                        color: Color(0xFF686464),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Please ensure that all uploaded immunization records are clear and legible. Accepted file formats for iuploads include PDF, JPG or PNG. In case of declination, please upload a signed copy of the declination form.',
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
          // FutureBuilder(future: future, builder: builder)
          
          
          
          
          
          Expanded(
            child: Column(
              children: [
                PhysicalExamContainer(),
                SizedBox(
                    height: 16), // Add some spacing between containers
                // VaccineContainer(),
                // SizedBox(height: 16),
                PhysicalExamContainer(),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: VaccineContainer(),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

