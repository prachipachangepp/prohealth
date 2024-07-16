import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/hr_module/see_all_hr/widgets/drop_down.dart';
import 'package:prohealth/presentation/screens/hr_module/see_all_hr/widgets/see_all_container_constant.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../app/resources/value_manager.dart';
import '../register/taxtfield_constant.dart';

class ClinicalHrScreen extends StatefulWidget {
  const ClinicalHrScreen({super.key});

  @override
  State<ClinicalHrScreen> createState() => _ClinicalHrScreenState();
}

class _ClinicalHrScreenState extends State<ClinicalHrScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 60,
        ),
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: ColorManager.fmediumgrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Expanded(
                  flex: 1,
                  child: Text(
                    AppStringEM.srno,
                    style: AllHRTableHeading.customTextStyle(context),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    AppStringEM.type,
                    style: AllHRTableHeading.customTextStyle(context),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    AppStringEM.name,
                    style: AllHRTableHeading.customTextStyle(context),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    AppStringEM.location,
                    style: AllHRTableHeading.customTextStyle(context),
                  ),
                ),
              ),
              // SizedBox(width: MediaQuery.of(context).size.width/20,),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 75.0),
                  child: Text(
                    AppStringEM.specialization,
                    style: AllHRTableHeading.customTextStyle(context),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: Text(
                    AppStringEM.edit,
                    style: AllHRTableHeading.customTextStyle(context),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 60,
        ),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) {
                // int serialNumber =
                //     index + 1 + (currentPage - 1) * itemsPerPage;
                // String formattedSerialNumber =
                // serialNumber.toString().padLeft(2, '0');

                return SeeAllContainerConstant();
              }),
        )
      ],
    );
  }
}

