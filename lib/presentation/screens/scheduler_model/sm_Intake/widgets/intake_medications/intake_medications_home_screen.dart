import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_medications/widgets/intake_medication_profile/intake_medication_profile_screen.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_medications/widgets/intake_pharmacy_vendor/intake_pharmacy_vendor_screen.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../widgets/constant_widgets/schedular_success_popup.dart';

class IntakeMedicationScreen extends StatefulWidget {
  final int patientId;
  const IntakeMedicationScreen({super.key, required this.patientId,});

  @override
  State<IntakeMedicationScreen> createState() => _IntakeMedicationScreenState();
}

class _IntakeMedicationScreenState extends State<IntakeMedicationScreen> {
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
    return  Column(
      children: [
        SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width/5, //4.8
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
                  borderRadius: BorderRadius.circular(14)
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
                        'Pharmacy Vendor',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s14,
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
                        'Medication Profile',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.semiBold,
                          color: selectedIndex == 1
                              ? ColorManager.mediumgrey
                              : Colors.white,
                        ),
                      ),
                    ),
                    onTap: () => selectButton(1),
                  ),
                  // InkWell(
                  //   child: Container(
                  //     height: 30,
                  //     width: MediaQuery.of(context).size.width / 10,
                  //     padding: EdgeInsets.symmetric(vertical: 6),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: selectedIndex == 2
                  //           ? Colors.white
                  //           : null,
                  //     ),
                  //     child: Text(
                  //       'Physician Orders',
                  //       textAlign: TextAlign.center,
                  //       style: GoogleFonts.firaSans(
                  //         fontSize: 12,
                  //         fontWeight: FontWeightManager.semiBold,
                  //         color: selectedIndex == 2
                  //             ? ColorManager.mediumgrey
                  //             : Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  //   onTap: () => selectButton(2),
                  // ),
                  // InkWell(
                  //   child: Container(
                  //     height: 30,
                  //     width: MediaQuery.of(context).size.width / 9.5,
                  //     padding: EdgeInsets.symmetric(vertical: 6),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: selectedIndex == 3
                  //           ? Colors.white
                  //           : null,
                  //     ),
                  //     child: Text(
                  //       'Face To Face',
                  //       textAlign: TextAlign.center,
                  //       style: GoogleFonts.firaSans(
                  //         fontSize: 12,
                  //         fontWeight: FontWeightManager.semiBold,
                  //         color: selectedIndex == 3
                  //             ? ColorManager.mediumgrey
                  //             : Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  //   onTap: () => selectButton(3),
                  // ),
                ],
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width/3.4),
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Container(
                height: 26,
                width: 102,
                // child: ElevatedButton(
                //   onPressed: () {
                //     showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return SchedularSuccessPopup(title: 'Success',);
                //       },
                //     );
                //   },
                //   child: Text(
                //     'Save',
                //     style: GoogleFonts.firaSans(
                //       fontSize: FontSize.s12,
                //       fontWeight: FontWeightManager.bold,
                //       color: Colors.white,
                //     ),
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 25,
                //       vertical: 10,
                //     ),
                //     backgroundColor: ColorManager.blueprime,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //   ),
                // ),
              ),
            ),
          ],
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
                  IntakePharmacyVendorScreen(patientId: widget.patientId,),
                  IntakeMedicationProfileScreen(),
                ]),
          ),
        ),
      ],
    );
  }
}
