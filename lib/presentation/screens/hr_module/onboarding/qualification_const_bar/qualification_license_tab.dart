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
  final StreamController<List<OnboardingQualificationLicenseData>> licenseStreamController = StreamController<List<OnboardingQualificationLicenseData>>.broadcast();

  @override
  void initState() {
    super.initState();
    getOnboardingQualificationLicense(context, 2).then((data){
      licenseStreamController.add(data);
    }).catchError((error){});
  }
  @override
  void dispose() {
    licenseStreamController.close();
    super.dispose();
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'License #${snapshot.data![index].licenseId.toString()}',
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
                                InfoText('',),
                                InfoText('',),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoData(snapshot.data![index].issueDate),
                                InfoData(snapshot.data![index].expDate),
                                InfoData(''),
                                InfoData(''),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            QualificationActionButtons(
                                approve: snapshot.data![index].approve,
                                onRejectPressed: () async {
                                  await rejectOnboardQualifyLicensePatch(context, snapshot.data![index].licenseId);
                                  getOnboardingQualificationLicense(context, 2).then((data){
                                    licenseStreamController.add(data);
                                  }).catchError((error){});
                                },
                                onApprovePressed: ()async{
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
                                          height: 200.0,
                                          width: 300.0,
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                width: double.infinity,
                                                height: 50,
                                                alignment: Alignment.bottomCenter,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff1696C8),
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(12),
                                                    topRight: Radius.circular(12),
                                                  ),
                                                ),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    icon: Icon(Icons.close, color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Do you really want to,\napprove this?",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 14,
                                                    fontWeight: FontWeightManager.regular,
                                                    color: ColorManager.mediumgrey,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        style: ElevatedButton.styleFrom(
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
                                                          await approveOnboardQualifyLicensePatch(context, snapshot.data![index].licenseId);
                                                          getOnboardingQualificationLicense(context, 2).then((data){
                                                            licenseStreamController.add(data);
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
                                }),
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
