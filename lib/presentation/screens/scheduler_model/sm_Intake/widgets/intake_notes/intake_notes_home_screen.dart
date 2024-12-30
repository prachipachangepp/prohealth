import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_notes/widgets/intake_notes_miscellaneous/intake_notes_miscellaneous_screen.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';

class SmIntakeNotesScreen extends StatefulWidget {
  final int patientId;
  SmIntakeNotesScreen({super.key, required this.patientId});

  @override
  State<SmIntakeNotesScreen> createState() => _SmIntakeNotesScreenState();
}

class _SmIntakeNotesScreenState extends State<SmIntakeNotesScreen> {
  int selectedIndex = 6;
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
    return Column(
      children: [
        SizedBox(height: AppSize.s15),
        Container(
          width: MediaQuery.of(context).size.width / 1.405,
          height: AppSize.s30,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: ColorManager.black.withOpacity(0.5),
                offset: Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
            color: ColorManager.blueprime,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              InkWell(
                child: Container(
                  height: AppSize.s30,
                  width: MediaQuery.of(context).size.width / 10,
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: selectedIndex == 0 ? ColorManager.white : null,
                  ),
                  child: Text(
                    'Physician',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.semiBold,
                      color: selectedIndex == 0
                          ? ColorManager.mediumgrey
                          : ColorManager.white,
                    ),
                  ),
                ),
                onTap: selectedIndex == 6
                    ? null
                    : () => selectButton(0), // Disable if not index 6
              ),
              InkWell(
                child: Container(
                  height: AppSize.s30,
                  width: MediaQuery.of(context).size.width / 10,
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: selectedIndex == 1 ? ColorManager.white : null,
                  ),
                  child: Text(
                    'Supervisory',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.semiBold,
                      color: selectedIndex == 1
                          ? ColorManager.mediumgrey
                          : ColorManager.white,
                    ),
                  ),
                ),
                onTap: selectedIndex == 6
                    ? null
                    : () => selectButton(1), // Disable if not index 6
              ),
              InkWell(
                child: Container(
                  height: AppSize.s30,
                  width: MediaQuery.of(context).size.width / 10,
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: selectedIndex == 2 ? ColorManager.white : null,
                  ),
                  child: Text(
                    'Nurses Clinical',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.semiBold,
                      color: selectedIndex == 2
                          ? ColorManager.mediumgrey
                          : ColorManager.white,
                    ),
                  ),
                ),
                onTap: selectedIndex == 6
                    ? null
                    : () => selectButton(2), // Disable if not index 6
              ),
              InkWell(
                child: Container(
                  height: AppSize.s30,
                  width: MediaQuery.of(context).size.width / 9.5,
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: selectedIndex == 3 ? ColorManager.white : null,
                  ),
                  child: Text(
                    'Speech Therapy',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.semiBold,
                      color: selectedIndex == 3
                          ? ColorManager.mediumgrey
                          : ColorManager.white,
                    ),
                  ),
                ),
                onTap: selectedIndex == 6
                    ? null
                    : () => selectButton(3), // Disable if not index 6
              ),
              InkWell(
                child: Container(
                  height: AppSize.s30,
                  width: MediaQuery.of(context).size.width / 9.8,
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: selectedIndex == 4 ? ColorManager.white : null,
                  ),
                  child: Text(
                    'Home Health Aid',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.semiBold,
                      color: selectedIndex == 4
                          ? ColorManager.mediumgrey
                          : ColorManager.white,
                    ),
                  ),
                ),
                onTap: selectedIndex == 6
                    ? null
                    : () => selectButton(4), // Disable if not index 6
              ),
              InkWell(
                child: Container(
                  height: AppSize.s30,
                  width: MediaQuery.of(context).size.width / 9.8,
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: selectedIndex == 5 ? ColorManager.white : null,
                  ),
                  child: Text(
                    'Spiritual',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.semiBold,
                      color: selectedIndex == 5
                          ? ColorManager.mediumgrey
                          : ColorManager.white,
                    ),
                  ),
                ),
                onTap: selectedIndex == 6
                    ? null
                    : () => selectButton(5), // Disable if not index 6
              ),
              InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: AppSize.s30,
                  width: MediaQuery.of(context).size.width / 9.8,
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: selectedIndex == 6 ? ColorManager.white : null,
                  ),
                  child: Text(
                    'Miscellaneous',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.semiBold,
                      color: selectedIndex == 6
                          ? ColorManager.mediumgrey
                          : ColorManager.white,
                    ),
                  ),
                ),
                onTap: () => selectButton(6), // This is the only enabled option
              ),
            ],
          ),
        ),
        const SizedBox(
          height: AppSize.s10,
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
                  // Container(color: Colors.red),
                  // Container(color: Colors.blue),
                  // Container(color: Colors.purple),
                  // Container(color: Colors.grey),
                  // Container(color: Colors.yellow),
                  // Container(color: Colors.brown),
                  IntakeNotesMiscellaneousScreen(
                    patientId: widget.patientId,
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}
