import 'dart:async';

import 'package:flutter/material.dart';
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
import '../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../manage/widgets/const_card_details.dart';
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
                    AppStringHRNoData.noOnboardEdnData,
                    style:AllNoDataAvailable.customTextStyle(context),
                  ),
                ));
          }
          if(snapshot.hasData){
            return Wrap(children: List.generate(snapshot.data!.length, (index){
              return CardDetails(childWidget: DetailsFormate(
                row1Child1: [
                  Text('College/University :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Graduate :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Degree :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Major Subject :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Text('Emergency Contact :',
                  //     style: ThemeManagerDark.customTextStyle(context)),
                ],
                row1Child2: [
                  Text(
                    snapshot.data![index].college,
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data![index].graduate,
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data![index].degree,
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data![index].major,
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                ],
                row2Child1: [
                  Text('Phone :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('City :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('State :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(' ',
                      style: ThemeManagerDark.customTextStyle(context)),
                ],
                row2Child2: [
                  Text(
                    snapshot.data![index].phone,
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data![index].city.toString(),
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(snapshot.data![index].state.toString(),
                      style: ThemeManagerDarkFont.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('',
                      style: ThemeManagerDarkFont.customTextStyle(context)),
                ],
                button:  Row(
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
                                                style:PopupBlueBarText.customTextStyle(context)
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
                                            style: PopupTextConst.customTextStyle(context)
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
                                                  style: TransparentButtonTextConst.customTextStyle(context)
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
                                                style: BlueButtonTextConst.customTextStyle(context),
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
                                                style:PopupBlueBarText.customTextStyle(context)
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
                                            style: PopupTextConst.customTextStyle(context)
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
                                                  style: TransparentButtonTextConst.customTextStyle(context)
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
                                                style: BlueButtonTextConst.customTextStyle(context),
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
                    ),
                  ],
                ),
                title: 'Education #${index + 1}',));
            }));
          }else{
            return const SizedBox();
          }
        }
    );
  }
}


