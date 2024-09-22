import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Make sure to import flutter_svg package

import 'package:prohealth/presentation/screens/hr_module/manage/widgets/bottom_row.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/termination/termination_head_tabbar.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/certificate_two_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/form_nine_screen.dart';
import '../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../manage/widgets/top_row.dart';
import 'offer_letter_description_screen.dart';

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
                style: FormHeading.customTextStyle(context)
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
              SizedBox(height: 30),
              buildActionButtons(context),
              SizedBox(height: 30),
             Row(
               children: [
                 BottomBarRow()
               ],
             )
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
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 80),
              Expanded(child: _buildDecorativeSymbol()),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCertificateBody() {
    return Column(
      children: [
        Text(
          'T H I S   A W A R D   C E R T I F I E S   T H A T',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 70.0),
        Text(
          '<Enter Name of Recipient>',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        Divider(height: 30, color: Colors.grey),
        SizedBox(height: 70.0),
        Text(
          'H A S   S U C C E S S F U L L Y   C O M P L E T E D',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 70.0),
        Text(
          '<Enter comments>',
          style: TextStyle(
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
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Divider(height: 20, color: Colors.grey),
          Text(
            text2,
            style: TextStyle(
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

  Widget buildActionButtons(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigator.push(context , MaterialPageRoute(builder: (context) => FormNineScreen()));
                Navigator.push(context, MaterialPageRoute(builder: (context) => FormNineScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
              child: Text(
                'Cancel',
                style: TransparentButtonTextConst.customTextStyle(context)
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context , MaterialPageRoute(builder: (context) => CertificateOfCompletionScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF50B5E5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
              child: Text(
                'Sign',
                style: BlueButtonTextConst.customTextStyle(context)
              ),
            ),
          ],
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
