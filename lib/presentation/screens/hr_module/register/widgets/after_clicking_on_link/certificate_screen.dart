import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/termination/termination_head_tabbar.dart';

import '../../../manage/widgets/top_row.dart';

class CertificateOfCompletion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TopRowConstant(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Declination Form',
                style: GoogleFonts.firaSans(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    height: 1241.0,
                    width: 878.0,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 4),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildCertificateHeader(),
                              SizedBox(height: 40),
                              _buildDecorativeSymbol(),
                              SizedBox(height: 40),
                              buildCertificateBody(),
                              SizedBox(height: 90),
                              buildSignatureSection(),
                              SizedBox(height: 60.0),
                              buildTitleSection(),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ),
                ],
              ),
              SizedBox(height: 20),
              buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCertificateHeader() {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 50.0),
              Expanded(child: _buildDecorativeSymbol()),
              SizedBox(width: 80.0),
              Text(
                'C E R T I F I C A T E  O F \n    C O M P L E T I O N',
                style: GoogleFonts.firaSans(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 80),
              Expanded(child: _buildDecorativeSymbol()),
            ],
          ),
          // Text(
          //   'C O M P L E T I O N',
          //   style: GoogleFonts.firaSans(
          //     fontSize: 40,
          //     fontWeight: FontWeight.w700,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildCertificateBody() {
    return Column(
      children: [
        Text(
          'T H I S   A W A R D   C E R T I F I E S   T H A T',
          style: GoogleFonts.firaSans(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 70.0),
        Text(
          '<Enter Name of Recipient>',
          style: GoogleFonts.caveat(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        Divider(height: 30, color: Colors.grey),
        SizedBox(height: 70.0),
        Text(
          'H A S   S U C C E S S F U L L Y   C O M P L E T E D',
          style: GoogleFonts.firaSans(
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 70.0),
        Text(
          '<Enter comments>',
          style: GoogleFonts.caveat(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        Divider(height: 20, color: Colors.grey),
      ],
    );
  }

  Widget buildSignatureSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildSignatureColumn('<Enter date>', 'D A T E'),
        SizedBox(width: 60),
        buildSignatureColumn('', 'S I G N A T U R E'),
      ],
    );
  }

  Widget buildSignatureColumn(String text1, String text2) {
    return Expanded(
      child: Column(
        children: [
          Text(
            text1,
            style: GoogleFonts.caveat(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Divider(height: 20, color: Colors.grey),
          Text(
            text2,
            style: GoogleFonts.firaSans(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildTitleSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Container()),
        SizedBox(width: 60),
        buildSignatureColumn('Enter title', 'T I T L E'),
      ],
    );
  }

  Widget buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            // Implement action for cancel button
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          child: Text(
            'Cancel',
            style: GoogleFonts.firaSans(
              color: Color((0xFF50B5E5)),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            // Implement action for sign button
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF50B5E5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          child: Text(
            'Sign',
            style: GoogleFonts.firaSans(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDecorativeSymbol() {
    return Text(
      '❧',
      style: TextStyle(fontSize: 90, color: Colors.black),
    );
  }
}

//   Widget _buildUnderlinedTextField(String hint) {
//     return TextField(
//       decoration: InputDecoration(
//         border: UnderlineInputBorder(),
//         contentPadding: EdgeInsets.zero,
//       ),
//       textAlign: TextAlign.center,
//     );
//   }
// }



