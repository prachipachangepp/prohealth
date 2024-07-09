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
import '../../widgets/widgets/banking_tab_constant.dart';


class QualificationEducation extends StatefulWidget {
  const QualificationEducation({Key? key}) : super(key: key);

  @override
  State<QualificationEducation> createState() => _QualificationEducationState();
}

class _QualificationEducationState extends State<QualificationEducation> {
  final StreamController<List<OnboardingQualificationEducationData>> educationStreamController = StreamController<List<OnboardingQualificationEducationData>>();

  @override
  void initState() {
    super.initState();
    getOnboardingQualificationEducation(context, 2).then((data){
      educationStreamController.add(data);
    }).catchError((error){});
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return StreamBuilder<List<OnboardingQualificationEducationData>>(
        stream: educationStreamController.stream,
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
                            InfoText('College/ University'),
                            InfoText('Graduate'),
                            InfoText('Degree'),
                            InfoText('Major Subject'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoData(snapshot.data![index].college),
                            InfoData(snapshot.data![index].graduate),
                            InfoData(snapshot.data![index].degree),
                            InfoData(snapshot.data![index].major),
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
                            InfoData(snapshot.data![index].phone),
                            InfoData(snapshot.data![index].city),
                            InfoData(snapshot.data![index].state),
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
      }else{
        return const SizedBox();
      }
        }
    );
  }
}
