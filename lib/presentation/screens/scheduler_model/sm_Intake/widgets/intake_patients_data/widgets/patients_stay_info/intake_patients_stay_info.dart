import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/app.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_withbutton_const.dart';
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
                    Text(AppString.status_completed,
                      style: GoogleFonts.firaSans(
                          decoration: TextDecoration.none,
                          fontSize: AppSize.s12,
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
                            fontSize: AppSize.s12,
                            color: ColorManager.granitegray,
                            fontWeight: FontWeightManager.semiBold,)),
                      SizedBox(height: AppSize.s20),
                      _buildInpatientStaySection(),
                      SizedBox(height: AppSize.s30),
                      Text('Location of Care',
                          style: GoogleFonts.firaSans(
                            fontSize: AppSize.s12,
                            color: ColorManager.granitegray,
                            fontWeight: FontWeightManager.semiBold,)),
                      SizedBox(height: AppSize.s20),
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
                    items: ['Option 1', 'Option 2', 'Option 3'])
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                    labelText: 'Medical Record #')
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularDropdown(
                    labelText: AppString.status,
                    items: ['Option 1', 'Option 2', 'Option 3']
                    )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                    labelText: 'Hospital')
            ),
          ],
        ),
        SizedBox(height: AppSize.s16),
        Row(
          children: [
            Flexible(
                child: SchedularTextField(
                    labelText: 'Phone')
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                    labelText: AppString.address)
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                    labelText:  AppString.city)
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularDropdown(
                    labelText:  AppString.state,
                    items: ['Option 1', 'Option 2', 'Option 3'])
            ),
          ],
        ),
        SizedBox(height: AppSize.s16),
        Row(
          children: [
            Flexible(child: SchedularTextFieldWithButton(
              labelText: AppString.zip_code,
              initialValue: '2656845121',
              buttonText: 'View Zone',
            )),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                    labelText: 'Admit Date',
                    isDate: true)
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                    labelText: 'D/C',
                    isDate: true)
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                    labelText: 'Recent Surgery/ Procedure'
                )
            ),
          ],
        ),
        SizedBox(height: AppSize.s16),
        Row(
          children: [
            Flexible(
                child: SchedularTextField(
                    labelText: 'Date of Surgery/ Procedure',
                    isDate: true)
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                    labelText: AppString.comments
                )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: Container()),             // Empty container for alignment
            SizedBox(width: AppSize.s35),
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
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                    labelText: AppString.enddate,
                    isDate: true
                )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                    labelText: 'Street'
                )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                    labelText: 'Suite/ Apt#'
                )
            ),
          ],
        ),
        SizedBox(height: AppSize.s20),
        Row(
          children: [
            Flexible(
                child: SchedularTextField(
                    labelText: AppString.city
                )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularDropdown(
                    labelText: AppString.state,
                    items: ['Option 1', 'Option 2', 'Option 3']
                )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextFieldWithButton(
                  labelText: AppString.zip_code,
                  initialValue: '2656845121',
                  buttonText: 'View Zone',
                )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                    labelText: AppString.phone
                )
            ),
          ],
        ),
        SizedBox(height: AppSize.s16),
        Row(
          children: [
            Flexible(
                child: SchedularTextField(
                    labelText: 'Fax'
                )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: Container()),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: Container()), // Empty container for alignment
            SizedBox(width: AppSize.s35),
            Flexible(
                child: Container()),
          ],
        )
      ],
    );
  }
}