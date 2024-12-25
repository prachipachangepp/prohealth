import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_physician_info/widget/physician_info_face_to_face/physician_info_face_to_face.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_physician_info/widget/physician_info_info/physician_info_info.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_physician_info/widget/physician_info_orders/physician_info_orders.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_physician_info/widget/physician_info_referring_diagnosis/physician_info_referring_diagnosis.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/value_manager.dart';

class IntakePhysicianScreen extends StatefulWidget {
  final int patientId;
  const IntakePhysicianScreen({super.key, required this.patientId});

  @override
  State<IntakePhysicianScreen> createState() => _IntakePhysicianScreenState();
}

class _IntakePhysicianScreenState extends State<IntakePhysicianScreen> {
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
        SizedBox(height: AppSize.s15),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width/2.466, //2.4
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
                  borderRadius: BorderRadius.circular(14)
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
                        color: selectedIndex == 0
                            ? ColorManager.white
                            : null,
                      ),
                      child: Text(
                        'Info',
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
                    onTap: () => selectButton(0),
                  ),
                  InkWell(
                    child: Container(
                      height: AppSize.s30,
                      width: MediaQuery.of(context).size.width / 10,
                      padding: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: selectedIndex == 1
                            ? ColorManager.white
                            : null,
                      ),
                      child: Text(
                        'Referring Diagnosis',
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
                    onTap: () => selectButton(1),
                  ),
                  InkWell(
                    child: Container(
                      height: AppSize.s30,
                      width: MediaQuery.of(context).size.width / 10,
                      padding: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: selectedIndex == 2
                            ? ColorManager.white
                            : null,
                      ),
                      child: Text(
                        'Physician Orders',
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
                    onTap: () => selectButton(2),
                  ),
                  InkWell(
                    child: Container(
                      height: AppSize.s30,
                      width: MediaQuery.of(context).size.width / 9.5,
                      padding: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: selectedIndex == 3
                            ? ColorManager.white
                            : null,
                      ),
                      child: Text(
                        'Face To Face',
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
                    onTap: () => selectButton(3),
                  ),
                ],
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width/5),
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Container(
                height: AppSize.s26,
                width: AppSize.s102,
                // child: ElevatedButton(
                //   onPressed: () {
                //     showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return SchedularSuccessPopup(title: 'Success',);
                //       },
                //     );
                //   },
                //   child: Text(AppString.save,
                //     style: GoogleFonts.firaSans(
                //       fontSize: FontSize.s12,
                //       fontWeight: FontWeightManager.bold,
                //       color: ColorManager.white,
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
                  PhysicianInfoInfoScreen(patientId: widget.patientId),
                  ReferringDiagnososScreen(patientId: widget.patientId,),
                  PhysicianOrder(patientId: widget.patientId,),

                  PhysicianFaceToFace(patientId: widget.patientId,),
                ]),
          ),
        ),
      ],
    );
  }
}
