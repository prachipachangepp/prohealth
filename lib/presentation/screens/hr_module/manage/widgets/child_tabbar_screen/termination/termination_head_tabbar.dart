import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/termination_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/termination_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/row_container_widget_const.dart';

class TerminationHeadTabbar extends StatefulWidget {
  const TerminationHeadTabbar({super.key});

  @override
  State<TerminationHeadTabbar> createState() => _TerminationHeadTabbarState();
}

class _TerminationHeadTabbarState extends State<TerminationHeadTabbar> {
  final StreamController<List<TerminationData>> terminationStremController = StreamController<List<TerminationData>>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TerminationData>>(
      stream: terminationStremController.stream,
      builder: (context,snapshot) {
        getTermination(context,1).then((data) {
          terminationStremController.add(data);
      }).catchError((error) {
        // Handle error
      });
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: CircularProgressIndicator(color: ColorManager.blueprime,),
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
          return SingleChildScrollView(
            child: WrapWidget(childern: List.generate(snapshot.data!.length, (index){
              var termination = snapshot.data![index];
              return Padding(
                padding:const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width/2.3,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  height:  MediaQuery.of(context).size.height/2.5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 120,
                      vertical: MediaQuery.of(context).size.height / 120,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                         Row(
                          children: [
                            Text('Employee #${termination.userId}',
                              style: const TextStyle(
                                fontFamily: 'FiraSans',
                                fontSize: 13,
                                color: Color(0xFF333333),
                                fontWeight: FontWeight.w500,
                              ),),
                          ],),
                        SizedBox(height: MediaQuery.of(context).size.height/50,),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name',
                                        style: ThemeManager.customTextStyle(context)),
                                    const SizedBox(height: 10,),
            
                                    Text('Date of Termination',
                                        style: ThemeManager.customTextStyle(context)),
                                    const SizedBox(height: 10,),
                                    Text('Date of Resignation',
                                        style: ThemeManager.customTextStyle(context)),
                                    const SizedBox(height: 10,),
                                    Text('Date of Hire',
                                        style: ThemeManager.customTextStyle(context)),
                                    const SizedBox(height: 10,),
                                    Text('Status',
                                        style: ThemeManager.customTextStyle(context)),
                                    Text('Position',
                                        style: ThemeManager.customTextStyle(context)),
                                    const SizedBox(height: 10,),
                                    Text('Phone No.',
                                        style: ThemeManager.customTextStyle(context)),
                                    const SizedBox(height: 10,),
                                    Text('Rehirable',
                                        style: ThemeManager.customTextStyle(context)),
                                    const SizedBox(height: 10,),
                                    Text('Final Address',
                                        style: ThemeManager.customTextStyle(context)),
                                  ],
                                ),
                                const SizedBox(width: 25,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${termination.firstName} "+"${termination.lastName}",
                                      style: ThemeManagerDark.customTextStyle(context),),
                                    const SizedBox(height: 10,),
                                    Text(termination.dateOfTermination,
                                      style: ThemeManagerDark.customTextStyle(context),),
                                    const SizedBox(height: 10,),
                                    Text(termination.dateOfResignation,
                                      style: ThemeManagerDark.customTextStyle(context),),
                                    const SizedBox(height: 10,),
                                    Text(termination.checkDate,
                                      style: ThemeManagerDark.customTextStyle(context),),
                                    Text(termination.status,
                                      style: ThemeManagerDark.customTextStyle(context),),
                                    const SizedBox(height: 10,),
                                    Text(termination.service,
                                      style: ThemeManagerDark.customTextStyle(context),),
                                    const SizedBox(height: 10,),
                                    Text(termination.primaryPhoneNo,
                                      style: ThemeManagerDark.customTextStyle(context),),
                                    const SizedBox(height: 10,),
                                    Text(termination.rehirable,
                                      style: ThemeManagerDark.customTextStyle(context),),
                                    const SizedBox(height: 10,),
                                    Text(termination.finalAddress,
                                      style: ThemeManagerDark.customTextStyle(context),),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width / 10,),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Type',
                                        style: ThemeManager.customTextStyle(context)),
                                    const SizedBox(height: 10,),
                                    Text('Reason',
                                        style: ThemeManager.customTextStyle(context)),
                                    const SizedBox(height: 10,),
                                    Text('Final Paycheck',
                                        style: ThemeManager.customTextStyle(context)),
                                    const SizedBox(height: 10,),
                                    Text('Date',
                                        style: ThemeManager.customTextStyle(context)),
                                    Text('Gross Pay',
                                        style: ThemeManager.customTextStyle(context)),
                                    const SizedBox(height: 10,),
                                    Text('Net Pay',
                                        style: ThemeManager.customTextStyle(context)),
                                    const SizedBox(height: 10,),
                                    Text('Methods',
                                        style: ThemeManager.customTextStyle(context)),
                                    const SizedBox(height: 10,),
                                    Text('Materials',
                                        style: ThemeManager.customTextStyle(context)),
                                  ],
                                ),
                                const SizedBox(width: 25,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(termination.type,
                                      style: ThemeManagerDark.customTextStyle(context),),
                                    const SizedBox(height: 10,),
                                    Text(termination.reson,
                                      style: ThemeManagerDark.customTextStyle(context),),
                                    const SizedBox(height: 10,),
                                    Text('\$${termination.finalPayCheck}',
                                        style: ThemeManagerDark.customTextStyle(context)),
                                    const SizedBox(height: 10,),
                                    Text(termination.checkDate,
                                        style: ThemeManagerDark.customTextStyle(context)),
                                    Text('\$${termination.grossPay}',
                                      style: ThemeManagerDark.customTextStyle(context),),
                                    const SizedBox(height: 10,),
                                    Text('\$${termination.netPay}',
                                      style: ThemeManagerDark.customTextStyle(context),),
                                    const SizedBox(height: 10,),
                                    Text(termination.methods,
                                        style: ThemeManagerDark.customTextStyle(context)),
                                    const SizedBox(height: 10,),
                                    Text(termination.materials,
                                        style: ThemeManagerDark.customTextStyle(context)),
                                  ],
                                ),
                              ],
                            )
            
            
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })),
          );
        }
        return const SizedBox();
      }
    );
  }
}
