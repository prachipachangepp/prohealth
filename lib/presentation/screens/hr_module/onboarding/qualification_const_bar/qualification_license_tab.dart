import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/qualification_bar_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/qualificatin_emloyment_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/widgets/qualification_tab_constant.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../data/api_data/hr_module_data/onboarding_data/onboarding_qualification_data.dart';
import '../../manage/const_wrap_widget.dart';

class QualificationLicense extends StatefulWidget {
  const QualificationLicense({Key? key}) : super(key: key);

  @override
  State<QualificationLicense> createState() => _QualificationLicenseState();
}

class _QualificationLicenseState extends State<QualificationLicense> {
  final StreamController<List<OnboardingQualificationLicenseData>> licenseStreamController = StreamController<List<OnboardingQualificationLicenseData>>();

  @override
  void initState() {
    super.initState();
    getOnboardingQualificationLicense(context, 2).then((data){
      licenseStreamController.add(data);
    }).catchError((error){});
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return StreamBuilder<List<OnboardingQualificationLicenseData>>(
        stream: licenseStreamController.stream,
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorManager.blueprime,
              ),
            );
          }
          if (snapshot.data!.isEmpty) {
            return Center(
                child: Text(
                  AppString.dataNotFound,
                  style: CustomTextStylesCommon.commonStyle(
                      fontWeight: FontWeightManager.medium,
                      fontSize: FontSize.s12,
                      color: ColorManager.mediumgrey),
                ));
          }
          if(snapshot.hasData){
            return WrapWidget(childern: List.generate(snapshot.data!.length, (index){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width/2.5,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 80,
                      vertical: MediaQuery.of(context).size.height / 120,
                    ),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data![index].empId.toString(),
                          style: GoogleFonts.firaSans(
                            fontSize: 13,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoText('Licensure/Certification'),
                                InfoText('Issuing Organization'),
                                InfoText('Country'),
                                InfoText('Number/ID'),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoData(snapshot.data![index].licensure),
                                InfoData(snapshot.data![index].org),
                                InfoData(snapshot.data![index].country),
                                InfoData(snapshot.data![index].licenseNumber),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoText('Issue Date',),
                                InfoText('End Date',),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoData(snapshot.data![index].issueDate),
                                InfoData(snapshot.data![index].expDate),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            QualificationActionButtons(
                                onRejectPressed: (){},
                                onApprovePressed: (){}),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: MediaQuery.of(context).size.width / 80,
            //       vertical: MediaQuery.of(context).size.height / 100),
            //   child: TwoContainersRow(
            //     child1: Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //          Row(
            //           children: [
            //             Text(
            //               AppString.emp1,
            //               style: CustomTextStylesCommon.commonStyle(
            //                   color: ColorManager.blackfaint,
            //                   fontSize: FontSize.s13,
            //                   fontWeight: FontWeightManager.medium
            //               )
            //             ),
            //           ],
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(AppString.finalposition,
            //                     style: ThemeManager.customTextStyle(context)),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(AppString.startdate,
            //                     style: ThemeManager.customTextStyle(context)),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(AppString.enddate,
            //                     style: ThemeManager.customTextStyle(context)),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(AppString.employer,
            //                     style: ThemeManager.customTextStyle(context)),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(AppString.emergencycont,
            //                     style: ThemeManager.customTextStyle(context)),
            //               ],
            //             ),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                  AppString.developer,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(
            //                   AppString.dateone,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(
            //                   AppString.detetwo,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(
            //                   AppString.johnSmith,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(
            //                   AppString.mobilenum,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //               ],
            //             ),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(AppString.reasonleaving,
            //                     style: ThemeManager.customTextStyle(context)),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(AppString.lastSupName,
            //                     style: ThemeManager.customTextStyle(context)),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(AppString.supPhone,
            //                     style: ThemeManager.customTextStyle(context)),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(AppString.city,
            //                     style: ThemeManager.customTextStyle(context)),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(AppString.country,
            //                     style: ThemeManager.customTextStyle(context)),
            //               ],
            //             ),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   AppString.personal,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(
            //                   AppString.jerrychrist,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(
            //                   AppString.tnum,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(
            //                   AppString.hamburg,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(
            //                   AppString.germany,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.all(AppPadding.p8),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               CustomButtonTransparent(
            //                 onPressed: () async{},
            //                 text: AppString.reject,
            //               ),
            //               SizedBox(
            //                 width: MediaQuery.of(context).size.width / 99,
            //               ),
            //               CustomIconButton(text: AppString.approve, onPressed: () async{}),
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //     child2: Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Row(
            //           children: [
            //             Text(
            //                 AppString.emp2,
            //                 style: CustomTextStylesCommon.commonStyle(
            //                     color: ColorManager.blackfaint,
            //                     fontSize: FontSize.s13,
            //                     fontWeight: FontWeightManager.medium
            //                 )
            //             ),
            //           ],
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(AppString.finalposition,
            //                     style: ThemeManager.customTextStyle(context)),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(AppString.startdate,
            //                     style: ThemeManager.customTextStyle(context)),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(AppString.enddate,
            //                     style: ThemeManager.customTextStyle(context)),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(AppString.employer,
            //                     style: ThemeManager.customTextStyle(context)),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(AppString.emergencycont,
            //                     style: ThemeManager.customTextStyle(context)),
            //               ],
            //             ),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   AppString.developer,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(
            //                   AppString.dateone,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(
            //                   AppString.detetwo,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(
            //                   AppString.johnSmith,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(
            //                   AppString.mobilenum,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //               ],
            //             ),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(AppString.reasonleaving,
            //                     style: ThemeManager.customTextStyle(context)),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(AppString.lastSupName,
            //                     style: ThemeManager.customTextStyle(context)),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(AppString.supPhone,
            //                     style: ThemeManager.customTextStyle(context)),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(AppString.city,
            //                     style: ThemeManager.customTextStyle(context)),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(AppString.country,
            //                     style: ThemeManager.customTextStyle(context)),
            //               ],
            //             ),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   AppString.personal,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(
            //                   AppString.jerrychrist,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(
            //                   AppString.tnum,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(
            //                   AppString.hamburg,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //                 const SizedBox(
            //                   height: AppSize.s10,
            //                 ),
            //                 Text(
            //                   AppString.germany,
            //                   style: ThemeManagerDark.customTextStyle(context),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.all(AppPadding.p8),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               CustomButtonTransparent(
            //                 onPressed: () async{},
            //                 text: AppString.reject,
            //               ),
            //               SizedBox(
            //                 width: MediaQuery.of(context).size.width / 99,
            //               ),
            //               CustomIconButton(text: AppString.approve, onPressed: () async{}),
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ));
          }else{
            return const SizedBox();
          }
        }
    );
  }
}
