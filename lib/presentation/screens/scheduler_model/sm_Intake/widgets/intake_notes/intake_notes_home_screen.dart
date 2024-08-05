import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_notes/widgets/intake_notes_miscellaneous/intake_notes_miscellaneous_screen.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_compliance/intake_patients_compliance.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_info/intake_patients_info.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_plan_care/intake_patients_plan_care.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_related_party/intake_patients_related_party.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_stay_info/intake_patients_stay_info.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';

class SmIntakeNotesScreen extends StatefulWidget {
  SmIntakeNotesScreen({super.key});

  @override
  State<SmIntakeNotesScreen> createState() => _SmIntakeNotesScreenState();
}

class _SmIntakeNotesScreenState extends State<SmIntakeNotesScreen> {
  int selectedIndex = 0;
  final PageController smIntakePageController = PageController();

  void selectButton(int index) {
    setState(() {
      selectedIndex = index;
    });

    smIntakePageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(14),
      child: Column(
        children: [
          SizedBox(height: 15,),
          Container(
            width: MediaQuery.of(context).size.width/1.405,
            height: 30,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
                color: ColorManager.blueprime,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              children: [
                InkWell(
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 10,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(20),
                      color: selectedIndex == 0
                          ? Colors.white
                          : null,
                    ),
                    child: Text(
                      'Physician',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeightManager.semiBold,
                        color: selectedIndex == 0
                            ? ColorManager.mediumgrey
                            : Colors.white,
                      ),
                    ),
                  ),
                  onTap: () => selectButton(0),
                ),
                InkWell(
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 10,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: selectedIndex == 1
                          ? Colors.white
                          : null,
                    ),
                    child: Text(
                      'Supervisory',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeightManager.semiBold,
                        color: selectedIndex == 1
                            ? ColorManager.mediumgrey
                            : Colors.white,
                      ),
                    ),
                  ),
                  onTap: () => selectButton(1),
                ),
                InkWell(
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 10,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: selectedIndex == 2
                          ? Colors.white
                          : null,
                    ),
                    child: Text(
                      'Nurses Clinical',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeightManager.semiBold,
                        color: selectedIndex == 2
                            ? ColorManager.mediumgrey
                            : Colors.white,
                      ),
                    ),
                  ),
                  onTap: () => selectButton(2),
                ),
                InkWell(
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 9.5,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: selectedIndex == 3
                          ? Colors.white
                          : null,
                    ),
                    child: Text(
                      'Speech Therapy',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeightManager.semiBold,
                        color: selectedIndex == 3
                            ? ColorManager.mediumgrey
                            : Colors.white,
                      ),
                    ),
                  ),
                  onTap: () => selectButton(3),
                ),
                InkWell(
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 9.8,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: selectedIndex == 4
                          ? Colors.white
                          : null,
                    ),
                    child: Text(
                      'Home Health Aid',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeightManager.semiBold,
                        color: selectedIndex == 4
                            ? ColorManager.mediumgrey
                            : Colors.white,
                      ),
                    ),
                  ),
                  onTap: () => selectButton(4),
                ),InkWell(
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 9.8,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: selectedIndex == 5
                          ? Colors.white
                          : null,
                    ),
                    child: Text(
                      'Spiritual',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeightManager.semiBold,
                        color: selectedIndex == 5
                            ? ColorManager.mediumgrey
                            : Colors.white,
                      ),
                    ),
                  ),
                  onTap: () => selectButton(5),
                ),InkWell(
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 9.8,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: selectedIndex == 6
                          ? Colors.white
                          : null,
                    ),
                    child: Text(
                      'Miscellaneous',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeightManager.semiBold,
                        color: selectedIndex == 6
                            ? ColorManager.mediumgrey
                            : Colors.white,
                      ),
                    ),
                  ),
                  onTap: () => selectButton(6),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                //horizontal: MediaQuery.of(context).size.width / 45,
                  vertical: 5),
              child: PageView(
                  controller: smIntakePageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Container(color: Colors.red),
                    Container(color: Colors.blue),
                    Container(color: Colors.purple),
                    Container(color: Colors.grey),
                    Container(color: Colors.yellow),
                    Container(color: Colors.brown),
                    IntakeNotesMiscellaneousScreen(),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
