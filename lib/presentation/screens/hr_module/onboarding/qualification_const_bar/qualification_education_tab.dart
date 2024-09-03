import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/education_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/qualification_bar_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/education_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_qualification_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/widgets/qualification_tab_constant.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../widgets/widgets/banking_tab_constant.dart';

class QualificationEducation extends StatefulWidget {
  final int employeeId;
  const QualificationEducation({Key? key, required this.employeeId}) : super(key: key);

  @override
  State<QualificationEducation> createState() => _QualificationEducationState();
}

class _QualificationEducationState extends State<QualificationEducation> {
  final StreamController<List<OnboardingQualificationEducationData>> educationStreamController = StreamController<List<OnboardingQualificationEducationData>>.broadcast();

  @override
  void initState() {
    super.initState();
    getOnboardingQualificationEducation(context, widget.employeeId,'no').then((data){
      educationStreamController.add(data);
    }).catchError((error){});
  }
  @override
  void dispose() {
    educationStreamController.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return StreamBuilder<List<OnboardingQualificationEducationData>>(
        stream: educationStreamController.stream,
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 150),
                child: CircularProgressIndicator(
                  color: ColorManager.blueprime,
                ),
              ),
            );
          }
          if (snapshot.data!.isEmpty) {
            return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child: Text(
                    AppString.dataNotFound,
                    style: CustomTextStylesCommon.commonStyle(
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSize.s12,
                        color: ColorManager.mediumgrey),
                  ),
                ));
          }
          if(snapshot.hasData){
            return WrapWidget(childern: List.generate(snapshot.data!.length, (index){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width/2.3,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Education #${index + 1}',
                          // 'Education #${snapshot.data![index].educationId.toString()}',
                          style: GoogleFonts.firaSans(
                            fontSize: 13,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        //SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoText('College/ University',),
                                InfoText('Graduate',),
                                InfoText('Degree',),
                                InfoText('Major Subject',),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoData(snapshot.data![index].college,),
                                InfoData(snapshot.data![index].graduate,),
                                InfoData(snapshot.data![index].degree,),
                                InfoData(snapshot.data![index].major,),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoText('Phone',),
                                InfoText('City',),
                                InfoText('State',),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoData(snapshot.data![index].phone,),
                                InfoData(snapshot.data![index].city,),
                                InfoData(snapshot.data![index].state,),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [


                            QualificationActionButtons(
                                approve: snapshot.data![index].approved,
                                onRejectPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          height: 181.0,
                                          width: 500.0,
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: ColorManager.bluebottom,
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    topRight: Radius.circular(8),
                                                  ),
                                                ),
                                                height: 35,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10.0),
                                                      child: Text(
                                                        'Reject',
                                                        style: GoogleFonts.firaSans(
                                                          fontSize: FontSize.s12,
                                                          fontWeight: FontWeightManager.semiBold,
                                                          color: ColorManager.white,
                                                          decoration: TextDecoration.none,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(Icons.close, color: ColorManager.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 20.0),
                                                  child: Text(
                                                    "Do you really want to,reject this?",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.firaSans(
                                                      fontSize: 14,
                                                      fontWeight: FontWeightManager.regular,
                                                      color: ColorManager.mediumgrey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: AppPadding.p24,right: AppPadding.p10),
                                                child: Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          elevation: 5,
                                                          backgroundColor: Colors.white,
                                                          foregroundColor: Color(0xff1696C8),
                                                          side: BorderSide(color: Color(0xff1696C8)),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'Cancel',
                                                          style: GoogleFonts.firaSans(
                                                            fontSize: 10.0,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: MediaQuery.of(context).size.width / 75),
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          await rejectOnboardQualifyEducationPatch(context, snapshot.data![index].educationId);
                                                          getOnboardingQualificationEducation(context, widget.employeeId,'no').then((data){
                                                            educationStreamController.add(data);
                                                          }).catchError((error){});
                                                          Navigator.of(context).pop();
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: Color(0xff1696C8),
                                                          foregroundColor: Colors.white,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'Yes',
                                                          style: GoogleFonts.firaSans(
                                                            fontSize: 10.0,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              onApprovePressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        height: 181.0,
                                        width: 500.0,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                color: ColorManager.bluebottom,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                ),
                                              ),
                                              height: 35,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20.0),
                                                    child: Text(
                                                      'Approve',
                                                      style: GoogleFonts.firaSans(
                                                        fontSize: FontSize.s12,
                                                        fontWeight: FontWeightManager.semiBold,
                                                        color: ColorManager.white,
                                                        decoration: TextDecoration.none,
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(Icons.close, color: ColorManager.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 20.0),
                                                child: Text(
                                                  "Do you really want to,approve this?",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 14,
                                                    fontWeight: FontWeightManager.regular,
                                                    color: ColorManager.mediumgrey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: AppPadding.p24,right: AppPadding.p10),
                                              child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        elevation: 5,
                                                        backgroundColor: Colors.white,
                                                        foregroundColor: Color(0xff1696C8),
                                                        side: BorderSide(color: Color(0xff1696C8)),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'Cancel',
                                                        style: GoogleFonts.firaSans(
                                                          fontSize: 10.0,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: MediaQuery.of(context).size.width / 75),
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        await approveOnboardQualifyEducationPatch(context, snapshot.data![index].educationId);
                                                        getOnboardingQualificationEducation(context, widget.employeeId,'no').then((data){
                                                          educationStreamController.add(data);
                                                        }).catchError((error){});
                                                        Navigator.of(context).pop();
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Color(0xff1696C8),
                                                        foregroundColor: Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'Yes',
                                                        style: GoogleFonts.firaSans(
                                                          fontSize: 10.0,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },

                                // onApprovePressed: ()async{
                                //   showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return Dialog(
                                //         shape: RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.circular(12.0),
                                //         ),
                                //         child: Container(
                                //           decoration: BoxDecoration(
                                //             borderRadius: BorderRadius.circular(20.0),
                                //           ),
                                //           height: 200.0,
                                //           width: 300.0,
                                //           child: Stack(
                                //             children: <Widget>[
                                //               Container(
                                //                 width: double.infinity,
                                //                 height: 50,
                                //                 alignment: Alignment.bottomCenter,
                                //                 decoration: BoxDecoration(
                                //                   color: Color(0xff1696C8),
                                //                   borderRadius: BorderRadius.only(
                                //                     topLeft: Radius.circular(12),
                                //                     topRight: Radius.circular(12),
                                //                   ),
                                //                 ),
                                //                 child: Align(
                                //                   alignment: Alignment.topRight,
                                //                   child: IconButton(
                                //                     onPressed: () {
                                //                       Navigator.of(context).pop();
                                //                     },
                                //                     icon: Icon(Icons.close, color: Colors.white),
                                //                   ),
                                //                 ),
                                //               ),
                                //               Align(
                                //                 alignment: Alignment.center,
                                //                 child: Text(
                                //                   "Do you really want to,\napprove this?",
                                //                   textAlign: TextAlign.center,
                                //                   style: GoogleFonts.firaSans(
                                //                     fontSize: 14,
                                //                     fontWeight: FontWeightManager.regular,
                                //                     color: ColorManager.mediumgrey,
                                //                   ),
                                //                 ),
                                //               ),
                                //               Padding(
                                //                 padding: const EdgeInsets.all(10),
                                //                 child: Align(
                                //                   alignment: Alignment.bottomCenter,
                                //                   child: Row(
                                //                     mainAxisAlignment: MainAxisAlignment.center,
                                //                     children: [
                                //                       ElevatedButton(
                                //                         onPressed: () {
                                //                           Navigator.of(context).pop();
                                //                         },
                                //                         style: ElevatedButton.styleFrom(
                                //                           backgroundColor: Colors.white,
                                //                           foregroundColor: Color(0xff1696C8),
                                //                           side: BorderSide(color: Color(0xff1696C8)),
                                //                           shape: RoundedRectangleBorder(
                                //                             borderRadius: BorderRadius.circular(8),
                                //                           ),
                                //                         ),
                                //                         child: Text(
                                //                           'Cancel',
                                //                           style: GoogleFonts.firaSans(
                                //                             fontSize: 10.0,
                                //                             fontWeight: FontWeight.w700,
                                //                           ),
                                //                         ),
                                //                       ),
                                //                       SizedBox(width: MediaQuery.of(context).size.width / 75),
                                //                       ElevatedButton(
                                //                         onPressed: () async {
                                //                           await approveOnboardQualifyEducationPatch(context, snapshot.data![index].educationId);
                                //                           getOnboardingQualificationEducation(context, 2).then((data){
                                //                             educationStreamController.add(data);
                                //                           }).catchError((error){});
                                //                           Navigator.of(context).pop();
                                //                         },
                                //                         style: ElevatedButton.styleFrom(
                                //                           backgroundColor: Color(0xff1696C8),
                                //                           foregroundColor: Colors.white,
                                //                           shape: RoundedRectangleBorder(
                                //                             borderRadius: BorderRadius.circular(8),
                                //                           ),
                                //                         ),
                                //                         child: Text(
                                //                           'Yes',
                                //                           style: GoogleFonts.firaSans(
                                //                             fontSize: 10.0,
                                //                             fontWeight: FontWeight.w700,
                                //                           ),
                                //                         ),
                                //                       ),
                                //                     ],
                                //                   ),
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //       );
                                //     },
                                //   );
                                // },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
          }else{
            return const SizedBox();
          }
        }
    );
  }
}


