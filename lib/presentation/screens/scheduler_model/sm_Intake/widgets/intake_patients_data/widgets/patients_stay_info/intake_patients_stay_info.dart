import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/app.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../patients_info/intake_patients_info.dart';

class IntakePatientsStayInfoScreen extends StatelessWidget {
  const IntakePatientsStayInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 80.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Status Completed',
                      style: GoogleFonts.firaSans(
                          decoration: TextDecoration.none,
                          fontSize: 12.0,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.greenDark
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 19.5),
              Container(
                // height: 423,
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Last Inpatient Stay Information',
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            color: Color(0xff686464),
                            fontWeight: FontWeightManager.semiBold,)),
                      SizedBox(height: 20),
                      _buildInpatientStaySection(),
                      SizedBox(height: 30),
                      Text('Location of Care',
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            color: Color(0xff686464),
                            fontWeight: FontWeightManager.semiBold,)),
                      SizedBox(height: 20),
                      _buildLocationOfCareSection(),
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

  Widget _buildInpatientStaySection() {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
                child: SchedularDropdown(
                    labelText: 'Facility',
                    initialValue: 'Select a Facility')
            ),
            SizedBox(width: 35),
            Flexible(
                child: SchedularTextField(
                    labelText: 'Medical Record #')
            ),
            SizedBox(width: 35),
            Flexible(
                child: SchedularDropdown(
                    labelText: AppString.status,
                    initialValue: 'Scheduled')
            ),
            SizedBox(width: 35),
            Flexible(
                child: SchedularTextField(
                    labelText: 'Hospital')
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Flexible(
                child: SchedularTextField(
                    labelText: 'Phone')
            ),
            SizedBox(width: 35),
            Flexible(
                child: SchedularTextField(
                    labelText: AppString.address)
            ),
            SizedBox(width: 35),
            Flexible(
                child: SchedularTextField(
                    labelText:  AppString.city)
            ),
            SizedBox(width: 35),
            Flexible(
                child: SchedularDropdown(
                    labelText:  AppString.state)
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Flexible(child: SchedularTextFieldWithButton(
              labelText: 'Zip Code',
              initialValue: '2656845121',
              buttonText: 'View Zone',
            )),
            SizedBox(width: 35),
            Flexible(
                child: SchedularTextField(
                    labelText: 'Admit Date',
                    isDate: true)
            ),
            SizedBox(width: 35),
            Flexible(
                child: SchedularTextField(
                    labelText: 'D/C',
                    isDate: true)
            ),
            SizedBox(width: 35),
            Flexible(
                child: SchedularTextField(
                    labelText: 'Recent Surgery/ Procedure'
                )
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Flexible(
                child: SchedularTextField(
                    labelText: 'Date of Surgery/ Procedure',
                    isDate: true)
            ),
            SizedBox(width: 35),
            Flexible(
                child: SchedularTextField(
                    labelText: AppString.comments
                )
            ),
            SizedBox(width: 35),
            Flexible(
                child: Container()), // Empty container for alignment
            SizedBox(width: 35),
            Flexible(
                child: Container()),
          ],
        )
      ],
    );
  }




  Widget _buildLocationOfCareSection() {
    return Column(
      children: [
        Row(
          children: [

            Flexible(
                child: SchedularTextField(
                    labelText: AppString.startdate,
                    isDate: true
                )
            ),
            SizedBox(width: 35),
            Flexible(
                child: SchedularTextField(
                    labelText: AppString.enddate,
                    isDate: true
                )
            ),
            SizedBox(width: 35),
            Flexible(
                child: SchedularTextField(
                    labelText: 'Street'
                )
            ),
            SizedBox(width: 35),
            Flexible(
                child: SchedularTextField(
                    labelText: 'Suite/ Apt#'
                )
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Flexible(
                child: SchedularTextField(
                    labelText: AppString.city
                )
            ),
            SizedBox(width: 35),
            Flexible(
                child: SchedularDropdown(
                    labelText: AppString.state
                )
            ),
            SizedBox(width: 35),
            Flexible(
                child: SchedularTextFieldWithButton(
                  labelText: 'Zip Code',
                  initialValue: '2656845121',
                  buttonText: 'View Zone',
                )
            ),
            SizedBox(width: 35),
            Flexible(
                child: SchedularTextField(
                    labelText: AppString.phone
                )
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Flexible(
                child: SchedularTextField(
                    labelText: 'Fax'
                )
            ),
            SizedBox(width: 35),
            Flexible(
                child: Container()),
            SizedBox(width: 35),
            Flexible(
                child: Container()), // Empty container for alignment
            SizedBox(width: 35),
            Flexible(
                child: Container()),
          ],
        )
      ],
    );
  }
}